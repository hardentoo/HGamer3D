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

// HG3DEventStaticFunctions.cpp
// a separate Scripting Event Handler, to forward GUI Events to Haskell

#include "CEGUI/CEGUI.h"
#include "HG3DWindowStaticFunctions.h"

// functions, downcast to specialized windows, use with care :-)
CEGUI::PushButton* HG3DWindowStaticFunctions::castWindowToPushButton(CEGUI::Window * window)
{
	return (CEGUI::PushButton*)window;
}

CEGUI::Listbox* HG3DWindowStaticFunctions::castWindowToListbox(CEGUI::Window * window)
{
	return (CEGUI::Listbox*)window;
}

CEGUI::Combobox* HG3DWindowStaticFunctions::castWindowToCombobox(CEGUI::Window * window)
{
	return (CEGUI::Combobox*)window;
}


CEGUI::RadioButton* HG3DWindowStaticFunctions::castWindowToRadioButton(CEGUI::Window * window)
{
	return (CEGUI::RadioButton*)window;
}

CEGUI::Editbox* HG3DWindowStaticFunctions::castWindowToEditbox(CEGUI::Window * window)
{
	return (CEGUI::Editbox*)window;
}

CEGUI::MultiLineEditbox* HG3DWindowStaticFunctions::castWindowToMultiLineEditbox(CEGUI::Window * window)
{
	return (CEGUI::MultiLineEditbox*)window;
}

CEGUI::FrameWindow* HG3DWindowStaticFunctions::castWindowToFrameWindow(CEGUI::Window * window)
{
	return (CEGUI::FrameWindow*)window;
}

CEGUI::ProgressBar* HG3DWindowStaticFunctions::castWindowToProgressBar(CEGUI::Window * window)
{
	return (CEGUI::ProgressBar*)window;
}

CEGUI::Slider* HG3DWindowStaticFunctions::castWindowToSlider(CEGUI::Window * window)
{
	return (CEGUI::Slider*)window;
}

CEGUI::Spinner* HG3DWindowStaticFunctions::castWindowToSpinner(CEGUI::Window * window)
{
	return (CEGUI::Spinner*)window;
}

CEGUI::MultiColumnList* HG3DWindowStaticFunctions::castWindowToMultiColumnList(CEGUI::Window * window)
{
	return (CEGUI::MultiColumnList*)window;
}



// functions for UDim and UVector2

float HG3DWindowStaticFunctions::udScale( const CEGUI::UDim* ud)
{
  return ud->d_scale;
}

float HG3DWindowStaticFunctions::udOffset( const CEGUI::UDim* ud)
{
  return ud->d_offset;
}

CEGUI::UDim* HG3DWindowStaticFunctions::v2X( const CEGUI::UVector2* uv2)
{
  return (new CEGUI::UDim(uv2->d_x));
}

CEGUI::UDim* HG3DWindowStaticFunctions::v2Y( const CEGUI::UVector2* uv2)
{
  return (new CEGUI::UDim(uv2->d_y));
}

CEGUI::UDim* HG3DWindowStaticFunctions::getWindowWidth(const CEGUI::Window* window)
{
  CEGUI::UDim* pud = new CEGUI::UDim(0.0, 0.0);
  *pud = window->getWidth();
  return pud;
}

CEGUI::UDim* HG3DWindowStaticFunctions::getWindowHeight(const CEGUI::Window* window)
{
  CEGUI::UDim* pud = new CEGUI::UDim(0.0, 0.0);
  *pud = window->getHeight();
  return pud;
}
