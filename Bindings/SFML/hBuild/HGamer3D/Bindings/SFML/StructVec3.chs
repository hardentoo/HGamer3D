{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE TypeSynonymInstances #-}

-- This source file is part of HGamer3D, a project to enable 3D game development 
-- in Haskell. For the latest info, see http://www.hgamer3d.org .
-- 

-- (c) 2011-2014 Peter Althainz
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
-- 


-- StructVec3.chs

-- 

module HGamer3D.Bindings.SFML.StructVec3 where

import Foreign
import Foreign.Ptr
import Foreign.C

import HGamer3D.Data.HG3DClass
import HGamer3D.Data.Vector
import HGamer3D.Data.Colour
import HGamer3D.Data.Angle


#include "StructVec3.h"

import Data.Bits
import HGamer3D.Data.Vector

newtype Vector3f = Vector3f Vec3

instance Storable Vector3f where
  alignment _ = alignment (undefined :: CDouble)
  sizeOf _ = {#sizeof vector3f_struct#}
  peek p = do
	x <- {#get vector3f_struct.x #} p
	y <- {#get vector3f_struct.y #} p
	z <- {#get vector3f_struct.z #} p
	let v = Vector3f (Vec3 (realToFrac x) (realToFrac y) (realToFrac z))
	return v
  poke p (Vector3f (Vec3 x y z)) = do
    {#set vector3f_struct.x #} p (realToFrac x)
    {#set vector3f_struct.y #} p (realToFrac  y)
    {#set vector3f_struct.z #} p (realToFrac  z)
    
type Vector3fPtr = Ptr (Vector3f)

{#pointer *vector3f_struct as Vec3Ptr -> Vec3 #}

withVec3 :: Vec3 -> (Vec3Ptr -> IO b) -> IO b
withVec3 v f = with v' f' where
     v' = Vector3f v
     f' p = f (castPtr p)
peekVec3 p = do
   (Vector3f v3) <- peek ((castPtr p)::Vector3fPtr)
   return v3

