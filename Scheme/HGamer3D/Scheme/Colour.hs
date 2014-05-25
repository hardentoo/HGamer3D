{-# LANGUAGE FlexibleContexts, StandaloneDeriving, TemplateHaskell #-}

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

-- Colour.hs

-- | Types which describe Colourss, Colour is defined in HGamer3D.Data but we need the ColourSlot
module HGamer3D.Scheme.Colour

where

import qualified HGamer3D.Data as D
import Control.Lens

-- | Slot, a name for a colour, to cross-reference materials in Nodes, ...
type ColourSlot = String
  

