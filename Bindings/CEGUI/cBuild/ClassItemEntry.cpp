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

// ClassItemEntry.cpp

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



// Returns whether this item is selected or not. 
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_isSelected(struct hg3dclass_struct * thisclass_c, int * result_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  bool result_cpp;
  result_cpp = (thisclass_cpp->isSelected());
  *result_c = (int)result_cpp;
};

// Returns whether this item is selectable or not. 
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_isSelectable(struct hg3dclass_struct * thisclass_c, int * result_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  bool result_cpp;
  result_cpp = (thisclass_cpp->isSelectable());
  *result_c = (int)result_cpp;
};

// Sets the selection state of this item (on/off). If this item is not selectable this function does nothing. 
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_setSelected(struct hg3dclass_struct * thisclass_c, int setting_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  bool setting_cpp = (bool)setting_c;
  (thisclass_cpp->setSelected(setting_cpp));
};

// Selects the item. 
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_select(struct hg3dclass_struct * thisclass_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  (thisclass_cpp->select());
};

// Deselects the item. 
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_deselect(struct hg3dclass_struct * thisclass_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  (thisclass_cpp->deselect());
};

// Set the selection state for this ListItem. Internal version. Should NOT be used by client code. 
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_setSelected_impl(struct hg3dclass_struct * thisclass_c, int state_c, int notify_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  bool state_cpp = (bool)state_c;
  bool notify_cpp = (bool)notify_c;
  (thisclass_cpp->setSelected_impl(state_cpp, notify_cpp));
};

// Sets whether this item will be selectable. 
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_setSelectable(struct hg3dclass_struct * thisclass_c, int setting_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  bool setting_cpp = (bool)setting_c;
  (thisclass_cpp->setSelectable(setting_cpp));
};

// Constructor for ItemEntry
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_construct(char * type_c, char * name_c, struct hg3dclass_struct * result_c)
{
  CEGUI::String type_cpp = CEGUI::String((const char*) type_c);
  CEGUI::String name_cpp = CEGUI::String((const char*) name_c);
  CEGUI::ItemEntry * result_cpp;
  result_cpp = (new CEGUI::ItemEntry(type_cpp, name_cpp));
  *result_c = getHG3DClass_ItemEntry((void *) result_cpp);
;
};

// Destructor for ItemEntry
extern "C" CEGUI_LIB_EXPORT void cegui_itmentr_destruct(struct hg3dclass_struct * thisclass_c)
{
  CEGUI::ItemEntry * thisclass_cpp = static_cast<CEGUI::ItemEntry*> (getHG3DClassPtr(*thisclass_c, "CEGUI::ItemEntry"));
  (delete thisclass_cpp);
};

