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

// ClassSoundBuffer.h

// 

#include "wchar.h"
#ifndef _DEFINED_HG3D_ClassSoundBuffer
#define _DEFINED_HG3D_ClassSoundBuffer

#include "ClassPtr.h"


// Default constructor. 
void sfml_snbf_construct(struct hg3dclass_struct * result_c);

// Destructor. 
void sfml_snbf_destruct(struct hg3dclass_struct * thisclass_c);

// Load the sound buffer from a file. 
void sfml_snbf_loadFromFile(struct hg3dclass_struct * thisclass_c, char * filename_c, int * result_c);

// Save the sound buffer to an audio file. 
void sfml_snbf_saveToFile(struct hg3dclass_struct * thisclass_c, char * filename_c, int * result_c);

// Get the sample rate of the sound. 
void sfml_snbf_getSampleRate(struct hg3dclass_struct * thisclass_c, unsigned int * result_c);

// Get the number of channels used by the sound. 
void sfml_snbf_getChannelCount(struct hg3dclass_struct * thisclass_c, unsigned int * result_c);

#endif 
