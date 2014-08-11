-- This source file is part of HGamer3D
-- (A project to enable 3D game development in Haskell)
-- For the latest info, see http://www.hgamer3d.org
--
-- (c) 2011-2013 Peter Althainz
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

import HGamer3D.Data
import HGamer3D.Engine.BaseAPI
import HGamer3D.Graphics3D.BaseAPI
import HGamer3D.Graphics3D.Schema.Camera

renderLoop cubeF g3ds guis last = do
   -- rotate 
  orientation cubeF >>= \o -> return (yaw o (Rad 0.005)) >>= orientationTo cubeF
  orientation cubeF >>= \o -> return (roll o (Rad 0.002)) >>= orientationTo cubeF
  (ev, last', quit) <- stepHGamer3D g3ds guis last
  if quit then return () else renderLoop cubeF g3ds guis last'
   
main :: IO ()
main = do
  
        (g3ds, guis, last) <- initHGamer3D "HGamer3D - BlueCube Example" True True True
        
	-- camera position
        camera <- addCamera g3ds (Camera (Frustum 5.0 5000.0 (Deg 60)) (Viewport 0 (Rectangle 0.0 0.0 1.0 1.0) black))
	let pos = Vec3 5.0 5.0 80.0
        positionTo camera pos
	let at = Vec3 0.0 0.0 (-300.0)
        cameraLookAt camera at
	
	-- define light
	setAmbientLight g3ds white
	pointLight g3ds white white (Vec3 10.0 10.0 20.0)
        
	-- create a shiny blue cube
        cubeFigure <- cube g3ds 0.2 (ResourceMaterial "Colours/Blue")
        positionTo cubeFigure (Vec3 0.0 0.0 0.0)
        
	-- start render loop
	renderLoop cubeFigure g3ds guis last
        freeHGamer3D g3ds guis
        return ()

