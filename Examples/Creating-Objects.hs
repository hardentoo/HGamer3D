-- This source file is part of HGamer3D
-- (A project to enable 3D game development in Haskell)
-- For the latest info, see http://www.althainz.de/HGamer3D.html
--
-- (c) 2011 Peter Althainz
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


-- Creating-Objects.hs
-- Tutorial, create basic objects

-- the keys "D,A,S,W,Q,E" rotate the cubes
-- look, how the combined cubes rotate around the axes


module Main where

import HGamer3D.BaseAPI

-- a Rotater combines a rotation with a keystroke
data Rotater = Rotater UnitQuaternion EnumKey

createRotater vector name key = do
	let quat = rotU vector 0.001
	let rot = Rotater quat key
	return (rot)
	
doRotater (Rotater quat key) object = do
	isR <- isKeyPressed key
	if isR then do
		qNow <- orientation3D object
		orientationTo3D object (fromNormal (quat .*. (mkNormal qNow)))
		return ()
		else return ()

createRotaters = do
	-- define rotation quats
	let arr = [	 ( (Vec3 0.0 1.0 0.0), "right", KeyD ),
					 ( (Vec3 0.0 (-1.0) 0.0), "left", KeyA), 
					 ( (Vec3 1.0 0.0 0.0), "down", KeyS), 
					 ( (Vec3 (-1.0) 0.0 0.0), "up", KeyW),
					 ( (Vec3 0.0 0.0 1.0), "left2", KeyQ), 
					 ( (Vec3 0.0 0.0 (-1.0)), "right2", KeyE)  ]
	 
	rotators <- sequence $ map ( \(vector, name, key) -> createRotater vector name key ) arr
	return (rotators)

stepFunc es vs time (object, rotators) = do
	sequence $ map (\r -> doRotater r object) rotators
	return (True, (object, rotators))

main = do

	-- initialize
	(es, vs) <- initializeHG3D "HGamer3D Tutorial - Creating and Moving Objects" "OctreeSceneManager"
	
	-- camera position
	let pos = Vec3 5.0 5.0 80.0
	setCameraPos vs pos
	let at = Vec3 0.0 0.0 (-300.0)
	setCameraLookAt vs at
	
	-- define colors and positions
	let red = Colour 1.0 0.0 0.0 1.0
	let green = Colour 0.0 1.0 0.0 1.0
	let blue = Colour 0.0 0.0 1.0 1.0
	
	let v0 = Vec3 0.0 0.0 0.0
	let vx = Vec3 10.0 0.0 0.0
	let vy = Vec3 0.0 10.0 0.0
	let vz = Vec3 0.0 0.0 10.0

	-- create some templates from different methods
	-- 
	
	-- createLine and createCube functions
	 
	lineBlueT <- createLine es "BlueLine" "BaseWhiteNoLighting" blue v0 vx
	lineGreenT <- createLine es "GreenLine" "BaseWhiteNoLighting" green v0 vy
	lineRedT <- createLine es "RedLine" "BaseWhiteNoLighting" red v0 vz

	cubeBlueT <- createCube es "BlueCube" "BaseWhiteNoLighting" blue
	cubeGreenT <- createCube es "GreenCube" "BaseWhiteNoLighting" green
	cubeRedT <- createCube es "RedCube" "BaseWhiteNoLighting" red


	-- use templates to create the objects
	--

	-- create lines and cubes from templates
	lineBlue <- createMesh es lineBlueT
	lineGreen <- createMesh es lineGreenT
	lineRed <- createMesh es lineRedT
	cubeBlue <- createMesh es cubeBlueT
	cubeGreen <- createMesh es cubeGreenT
	cubeRed <- createMesh es cubeRedT
	
	-- create objects from pre-defined templates
	cubeOne <- createMesh es MeshCube
	planeOne <- createMesh es MeshPlane
	sphereOne <- createMesh es MeshSphere
	
	
	-- move and scale objects
	
	setPosition cubeBlue vx
	setPosition cubeGreen vy
	setPosition cubeRed vz
	
	setPosition cubeOne (2.0 *& vx)
	setPosition planeOne (2.0 *& vy)
	setPosition sphereOne (2.0 *& vz)
	
	setScale cubeOne (Vec3 0.03 0.03 0.03)
	setScale planeOne (Vec3 0.03 0.03 0.03)
	setScale sphereOne (Vec3 0.03 0.03 0.03)

	setScale cubeBlue (Vec3 3.0 3.0 3.0)
	setScale cubeRed (Vec3 1.0 3.0 1.0)
	
	-- combine the cubes to one object
	cubes <- combineGraphicsObjects es [cubeBlue, cubeGreen, cubeRed, cubeOne, planeOne, sphereOne]
	
	
	-- define light
	let col = Colour 1.0 1.0 1.0 1.0
	light <- createLight es "MainLight" col (Vec3 20.0 80.0 50.0)
	createAmbientLight es col

	rotators <- createRotaters
	time <- getTime es
	renderLoop es vs time (cubes, rotators) stepFunc
		
	

