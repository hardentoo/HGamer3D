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

// ClassManualObjectFactory.cpp

// 

#include <wchar.h>
#include <string>
#include <iostream>

#include <iostream>
	#include <typeinfo>
	#include <stdio.h>
	#include <cstring>
	#include <exception>
	#include "OgreDllDefines.h"
	#include "ClassPtr.h"
	#include "./Ogre.h"
#include "./OgreString.h"
#include "./WindowUtilsHG3D.h"
#include "HG3DUtilities.h"

using namespace Ogre;



// 
extern "C" Ogre_LIB_EXPORT void ogre_mnof_construct(struct hg3dclass_struct * result_c)
{
  Ogre::ManualObjectFactory * result_cpp;
  result_cpp = (new Ogre::ManualObjectFactory());
  *result_c = getHG3DClass_ManualObjectFactory((void *) result_cpp);
;
};

// 
extern "C" Ogre_LIB_EXPORT void ogre_mnof_destruct(struct hg3dclass_struct * thisclass_c)
{
  Ogre::ManualObjectFactory * thisclass_cpp = static_cast<Ogre::ManualObjectFactory*> (getHG3DClassPtr(*thisclass_c, "Ogre::ManualObjectFactory"));
  (delete thisclass_cpp);
};

// Get the type of the object to be created. 
extern "C" Ogre_LIB_EXPORT void ogre_mnof_getType(struct hg3dclass_struct * thisclass_c, char * result_c)
{
  Ogre::ManualObjectFactory * thisclass_cpp = static_cast<Ogre::ManualObjectFactory*> (getHG3DClassPtr(*thisclass_c, "Ogre::ManualObjectFactory"));
  Ogre::String result_cpp;
  result_cpp = (thisclass_cpp->getType());
  if (strlen( (char *) result_cpp.c_str()) < (1024 * 64 - 1))  { 
    strcpy(result_c, (char *) result_cpp.c_str()); 
  } else {
    strcpy(result_c, "error: outstring larger then 64k");
  };
};

// 
extern "C" Ogre_LIB_EXPORT void ogre_mnof_destroyInstance(struct hg3dclass_struct * thisclass_c, struct hg3dclass_struct * obj_c)
{
  Ogre::ManualObjectFactory * thisclass_cpp = static_cast<Ogre::ManualObjectFactory*> (getHG3DClassPtr(*thisclass_c, "Ogre::ManualObjectFactory"));
  Ogre::MovableObject * obj_cpp = static_cast<Ogre::MovableObject*> (getHG3DClassPtr(*obj_c, "Ogre::MovableObject"));
  (thisclass_cpp->destroyInstance(obj_cpp));
};

