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

// ClassMultiRenderTarget.cpp

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
extern "C" Ogre_LIB_EXPORT void ogre_mrt_bindSurface(struct hg3dclass_struct * thisclass_c, int attachment_c, struct hg3dclass_struct * target_c)
{
  Ogre::MultiRenderTarget * thisclass_cpp = static_cast<Ogre::MultiRenderTarget*> (getHG3DClassPtr(*thisclass_c, "Ogre::MultiRenderTarget"));
  size_t attachment_cpp = (size_t)attachment_c;
  Ogre::RenderTexture * target_cpp = static_cast<Ogre::RenderTexture*> (getHG3DClassPtr(*target_c, "Ogre::RenderTexture"));
  (thisclass_cpp->bindSurface(attachment_cpp, target_cpp));
};

// 
extern "C" Ogre_LIB_EXPORT void ogre_mrt_unbindSurface(struct hg3dclass_struct * thisclass_c, int attachment_c)
{
  Ogre::MultiRenderTarget * thisclass_cpp = static_cast<Ogre::MultiRenderTarget*> (getHG3DClassPtr(*thisclass_c, "Ogre::MultiRenderTarget"));
  size_t attachment_cpp = (size_t)attachment_c;
  (thisclass_cpp->unbindSurface(attachment_cpp));
};

// 
extern "C" Ogre_LIB_EXPORT void ogre_mrt_getBoundSurface(struct hg3dclass_struct * thisclass_c, int index_c, struct hg3dclass_struct * result_c)
{
  Ogre::MultiRenderTarget * thisclass_cpp = static_cast<Ogre::MultiRenderTarget*> (getHG3DClassPtr(*thisclass_c, "Ogre::MultiRenderTarget"));
  size_t index_cpp = (size_t)index_c;
  Ogre::RenderTexture * result_cpp;
  result_cpp = (thisclass_cpp->getBoundSurface(index_cpp));
  *result_c = getHG3DClass_RenderTexture((void *) result_cpp);
;
};

