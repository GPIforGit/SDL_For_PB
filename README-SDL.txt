
                         Simple DirectMedia Layer

                                  (SDL)

                                Version 2.0

---
https://www.libsdl.org/

Simple DirectMedia Layer is a cross-platform development library designed
to provide low level access to audio, keyboard, mouse, joystick, and graphics
hardware via OpenGL and Direct3D. It is used by video playback software,
emulators, and popular games including Valve's award winning catalog
and many Humble Bundle games.

More extensive documentation is available in the docs directory, starting
with README.md

Enjoy!
	Sam Lantinga				(slouken@libsdl.org)

--------------------------------------------------------------------------

Please distribute this file with the SDL runtime environment:

The Simple DirectMedia Layer (SDL for short) is a cross-platform library
designed to make it easy to write multi-media software, such as games
and emulators.

The Simple DirectMedia Layer library source code is available from:
https://www.libsdl.org/

This library is distributed under the terms of the zlib license:
http://www.zlib.net/zlib_license.html

--------------------------------------------------------------------------

This library is a wrapper around the excellent FreeType 2.0 library,
available at:
	http://www.freetype.org/

This library allows you to use TrueType fonts to render text in SDL
applications.

To make the library, first install the FreeType library, then type
'./configure' then 'make' to build the SDL truetype library and the
showfont and glfont example applications.

Be careful when including fonts with your application, as many of them
are copyrighted.  The Microsoft fonts, for example, are not freely 
redistributable and even the free "web" fonts they provide are only 
redistributable in their special executable installer form (May 1998).
There are plenty of freeware and shareware fonts available on the Internet
though, and may suit your purposes.

This library is under the zlib license, see the file "COPYING.txt" for details.

Portions of this software are copyright © 2013 The FreeType Project (www.freetype.org).  All rights reserved.

Enjoy!
	-Sam Lantinga <slouken@libsdl.org>		(6/20/2001)

--------------------------------------------------------------------------

SDL_net 2.0

The latest version of this library is available from:
http://www.libsdl.org/projects/SDL_net/

This is an example portable network library for use with SDL.
It is available under the zlib license, found in the file COPYING.txt.
The API can be found in the file SDL_net.h
This library supports UNIX, Windows, MacOS Classic, MacOS X,
BeOS and QNX.

The demo program is a chat client and server.
The chat client requires the sample GUI library available at:
http://www.libsdl.org/projects/GUIlib/
The chat client connects to the server via TCP, registering itself.
The server sends back a list of connected clients, and keeps the
client updated with the status of other clients.
Every line of text from a client is sent via UDP to every other client.

Note that this isn't necessarily how you would want to write a chat
program, but it demonstrates how to use the basic features of the 
network library.

Enjoy!
	-Sam Lantinga and Roy Wood

--------------------------------------------------------------------------

SDL_image 2.0

The latest version of this library is available from:
http://www.libsdl.org/projects/SDL_image/

This is a simple library to load images of various formats as SDL surfaces.
This library supports BMP, PNM (PPM/PGM/PBM), XPM, LBM, PCX, GIF, JPEG, PNG,
TGA, TIFF, and simple SVG formats.

API:
#include "SDL_image.h"

	SDL_Surface *IMG_Load(const char *file);
or
	SDL_Surface *IMG_Load_RW(SDL_RWops *src, int freesrc);
or
	SDL_Surface *IMG_LoadTyped_RW(SDL_RWops *src, int freesrc, char *type);

where type is a string specifying the format (i.e. "PNG" or "pcx").
Note that IMG_Load_RW cannot load TGA images.

To create a surface from an XPM image included in C source, use:

	SDL_Surface *IMG_ReadXPMFromArray(char **xpm);

An example program 'showimage' is included, with source in showimage.c

JPEG support requires the JPEG library: http://www.ijg.org/
PNG support requires the PNG library: http://www.libpng.org/pub/png/libpng.html
    and the Zlib library: http://www.gzip.org/zlib/
TIFF support requires the TIFF library: ftp://ftp.sgi.com/graphics/tiff/

If you have these libraries installed in non-standard places, you can
try adding those paths to the configure script, e.g.
sh ./configure CPPFLAGS="-I/somewhere/include" LDFLAGS="-L/somewhere/lib"
If this works, you may need to add /somewhere/lib to your LD_LIBRARY_PATH
so shared library loading works correctly.

This library is under the zlib License, see the file "COPYING.txt" for details.

--------------------------------------------------------------------------

SDL_mixer 2.0

The latest version of this library is available from:
http://www.libsdl.org/projects/SDL_mixer/

Due to popular demand, here is a simple multi-channel audio mixer.
It supports 8 channels of 16 bit stereo audio, plus a single channel
of music.

See the header file SDL_mixer.h and the examples playwave.c and playmus.c
for documentation on this mixer library.

The mixer can currently load Microsoft WAVE files and Creative Labs VOC
files as audio samples, it can load FLAC files with libFLAC, it can load
Ogg Vorbis files with Ogg Vorbis or Tremor libraries, it can load MP3 files
using mpg123 or libmad, and it can load MIDI files with Timidity,
FluidSynth, and natively on Windows, Mac OSX, and Linux, and finally it can
load the following file formats via ModPlug or MikMod: .MOD .S3M .IT .XM.

Tremor decoding is disabled by default; you can enable it by passing
	--enable-music-ogg-tremor
to configure, or by defining MUSIC_OGG and OGG_USE_TREMOR.

libmad decoding is disabled by default; you can enable it by passing
	--enable-music-mp3-mad
to configure, or by defining MUSIC_MP3_MAD
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
WARNING: The license for libmad is GPL, which means that in order to
         use it your application must also be GPL!
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The process of mixing MIDI files to wave output is very CPU intensive,
so if playing regular WAVE files sound great, but playing MIDI files
sound choppy, try using 8-bit audio, mono audio, or lower frequencies.

To play MIDI files using FluidSynth, you'll need to set the SDL_SOUNDFONTS
environment variable to a Sound Font 2 (.sf2) file containing the musical
instruments you want to use for MIDI playback.
(On some Linux distributions you can install the fluid-soundfont-gm package)

To play MIDI files using Timidity, you'll need to get a complete set of
GUS patches from:
http://www.libsdl.org/projects/mixer/timidity/timidity.tar.gz
and unpack them in /usr/local/lib under UNIX, and C:\ under Win32.

iOS:
In order to use this library on iOS, you should include the SDL.xcodeproj
and Xcode-iOS/SDL_mixer.xcodeproj in your application, add the SDL/include
and SDL_mixer directories to your "Header Search Paths" setting, then add the
libSDL2.a and libSDL2_mixer.a to your "Link Binary with Libraries" setting.

This library is under the zlib license, see the file "COPYING.txt" for details.