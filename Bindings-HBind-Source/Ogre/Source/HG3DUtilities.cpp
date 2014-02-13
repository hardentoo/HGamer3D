/*
This source file is part of HGamer3D
(A project to enable 3D game development in Haskell)
For the latest info, see http://www.althainz.de/HGamer3D.html

(c) 2011 Peter Althainz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#include "Ogre.h"
#include "HG3DUtilities.h"

static int quitReceived = 0;

unsigned int HG3DUtilities::getWindowHandle(Ogre::RenderWindow *window)
{
  unsigned int handle;

  window->getCustomAttribute("WINDOW", &handle);
  return handle;
}

class CloserStop : public Ogre::WindowEventListener 
{
public:
  void 	windowClosed (Ogre::RenderWindow *rw)
  {
  };

  bool 	windowClosing (Ogre::RenderWindow *rw)
  {
    quitReceived = 1;
    return false;
  };

  void 	windowFocusChange (Ogre::RenderWindow *rw)
  {
  };

  void 	windowMoved (Ogre::RenderWindow *rw)
  {
  };

  void 	windowResized (Ogre::RenderWindow *rw)
  {
  };
};

void HG3DUtilities::setupCloseEventHandler(Ogre::RenderWindow *window)
{
  Ogre::WindowEventUtilities::addWindowEventListener(window, new CloserStop() );
}

int HG3DUtilities::checkQuitReceived()
{
  int rval = quitReceived;
  quitReceived = 0;
  return rval;
}
