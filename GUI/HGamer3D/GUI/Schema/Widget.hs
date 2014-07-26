{-# LANGUAGE DeriveDataTypeable, StandaloneDeriving #-}
-- This source file is part of HGamer3D
-- (A project to enable 3D game development in Haskell)
-- For the latest info, see http://www.hgamer3d.org
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

-- HGamer3D/GUI/Schema/Widget.hs

-- | Types which describe the GUI Widgets
module HGamer3D.GUI.Schema.Widget
where

import Data.Typeable
import HGamer3D.Data as Dat
import HGamer3D.GUI.Schema.GUIDim

-- | The data to specify a widget
data Widget = Button String [WidgetProperty]
            | RadioButton String [WidgetProperty]
            | CheckBox String [WidgetProperty]
            | ComboBox String [WidgetProperty]
            | ListBox String [WidgetProperty]
            | EditText String [WidgetProperty]
            | MultilineText String [WidgetProperty]
            | Spinner String [WidgetProperty]
            | Slider String [WidgetProperty]
            deriving (Eq, Show, Typeable)

-- | Widget Properties
data WidgetProperty = XPos GUIDim
                    | YPos GUIDim
                    | Width GUIDim
                    | Height GUIDim
                    | Visible Bool
                    | Alpha Float
                    | Text String
                    | Margin GUIDim
                    | Tooltip String
                    | TextChoice [String]               -- only ComboBox
                    | TextSelection [(String, Bool)]    -- only ListBox
                    | Value Float                       -- only Spinner, Slider
                    | Selected Bool                     -- only CheckBox, RadioButton
                      deriving (Eq, Show, Typeable)


