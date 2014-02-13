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


-- ClassComboDropList.chs

-- 

module HGamer3D.Bindings.CEGUI.ClassComboDropList where

import Foreign
import Foreign.Ptr
import Foreign.C

import HGamer3D.Data.HG3DClass
import HGamer3D.Data.Vector
import HGamer3D.Data.Colour
import HGamer3D.Data.Angle

{# import HGamer3D.Bindings.CEGUI.Utils #}
{# import HGamer3D.Bindings.CEGUI.ClassPtr #}
{# import HGamer3D.Bindings.CEGUI.StructHG3DClass #}

#include "ClassComboDropList.h"
{- function initialiseComponents -}
{#fun cegui_cmbdrplst_initialiseComponents as initialiseComponents 
{ withHG3DClass* `HG3DClass' } -> `()'  #}

{- function setArmed -}
{#fun cegui_cmbdrplst_setArmed as setArmed 
{ withHG3DClass* `HG3DClass' ,
 fromBool `Bool' } -> `()'  #}

{- function isArmed -}
{#fun cegui_cmbdrplst_isArmed as isArmed 
{ withHG3DClass* `HG3DClass' ,
 alloca- `Bool' peekBoolUtil*} -> `()'  #}

{- function setAutoArmEnabled -}
{#fun cegui_cmbdrplst_setAutoArmEnabled as setAutoArmEnabled 
{ withHG3DClass* `HG3DClass' ,
 fromBool `Bool' } -> `()'  #}

{- function isAutoArmEnabled -}
{#fun cegui_cmbdrplst_isAutoArmEnabled as isAutoArmEnabled 
{ withHG3DClass* `HG3DClass' ,
 alloca- `Bool' peekBoolUtil*} -> `()'  #}

{- function ComboDropList -}
{#fun cegui_cmbdrplst_construct as new 
{ withCString* `String' ,
 withCString* `String' ,
 alloca- `HG3DClass' peek*} -> `()'  #}

{- function ~ComboDropList -}
{#fun cegui_cmbdrplst_destruct as delete 
{ withHG3DClass* `HG3DClass' } -> `()'  #}

