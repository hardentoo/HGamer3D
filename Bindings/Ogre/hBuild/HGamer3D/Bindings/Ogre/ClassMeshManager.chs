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


-- ClassMeshManager.chs

-- 

module HGamer3D.Bindings.Ogre.ClassMeshManager where

import Foreign
import Foreign.Ptr
import Foreign.C

import HGamer3D.Data.HG3DClass
import HGamer3D.Data.Vector
import HGamer3D.Data.Colour
import HGamer3D.Data.Angle

{# import HGamer3D.Bindings.Ogre.Utils #}
{# import HGamer3D.Bindings.Ogre.ClassPtr #}
{# import HGamer3D.Bindings.Ogre.StructHG3DClass #}

#include "ClassMeshManager.h"
{- function MeshManager -}
{#fun ogre_mshmgr_construct as new 
{ alloca- `HG3DClass' peek*} -> `()'  #}

{- function ~MeshManager -}
{#fun ogre_mshmgr_destruct as delete 
{ withHG3DClass* `HG3DClass' } -> `()'  #}

{- function setPrepareAllMeshesForShadowVolumes -}
{#fun ogre_mshmgr_setPrepareAllMeshesForShadowVolumes as setPrepareAllMeshesForShadowVolumes 
{ withHG3DClass* `HG3DClass' ,
 fromBool `Bool' } -> `()'  #}

{- function getPrepareAllMeshesForShadowVolumes -}
{#fun ogre_mshmgr_getPrepareAllMeshesForShadowVolumes as getPrepareAllMeshesForShadowVolumes 
{ withHG3DClass* `HG3DClass' ,
 alloca- `Bool' peekBoolUtil*} -> `()'  #}

{- function getBoundsPaddingFactor -}
{#fun ogre_mshmgr_getBoundsPaddingFactor as getBoundsPaddingFactor 
{ withHG3DClass* `HG3DClass' ,
 alloca- `Float' peekFloatConv*} -> `()'  #}

{- function setBoundsPaddingFactor -}
{#fun ogre_mshmgr_setBoundsPaddingFactor as setBoundsPaddingFactor 
{ withHG3DClass* `HG3DClass' ,
 realToFrac `Float' } -> `()'  #}

{- function loadResource -}
{#fun ogre_mshmgr_loadResource as loadResource 
{ withHG3DClass* `HG3DClass' ,
 withHG3DClass* `HG3DClass' } -> `()'  #}

{- function getSingleton -}
{#fun ogre_mshmgr_getSingleton as getSingleton 
{ alloca- `HG3DClass' peek*} -> `()'  #}

{- function getSingletonPtr -}
{#fun ogre_mshmgr_getSingletonPtr as getSingletonPtr 
{ alloca- `HG3DClass' peek*} -> `()'  #}

