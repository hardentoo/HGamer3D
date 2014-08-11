-- This source file is part of HGamer3D
-- (A project to enable 3D game development in Haskell)
-- For the latest info, see http://www.hgamer3d.org
--
-- (c) 2014 Peter Althainz
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Coordinates.hs
-- Orientate yourself in 3D world

module Main

where

-- import the needed Ecs API files
import HGamer3D.Data
import HGamer3D.Engine.EcsAPI
import HGamer3D.Graphics3D.EcsAPI

-- other imports
import Control.Concurrent

-- define two cameras
camera1 = Camera (Frustum 5.0 5000.0 (Deg 40)) (Viewport 0 (Rectangle 0.0 0.0 1.0 1.0) black)
camera2 = Camera (Frustum 5.0 5000.0 (Deg 10)) (Viewport 1 (Rectangle 0.7 0.7 0.27 0.27) darkgrey)

-- define some light
light1 = Light white white PointLight 

-- define a geometry, which is laid out in different axes
fzero = SimpleFigure Sphere (ResourceMaterial "Colours/Green")
fx = SimpleFigure Cube (ResourceMaterial "Colours/Blue")
fy = SimpleFigure Cube (ResourceMaterial "Colours/Red")

figure1 = CombinedFigure [
     (Vec3 0.0 0.0 (-200.0), unitU, unitVec3 &* 0.1, fzero),
     (Vec3 20.0 0.0 (-200.0), unitU, unitVec3 &* 0.1, fx),
     (Vec3 0.0 20.0 (-200.0), unitU, unitVec3 &* 0.1 , fy)
  ]

-- define event listener, to get quit event
events1 = EventReceiver [ApplicationEvents]

-- rotation helper functions
alphaTime :: IO Float
alphaTime = do
  t <- getTime
  let t' = fromIntegral ((msec t) `mod` 5000)
  let v = (t' * 6.28 / 5000.0) 
  return v

rotate alpha vstart radius = let
  x = (sin alpha) * radius
  z = (cos alpha) * radius
  in (Vec3 x 0.0 z) &+ vstart

main = do

  -- make entities for environment and geometry

  -- camera, light and scene parameters into one
  envE <- entity [
       CTCam #: camera1,
       CTScP #: SceneParameter white NoShadows NoSky,
       CTEvR #: events1
       ]

  -- a rotating camera for fun
  rotC <- entity [
     CTPos #: Vec3 0.0 0.0 0.0,
     CTOri #: unitU,
     CTCam #: camera2
     ]

  -- geometry entity
  geoE <- entity [
     CTPos #: unitVec3,
     CTOri #: unitU,
     CTFig #: figure1
     ]

  -- light entity
  liE1 <- entity [
       CTLig #: light1,
       CTPos #: Vec3 500.0 500.0 (-500.0)
       ]
  liE2 <- entity [
       CTLig #: light1,
       CTPos #: Vec3 100.0 50.0 0.0	
       ]

  -- end definition of entities

  -- run graphics system
  ecsG3D <- runSystemGraphics3D (msecT 30)
  ecsEvt <- runSystemEvent (msecT 110)
  let systems = ecsG3D #+ ecsEvt #+ []

  -- add entities to running system
  mapM (addToWorld systems) [envE, rotC, geoE, liE1, liE2] 

  let listenQuitLoop = do
      evts <- receiveEvents envE
      if length (filter (\evt -> case evt of
      	 		      	      (AppEvt AppQuit) -> True
				      _ -> False) evts) == 0 then do
         threadDelay 100000  -- wait 100 msec
	 -- rotate second camera
	 alpha <- alphaTime
	 updateC (rotC # CTPos) (const (rotate alpha (Vec3 0.0 0.0 (-200.0)) 400.0))
	 updateC (rotC # CTOri) (const (rotU vec3Y alpha))
      	 listenQuitLoop
	 else return ()

  listenQuitLoop

