{-# OPTIONS_HADDOCK hide #-}
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

-- GUI/Internal/Widgets.hs

-- |Widget functionality of the GUI. Implementation module with internal data structures exposed. Public API in HGamer3D.GUI.

module HGamer3D.GUI.Internal.Widgets
where

import HGamer3D.Bindings.CEGUI.ClassOgreRenderer as CEGUIOgreRenderer
import HGamer3D.Bindings.CEGUI.ClassSystem as CEGUISystem
import HGamer3D.Bindings.CEGUI.ClassSystemHG3D as CEGUISystemHG3D
import HGamer3D.Bindings.CEGUI.ClassWindowManagerHG3D as CEGUIWindowManagerHG3D
import HGamer3D.Bindings.CEGUI.ClassWindowManager as CEGUIWindowManager
import HGamer3D.Bindings.CEGUI.ClassResourceProvider as CEGUIResourceProvider
import HGamer3D.Bindings.CEGUI.ClassDefaultResourceProvider as CEGUIDefaultResourceProvider
import HGamer3D.Bindings.CEGUI.ClassImageset as CEGUIImageset
import HGamer3D.Bindings.CEGUI.ClassFont as CEGUIFont
import HGamer3D.Bindings.CEGUI.ClassScheme as CEGUIScheme
import HGamer3D.Bindings.CEGUI.ClassWidgetLookManager as CEGUIWidgetLookManager
import HGamer3D.Bindings.CEGUI.ClassScriptModule as CEGUIScriptModule
import HGamer3D.Bindings.CEGUI.ClassLogger as CEGUILogger
import HGamer3D.Bindings.CEGUI.EnumLoggingLevel
import HGamer3D.Bindings.CEGUI.EnumMouseButton as CEGUIButton
import HGamer3D.Bindings.CEGUI.ClassFontManager as CEGUIFontManager
import HGamer3D.Bindings.CEGUI.ClassSchemeManager as CEGUISchemeManager
import HGamer3D.Bindings.CEGUI.ClassDefaultLogger as CEGUIDefaultLogger
import HGamer3D.Bindings.CEGUI.ClassHG3DEventController as HG3DEventController
import HGamer3D.Bindings.CEGUI.ClassWindowManagerHG3D as HG3DWindowManager
--import HGamer3D.Bindings.Ogre.ClassHG3DMessagePump as MessagePump


import GHC.Ptr
import Data.List.Split
import Data.Maybe

import HGamer3D.Data
import HGamer3D.Util

-- import HGamer3D.Internal.WinEvent

import HGamer3D.Bindings.CEGUI.ClassPtr
import HGamer3D.Bindings.CEGUI.Utils

import HGamer3D.Bindings.CEGUI.ClassWindow as Window
import HGamer3D.Bindings.CEGUI.ClassWindowManager as WindowManager
import HGamer3D.Bindings.CEGUI.ClassWindowManagerHG3D as WindowManagerHG3D
import HGamer3D.Bindings.CEGUI.ClassWindow as Window
import HGamer3D.Bindings.CEGUI.ClassSystem as System
import HGamer3D.Bindings.CEGUI.ClassSystemHG3D as SystemHG3D
import HGamer3D.Bindings.CEGUI.ClassPropertySet as PropertySet
import HGamer3D.Bindings.CEGUI.ClassHG3DEventStaticFunctions as EvtSF 
import HGamer3D.Bindings.CEGUI.ClassHG3DListboxStaticFunctions as ListboxSF
import HGamer3D.Bindings.CEGUI.ClassHG3DWindowStaticFunctions as WindowSF
import HGamer3D.Bindings.CEGUI.ClassListbox as Listbox
import HGamer3D.Bindings.CEGUI.ClassListboxItem as ListboxItem
import HGamer3D.Bindings.CEGUI.ClassCombobox as Combobox
import HGamer3D.Bindings.CEGUI.EnumKeyScan

import HGamer3D.Bindings.CEGUI.ClassHG3DEventStaticFunctions as EvtSF 

import HGamer3D.Bindings.CEGUI.EnumMouseButton as CEGUIButton

import HGamer3D.GUI.Internal.Base
-- import HGamer3D.GUI.Internal.Properties
import HGamer3D.Data.HG3DClass

import qualified HGamer3D.GUI.Schema.Widget as ScW
import qualified HGamer3D.GUI.Schema.Layout as ScL
import qualified HGamer3D.GUI.Schema.Form as ScF

-- | GUI Element, Sybtype Button
type GUIButton = GUIElement GEButton

-- | GUI Elements, which have a selection
type GUIHasSelection a = GUIElement a

-- | GUI Element, Sybtype CheckBox
type GUICheckBox = GUIHasSelection GECheckBox

-- | GUI Element, Sybtype RadioButton
type GUIRadioButton = GUIHasSelection GERadioButton

-- | GUI Element, Sybtype EditText
type GUIEditText = GUIElement GEEditText

-- | GUI Element, Sybtype MultilineText
type GUIMultilineText = GUIElement GEMultilineText

-- | GUI Element, Sybtype Listbox
type GUIListBox = GUIElement GEListBox

-- | GUI Element, Sybtype Combobox
type GUIComboBox = GUIElement GEComboBox

-- | GUI Element, which have a value
type GUIHasValue a = GUIElement a

-- | GUI Element, Sybtype Slider
type GUISlider = GUIHasValue GESlider

-- | GUI Element, Sybtype Spinner
type GUISpinner = GUIHasValue GESpinner

-- | GUI Element, Subtype FrameWindow
type GUIWindow = GUIElement GEWindow

-- | GUI Element, which is a layout container
type GUILayout a = GUIElement a

-- | GUI Element, vertical layout container
type GUIVLayout = GUILayout GEVLayout

-- | GUI Element, horizontal layout container
type GUIHLayout = GUILayout GEHLayout

-- | GUI Element, grid layout container
type GUIGridLayout = GUILayout GEGridLayout


-- | get Type of GUI element as string
typeOfGuiEl :: GUIElement a -- ^ GUI element to enable
               -> IO String
typeOfGuiEl (GUIElement window _) = do
	Window.getType window

toGuiType :: String -> b -> GUIElement a -> IO (GUIElement b)
toGuiType typestr cons guiel@(GUIElement window _) = do
          tp <- typeOfGuiEl guiel
          -- CEGUI Types as String have the format "WindowLook/Button" for example
          -- sometimes they have no "xyzLook" part and no /
          let tp' = last (splitOn "/" tp)  
          let guiel' = case tp' of
                         typestr -> GUIElement window cons
                         _ -> error ("HGamer3D.GUI.Internal.Widgets.toGuiType: " ++ typestr ++ " not found!")
          return guiel'

_createElement :: String -> (GUIElement a -> IO (GUIElement b)) -> GUISystem -> String -> [GUIElement b -> IO ()] -> IO (GUIElement b)
_createElement elType convFunc guis style proplist = do
  let winMgr = guiWindowManager guis
  let uname = guiUniqueName guis
  elName <- nextUniqueName uname
  window <- WindowManager.createWindow winMgr (style ++ "/" ++ elType) elName
  el <- convFunc (GUIElement window undefined)
  -- set the properties
  setP el proplist 
  return el

_createElement' :: String -> (GUIElement a -> IO (GUIElement b)) -> GUISystem -> [GUIElement b -> IO ()] -> IO (GUIElement b)
_createElement' elType convFunc guis proplist = do
  let winMgr = guiWindowManager guis
  let uname = guiUniqueName guis
  elName <- nextUniqueName uname
  window <- WindowManager.createWindow winMgr (elType) elName
  el <- convFunc (GUIElement window undefined)
  -- set the properties
  setP el proplist 
  return el

button :: GUISystem -> String -> [GUIButton -> IO ()] -> IO GUIButton
button = _createElement "Button" toButton

radioButton :: GUISystem -> String -> [GUIRadioButton -> IO ()] -> IO GUIRadioButton
radioButton = _createElement "RadioButton" toRadioButton

checkBox :: GUISystem -> String -> [GUICheckBox -> IO ()] -> IO GUICheckBox
checkBox = _createElement "Checkbox" toCheckBox

editText :: GUISystem -> String -> [GUIEditText -> IO ()] -> IO GUIEditText
editText = _createElement "Editbox" toEditText

multilineText :: GUISystem -> String -> [GUIMultilineText -> IO ()] -> IO GUIMultilineText
multilineText = _createElement "MultiLineEditbox" toMultilineText

comboBox :: GUISystem -> String -> [GUIComboBox -> IO ()] -> IO GUIComboBox
comboBox = _createElement "Combobox" toComboBox

listBox :: GUISystem -> String -> [GUIListBox -> IO ()] -> IO GUIListBox
listBox = _createElement "Listbox" toListBox

spinner :: GUISystem -> String -> [GUISpinner -> IO ()] -> IO GUISpinner
spinner = _createElement "Spinner" toSpinner

slider :: GUISystem -> String -> [GUISlider -> IO ()] -> IO GUISlider
slider = _createElement "Slider" toSlider

window :: GUISystem -> String -> [GUIWindow -> IO ()] -> IO GUIWindow
window = _createElement "FrameWindow" toWindow

hLayout :: GUISystem -> [GUIHLayout -> IO ()] -> IO GUIHLayout
hLayout = _createElement' "HorizontalLayoutContainer" toHLayout

vLayout :: GUISystem -> [GUIVLayout -> IO ()] -> IO GUIVLayout
vLayout = _createElement' "VerticalLayoutContainer" toVLayout

gridLayout :: GUISystem -> [GUIGridLayout -> IO ()] -> IO GUIGridLayout
gridLayout = _createElement' "GridLayoutContainer" toGridLayout

toButton = toGuiType "Button" GEButton
toRadioButton = toGuiType "RadioButton" GERadioButton
toCheckBox = toGuiType "Checkbox" GECheckBox

toEditText = toGuiType "Editbox" GEEditText
toMultilineText = toGuiType "MultiLineEditbox" GEMultilineText

toComboBox = toGuiType "Combobox" GEComboBox
toListBox = toGuiType "Listbox" GEListBox

toSlider = toGuiType "Slider" GESlider
toSpinner = toGuiType "Spinner" GESpinner

toHLayout = toGuiType "HorizontalLayoutContainer" GEHLayout
toVLayout = toGuiType "VerticalLayoutContainer" GEVLayout
toGridLayout = toGuiType "GridLayoutContainer" GEGridLayout
toWindow = toGuiType "FrameWindow" GEWindow

findElement :: (GUIElement a -> IO (GUIElement b))
               ->String 
               -> GUIElement a 
               -> IO (GUIElement b)
findElement toNewType name topel = do
  mFound <- findChildGuiElRecursive topel name
  el <- toNewType (fromJust mFound)
  return el  

findButton = findElement toButton
findRadioButton = findElement toRadioButton
findCheckBox = findElement toCheckBox
findEditText = findElement toEditText
findMultilineText = findElement toMultilineText
findComboBox = findElement toComboBox
findListBox = findElement toListBox
findSpinner = findElement toSpinner
findSlider = findElement toSlider

-- | add one line of text as a selectable entry to a combobox
comboboxAddText :: GUIComboBox -- ^ GUI element, needs to be a combobox
                   -> String -- ^ the entry string to add
                   -> IO ()
comboboxAddText (GUIElement window GEComboBox) itemname = do
	realcombo <- WindowSF.castWindowToCombobox window
	ListboxSF.comboboxAddItem realcombo itemname
	
-- | removes all lines of entries from a combobox
comboboxRemoveAllText :: GUIComboBox -- ^ the GUI elements, needs to be a combobox
                         -> IO ()
comboboxRemoveAllText (GUIElement window GEComboBox) = do
	realcombo <- WindowSF.castWindowToCombobox window
	Combobox.resetList realcombo
	
comboboxStatus :: GUIComboBox -- ^ GUI element, needs to be a listbox
                         -> IO [String] -- ^ list of entry, selected pairs
comboboxStatus (GUIElement window GEComboBox) = do
	realbox <- WindowSF.castWindowToCombobox window
        count <- Combobox.getItemCount realbox
        outlist <- mapM ( \ind -> do
                        item <- Combobox.getListboxItemFromIndex realbox ind
                        txt <- ListboxItem.getText item
                        return txt
                  ) [0..(count-1)]
        return outlist

-- | add one line of text as a selectable entry to a listbox
listboxAddText :: GUIListBox -- ^ GUI element, needs to be a listbox
                  -> String -- ^ the entry string to add
                  -> IO ()
listboxAddText (GUIElement window GEListBox) itemname = do
	reallistbox <- WindowSF.castWindowToListbox window
	ListboxSF.listboxAddItem reallistbox itemname
	
_getTextListOfItem reallistbox item list = do
  let (HG3DClass ptra ptrb) = item
  if ptra /= nullPtr then do
    txt <- ListboxItem.getText item
    let list' = list ++ [txt]
    item' <- Listbox.getNextSelected reallistbox item
    list'' <- _getTextListOfItem reallistbox item' list'
    return list''
    else do
      return list
 
listboxInitialize :: GUIListBox -- ^ GUI element, needs to be a listbox
                         -> [(String, Bool)] -- ^ list of entry, selected pairs
                         -> IO ()
listboxInitialize (GUIElement window GEListBox) pairs = do
	reallistbox <- WindowSF.castWindowToListbox window
	Listbox.resetList reallistbox
        mapM ( \((entry, selected), ind) -> do
                  	ListboxSF.listboxAddItem reallistbox entry
                        item <- Listbox.getListboxItemFromIndex reallistbox ind
                        ListboxItem.setSelected item selected
                        return ()
                  ) (zip pairs [0..])
        return ()
  
listboxStatus :: GUIListBox -- ^ GUI element, needs to be a listbox
                         -> IO [(String, Bool)] -- ^ list of entry, selected pairs
listboxStatus (GUIElement window GEListBox) = do
	reallistbox <- WindowSF.castWindowToListbox window
        count <- Listbox.getItemCount reallistbox
        outlist <- mapM ( \ind -> do
                        item <- Listbox.getListboxItemFromIndex reallistbox ind
                        sel <- ListboxItem.isSelected item
                        txt <- ListboxItem.getText item
                        return (txt, sel)
                  ) [0..(count-1)]
        return outlist
  

-- | return the selected items as an array of strings
listboxGetSelectedText :: GUIListBox -- ^ the GUI element, needs to be a listbox
                          -> IO [String] -- ^ the selected items as an array of strings
listboxGetSelectedText (GUIElement window GEListBox) = do
	reallistbox <- WindowSF.castWindowToListbox window
	item <- Listbox.getFirstSelectedItem reallistbox
        list <- _getTextListOfItem reallistbox item ([]::[String])
        return list
				
-- | removes all lines of entries from a listbox
listboxRemoveAllText :: GUIListBox -- ^ the GUI element, needs to be a listbox
                        -> IO ()
listboxRemoveAllText (GUIElement window GEListBox) = do
	reallistbox <- WindowSF.castWindowToListbox window
	Listbox.resetList reallistbox
	



