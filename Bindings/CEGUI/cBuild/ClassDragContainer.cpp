// This source file is part of HGamer3D, a project to enable 3D game development 
// in Haskell. For the latest info, see http://www.hgamer3d.org .
// 
// (c) 2011-2014 Peter Althainz
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 

// ClassDragContainer.cpp

// 

#include <wchar.h>
#include <string>
#include <iostream>

#include <iostream>
	#include <typeinfo>
	#include <stdio.h>
	#include <cstring>
	#include <exception>
	#include "CEGUIDllDefines.h"
	#include "ClassPtr.h"
	#include "./CEGUI.h"
#include "./CEGUIString.h"
#include "RendererModules/Ogre/CEGUIOgreRenderer.h"
#include "./WindowManagerHG3D.h"
#include "./SystemHG3D.h"
#include "HG3DCommandHandler.h"
#include "HG3DEventStaticFunctions.h"
#include "HG3DListboxStaticFunctions.h"
#include "HG3DEventController.h"
#include "HG3DEventModule.h"
#include "HG3DWindowStaticFunctions.h"

using namespace CEGUI;



// Constructor for DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_construct(char * type_c, char * name_c, struct hg3dclass_struct * result_c)
{
  CEGUI::String type_cpp = CEGUI::String((const char*) type_c);
  CEGUI::String name_cpp = CEGUI::String((const char*) name_c);
  CEGUI::DragContainer * result_cpp;
  result_cpp = (new CEGUI::DragContainer(type_cpp, name_cpp));
  *result_c = getHG3DClass_DragContainer((void *) result_cpp);
;
};

// Destructor for DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_destruct(struct hg3dclass_struct * thisclass_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  (delete thisclass_cpp);
};

// Return whether dragging is currently enabled for this DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_isDraggingEnabled(struct hg3dclass_struct * thisclass_c, int * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  bool result_cpp;
  result_cpp = (thisclass_cpp->isDraggingEnabled());
  *result_c = (int)result_cpp;
};

// Set whether dragging is currently enabled for this DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_setDraggingEnabled(struct hg3dclass_struct * thisclass_c, int setting_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  bool setting_cpp = (bool)setting_c;
  (thisclass_cpp->setDraggingEnabled(setting_cpp));
};

// Return whether the DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_isBeingDragged(struct hg3dclass_struct * thisclass_c, int * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  bool result_cpp;
  result_cpp = (thisclass_cpp->isBeingDragged());
  *result_c = (int)result_cpp;
};

// Return the current drag threshold in pixels. 
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_getPixelDragThreshold(struct hg3dclass_struct * thisclass_c, float * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  float result_cpp;
  result_cpp = (thisclass_cpp->getPixelDragThreshold());
  *result_c = (float)result_cpp;
};

// Set the current drag threshold in pixels. 
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_setPixelDragThreshold(struct hg3dclass_struct * thisclass_c, float pixels_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  float pixels_cpp = (float)pixels_c;
  (thisclass_cpp->setPixelDragThreshold(pixels_cpp));
};

// Return the alpha value that will be set on the DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_getDragAlpha(struct hg3dclass_struct * thisclass_c, float * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  float result_cpp;
  result_cpp = (thisclass_cpp->getDragAlpha());
  *result_c = (float)result_cpp;
};

// Set the alpha value to be set on the DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_setDragAlpha(struct hg3dclass_struct * thisclass_c, float alpha_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  float alpha_cpp = (float)alpha_c;
  (thisclass_cpp->setDragAlpha(alpha_cpp));
};

// Set the Image to be used for the mouse cursor when a drag operation is in progress. 
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_setDragCursorImage3(struct hg3dclass_struct * thisclass_c, char * imageset_c, char * image_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  CEGUI::String imageset_cpp = CEGUI::String((const char*) imageset_c);
  CEGUI::String image_cpp = CEGUI::String((const char*) image_c);
  (thisclass_cpp->setDragCursorImage(imageset_cpp, image_cpp));
};

// Return the WindowDragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_getCurrentDropTarget(struct hg3dclass_struct * thisclass_c, struct hg3dclass_struct * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  CEGUI::Window * result_cpp;
  result_cpp = (thisclass_cpp->getCurrentDropTarget());
  *result_c = getHG3DClass_Window((void *) result_cpp);
;
};

// Return whether sticky mode is enable or disabled. 
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_isStickyModeEnabled(struct hg3dclass_struct * thisclass_c, int * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  bool result_cpp;
  result_cpp = (thisclass_cpp->isStickyModeEnabled());
  *result_c = (int)result_cpp;
};

// Enable or disable sticky mode. 
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_setStickyModeEnabled(struct hg3dclass_struct * thisclass_c, int setting_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  bool setting_cpp = (bool)setting_c;
  (thisclass_cpp->setStickyModeEnabled(setting_cpp));
};

// Immediately pick up the DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_pickUp(struct hg3dclass_struct * thisclass_c, const int force_sticky_c, int * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  const bool force_sticky_cpp = (bool)force_sticky_c;
  bool result_cpp;
  result_cpp = (thisclass_cpp->pickUp(force_sticky_cpp));
  *result_c = (int)result_cpp;
};

// Set the fixed mouse cursor dragging offset to be used for this DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_setFixedDragOffset(struct hg3dclass_struct * thisclass_c, struct hg3dclass_struct * offset_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  const CEGUI::UVector2 * offset_cpp = static_cast<CEGUI::UVector2*> (getHG3DClassPtr(*offset_c, "CEGUI::UVector2"));
  (thisclass_cpp->setFixedDragOffset(*offset_cpp));
};

// Return the fixed mouse cursor dragging offset to be used for this DragContainer
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_getFixedDragOffset(struct hg3dclass_struct * thisclass_c, struct hg3dclass_struct * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  const CEGUI::UVector2 * result_cpp;
  result_cpp = &(thisclass_cpp->getFixedDragOffset());
  *result_c = getHG3DClass_UVector2((void *) result_cpp);
;
};

// Set whether the fixed dragging offset - as set with the setFixedDragOffset - function will be used, or whether the built-in positioning will be used. 
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_setUsingFixedDragOffset(struct hg3dclass_struct * thisclass_c, const int enable_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  const bool enable_cpp = (bool)enable_c;
  (thisclass_cpp->setUsingFixedDragOffset(enable_cpp));
};

// Return whether the fixed dragging offset - as set with the setFixedDragOffset function - will be used, or whether the built-in positioning will be used. 
extern "C" CEGUI_LIB_EXPORT void cegui_drgcnt_isUsingFixedDragOffset(struct hg3dclass_struct * thisclass_c, int * result_c)
{
  CEGUI::DragContainer * thisclass_cpp = static_cast<CEGUI::DragContainer*> (getHG3DClassPtr(*thisclass_c, "CEGUI::DragContainer"));
  bool result_cpp;
  result_cpp = (thisclass_cpp->isUsingFixedDragOffset());
  *result_c = (int)result_cpp;
};

