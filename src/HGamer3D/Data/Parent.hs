{-
	Datatypes to specify a parent by id
	HGamer3D Library (A project to enable 3D game development in Haskell)
	Copyright 2011-2015 Peter Althainz
	
	Distributed under the Apache License, Version 2.0
	(See attached file LICENSE or copy at 
	http://www.apache.org/licenses/LICENSE-2.0)
 
	file: HGamer3D/Data/Colour.hs
-}
    
-- | The Parent component type
module HGamer3D.Data.Parent

(
    Parent,
    ctParent 
)

where

import Data.MessagePack
import Data.ByteString
import Fresco

type Parent = ByteString

ctParent :: ComponentType Parent
ctParent = ComponentType 0xbadd24df00e737d8

