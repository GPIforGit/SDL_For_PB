
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

typedef enum{
    SDL_CONTROLLER_BINDTYPE_NONE = 0,
    SDL_CONTROLLER_BINDTYPE_BUTTON,
    SDL_CONTROLLER_BINDTYPE_AXIS,
    SDL_CONTROLLER_BINDTYPE_HAT
} SDL_GameControllerBindType;

typedef enum{
    SDL_CONTROLLER_AXIS_INVALID = -1,
    SDL_CONTROLLER_AXIS_LEFTX,
    SDL_CONTROLLER_AXIS_LEFTY,
    SDL_CONTROLLER_AXIS_RIGHTX,
    SDL_CONTROLLER_AXIS_RIGHTY,
    SDL_CONTROLLER_AXIS_TRIGGERLEFT,
    SDL_CONTROLLER_AXIS_TRIGGERRIGHT,
    SDL_CONTROLLER_AXIS_MAX
} SDL_GameControllerAxis;

typedef enum{
    SDL_CONTROLLER_BUTTON_INVALID = -1,
    SDL_CONTROLLER_BUTTON_A,
    SDL_CONTROLLER_BUTTON_B,
    SDL_CONTROLLER_BUTTON_X,
    SDL_CONTROLLER_BUTTON_Y,
    SDL_CONTROLLER_BUTTON_BACK,
    SDL_CONTROLLER_BUTTON_GUIDE,
    SDL_CONTROLLER_BUTTON_START,
    SDL_CONTROLLER_BUTTON_LEFTSTICK,
    SDL_CONTROLLER_BUTTON_RIGHTSTICK,
    SDL_CONTROLLER_BUTTON_LEFTSHOULDER,
    SDL_CONTROLLER_BUTTON_RIGHTSHOULDER,
    SDL_CONTROLLER_BUTTON_DPAD_UP,
    SDL_CONTROLLER_BUTTON_DPAD_DOWN,
    SDL_CONTROLLER_BUTTON_DPAD_LEFT,
    SDL_CONTROLLER_BUTTON_DPAD_RIGHT,
    SDL_CONTROLLER_BUTTON_MAX
} SDL_GameControllerButton;

typedef enum{
    SDL_LOG_PRIORITY_VERBOSE = 1,
    SDL_LOG_PRIORITY_DEBUG,
    SDL_LOG_PRIORITY_INFO,
    SDL_LOG_PRIORITY_WARN,
    SDL_LOG_PRIORITY_ERROR,
    SDL_LOG_PRIORITY_CRITICAL,
    SDL_NUM_LOG_PRIORITIES
} SDL_LogPriority;


typedef struct {
    char data[16];
} SDL_JoystickGUID;

typedef struct _SDL_GameControllerButtonBind
{
    SDL_GameControllerBindType bindType;
    union
    {
        int button;
        int axis;
        struct {
            int hat;
            int hat_mask;
        } hat;
    } value;

} SDL_GameControllerButtonBind;

typedef struct SDL_Color
{
    char r;
    char g;
    char b;
    char a;
} SDL_Color;
#define SDL_Colour SDL_Color

struct _SDL_GameController;
typedef struct _SDL_GameController SDL_GameController;

struct _SDL_Joystick;
typedef struct _SDL_Joystick SDL_Joystick;

struct _TTF_Font;
typedef struct _TTF_Font TTF_Font;

struct _SDL_Surface;
typedef struct _SDL_Surface SDL_Surface;

struct SDL_Thread;
typedef struct SDL_Thread SDL_Thread;

typedef int (SDLCALL * SDL_ThreadFunction) (void *data);

// global return variables

SDL_JoystickGUID ret_JoystickGuid;
SDL_GameControllerButtonBind ret_GameControllerButtonBind;

//-
extern DECLSPEC SDL_JoystickGUID SDLCALL SDL_JoystickGetDeviceGUID(int device_index);
SDL_JoystickGUID* _Helper_JoystickGetDeviceGUID(int index){
    ret_JoystickGuid= SDL_JoystickGetDeviceGUID(index);
    return &ret_JoystickGuid;
}

extern DECLSPEC SDL_JoystickGUID SDLCALL SDL_JoystickGetGUID(SDL_Joystick * joystick);
SDL_JoystickGUID* _Helper_JoystickGetGUID(SDL_Joystick * joystick){
    ret_JoystickGuid= SDL_JoystickGetGUID(joystick);
    return &ret_JoystickGuid;
}

extern DECLSPEC SDL_JoystickGUID SDLCALL SDL_JoystickGetGUIDFromString(const char *pchGUID);
 SDL_JoystickGUID* _Helper_JoystickGetGUIDFromString(const char *pchGUID){
    ret_JoystickGuid= SDL_JoystickGetGUIDFromString(pchGUID);
    return &ret_JoystickGuid;
}

extern DECLSPEC void SDLCALL SDL_JoystickGetGUIDString(SDL_JoystickGUID guid, char *pszGUID, int cbGUID);
void _Helper_JoystickGetGUIDString(SDL_JoystickGUID *guid, char *pszGUID, int cbGUID){
    return SDL_JoystickGetGUIDString(*guid,pszGUID,cbGUID);
}

