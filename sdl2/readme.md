# SDL for Pure Basic
Complete SDL - package for Pure Basic. 
I added some small examples and a "translator" for the Lazy-Foo - SDL-Tutorials  https://lazyfoo.net/tutorials/SDL/ (please read the readme!).

## Versions:
* SDL:       2.0.14
* SDL_image: 2.0.5
* SDL_mixer: 2.0.4
* SDL_net:   2.0.1
* SDL_ttf:   2.0.15

## Windows:
All necassarys dlls are included.

## MacOs:
Mac users must download and install the sdl-framework:

* download *.dmg from this files
  * https://www.libsdl.org/download-2.0.php#source
  * https://www.libsdl.org/projects/SDL_image/
  * https://www.libsdl.org/projects/SDL_mixer/
  * https://www.libsdl.org/projects/SDL_net/
  * https://www.libsdl.org/projects/SDL_rtf/
  * https://www.libsdl.org/projects/SDL_ttf/
* open the *.dmg	
* copy "sdl*.frameworks" to /Library/Frameworks/	

more infos for example here: https://lazyfoo.net/tutorials/SDL/01_hello_SDL/mac/index.php

## Linux:
Install with your packet manager:

* libsdl2-dev
* libsdl2-image-dev
* libsdl2-mixer-dev
* libsdl2-net-dev
* libsdl2-ttf-dev

sudo apt-get install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev

**ATTENTION**

With Ubuntu you will get an outdated sdl 2.0.10 - see WhatsNew-SDL.txt for differences.

## How to start.
Simple XIncludeFile "sdl2\sdl.pbi" and the basic-sdl should work. All functions are in a module. Instead of SDL_INIT(#SDL_INIT_VIDEO) write SDL::INIT(SDL::#INIT_VIDEO). For mixer include "sdl2\SDL_image.pbi" before the "sdl2\SDL.pbi". More infos in the SDL.pbi.

## Changes
* SDL

  there are some conflicts with #pb-constants. Add a _ at the end:
  * SDL::#GL_DOUBLEBUFFER_
  * SDL::#GL_STEREO_
  * SDL::#THREAD_PRIORITY_NORMAL_
  * SDL::#THREAD_PRIORITY_TIME_CRITICAL_
  * SDL::#AUDIO_U16SYS_
  * SDL::#AUDIO_S16SYS_
  * SDL::#AUDIO_S32SYS_
  * SDL::#AUDIO_F32SYS_
  
* SDL_Image

  XIncludeFile "sdl2/SDL_image.pbi" before "sdl2/SDL.pbi" - everything is in the module SDL.
  
* SDL_mixer

  XIncludeFile "sdl2/SDL_mixer.pbi" before "sdl2/SDL.pbi" - everything is in the module SDL.
  
* SDL_net

  XIncludeFile "sdl2/SDL_net.pbi" before "sdl2/SDL.pbi" - everything is in the module SDL.
  Renamed everything form SDLNet_* in SDL::Net_*
  
* SDL_ttf

  XIncludeFile "sdl2/SDL_ttf.pbi" before "sdl2/SDL.pbi" - everything is in the module SDL.
  Because PB is unicode by default, I renamed the original TTF_RenderText*() to TTF_RenderASCII*() and TTF_RenderUnicode*() to TTF_RenderText*()

https://github.com/GPIforGit/SDL_For_PB/releases
