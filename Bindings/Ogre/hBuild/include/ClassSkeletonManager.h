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

// ClassSkeletonManager.h

// 

#include "wchar.h"
#ifndef _DEFINED_HG3D_ClassSkeletonManager
#define _DEFINED_HG3D_ClassSkeletonManager

#include "ClassPtr.h"


// Constructor. 
void ogre_sklmgr_construct(struct hg3dclass_struct * result_c);

// 
void ogre_sklmgr_destruct(struct hg3dclass_struct * thisclass_c);

// 
void ogre_sklmgr_getSingleton(struct hg3dclass_struct * result_c);

// 
void ogre_sklmgr_getSingletonPtr(struct hg3dclass_struct * result_c);

#endif 
