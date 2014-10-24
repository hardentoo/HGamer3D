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

// ClassHG3DListboxStaticFunctions.cpp

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



// 
extern "C" CEGUI_LIB_EXPORT void cegui_hg3dlstbxsf_listboxAddItem(struct hg3dclass_struct * listbox_c, char * itemString_c)
{
  CEGUI::Listbox * listbox_cpp = static_cast<CEGUI::Listbox*> (getHG3DClassPtr(*listbox_c, "CEGUI::Listbox"));
  CEGUI::String itemString_cpp = CEGUI::String((const char*) itemString_c);
  (HG3DListboxStaticFunctions::listboxAddItem(listbox_cpp, itemString_cpp));
};

// 
extern "C" CEGUI_LIB_EXPORT void cegui_hg3dlstbxsf_comboboxAddItem(struct hg3dclass_struct * combobox_c, char * itemString_c)
{
  CEGUI::Combobox * combobox_cpp = static_cast<CEGUI::Combobox*> (getHG3DClassPtr(*combobox_c, "CEGUI::Combobox"));
  CEGUI::String itemString_cpp = CEGUI::String((const char*) itemString_c);
  (HG3DListboxStaticFunctions::comboboxAddItem(combobox_cpp, itemString_cpp));
};

