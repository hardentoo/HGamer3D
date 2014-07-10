-- This source file is part of HGamer3D
-- (A project to enable 3D game development in Haskell)
-- For the latest info, see http://www.althainz.de/HGamer3D.html
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

-- HGamer3D/Internal/GameLoop Module
--

-- | HGamer3D - A game engine for the Haskell Programmer, this module includes the implementation of the gameloop and initialization routines. This is an internal module, the public API is in HGamer3D.BaseAPI.
module HGamer3D.Internal.GameLoop

(
  HG3DEvent (..),
  
  initHGamer3D,
  freeHGamer3D,
  stepHGamer3D,
  
  ) where

  import HGamer3D.Data
  import HGamer3D.Util

  import HGamer3D.Graphics3D
  import HGamer3D.WinEvent
  import HGamer3D.GUI
  
  import HGamer3D.Internal.Event

  -- need a couple of internal functions from base modules, to implement game loop
  import HGamer3D.Graphics3D.Internal.Base (renderOneFrame, graphics3DPumpWindowMessages, checkQuitReceived)
  import HGamer3D.GUI.Internal.Base (pollGUIEvent, initGUI, injectWinEventToGUI)
  import HGamer3D.WinEvent.Internal.Base (attachToWindow)

  import qualified System.Info as SI

  freeHGamer3D :: Graphics3DSystem -> GUISystem -> IO ()
  freeHGamer3D g3ds guis = do 
     freeGraphics3D g3ds


  -- | Game Loop
  -- The game loop works in a way, that window events are much faster processed then 
  -- update of rendering -> all events needs to be cleared, then next renderOneFrame is processed
  -- after that the call returns.
  stepHGamer3D :: Graphics3DSystem -- ^ the Graphics System
                  -> GUISystem     -- ^ the GUI System
                  -> IO ([HG3DEvent], Bool) -- ^ list of Events received, quit flag (True if quit received)
                  
  stepHGamer3D g3ds guis = do
    
    let oneStep quitReceived events = do
        -- this one is quite tricky, on Linux we need to call the message loop in addition to WinEvent!
        if SI.os /= "mingw32" then graphics3DPumpWindowMessages else return ()
        i <- checkQuitReceived
        let quitReceived' = quitReceived || (i == 1)
        mWinEvt <- pollWinEvent
        case mWinEvt of
           Just winEvt -> do
             injectWinEventToGUI guis winEvt  -- inject event into gui
             let events' = events ++ [WindowEvt winEvt]
             oneStep quitReceived' events'
           Nothing -> do
             mGuiEvt <- pollGUIEvent guis
             case mGuiEvt of
               Just guiEvt -> do
                 let events' = events ++ [GUIEvt guiEvt]
                 oneStep quitReceived' events'
               Nothing -> do
                 renderOneFrame g3ds
                 return (events, quitReceived')
    oneStep False []

  initHGamer3D :: String -- ^ Window Title
                  -> Bool -- ^ Flag show config dialogue
                  -> Bool -- ^ Flag logging enabled
                  -> Bool -- ^ show Graphics Cursor
                  -> IO (Graphics3DSystem, GUISystem, Camera, Viewport)
  initHGamer3D windowTitle fConfigDialogue fLog fGraphicsCursor = do
        success <- initWinEvent [WEV_INIT_EVENTS, WEV_INIT_TIMER, WEV_INIT_VIDEO]
        (g3ds, camera, viewport, window) <- initGraphics3D windowTitle "DefaultSceneManager" fConfigDialogue fLog
        win <- attachToWindow window
        guis <- initGUI fLog fGraphicsCursor
        return (g3ds, guis, camera, viewport)
