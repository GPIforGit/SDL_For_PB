hi,

I have translated the c-header from the complete SDL - package for Pure Basic. 
I added some small exmaples and a "translator" for the Lazy-Foo - SDL-Tutorials  https://lazyfoo.net/tutorials/SDL/ (please read the readme!).

Mac users must download and install the sdl-framework:
download *.dmg from this files
		https://www.libsdl.org/download-2.0.php#source
		https://www.libsdl.org/projects/SDL_image/
		https://www.libsdl.org/projects/SDL_mixer/
		https://www.libsdl.org/projects/SDL_net/
		https://www.libsdl.org/projects/SDL_rtf/
		https://www.libsdl.org/projects/SDL_ttf/
	open the *.dmg
	copy "sdl*.frameworks" to /Library/Frameworks/
	more infos for example here: https://lazyfoo.net/tutorials/SDL/01_hello_SDL/mac/index.php

Sorry, I don't have any experience with linux, but it should easy to add support for it. When somebody has done it, I will add this to the package.

Why SDL?
- Check mouse without problems, when in windows a desktop-scale is set other than 100%
- Switch between window, borderless window and fullscreen without reloading all the sprites.
- Playback of mp3, ogg etc. (I had the problem, that PB doesn't like my OGGs)
- Support for Joystick and Gamepad - including rumble. Simple connect a PS4, XBOX or Switch-Pro Controller and SDL will support it.

How to start.
Simple xincludefile "sdl2\sdl.pbi" and the basic-sdl should work. Important, all functions are in a module. Instead of SDL_INIT(#SDL_INIT_VIDEO) write SDL::INIT(SDL::#INIT_VIDEO). For mixer include "sdl2\SDL_image.pbi" before the "sdl2\SDL.pbi". More infos in the SDL.pbi.

IMPORTANT:
Das ist die erste Funktion. And SDL is big, so maybe there are some bugs.

https://github.com/GPIforGit/SDL_For_PB/releases