extern DECLSPEC int SDLCALL SDL_SetError(SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(1);
int _Helper_SetError(const char *fmt){
    return SDL_SetError(fmt);
}

extern DECLSPEC char * SDLCALL SDL_GameControllerMappingForGUID(SDL_JoystickGUID guid);
char * _Helper_GameControllerMappingForGUID(const SDL_JoystickGUID *guid){
    ret_JoystickGuid=*guid;
    return SDL_GameControllerMappingForGUID(ret_JoystickGuid);
}

extern DECLSPEC SDL_GameControllerButtonBind SDLCALL SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller, SDL_GameControllerAxis axis);
SDL_GameControllerButtonBind* _Helper_GameControllerGetBindForAxis(SDL_GameController *gamecontroller, SDL_GameControllerAxis axis){
    ret_GameControllerButtonBind = SDL_GameControllerGetBindForAxis(gamecontroller, axis);
    return &ret_GameControllerButtonBind;
}

extern DECLSPEC SDL_GameControllerButtonBind SDLCALL SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller, SDL_GameControllerButton button);
SDL_GameControllerButtonBind* _Helper_GameControllerGetBindForButton(SDL_GameController *gamecontroller, SDL_GameControllerButton button){
    ret_GameControllerButtonBind = SDL_GameControllerGetBindForButton(gamecontroller,button);
    return &ret_GameControllerButtonBind;
}


extern DECLSPEC void SDLCALL SDL_Log(SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(1);
extern DECLSPEC void SDLCALL SDL_LogVerbose(int category, SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(2);
extern DECLSPEC void SDLCALL SDL_LogDebug(int category, SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(2);
extern DECLSPEC void SDLCALL SDL_LogInfo(int category, SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(2);
extern DECLSPEC void SDLCALL SDL_LogWarn(int category, SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(2);
extern DECLSPEC void SDLCALL SDL_LogError(int category, SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(2);
extern DECLSPEC void SDLCALL SDL_LogCritical(int category, SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(2);
void   _Helper_Log(const char *fmt){
    return SDL_Log(fmt);
}
void   _Helper_LogVerbose(int category, const char *fmt){
    return SDL_LogVerbose(category, fmt);
}
void   _Helper_LogDebug(int category, const char *fmt){
    return SDL_LogDebug(category, fmt);
}
void   _Helper_LogInfo(int category, const char *fmt){
    return SDL_LogInfo(category, fmt);
}
void   _Helper_LogWarn(int category, const char *fmt){
    return SDL_LogWarn(category, fmt);
}
void   _Helper_LogError(int category, const char *fmt){
    return SDL_LogError(category, fmt);
}
void   _Helper_LogCritical(int category, const char *fmt){
    return SDL_LogCritical(category, fmt);
}

extern DECLSPEC void SDLCALL SDL_LogMessage(int category, SDL_LogPriority priority, SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(3);
void _Helper_LogMessage(int category, SDL_LogPriority priority,const char *fmt){
    return SDL_LogMessage(category, priority, fmt);
}

#if defined(WIN32) || defined(_WIN32) || defined(__CYGWIN__) || defined(__MINGW32__)
#include <process.h>
typedef uintptr_t (__cdecl * pfnSDL_CurrentBeginThread)
                   (void *, unsigned, unsigned (__stdcall *func)(void *),
                    void * /*arg*/, unsigned, unsigned * /* threadID */);
typedef void (__cdecl * pfnSDL_CurrentEndThread) (unsigned code);
#define SDL_beginthread _beginthreadex
#define SDL_endthread _endthreadex
extern DECLSPEC SDL_Thread *SDLCALL
SDL_CreateThread(SDL_ThreadFunction fn, const char *name, void *data,
                 pfnSDL_CurrentBeginThread pfnBeginThread,
                 pfnSDL_CurrentEndThread pfnEndThread);

extern DECLSPEC SDL_Thread *SDLCALL
SDL_CreateThreadWithStackSize(int (SDLCALL * fn) (void *),
                 const char *name, const size_t stacksize, void *data,
                 pfnSDL_CurrentBeginThread pfnBeginThread,
                 pfnSDL_CurrentEndThread pfnEndThread);


SDL_Thread * _Helper_CreateThread(SDL_ThreadFunction fn, const char *name, void *data){
    return SDL_CreateThread(fn, name, data, (pfnSDL_CurrentBeginThread)SDL_beginthread, (pfnSDL_CurrentEndThread)SDL_endthread);
}
SDL_Thread * _Helper_CreateThreadWithStackSize(int (SDLCALL * fn) (void *), const char *name, const size_t stacksize, void *data){
    return SDL_CreateThreadWithStackSize(fn, name, stacksize, data, (pfnSDL_CurrentBeginThread)_beginthreadex, (pfnSDL_CurrentEndThread)SDL_endthread);
}

#endif





#ifdef __cplusplus
}
#endif

#include "close_code.h"
