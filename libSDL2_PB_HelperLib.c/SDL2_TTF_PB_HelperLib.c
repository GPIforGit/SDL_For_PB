
#include "begin_code.h"
#ifdef __cplusplus
extern "C" {
#endif

//SDL_DISABLE_ANALYZE_MACROS
#define SDL_IN_BYTECAP(x)
#define SDL_INOUT_Z_CAP(x)
#define SDL_OUT_Z_CAP(x)
#define SDL_OUT_CAP(x)
#define SDL_OUT_BYTECAP(x)
#define SDL_OUT_Z_BYTECAP(x)
#define SDL_PRINTF_FORMAT_STRING
#define SDL_SCANF_FORMAT_STRING
#define SDL_PRINTF_VARARG_FUNC( fmtargnumber )
#define SDL_SCANF_VARARG_FUNC( fmtargnumber )

typedef unsigned short Uint16;
typedef unsigned long Uint32;

typedef struct SDL_Color
{
    char r;
    char g;
    char b;
    char a;
} SDL_Color;
#define SDL_Colour SDL_Color

struct _SDL_Surface;
typedef struct _SDL_Surface SDL_Surface;

typedef struct _TTF_Font TTF_Font;


typedef SDL_Surface *(SDLCALL TTF_Render) (TTF_Font *font, const char *text, SDL_Color fg);

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderText_Solid(TTF_Font *font, const char *text, SDL_Color fg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUTF8_Solid(TTF_Font *font, const char *text, SDL_Color fg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUNICODE_Solid(TTF_Font *font, const Uint16 *text, SDL_Color fg);

SDL_Surface * _Helper_RenderText_Solid(TTF_Font *font, const char *text, SDL_Color *fg){
    return TTF_RenderText_Solid(font, text, *fg);
}
SDL_Surface * _Helper_RenderUTF8_Solid(TTF_Font *font, const char *text, SDL_Color *fg){
    return TTF_RenderUTF8_Solid(font, text, *fg);
}
SDL_Surface * _Helper_RenderUNICODE_Solid(TTF_Font *font, const Uint16 *text, SDL_Color *fg){
    return TTF_RenderUNICODE_Solid(font, text, *fg);
}

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderGlyph_Solid(TTF_Font *font, Uint16 ch, SDL_Color fg);

SDL_Surface * _Helper_RenderGlyph_Solid(TTF_Font *font, Uint16 ch, SDL_Color *fg){
    return TTF_RenderGlyph_Solid(font, ch, *fg);
}

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderText_Shaded(TTF_Font *font, const char *text, SDL_Color fg, SDL_Color bg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUTF8_Shaded(TTF_Font *font, const char *text, SDL_Color fg, SDL_Color bg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUNICODE_Shaded(TTF_Font *font, const Uint16 *text, SDL_Color fg, SDL_Color bg);

SDL_Surface * _Helper_RenderText_Shaded(TTF_Font *font, const char *text, SDL_Color *fg, SDL_Color *bg){
    return TTF_RenderText_Shaded(font, text, *fg, *bg);
}
SDL_Surface * _Helper_RenderUTF8_Shaded(TTF_Font *font, const char *text, SDL_Color *fg, SDL_Color *bg){
    return TTF_RenderUTF8_Shaded(font, text, *fg, *bg);
}
SDL_Surface * _Helper_RenderUNICODE_Shaded(TTF_Font *font, const Uint16 *text, SDL_Color *fg, SDL_Color *bg){
    return TTF_RenderUNICODE_Shaded(font, text, *fg, *bg);
}

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderGlyph_Shaded(TTF_Font *font, Uint16 ch, SDL_Color fg, SDL_Color bg);

SDL_Surface * _Helper_RenderGlyph_Shaded(TTF_Font *font, Uint16 ch, SDL_Color *fg, SDL_Color *bg){
    return TTF_RenderGlyph_Shaded(font, ch, *fg, *bg);
}

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderText_Blended(TTF_Font *font, const char *text, SDL_Color fg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUTF8_Blended(TTF_Font *font, const char *text, SDL_Color fg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUNICODE_Blended(TTF_Font *font, const Uint16 *text, SDL_Color fg);

SDL_Surface * _Helper_RenderText_Blended(TTF_Font *font, const char *text, SDL_Color *fg){
    return TTF_RenderText_Blended(font, text, *fg);
}
SDL_Surface * _Helper_RenderUTF8_Blended(TTF_Font *font, const char *text, SDL_Color *fg){
    return TTF_RenderUTF8_Blended(font, text, *fg);
}
SDL_Surface * _Helper_RenderUNICODE_Blended(TTF_Font *font, const Uint16 *text, SDL_Color *fg){
    return TTF_RenderUNICODE_Blended(font, text, *fg);
}

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderGlyph_Blended(TTF_Font *font, Uint16 ch, SDL_Color fg);

SDL_Surface * _Helper_RenderGlyph_Blended(TTF_Font *font, Uint16 ch, SDL_Color *fg){
    return TTF_RenderGlyph_Blended(font, ch, *fg);
}

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderText_Blended_Wrapped(TTF_Font *font, const char *text, SDL_Color fg, Uint32 wrapLength);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUTF8_Blended_Wrapped(TTF_Font *font, const char *text, SDL_Color fg, Uint32 wrapLength);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUNICODE_Blended_Wrapped(TTF_Font *font, const Uint16 *text, SDL_Color fg, Uint32 wrapLength);

SDL_Surface * _Helper_RenderText_Blended_Wrapped(TTF_Font *font, const char *text, SDL_Color *fg, Uint32 wrapLength){
    return TTF_RenderText_Blended_Wrapped(font, text, *fg, wrapLength);
}
SDL_Surface * _Helper_RenderUTF8_Blended_Wrapped(TTF_Font *font, const char *text, SDL_Color *fg, Uint32 wrapLength){
    return TTF_RenderUTF8_Blended_Wrapped(font, text, *fg, wrapLength);
}
SDL_Surface * _Helper_RenderUNICODE_Blended_Wrapped(TTF_Font *font, const Uint16 *text, SDL_Color *fg, Uint32 wrapLength){
    return TTF_RenderUNICODE_Blended_Wrapped(font, text, *fg, wrapLength);
}

#ifdef __cplusplus
}
#endif

#include "close_code.h"
