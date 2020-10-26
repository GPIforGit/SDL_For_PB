;  Simple DirectMedia Layer
;  Copyright (C) 1997-2020 Sam Lantinga <slouken@libsdl.org>
;
;  This software is provided 'as-is', without any express or implied
;  warranty.  In no event will the authors be held liable for any damages
;  arising from the use of this software.
;
;  Permission is granted to anyone to use this software for any purpose,
;  including commercial applications, and to alter it and redistribute it
;  freely, subject to the following restrictions:
;
;  1. The origin of this software must not be misrepresented; you must not
;     claim that you wrote the original software. If you use this software
;     in a product, an acknowledgment in the product documentation would be
;     appreciated but is not required.
;  2. Altered source versions must be plainly marked as such, and must not be
;     misrepresented as being the original software.
;  3. This notice may not be removed or altered from any source distribution.
;
; ---------------------------------------------------------------------------
;
; Converted for PB 2020 by GPI
;    Thanks to ccode_new for the linux-helper-lib
;
; ---------------------------------------------------------------------------
; Documentations:
;
;   SDL:       http://wiki.libsdl.org/FrontPage
;   SDL_image: https://www.libsdl.org/projects/SDL_image/docs/
;   SDL_mixer: https://www.libsdl.org/projects/SDL_mixer/docs/index.html
;   SDL_net:   https://www.libsdl.org/projects/SDL_net/docs/
;   SDL_ttf:   https://www.libsdl.org/projects/SDL_ttf/docs/index.html
;
; Versions:
;   SDL:       2.0.12
;   SDL_image: 2.0.5
;   SDL_mixer: 2.0.4
;   SDL_net:   2.0.1
;   SDL_ttf:   2.0.15
;
; Conflict with pb-constants:
;   #GL_DOUBLEBUFFER_
;   #GL_STEREO_
;   #THREAD_PRIORITY_NORMAL_
;   #THREAD_PRIORITY_TIME_CRITICAL_
;   #AUDIO_U16SYS_
;   #AUDIO_S16SYS_
;   #AUDIO_S32SYS_
;   #AUDIO_F32SYS_
;
; Changes in SDL
;   Everything is in the modul SDL, so remove SDL_ and write SDL::
;
; Changes in SDL_Image
;   xincludefile "sdl2\SDL_image.pbi" before "sdl2\SDL.pbi" - everything is in the module SDL.
; 
; Changes in SDL_mixer
;   xincludefile "sdl2\SDL_mixer.pbi" before "sdl2\SDL.pbi" - everything is in the module SDL.
;
; Changes in SDL_net
;   xincludefile "sdl2\SDL_net.pbi" before "sdl2\SDL.pbi" - everything is in the module SDL.
;   Renamed everything form SDLNet_* in SDL::Net_*
;
; Changes in SDL_ttf
;   xincludefile "sdl2\SDL_ttf.pbi" before "sdl2\SDL.pbi" - everything is in the module SDL.
;   Because PB is unicode by default, I renamed the original TTF_RenderText*() to TTF_RenderASCII*() and TTF_RenderUnicode*() to TTF_RenderText*()
;
DeclareModule SDL
  ;from SDL_version.h.pbi
  Macro VERSIONNUM(X, Y, Z): ((X)*1000 + (Y)*100 + (Z)) :EndMacro
  Macro VERSION_ATLEAST(X, Y, Z): (sdl::#COMPILEDVERSION >= sdl::VERSIONNUM(X, Y, Z)) :EndMacro
  #MAJOR_VERSION = 2
  #MINOR_VERSION = 0
  #PATCHLEVEL = 12
  #COMPILEDVERSION = VERSIONNUM(#MAJOR_VERSION,#MINOR_VERSION,#PATCHLEVEL)
  ;{
  #SDL_USE_IMAGE=Defined(SDL_USE_IMAGE,#PB_Module)
  #SDL_USE_MIXER=Defined(SDL_USE_MIXER,#PB_Module)
  #SDL_USE_TTF=Defined(SDL_USE_TTF,#PB_Module)
  #SDL_USE_NET=Defined(SDL_USE_NET,#PB_Module)
  CompilerSelect #PB_Compiler_OS 
    CompilerCase #PB_OS_Windows
      #SDL2_LIB="SDL2.lib"
      #SDL2_IMAGE_LIB="SDL2_image.lib"
      #SDL2_MIXER_LIB="SDL2_mixer.lib"
      #SDL2_TTF_LIB="SDL2_ttf.lib"
      #SDL2_NET_LIB="SDL2_net.lib"
      #libSDL2_PB_HelperLib_a="libSDL2_PB_HelperLib.a"
      #libSDL2_TTF_PB_HelperLib_a="libSDL2_TTF_PB_HelperLib.a"
      #FuncPrefix=""
    CompilerCase #PB_OS_MacOS
      #SDL2_LIB=      "/Library/Frameworks/SDL2.framework/SDL2"
      #SDL2_IMAGE_LIB="/Library/Frameworks/SDL2_image.framework/SDL2_image"
      #SDL2_MIXER_LIB="/Library/Frameworks/SDL2_mixer.framework/SDL2_mixer"
      #SDL2_TTF_LIB=  "/Library/Frameworks/SDL2_ttf.framework/SDL2_ttf"
      #SDL2_NET_LIB=  "/Library/Frameworks/SDL2_net.framework/SDL2_net"
      #FuncPrefix="_"
      #libSDL2_PB_HelperLib_a="libSDL2_PB_HelperLibMAC.a"
      #libSDL2_TTF_PB_HelperLib_a="libSDL2_TTF_PB_HelperLibMAC.a"
    CompilerCase #PB_OS_Linux
      #SDL2_LIB=      "-lSDL2"
      #SDL2_IMAGE_LIB="-lSDL2_image"
      #SDL2_MIXER_LIB="-lSDL2_mixer"
      #SDL2_TTF_LIB=  "-lSDL2_ttf"
      #SDL2_NET_LIB=  "-lSDL2_net"
      #FuncPrefix=""
      #libSDL2_PB_HelperLib_a="libSDL2_PB_HelperLibLINUX.a"
      #libSDL2_TTF_PB_HelperLib_a="libSDL2_TTF_PB_HelperLibLINUX.a"
    CompilerDefault
      CompilerError "Os is not supported!"
  CompilerEndSelect
  CompilerIf #PB_Compiler_Processor <> #PB_Processor_x64
    CompilerError "Processor is not supported!"
    End
  CompilerEndIf
  Macro char:   a  :EndMacro
  Macro int:    l  :EndMacro
  Macro unsignedint: l :EndMacro
  Macro void:   l  :EndMacro
  Macro enum: l :EndMacro
  Macro size_t: q : EndMacro
  Macro punsignedlong: long :EndMacro
  Macro penum : long : EndMacro
  Macro psize_t: long : EndMacro
  Macro pfloat: float :EndMacro
  Macro pint:    long  :EndMacro
  Macro punsignedint: long :EndMacro
  Macro pvoid: ascii :EndMacro
  Macro r_ascii: i : EndMacro; Ascii (don't free)
  Macro r_utf8: i : EndMacro ; UTF8 (don't free)
  Macro r_fascii: i : EndMacro; Ascii (free!)
  Macro r_futf8: i : EndMacro ; UTF8 (free!)
  Macro r_Uint8: i :EndMacro
  Macro r_void: i :EndMacro
  #SDLALIGN = #PB_Structure_AlignC ;4
  Declare.s MagicPeekS(*adr,len=-1,format=#PB_Unicode)
  Macro _GetAscii(str):sdl::MagicPeekS(str,-1,#PB_Ascii):EndMacro
  Macro _GetUTF8(str):sdl::MagicPeekS(str,-1,#PB_UTF8):EndMacro
  Macro iif(a,b,c): sdl::_iif(Bool(a),b,c) :EndMacro
  Declare.s _GetFreeAscii(*str)
  Declare.s _GetFreeUTF8(*str)
  Declare.i _iif(a.i,b.i,c.i)
  ;}
;-----------------------
;- SDL_stdinc.h.pbi
;{

;XIncludeFile "SDL_config.h.pbi"
Macro FOURCC(A, B, C, D)
  ((( a & $ff) << 0) | ((B & $ff) << 8) | ((C & $ff) << 16) | (( D & $ff) << 24))
EndMacro
Macro Sint8:  b : EndMacro
Macro Uint8:  a : EndMacro
Macro Sint16: w : EndMacro
Macro Uint16: u : EndMacro
Macro Sint32: l : EndMacro
Macro Uint32: l : EndMacro
Macro Sint64: q : EndMacro
Macro Uint64: q : EndMacro
Macro unsignedlong: l :EndMacro
Macro t_bool: l :EndMacro
Macro pSint8:  byte : EndMacro
Macro pUint8:  ascii : EndMacro
Macro pSint16: word : EndMacro
Macro pUint16: unicode : EndMacro
Macro pSint32: long : EndMacro
Macro pUint32: long : EndMacro
Macro pSint64: quad : EndMacro
Macro pUint64: quad : EndMacro
#True=1
#False=0
#MAX_SINT8 = 127
#MIN_SINT8 = -128
#MAX_UINT8 = 255
#MIN_UINT8 = 0
#MAX_SINT16 = 32767
#MIN_SINT16 = -32768
#MAX_UINT16 = 65535 
#MIN_UINT16 = 0 
#MAX_SINT32 = 2147483647 
#MIN_SINT32 = -2147483648 
#MAX_UINT32 = 4294967295
#MIN_UINT32 = 0 
#MAX_SINT64 = 9223372036854775807 
#MIN_SINT64 = -9223372036854775808 
#MAX_UINT64 = 18446744073709551615 
#MIN_UINT64 = 0
Enumeration bool
  #False=0
  #True=1
EndEnumeration
#M_PI = 3.1415926535897932384
#ICONV_ERROR     =-1
#ICONV_E2BIG     =-2
#ICONV_EILSEQ    =-3
#ICONV_EINVAL    =-4
Macro malloc_func: integer :EndMacro;malloc_func.pvoi(size.size_t)
Macro calloc_func: integer :EndMacro;calloc_func.pvoid(nmemb.size_t, size.size_t)
Macro realloc_func: integer :EndMacro;realloc_func.pvoid(*mem.pvoid, size.size_t)
Macro free_func: integer :EndMacro   ;free_func.void(*mem.pvoid)
ImportC #SDL2_lib
  malloc.r_void(size.size_t) As #FuncPrefix + "SDL_malloc"
  calloc.r_void(nmemb.size_t, size.size_t) As #FuncPrefix + "SDL_calloc"
  realloc.r_void(*mem.pvoid, size.size_t) As #FuncPrefix + "SDL_realloc"
  free.void(*mem.pvoid) As #FuncPrefix + "SDL_free"
  CompilerIf VERSION_ATLEAST(2,0,7)
    GetMemoryFunctions.void(*ppmallocfunc.malloc_func, *ppcallocfunc.calloc_func, *ppreallocfunc.realloc_func, *ppfreefunc.free_func) As #FuncPrefix + "SDL_GetMemoryFunctions"
    SetMemoryFunctions.int(*mallocfunc.malloc_func, *callocfunc.calloc_func, *reallocfunc.realloc_func, *freefunc.free_func) As #FuncPrefix + "SDL_SetMemoryFunctions"
    GetNumAllocations.int() As #FuncPrefix + "SDL_GetNumAllocations"
  CompilerEndIf
  _getenv.r_ascii(name . p-ascii ) As #FuncPrefix + "SDL_getenv"
  Macro getenv(a) : SDL::_GetAscii(SDL::_getenv(a)) : EndMacro
  setenv.int(name.p-ascii, value.p-ascii, overwrite.int) As #FuncPrefix + "SDL_setenv"
  qsort.void(*base.pvoid, nmemb.size_t, size.size_t, *compare) As #FuncPrefix + "SDL_qsort"  
  isdigit.int(x.int) As #FuncPrefix + "SDL_isdigit"
  isspace.int(x.int) As #FuncPrefix + "SDL_isspace"
  isupper.int(x.int) As #FuncPrefix + "SDL_isupper"
  islower.int(x.int) As #FuncPrefix + "SDL_islower"
  toupper.int(x.int) As #FuncPrefix + "SDL_toupper"
  tolower.int(x.int) As #FuncPrefix + "SDL_tolower"
  Macro stack_alloc(type, count): SDL::malloc(SizeOf(type)*(count)) :EndMacro
  Macro stack_free(dat): sdl::free(dat) :EndMacro
  Macro zero(x): FillMemory(@x, SizeOf(x),0) : EndMacro
  ;zerop und zeroa not possible in pb
  Macro memcpy4(dst,src,dwords) : CopyMemory(src,dst, (dwords)*4) : EndMacro
  Macro memset4(dest,value,count):FillMemory(dest, (count)*4, value, #PB_Long):EndMacro
EndImport
Declare.i max(a.i,b.i)
Declare.i min(a.i,b.i)
;}
;-----------------------
;- SDL_assert.h.pbi
;{

;XIncludeFile "SDL_config.h.pbi"
Enumeration AssertState
  #ASSERTION_RETRY
  #ASSERTION_BREAK
  #ASSERTION_ABORT
  #ASSERTION_IGNORE
  #ASSERTION_ALWAYS_IGNORE
EndEnumeration
CompilerIf Defined(SDL_DEFAULT_ASSERT_LEVEL,#PB_Constant)
  #ASSERT_LEVEL = #SDL_DEFAULT_ASSERT_LEVEL
CompilerElseIf #PB_Compiler_Debugger
  #ASSERT_LEVEL = 2
CompilerElse
  #ASSERT_LEVEL = 1
CompilerEndIf
Macro r_AssertionHandler: i :EndMacro
Macro r_AssertData: i :EndMacro
Structure AssertData Align #SDLALIGN
  always_ignore.int 
  trigger_count.unsignedint 
  *condition.pchar 
  *filename.pchar 
  linenum.int 
  *function.pchar 
  *next.pAssertData 
EndStructure
Macro AssertionHandler: integer :EndMacro;AssertionHandler.enum( *data.AssertData, *userdata.pvoid)
ImportC #SDL2_lib
  SetAssertionHandler.void(*handler.AssertionHandler, *userdata.pvoid) As #FuncPrefix + "SDL_SetAssertionHandler"
  CompilerIf VERSION_ATLEAST(2,0,2)
    GetDefaultAssertionHandler.r_AssertionHandler() As #FuncPrefix + "SDL_GetDefaultAssertionHandler"
    GetAssertionHandler.r_AssertionHandler(*ppuserdata.pvoid) As #FuncPrefix + "SDL_GetAssertionHandler"
  CompilerEndIf
  GetAssertionReport.r_AssertData() As #FuncPrefix + "SDL_GetAssertionReport"
  ResetAssertionReport.void() As #FuncPrefix + "SDL_ResetAssertionReport"
  Macro TriggerBreakpoint() : CallDebugger : EndMacro
  ;4x same macro with diffrent names!
  Macro assert_paranoid(_con_)
    While Not Bool(_con_)
      CompilerIf #PB_Compiler_Procedure<>""
        Static _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerElse
        Define _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerEndIf
      If _sdl_assertdata_#MacroExpandedCount\condition=0
        _sdl_assertdata_#MacroExpandedCount\condition = Ascii( sdl::_sdl_dquote#_con_#sdl::_sdl_dquote )
      EndIf
      Select SDL::ReportAssertion(_sdl_assertdata_#MacroExpandedCount, #PB_Compiler_Procedure, #PB_Compiler_File, #PB_Compiler_Line)
        Case SDL::#ASSERTION_BREAK
          SDL::TriggerBreakpoint()
        Case SDL::#ASSERTION_RETRY
          ;
        Default
          Break
      EndSelect
    Wend
  EndMacro
  Macro assert(_con_)
    While Not Bool(_con_)
      CompilerIf #PB_Compiler_Procedure<>""
        Static _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerElse
        Define _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerEndIf
      If _sdl_assertdata_#MacroExpandedCount\condition=0
        _sdl_assertdata_#MacroExpandedCount\condition = Ascii( sdl::_sdl_dquote#_con_#sdl::_sdl_dquote )
      EndIf
      Select SDL::ReportAssertion(_sdl_assertdata_#MacroExpandedCount, #PB_Compiler_Procedure, #PB_Compiler_File, #PB_Compiler_Line)
        Case SDL::#ASSERTION_BREAK
          SDL::TriggerBreakpoint()
        Case SDL::#ASSERTION_RETRY
          ;
        Default
          Break
      EndSelect
    Wend
  EndMacro
  Macro assert_release(_con_)
    While Not Bool(_con_)
      CompilerIf #PB_Compiler_Procedure<>""
        Static _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerElse
        Define _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerEndIf
      If _sdl_assertdata_#MacroExpandedCount\condition=0
        _sdl_assertdata_#MacroExpandedCount\condition = Ascii( sdl::_sdl_dquote#_con_#sdl::_sdl_dquote )
      EndIf
      Select SDL::ReportAssertion(_sdl_assertdata_#MacroExpandedCount, #PB_Compiler_Procedure, #PB_Compiler_File, #PB_Compiler_Line)
        Case SDL::#ASSERTION_BREAK
          SDL::TriggerBreakpoint()
        Case SDL::#ASSERTION_RETRY
          ;
        Default
          Break
      EndSelect
    Wend
  EndMacro
  Macro assert_always(_con_)
    While Not Bool(_con_)
      CompilerIf #PB_Compiler_Procedure<>""
        Static _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerElse
        Define _sdl_assertdata_#MacroExpandedCount.sdl::AssertData
      CompilerEndIf
      If _sdl_assertdata_#MacroExpandedCount\condition=0
        _sdl_assertdata_#MacroExpandedCount\condition = Ascii( sdl::_sdl_dquote#_con_#sdl::_sdl_dquote )
      EndIf
      Select SDL::ReportAssertion(_sdl_assertdata_#MacroExpandedCount, #PB_Compiler_Procedure, #PB_Compiler_File, #PB_Compiler_Line)
        Case SDL::#ASSERTION_BREAK
          SDL::TriggerBreakpoint()
        Case SDL::#ASSERTION_RETRY
          ;
        Default
          Break
      EndSelect
    Wend
  EndMacro
  ;disable unneded macros
  CompilerSelect #ASSERT_LEVEL
    CompilerCase 0
      UndefineMacro assert : Macro assert(con): EndMacro
      UndefineMacro assert_release : Macro assert_release(con):  EndMacro
      UndefineMacro assert_paranoid : Macro assert_paranoid(con): EndMacro    
    CompilerCase 1
      UndefineMacro assert : Macro assert(con): EndMacro
      UndefineMacro assert_paranoid : Macro assert_paranoid(con): EndMacro    
    CompilerCase 2
      UndefineMacro assert_paranoid : Macro assert_paranoid(con): EndMacro    
    CompilerCase 3
      ;all active
    CompilerDefault
      CompilerError "SDL: Unknown assertion level"
  CompilerEndSelect
EndImport
;}
;-----------------------
;- SDL_platform.h.pbi
;{

ImportC #SDL2_lib
  _GetPlatform.r_ascii() As #FuncPrefix + "SDL_GetPlatform"
  Macro GetPlatform(): SDL::_GetAscii(SDL::_GetPlatform()) :EndMacro
EndImport
;}
;-----------------------
;- SDL_atomic.h.pbi
;{

Macro t_SpinLock: int : EndMacro
Macro pSpinLock: pint : EndMacro
Structure atomic_t Align #SDLALIGN
  value.int 
EndStructure
ImportC #SDL2_lib
  ;-{ SDL_atomic.h  
  AtomicTryLock.t_bool(*lock.pSpinLock) As #FuncPrefix + "SDL_AtomicTryLock"
  AtomicLock.void(*lock.pSpinLock) As #FuncPrefix + "SDL_AtomicLock"
  AtomicUnlock.void(*lock.pSpinLock) As #FuncPrefix + "SDL_AtomicUnlock"
  AtomicCAS.t_bool(*a.atomic_t, oldval.int, newval.int) As #FuncPrefix + "SDL_AtomicCAS"
  CompilerIf VERSION_ATLEAST(2,0,2)
    AtomicSet.int(*a.atomic_t, v.int) As #FuncPrefix + "SDL_AtomicSet"
    AtomicGet.int(*a.atomic_t) As #FuncPrefix + "SDL_AtomicGet"
    AtomicAdd.int(*a.atomic_t, v.int) As #FuncPrefix + "SDL_AtomicAdd"
  CompilerEndIf
  AtomicCASPtr.t_bool(*ppa.pvoid, *oldval.pvoid, *newval.pvoid) As #FuncPrefix + "SDL_AtomicCASPtr"
  CompilerIf VERSION_ATLEAST(2,0,2)
    AtomicSetPtr.r_void(*ppa.pvoid, *v.pvoid) As #FuncPrefix + "SDL_AtomicSetPtr"
    AtomicGetPtr.r_void(*ppa.pvoid) As #FuncPrefix + "SDL_AtomicGetPtr"
  CompilerEndIf
  Macro AtomicIncRef(a): SDL::AtomicAdd(a, 1) :EndMacro
  Macro AtomicDecRef(a): Bool(SDL::AtomicAdd(a, -1) = 1) :EndMacro
  ;}
EndImport
;}
;-----------------------
;- SDL_error.h.pbi
;{

Enumeration errorcode
  #ENOMEM
  #EFREAD
  #EFWRITE
  #EFSEEK
  #UNSUPPORTED
  #LASTERROR
EndEnumeration
ImportC #libSDL2_PB_HelperLib_a
  SetError.int(text.p-ascii) As #FuncPrefix + "_Helper_SetError"
EndImport
;Debug @_Call_SetError()
ImportC #SDL2_lib
  _GetError.r_utf8() As #FuncPrefix + "SDL_GetError"
  Macro GetError(): SDL::_GetUTF8(SDL::_GetError()) :EndMacro
  ClearError.void() As #FuncPrefix + "SDL_ClearError"
  Error.int(errorcode.enum) As #FuncPrefix + "SDL_Error"
  Macro OutOfMemory() : SDL::Error(SDL::#ENOMEM):EndMacro
  Macro Unsupported() : SDL::Error(SDL::#UNSUPPORTED):EndMacro
  Macro InvalidParamError(param) : SDL::SetError("Parameter '" + param + "' is invalid") : EndMacro
EndImport
;}
;-----------------------
;- SDL_endian.h.pbi
;{

#LIL_ENDIAN = 1234
#BIG_ENDIAN = 4321
#BYTEORDER = #LIL_ENDIAN
CompilerIf #BYTEORDER = #LIL_ENDIAN
  Macro SwapLE16(X) : (X) : EndMacro
  Macro SwapLE32(X) : (X) : EndMacro
  Macro SwapLE64(X) : (X) : EndMacro
  Macro SwapFloatLE(X) : (X) : EndMacro
  Macro SwapBE16(X) : sdl::Swap16(X) : EndMacro
  Macro SwapBE32(X) : sdl::Swap32(X) : EndMacro
  Macro SwapBE64(X) : sdl::Swap64(X) : EndMacro
  Macro SwapFloatBE(X) :  sdl::SwapFloat(X) : EndMacro
CompilerElse
  Macro SwapLE16(X) : SDL::Swap16(X) : EndMacro
  Macro SwapLE32(X) : SDL::Swap32(X) : EndMacro
  Macro SwapLE64(X) : SDL::Swap64(X) : EndMacro
  Macro SwapFloatLE(X) :  SDL::SwapFloat(X) : EndMacro
  Macro SwapBE16(X) : (X) : EndMacro
  Macro SwapBE32(X) : (X) : EndMacro
  Macro SwapBE64(X) : (X) : EndMacro
  Macro SwapFloatBE(X) : (X) : EndMacro
CompilerEndIf
Declare.u swap16(x.u)
Declare.l swap32(x.l)
Declare.q swap64(x.q)
Declare.f SwapFloat(x.f)
;procedures in sdl2.pbi
;}
;-----------------------
;- SDL_mutex.h.pbi
;{

#MUTEX_TIMEDOUT = 1
#MUTEX_MAXWAIT  = $ffffffff 
Macro r_mutex: i :EndMacro
Macro r_sem: i :EndMacro
Macro r_cond: i :EndMacro
Structure mutex:EndStructure
Structure sem:EndStructure
Structure cond:EndStructure
ImportC #SDL2_lib
  Macro mutexP(m): SDL::LockMutex(m) :EndMacro
  Macro mutexV(m): SDL::UnlockMutex(m) :EndMacro
  _CreateMutex.r_mutex() As #FuncPrefix + "SDL_CreateMutex"
  Macro CreateMutex(): sdl::_CreateMutex() :EndMacro
  _LockMutex.int(*mutex.mutex) As #FuncPrefix + "SDL_LockMutex"
  Macro LockMutex(mutex): sdl::_LockMutex(mutex) :EndMacro
  _TryLockMutex.int(*mutex.mutex) As #FuncPrefix + "SDL_TryLockMutex"
  Macro TryLockMutex(mutex): sdl::_TryLockMutex(mutex) :EndMacro
  _UnlockMutex.int(*mutex.mutex) As #FuncPrefix + "SDL_UnlockMutex"
  Macro UnlockMutex(mutex): sdl::_UnlockMutex(mutex) :EndMacro
  _DestroyMutex.void(*mutex.mutex) As #FuncPrefix + "SDL_DestroyMutex"
  Macro DestroyMutex(mutex): sdl::_DestroyMutex(mutex) :EndMacro
  _CreateSemaphore.r_sem(initial_value.Uint32) As #FuncPrefix + "SDL_CreateSemaphore"
  Macro CreateSemaphore(value): sdl::_CreateSemaphore(value) :EndMacro
  _DestroySemaphore.void(*sem.sem) As #FuncPrefix + "SDL_DestroySemaphore"
  Macro DestroySemaphore(sem): sdl::_DestroySemaphore(sem) :EndMacro
  SemWait.int(*sem.sem) As #FuncPrefix + "SDL_SemWait"
  SemTryWait.int(*sem.sem) As #FuncPrefix + "SDL_SemTryWait"
  SemWaitTimeout.int(*sem.sem, ms.Uint32) As #FuncPrefix + "SDL_SemWaitTimeout"
  SemPost.int(*sem.sem) As #FuncPrefix + "SDL_SemPost"
  SemValue.Uint32(*sem.sem) As #FuncPrefix + "SDL_SemValue"
  CreateCond.r_cond() As #FuncPrefix + "SDL_CreateCond"
  DestroyCond.void(*cond.cond) As #FuncPrefix + "SDL_DestroyCond"
  CondSignal.int(*cond.cond) As #FuncPrefix + "SDL_CondSignal"
  CondBroadcast.int(*cond.cond) As #FuncPrefix + "SDL_CondBroadcast"
  CondWait.int(*cond.cond, *mutex.mutex) As #FuncPrefix + "SDL_CondWait"
  CondWaitTimeout.int(*cond.cond, *mutex.mutex, ms.Uint32) As #FuncPrefix + "SDL_CondWaitTimeout"
EndImport
;}
;-----------------------
;- SDL_thread.h.pbi
;{

Macro r_Thread: i :EndMacro
Structure thread:EndStructure
Macro ThreadFunction: integer :EndMacro  ;Thereadfunction.Int(*Data.pvoid)
Macro t_threadID: unsignedlong :EndMacro
Macro t_TLSID: unsignedint :EndMacro
Macro pthreadID: punsignedlong :EndMacro
Macro pTLSID: punsignedint :EndMacro
Enumeration ThreadPriority
  #THREAD_PRIORITY_LOW
  #THREAD_PRIORITY_NORMAL_
  #THREAD_PRIORITY_HIGH
  CompilerIf VERSION_ATLEAST(2,0,9)
    #THREAD_PRIORITY_TIME_CRITICAL_
  CompilerEndIf
EndEnumeration
#PASSED_BEGINTHREAD_ENDTHREAD = #True
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  ImportC #libSDL2_PB_HelperLib_a
    _CreateThread.r_Thread(*fn.ThreadFunction, name.p-ascii, *data.pvoid) As #FuncPrefix + "_Helper_CreateThread"
    Macro CreateThread(fn, name, dat): SDL::_CreateThread(fn, name, dat) :EndMacro
    CompilerIf VERSION_ATLEAST(2,0,9)
      CreateThreadWithStackSize.r_Thread(*fn.ThreadFunction, name.p-ascii, stacksize.size_t, *data.pvoid) As #FuncPrefix + "_Helper_CreateThreadWithStackSize"
    CompilerEndIf
  EndImport
CompilerElse
  ImportC #SDL2_lib
    _CreateThread.r_Thread(*fn.ThreadFunction, *name.p-ascii, *data.pvoid) As #FuncPrefix + "SDL_CreateThread"
    Macro CreateThread(fn, name, dat): SDL::_CreateThread(fn, name, dat) :EndMacro
    CompilerIf VERSION_ATLEAST(2,0,9)
      CreateThreadWithStackSize.r_Thread(*fn.ThreadFunction, *name.p-ascii, stacksize.size_t, *data.pvoid) As #FuncPrefix + "SDL_CreateThreadWithStackSize"
    CompilerEndIf
  EndImport
CompilerEndIf
ImportC #SDL2_lib
  _GetThreadName.r_ascii(*thread.thread) As #FuncPrefix + "SDL_GetThreadName"
  Macro GetThreadName(tread): SDL::_GetAscii(SDL::_GetThreadName(tread)) :EndMacro
  _ThreadID.t_threadID() As #FuncPrefix + "SDL_ThreadID"
  Macro ThreadID(): SDL::_ThreadID() :EndMacro
  GetThreadID.t_threadID(*thread.thread) As #FuncPrefix + "SDL_GetThreadID"
  SetThreadPriority.int(priority.enum) As #FuncPrefix + "SDL_SetThreadPriority"
  _WaitThread.void(*thread.thread, *status.pint) As #FuncPrefix + "SDL_WaitThread"
  Macro WaitThread(thread,status): SDL::_WaitThread(thread,status) :EndMacro
  CompilerIf VERSION_ATLEAST(2,0,2)
    DetachThread.void(*thread.thread) As #FuncPrefix + "SDL_DetachThread"
  CompilerEndIf
  TLSCreate.t_TLSID() As #FuncPrefix + "SDL_TLSCreate"
  TLSGet.r_void(id.t_TLSID) As #FuncPrefix + "SDL_TLSGet"
  TLSSet.int(id.t_TLSID, *value.pvoid, *destructor) As #FuncPrefix + "SDL_TLSSet"; destructor.void(*data.pvoid)
EndImport
;}
;-----------------------
;- SDL_rwops.h.pbi
;{

#RWOPS_UNKNOWN = 0
#RWOPS_WINFILE = 1
#RWOPS_STDFILE = 2
#RWOPS_JNIFILE = 3
#RWOPS_MEMORY = 4
#RWOPS_MEMORY_RO = 5
#RW_SEEK_SET = 0
#RW_SEEK_CUR = 1
#RW_SEEK_END = 2
Structure _rwops_buffer Align #SDLALIGN
  *data.pvoid 
  size.size_t 
  left.size_t 
EndStructure
Structure _rwops_windowsio Align #SDLALIGN
  append.t_bool 
  *h.pvoid 
  buffer._rwops_buffer
EndStructure
Structure _rwops_mem Align #SDLALIGN
  *base.pUint8 
  *here.pUint8 
  *stop.pUint8 
EndStructure
Structure _rwops_unknown Align #SDLALIGN
  *data1.pvoid 
  *data2.pvoid 
EndStructure
Structure _rwops_hidden Align #SDLALIGN
  StructureUnion
    windowsio. _rwops_windowsio
    mem._rwops_mem
    unknown._rwops_unknown
  EndStructureUnion
EndStructure
Structure RWops Align #SDLALIGN
  *size;(.Sint64 SDLCALL * size ) ( struct SDL_RWops * context ) ;
  *seek;(.Sint64 SDLCALL * seek ) ( struct SDL_RWops * context , Sint64 offset , int whence ) ;
  *read;(.size_t SDLCALL * Read ) ( struct SDL_RWops * context , void * ptr , size_t size , size_t maxnum ) ;
  *write;(.size_t SDLCALL * write ) ( struct SDL_RWops * context , const void * ptr , size_t size , size_t num ) ;
  *close;(.int SDLCALL * close ) ( struct SDL_RWops * context ) ;
  type.Uint32 
  hidden._rwops_hidden
EndStructure
Macro r_RWops: i :EndMacro
ImportC #SDL2_lib
  RWFromFile.r_RWops(file.p-utf8, mode.p-ascii) As #FuncPrefix + "SDL_RWFromFile"
  RWFromFP.r_RWops(*fp.pvoid, autoclose.t_bool) As #FuncPrefix + "SDL_RWFromFP"
  RWFromMem.r_RWops(*mem.pvoid, size.int) As #FuncPrefix + "SDL_RWFromMem"
  RWFromConstMem.r_RWops(*mem.pvoid, size.int) As #FuncPrefix + "SDL_RWFromConstMem"
  AllocRW.r_RWops() As #FuncPrefix + "SDL_AllocRW"
  FreeRW.void(*area.RWops) As #FuncPrefix + "SDL_FreeRW"
  CompilerIf VERSION_ATLEAST(2,0,10)
    RWsize.Sint64(*context.RWops) As #FuncPrefix + "SDL_RWsize"
    RWseek.Sint64(*context.RWops, offset.Sint64, whence.int) As #FuncPrefix + "SDL_RWseek"
    RWtell.Sint64(*context.RWops) As #FuncPrefix + "SDL_RWtell"
    RWread.size_t(*context.RWops, *ptr.pvoid, size.size_t, maxnum.size_t) As #FuncPrefix + "SDL_RWread"
    RWwrite.size_t(*context.RWops, *ptr.pvoid, size.size_t, num.size_t) As #FuncPrefix + "SDL_RWwrite"
    RWclose.int(*context.RWops) As #FuncPrefix + "SDL_RWclose"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    LoadFile_RW.r_void(*src.RWops, *datasize.psize_t, freesrc.int) As #FuncPrefix + "SDL_LoadFile_RW"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,10)
    LoadFile.r_void(file.p-utf8, *datasize.psize_t) As #FuncPrefix + "SDL_LoadFile"
  CompilerEndIf
  ReadU8.Uint8(*src.RWops) As #FuncPrefix + "SDL_ReadU8"
  ReadLE16.Uint16(*src.RWops) As #FuncPrefix + "SDL_ReadLE16"
  ReadBE16.Uint16(*src.RWops) As #FuncPrefix + "SDL_ReadBE16"
  ReadLE32.Uint32(*src.RWops) As #FuncPrefix + "SDL_ReadLE32"
  ReadBE32.Uint32(*src.RWops) As #FuncPrefix + "SDL_ReadBE32"
  ReadLE64.Uint64(*src.RWops) As #FuncPrefix + "SDL_ReadLE64"
  ReadBE64.Uint64(*src.RWops) As #FuncPrefix + "SDL_ReadBE64"
  WriteU8.size_t(*dst.RWops, value.Uint8) As #FuncPrefix + "SDL_WriteU8"
  WriteLE16.size_t(*dst.RWops, value.Uint16) As #FuncPrefix + "SDL_WriteLE16"
  WriteBE16.size_t(*dst.RWops, value.Uint16) As #FuncPrefix + "SDL_WriteBE16"
  WriteLE32.size_t(*dst.RWops, value.Uint32) As #FuncPrefix + "SDL_WriteLE32"
  WriteBE32.size_t(*dst.RWops, value.Uint32) As #FuncPrefix + "SDL_WriteBE32"
  WriteLE64.size_t(*dst.RWops, value.Uint64) As #FuncPrefix + "SDL_WriteLE64"
  WriteBE64.size_t(*dst.RWops, value.Uint64) As #FuncPrefix + "SDL_WriteBE64"
EndImport
;}
;-----------------------
;- SDL_audio.h.pbi
;{

#AUDIO_MASK_BITSIZE     = ($FF)
#AUDIO_MASK_DATATYPE    = (1<<8)
#AUDIO_MASK_ENDIAN      = (1<<12)
#AUDIO_MASK_SIGNED      = (1<<15)
#AUDIO_U8 = $0008
#AUDIO_S8 = $8008
#AUDIO_U16LSB = $0010
#AUDIO_S16LSB = $8010
#AUDIO_U16MSB = $1010
#AUDIO_S16MSB = $9010
#AUDIO_U16 = #AUDIO_U16LSB
#AUDIO_S16 = #AUDIO_S16LSB
#AUDIO_S32LSB = $8020
#AUDIO_S32MSB = $9020
#AUDIO_S32 = #AUDIO_S32LSB
#AUDIO_F32LSB = $8120
#AUDIO_F32MSB = $9120
#AUDIO_F32 = #AUDIO_F32LSB
CompilerIf #BYTEORDER = #LIL_ENDIAN
  #AUDIO_U16SYS_ = #AUDIO_U16LSB
  #AUDIO_S16SYS_ = #AUDIO_S16LSB
  #AUDIO_S32SYS_ = #AUDIO_S32LSB
  #AUDIO_F32SYS_ = #AUDIO_F32LSB
CompilerElse
  #AUDIO_U16SYS_ = #AUDIO_U16MSB
  #AUDIO_S16SYS_ = #AUDIO_S16MSB
  #AUDIO_S32SYS_ = #AUDIO_S32MSB
  #AUDIO_F32SYS_ = #AUDIO_F32MSB
CompilerEndIf
#AUDIO_ALLOW_FREQUENCY_CHANGE = $00000001
#AUDIO_ALLOW_FORMAT_CHANGE = $00000002
#AUDIO_ALLOW_CHANNELS_CHANGE = $00000004
CompilerIf VERSION_ATLEAST(2,0,9)
  #AUDIO_ALLOW_SAMPLES_CHANGE = $00000008
  #AUDIO_ALLOW_ANY_CHANGE =(#AUDIO_ALLOW_FREQUENCY_CHANGE|#AUDIO_ALLOW_FORMAT_CHANGE|#AUDIO_ALLOW_CHANNELS_CHANGE|#AUDIO_ALLOW_SAMPLES_CHANGE)
CompilerElse
  #AUDIO_ALLOW_ANY_CHANGE =(#AUDIO_ALLOW_FREQUENCY_CHANGE|#AUDIO_ALLOW_FORMAT_CHANGE|#AUDIO_ALLOW_CHANNELS_CHANGE)
CompilerEndIf
#AUDIOCVT_MAX_FILTERS = 9
Enumeration AudioStatus
  #AUDIO_STOPPED=0
  #AUDIO_PLAYING
  #AUDIO_PAUSED
EndEnumeration
#MIX_MAXVOLUME = 128
Macro t_AudioFormat: Uint16  :EndMacro
Macro t_AudioDeviceID : Uint32 :EndMacro
Macro pAudioFormat: pUint16  :EndMacro
Macro pAudioDeviceID : pUint32 :EndMacro
Macro AudioCallback: integer :EndMacro; AudioCallback.void ( *userdata,pvoid, *stream.pUint8, len.int)
Macro AudioFilter: integer :EndMacro  ; AudioFilter.void (*cvt.pAudioCVT, format.AudioFormat)
CompilerIf VERSION_ATLEAST(2,0,7)
  Structure AudioStream:EndStructure
  Macro r_AudioStream: i :EndMacro
CompilerEndIf
Structure AudioSpec Align #SDLALIGN
  freq.int 
  format.t_AudioFormat 
  channels.Uint8 
  silence.Uint8 
  samples.Uint16 
  padding.Uint16 
  size.Uint32 
  *callback.AudioCallback 
  *userdata.pvoid 
EndStructure
Macro r_AudioSpec: i : EndMacro
Structure AudioCVT Align #SDLALIGN
  needed.int 
  src_format.t_AudioFormat 
  dst_format.t_AudioFormat
  rate_incr.d 
  *buf.pUint8
  len.int
  len_cvt.int
  len_mult.int
  len_ratio.d
  filters.AudioFilter [ #AUDIOCVT_MAX_FILTERS + 1 ]
  filter_index.int
EndStructure
Macro r_AudioCVT: i :EndMacro
Declare.t_AudioDeviceID OpenAudioDevice(device.s, iscapture.int, *desired.AudioSpec, *obtained.AudioSpec, allowed_changes.int)
ImportC #SDL2_lib
  Macro AUDIO_BITSIZE(x)        : (x & SDL::#AUDIO_MASK_BITSIZE) : EndMacro
  Macro AUDIO_ISFLOAT(x)        : Bool(x & SDL::#AUDIO_MASK_DATATYPE) : EndMacro
  Macro AUDIO_ISBIGENDIAN(x)    : Bool(x & SDL::#AUDIO_MASK_ENDIAN) : EndMacro
  Macro AUDIO_ISSIGNED(x)       : Bool(x & SDL::#AUDIO_MASK_SIGNED) : EndMacro
  Macro AUDIO_ISINT(x)          : Bool(Not SDL::AUDIO_ISFLOAT(x)) : EndMacro
  Macro AUDIO_ISLITTLEENDIAN(x) : Bool(Not SDL::AUDIO_ISBIGENDIAN(x)) : EndMacro
  Macro AUDIO_ISUNSIGNED(x)     : Bool(Not SDL::AUDIO_ISSIGNED(x)) : EndMacro
  GetNumAudioDrivers.int() As #FuncPrefix + "SDL_GetNumAudioDrivers"
  _GetAudioDriver.r_ascii(index.int) As #FuncPrefix + "SDL_GetAudioDriver"
  Macro GetAudioDriver(index): SDL::_GetAscii(SDL::_GetAudioDriver(index)) :EndMacro
  AudioInit.int(driver_name.p-ascii) As #FuncPrefix + "SDL_AudioInit"
  AudioQuit.void() As #FuncPrefix + "SDL_AudioQuit"
  _GetCurrentAudioDriver.r_ascii() As #FuncPrefix + "SDL_GetCurrentAudioDriver"
  Macro GetCurrentAudioDriver(): SDL::_GetAscii(SDL::_GetCurrentAudioDriver()) :EndMacro
  OpenAudio.int(*desired.AudioSpec, *obtained.AudioSpec) As #FuncPrefix + "SDL_OpenAudio"
  GetNumAudioDevices.int(iscapture.int) As #FuncPrefix + "SDL_GetNumAudioDevices"
  _GetAudioDeviceName.r_utf8(index.int, iscapture.int) As #FuncPrefix + "SDL_GetAudioDeviceName"
  Macro GetAudioDeviceName(index,iscapture): SDL::_GetUTF8(SDL::_GetAudioDeviceName(index,iscapture)) :EndMacro
  _OpenAudioDevice.t_AudioDeviceID(*device, iscapture.int, *desired.AudioSpec, *obtained.AudioSpec, allowed_changes.int) As #FuncPrefix + "SDL_OpenAudioDevice"  
  GetAudioStatus.enum() As #FuncPrefix + "SDL_GetAudioStatus"
  GetAudioDeviceStatus.enum(dev.t_AudioDeviceID) As #FuncPrefix + "SDL_GetAudioDeviceStatus"
  PauseAudio.void(pause_on.int) As #FuncPrefix + "SDL_PauseAudio"
  PauseAudioDevice.void(dev.t_AudioDeviceID, pause_on.int) As #FuncPrefix + "SDL_PauseAudioDevice"
  LoadWAV_RW.r_AudioSpec(*src.RWops, freesrc.int, *spec.AudioSpec, *pp_audio_buf.pUint8, *audio_len.pUint32) As #FuncPrefix + "SDL_LoadWAV_RW"
  FreeWAV.void(*audio_buf.pUint8) As #FuncPrefix + "SDL_FreeWAV"
  BuildAudioCVT.int(*cvt.AudioCVT, src_format.t_AudioFormat, src_channels.Uint8, src_rate.int, dst_format.t_AudioFormat, dst_channels.Uint8, dst_rate.int) As #FuncPrefix + "SDL_BuildAudioCVT"
  ConvertAudio.int(*cvt.AudioCVT) As #FuncPrefix + "SDL_ConvertAudio"
  CompilerIf VERSION_ATLEAST(2,0,7)
    NewAudioStream.r_AudioStream(src_format.t_AudioFormat, src_channels.Uint8, src_rate.int, dst_format.t_AudioFormat, dst_channels.Uint8, dst_rate.int) As #FuncPrefix + "SDL_NewAudioStream"
    AudioStreamPut.int(*stream.AudioStream, *buf.pvoid, len.int) As #FuncPrefix + "SDL_AudioStreamPut"
    AudioStreamGet.int(*stream.AudioStream, *buf.pvoid, len.int) As #FuncPrefix + "SDL_AudioStreamGet"
    AudioStreamAvailable.int(*stream.AudioStream) As #FuncPrefix + "SDL_AudioStreamAvailable"
    AudioStreamFlush.int(*stream.AudioStream) As #FuncPrefix + "SDL_AudioStreamFlush"
    AudioStreamClear.void(*stream.AudioStream) As #FuncPrefix + "SDL_AudioStreamClear"
    FreeAudioStream.void(*stream.AudioStream) As #FuncPrefix + "SDL_FreeAudioStream"
  CompilerEndIf
  MixAudio.void(*dst.pUint8, *src.pUint8, len.Uint32, volume.int) As #FuncPrefix + "SDL_MixAudio"
  MixAudioFormat.void(*dst.pUint8, *src.pUint8, format.t_AudioFormat, len.Uint32, volume.int) As #FuncPrefix + "SDL_MixAudioFormat"
  CompilerIf VERSION_ATLEAST(2,0,4)
    QueueAudio.int(dev.t_AudioDeviceID, *data.pvoid, len.Uint32) As #FuncPrefix + "SDL_QueueAudio"
  CompilerEndIf  
  CompilerIf VERSION_ATLEAST(2,0,5)
    DequeueAudio.Uint32(dev.t_AudioDeviceID, *data.pvoid, len.Uint32) As #FuncPrefix + "SDL_DequeueAudio"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,4)
    GetQueuedAudioSize.Uint32(dev.t_AudioDeviceID) As #FuncPrefix + "SDL_GetQueuedAudioSize"
    ClearQueuedAudio.void(dev.t_AudioDeviceID) As #FuncPrefix + "SDL_ClearQueuedAudio"
  CompilerEndIf
  LockAudio.void() As #FuncPrefix + "SDL_LockAudio"
  LockAudioDevice.void(dev.t_AudioDeviceID) As #FuncPrefix + "SDL_LockAudioDevice"
  UnlockAudio.void() As #FuncPrefix + "SDL_UnlockAudio"
  UnlockAudioDevice.void(dev.t_AudioDeviceID) As #FuncPrefix + "SDL_UnlockAudioDevice"
  CloseAudio.void() As #FuncPrefix + "SDL_CloseAudio"
  CloseAudioDevice.void(dev.t_AudioDeviceID) As #FuncPrefix + "SDL_CloseAudioDevice"
  Macro LoadWAV(file, spec, audio_buf, audio_len): SDL::LoadWAV_RW(SDL::RWFromFile(file, "rb"),1, spec,audio_buf,audio_len) :EndMacro
EndImport
;}
;-----------------------
;- SDL_clipboard.h.pbi
;{

ImportC #SDL2_lib
  _SetClipboardText.int(text.p-utf8) As #FuncPrefix + "SDL_SetClipboardText"
  Macro SetClipboardText(text): SDL::_SetClipboardText(text) :EndMacro
  _GetClipboardText.r_utf8() As #FuncPrefix + "SDL_GetClipboardText"
  Macro GetClipboardText(): SDL::_GetFreeUTF8(SDL::_GetClipboardText()) :EndMacro
  HasClipboardText.t_bool() As #FuncPrefix + "SDL_HasClipboardText"
EndImport
;}
;-----------------------
;- SDL_cpuinfo.h.pbi
;{

#CACHELINE_SIZE = 128
ImportC #SDL2_lib
  GetCPUCount.int() As #FuncPrefix + "SDL_GetCPUCount"
  GetCPUCacheLineSize.int() As #FuncPrefix + "SDL_GetCPUCacheLineSize"
  HasRDTSC.t_bool() As #FuncPrefix + "SDL_HasRDTSC"
  HasAltiVec.t_bool() As #FuncPrefix + "SDL_HasAltiVec"
  HasMMX.t_bool() As #FuncPrefix + "SDL_HasMMX"
  Has3DNow.t_bool() As #FuncPrefix + "SDL_Has3DNow"
  HasSSE.t_bool() As #FuncPrefix + "SDL_HasSSE"
  HasSSE2.t_bool() As #FuncPrefix + "SDL_HasSSE2"
  HasSSE3.t_bool() As #FuncPrefix + "SDL_HasSSE3"
  HasSSE41.t_bool() As #FuncPrefix + "SDL_HasSSE41"
  HasSSE42.t_bool() As #FuncPrefix + "SDL_HasSSE42"
  CompilerIf VERSION_ATLEAST(2,0,2)
    HasAVX.t_bool() As #FuncPrefix + "SDL_HasAVX"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,4)
    HasAVX2.t_bool() As #FuncPrefix + "SDL_HasAVX2"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,9)
    HasAVX512F.t_bool() As #FuncPrefix + "SDL_HasAVX512F"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,12)
    HasARMSIMD.t_bool() As #FuncPrefix + "SDL_HasARMSIMD"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    HasNEON.t_bool() As #FuncPrefix + "SDL_HasNEON"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,1)
    GetSystemRAM.int() As #FuncPrefix + "SDL_GetSystemRAM"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,10)
    SIMDGetAlignment.size_t() As #FuncPrefix + "SDL_SIMDGetAlignment"
    SIMDAlloc.r_void(len.size_t) As #FuncPrefix + "SDL_SIMDAlloc"
    SIMDFree.void(*ptr.pvoid) As #FuncPrefix + "SDL_SIMDFree"
  CompilerEndIf
EndImport
;}
;-----------------------
;- SDL_pixels.h.pbi
;{

Macro DEFINE_PIXELFOURCC(A, B, C, D):
  SDL::FOURCC(A, B, C, D) 
EndMacro
Macro DEFINE_PIXELFORMAT(type, order, layout, bits, bytes) : ((1 << 28) | ((type) << 24) | ((order) << 20) | ((layout) << 16) | ((bits) << 8) | ((bytes) << 0)) :EndMacro
#ALPHA_OPAQUE = 255
#ALPHA_TRANSPARENT = 0
Enumeration PixelType
  #PIXELTYPE_UNKNOWN
  #PIXELTYPE_INDEX1
  #PIXELTYPE_INDEX4
  #PIXELTYPE_INDEX8
  #PIXELTYPE_PACKED8
  #PIXELTYPE_PACKED16
  #PIXELTYPE_PACKED32
  #PIXELTYPE_ARRAYU8
  #PIXELTYPE_ARRAYU16
  #PIXELTYPE_ARRAYU32
  #PIXELTYPE_ARRAYF16
  #PIXELTYPE_ARRAYF32
EndEnumeration
Enumeration BitmapOrder
  #BITMAPORDER_NONE
  #BITMAPORDER_4321
  #BITMAPORDER_1234
EndEnumeration
Enumeration PackedOrder
  #PACKEDORDER_NONE
  #PACKEDORDER_XRGB
  #PACKEDORDER_RGBX
  #PACKEDORDER_ARGB
  #PACKEDORDER_RGBA
  #PACKEDORDER_XBGR
  #PACKEDORDER_BGRX
  #PACKEDORDER_ABGR
  #PACKEDORDER_BGRA
EndEnumeration
Enumeration ArrayOrder
  #ARRAYORDER_NONE
  #ARRAYORDER_RGB
  #ARRAYORDER_RGBA
  #ARRAYORDER_ARGB
  #ARRAYORDER_BGR
  #ARRAYORDER_BGRA
  #ARRAYORDER_ABGR
EndEnumeration
Enumeration PackedLayout
  #PACKEDLAYOUT_NONE
  #PACKEDLAYOUT_332
  #PACKEDLAYOUT_4444
  #PACKEDLAYOUT_1555
  #PACKEDLAYOUT_5551
  #PACKEDLAYOUT_565
  #PACKEDLAYOUT_8888
  #PACKEDLAYOUT_2101010
  #PACKEDLAYOUT_1010102
EndEnumeration
Enumeration PixelFormatEnum
  #PIXELFORMAT_UNKNOWN
  #PIXELFORMAT_INDEX1LSB = DEFINE_PIXELFORMAT ( #PIXELTYPE_INDEX1 , #BITMAPORDER_4321 , 0 , 1 , 0 )
  #PIXELFORMAT_INDEX1MSB = DEFINE_PIXELFORMAT ( #PIXELTYPE_INDEX1 , #BITMAPORDER_1234 , 0 , 1 , 0 )
  #PIXELFORMAT_INDEX4LSB = DEFINE_PIXELFORMAT ( #PIXELTYPE_INDEX4 , #BITMAPORDER_4321 , 0 , 4 , 0 )
  #PIXELFORMAT_INDEX4MSB = DEFINE_PIXELFORMAT ( #PIXELTYPE_INDEX4 , #BITMAPORDER_1234 , 0 , 4 , 0 )
  #PIXELFORMAT_INDEX8 = DEFINE_PIXELFORMAT ( #PIXELTYPE_INDEX8 , 0 , 0 , 8 , 1 )
  #PIXELFORMAT_RGB332 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED8 , #PACKEDORDER_XRGB , #PACKEDLAYOUT_332 , 8 , 1 )
  #PIXELFORMAT_RGB444 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_XRGB , #PACKEDLAYOUT_4444 , 12 , 2 )
  #PIXELFORMAT_BGR444 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_XBGR , #PACKEDLAYOUT_4444 , 12 , 2 )
  #PIXELFORMAT_RGB555 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_XRGB , #PACKEDLAYOUT_1555 , 15 , 2 )
  #PIXELFORMAT_BGR555 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_XBGR , #PACKEDLAYOUT_1555 , 15 , 2 )
  #PIXELFORMAT_ARGB4444 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_ARGB , #PACKEDLAYOUT_4444 , 16 , 2 )
  #PIXELFORMAT_RGBA4444 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_RGBA , #PACKEDLAYOUT_4444 , 16 , 2 )
  #PIXELFORMAT_ABGR4444 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_ABGR , #PACKEDLAYOUT_4444 , 16 , 2 )
  #PIXELFORMAT_BGRA4444 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_BGRA , #PACKEDLAYOUT_4444 , 16 , 2 )
  #PIXELFORMAT_ARGB1555 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_ARGB , #PACKEDLAYOUT_1555 , 16 , 2 )
  #PIXELFORMAT_RGBA5551 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_RGBA , #PACKEDLAYOUT_5551 , 16 , 2 )
  #PIXELFORMAT_ABGR1555 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_ABGR , #PACKEDLAYOUT_1555 , 16 , 2 )
  #PIXELFORMAT_BGRA5551 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_BGRA , #PACKEDLAYOUT_5551 , 16 , 2 )
  #PIXELFORMAT_RGB565 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_XRGB , #PACKEDLAYOUT_565 , 16 , 2 )
  #PIXELFORMAT_BGR565 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED16 , #PACKEDORDER_XBGR , #PACKEDLAYOUT_565 , 16 , 2 )
  #PIXELFORMAT_RGB24 = DEFINE_PIXELFORMAT ( #PIXELTYPE_ARRAYU8 , #ARRAYORDER_RGB , 0 , 24 , 3 )
  #PIXELFORMAT_BGR24 = DEFINE_PIXELFORMAT ( #PIXELTYPE_ARRAYU8 , #ARRAYORDER_BGR , 0 , 24 , 3 )
  #PIXELFORMAT_RGB888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_XRGB , #PACKEDLAYOUT_8888 , 24 , 4 )
  #PIXELFORMAT_RGBX8888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_RGBX , #PACKEDLAYOUT_8888 , 24 , 4 )
  #PIXELFORMAT_BGR888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_XBGR , #PACKEDLAYOUT_8888 , 24 , 4 )
  #PIXELFORMAT_BGRX8888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_BGRX , #PACKEDLAYOUT_8888 , 24 , 4 )
  #PIXELFORMAT_ARGB8888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_ARGB , #PACKEDLAYOUT_8888 , 32 , 4 )
  #PIXELFORMAT_RGBA8888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_RGBA , #PACKEDLAYOUT_8888 , 32 , 4 )
  #PIXELFORMAT_ABGR8888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_ABGR , #PACKEDLAYOUT_8888 , 32 , 4 )
  #PIXELFORMAT_BGRA8888 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_BGRA , #PACKEDLAYOUT_8888 , 32 , 4 )
  #PIXELFORMAT_ARGB2101010 = DEFINE_PIXELFORMAT ( #PIXELTYPE_PACKED32 , #PACKEDORDER_ARGB , #PACKEDLAYOUT_2101010 , 32 , 4 )
CompilerIf #BYTEORDER = #BIG_ENDIAN
  #PIXELFORMAT_RGBA32 = #PIXELFORMAT_RGBA8888
  #PIXELFORMAT_ARGB32 = #PIXELFORMAT_ARGB8888
  #PIXELFORMAT_BGRA32 = #PIXELFORMAT_BGRA8888
  #PIXELFORMAT_ABGR32 = #PIXELFORMAT_ABGR8888
CompilerElse
  #PIXELFORMAT_RGBA32 = #PIXELFORMAT_ABGR8888
  #PIXELFORMAT_ARGB32 = #PIXELFORMAT_BGRA8888
  #PIXELFORMAT_BGRA32 = #PIXELFORMAT_ARGB8888
  #PIXELFORMAT_ABGR32 = #PIXELFORMAT_RGBA8888
CompilerEndIf
  #PIXELFORMAT_YV12 = DEFINE_PIXELFOURCC ('Y','V','1','2')
  #PIXELFORMAT_IYUV = DEFINE_PIXELFOURCC ('I','Y','U','V')
  #PIXELFORMAT_YUY2 = DEFINE_PIXELFOURCC ('Y','U','Y','2')
  #PIXELFORMAT_UYVY = DEFINE_PIXELFOURCC ('U','Y','V','Y')
  #PIXELFORMAT_YVYU = DEFINE_PIXELFOURCC ('Y','V','Y','U')
  #PIXELFORMAT_NV12 = DEFINE_PIXELFOURCC ('N','V','1','2')
  #PIXELFORMAT_NV21 = DEFINE_PIXELFOURCC ('N','V','2','1')
  #PIXELFORMAT_EXTERNAL_OES = DEFINE_PIXELFOURCC ('O','E','S',' ' )
EndEnumeration
Structure Color Align #SDLALIGN
  r.Uint8
  g.Uint8
  b.Uint8
  a.Uint8
EndStructure
Macro r_color: i :EndMacro
Macro Colour: Color :EndMacro
Structure Palette Align #SDLALIGN
  ncolors.int
  *colors.Color
  version.Uint32
  refcount.int
EndStructure
Macro r_Palette: i :EndMacro
Structure PixelFormat Align #SDLALIGN
  format.Uint32
  *palette.Palette
  BitsPerPixel.Uint8
  BytesPerPixel.Uint8
  padding.Uint8 [ 2 ]
  Rmask.Uint32
  Gmask.Uint32
  Bmask.Uint32
  Amask.Uint32
  Rloss.Uint8
  Gloss.Uint8
  Bloss.Uint8
  Aloss.Uint8
  Rshift.Uint8
  Gshift.Uint8
  Bshift.Uint8
  Ashift.Uint8
  refcount.int
  *next.PixelFormat
EndStructure
Macro r_PixelFormat: i :EndMacro
ImportC #SDL2_lib
  _GetPixelFormatName.r_ascii(format.Uint32) As #FuncPrefix + "SDL_GetPixelFormatName"
  Macro GetPixelFormatName(format): SDL::_GetAscii(SDL::_GetPixelFormatName(format)) :EndMacro
  PixelFormatEnumToMasks.t_bool(format.Uint32, *bpp.pint, *Rmask.pUint32, *Gmask.pUint32, *Bmask.pUint32, *Amask.pUint32) As #FuncPrefix + "SDL_PixelFormatEnumToMasks"
  MasksToPixelFormatEnum.Uint32(bpp.int, Rmask.Uint32, Gmask.Uint32, Bmask.Uint32, Amask.Uint32) As #FuncPrefix + "SDL_MasksToPixelFormatEnum"
  AllocFormat.r_PixelFormat(pixel_format.Uint32) As #FuncPrefix + "SDL_AllocFormat"
  FreeFormat.void(*format.PixelFormat) As #FuncPrefix + "SDL_FreeFormat"
  AllocPalette.r_Palette(ncolors.int) As #FuncPrefix + "SDL_AllocPalette"
  SetPixelFormatPalette.int(*format.PixelFormat, *palette.Palette) As #FuncPrefix + "SDL_SetPixelFormatPalette"
  SetPaletteColors.int(*palette.Palette, *colors.Color, firstcolor.int, ncolors.int) As #FuncPrefix + "SDL_SetPaletteColors"
  FreePalette.void(*palette.Palette) As #FuncPrefix + "SDL_FreePalette"
  MapRGB.Uint32(*format.PixelFormat, r.Uint8, g.Uint8, b.Uint8) As #FuncPrefix + "SDL_MapRGB"
  MapRGBA.Uint32(*format.PixelFormat, r.Uint8, g.Uint8, b.Uint8, a.Uint8) As #FuncPrefix + "SDL_MapRGBA"
  GetRGB.void(pixel.Uint32, *format.PixelFormat, *r.pUint8, *g.pUint8, *b.pUint8) As #FuncPrefix + "SDL_GetRGB"
  GetRGBA.void(pixel.Uint32, *format.PixelFormat, *r.pUint8, *g.pUint8, *b.pUint8, *a.pUint8) As #FuncPrefix + "SDL_GetRGBA"
  CalculateGammaRamp.void(gamma.f, *ramp.pUint16) As #FuncPrefix + "SDL_CalculateGammaRamp"  
  Macro PIXELFLAG(X) : (((X) >> 28) & $0F) :EndMacro
  Macro PIXELTYPE(X) : (((X) >> 24) & $0F) :EndMacro
  Macro PIXELORDER(X) : (((X) >> 20) & $0F) :EndMacro
  Macro PIXELLAYOUT(X) : (((X) >> 16) & $0F) :EndMacro
  Macro BITSPERPIXEL(X) : (((X) >> 8) & $FF) :EndMacro
  Macro ISPIXELFORMAT_FOURCC(format) : Bool((format) And (SDL::PIXELFLAG(format) <> 1)) :EndMacro
  Macro BYTESPERPIXEL(X) 
    sdl::_iif(SDL::ISPIXELFORMAT_FOURCC(X) ,
             sdl::iif(((X) = SDL::#PIXELFORMAT_YUY2) Or ((X) = SDL::#PIXELFORMAT_UYVY) Or ((X) = SDL::#PIXELFORMAT_YVYU) , 2 , 1),
             ((X) >> 0) & $FF)
  EndMacro
  Macro ISPIXELFORMAT_INDEXED(format)
    Bool(Not SDL::ISPIXELFORMAT_FOURCC(format) And
         ((SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_INDEX1) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_INDEX4) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_INDEX8)))
  EndMacro
  Macro ISPIXELFORMAT_PACKED(format)
    Bool(Not SDL::ISPIXELFORMAT_FOURCC(format) And
         ((SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_PACKED8) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_PACKED16) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_PACKED32)))
  EndMacro
  Macro ISPIXELFORMAT_ARRAY(format) 
    Bool(Not SDL::ISPIXELFORMAT_FOURCC(format) And
         ((SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_ARRAYU8) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_ARRAYU16) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_ARRAYU32) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_ARRAYF16) Or
          (SDL::PIXELTYPE(format) = SDL::#PIXELTYPE_ARRAYF32)))
  EndMacro
  Macro ISPIXELFORMAT_ALPHA(format)   
    Bool((SDL::ISPIXELFORMAT_PACKED(format) And
          ((sdl::PIXELORDER(format) = SDL::#PACKEDORDER_ARGB) Or
           (sdl::PIXELORDER(format) = SDL::#PACKEDORDER_RGBA) Or
           (sdl::PIXELORDER(format) = SDL::#PACKEDORDER_ABGR) Or
           (sdl::PIXELORDER(format) = SDL::#PACKEDORDER_BGRA))) Or
         (SDL::ISPIXELFORMAT_ARRAY(format) And
          ((sdl::PIXELORDER(format) = SDL::#ARRAYORDER_ARGB) Or
           (sdl::PIXELORDER(format) = SDL::#ARRAYORDER_RGBA) Or
           (sdl::PIXELORDER(format) = SDL::#ARRAYORDER_ABGR) Or
           (sdl::PIXELORDER(format) = SDL::#ARRAYORDER_BGRA))))
  EndMacro
EndImport
;}
;-----------------------
;- SDL_rect.h.pbi
;{

CompilerIf #False
  Structure Point 
    x.int
    y.int
  EndStructure
  Structure Rect
    x.int 
    y.int
    w.int 
    h.int
  EndStructure
CompilerEndIf
Macro Point:sdl::_Point:EndMacro
Structure _Point Align #SDLALIGN
  x.int
  y.int
EndStructure
Macro r_Point: i :EndMacro
Structure FPoint Align #SDLALIGN
  x.f
  y.f
EndStructure
Macro r_FPoint: i :EndMacro
Macro Rect:sdl::_Rect:EndMacro
Structure _Rect Align #SDLALIGN
  x.int 
  y.int
  w.int 
  h.int
EndStructure
Macro r_Rect: i :EndMacro
Structure FRect Align #SDLALIGN
  x.f
  y.f
  w.f
  h.f
EndStructure
Macro r_FRect: i :EndMacro
ImportC #SDL2_lib
  HasIntersection.t_bool(*A.Rect, *B.Rect) As #FuncPrefix + "SDL_HasIntersection"
  IntersectRect.t_bool(*A.Rect, *B.Rect, *result.Rect) As #FuncPrefix + "SDL_IntersectRect"
  UnionRect.void(*A.Rect, *B.Rect, *result.Rect) As #FuncPrefix + "SDL_UnionRect"
  EnclosePoints.t_bool(*points.Point, count.int, *clip.Rect, *result.Rect) As #FuncPrefix + "SDL_EnclosePoints"
  IntersectRectAndLine.t_bool(*rectxx.Rect, *X1.pint, *Y1.pint, *X2.pint, *Y2.pint) As #FuncPrefix + "SDL_IntersectRectAndLine"
  Macro PointInRect(p,r): Bool( (p\x >= r\x) And (p\x < (r\x + r\w)) And (p\y >= r\y) And (p\y < (r\y + r\h)) ) : EndMacro
  Macro RectEmpty(r) : Bool((Not r) Or (r\w <= 0) Or (r\h <= 0)) : EndMacro
  Macro RectEquals(a, b) : Bool (a And b And (a\x = b\x) And (a\y = b\y) And (a\w = b\w) And (a\h = b\h)) : EndMacro
EndImport  
;}
;-----------------------
;- SDL_blendmode.h.pbi
;{

Enumeration BlendMode
  #BLENDMODE_NONE = $00000000
  #BLENDMODE_BLEND = $00000001
  #BLENDMODE_ADD = $00000002
  #BLENDMODE_MOD = $00000004
  CompilerIf VERSION_ATLEAST(2,0,12)
    #BLENDMODE_MUL = $00000008
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    #BLENDMODE_INVALID = $7FFFFFFF
  CompilerEndIf  
EndEnumeration
CompilerIf VERSION_ATLEAST(2,0,6)
  Enumeration BlendOperation
    #BLENDOPERATION_ADD = $1
    #BLENDOPERATION_SUBTRACT = $2
    #BLENDOPERATION_REV_SUBTRACT = $3
    #BLENDOPERATION_MINIMUM = $4
    #BLENDOPERATION_MAXIMUM = $5
  EndEnumeration
  Enumeration BlendFactor
    #BLENDFACTOR_ZERO = $1
    #BLENDFACTOR_ONE = $2
    #BLENDFACTOR_SRC_COLOR = $3
    #BLENDFACTOR_ONE_MINUS_SRC_COLOR = $4
    #BLENDFACTOR_SRC_ALPHA = $5
    #BLENDFACTOR_ONE_MINUS_SRC_ALPHA = $6
    #BLENDFACTOR_DST_COLOR = $7
    #BLENDFACTOR_ONE_MINUS_DST_COLOR = $8
    #BLENDFACTOR_DST_ALPHA = $9
    #BLENDFACTOR_ONE_MINUS_DST_ALPHA = $A
  EndEnumeration
CompilerEndIf
ImportC #SDL2_lib
  CompilerIf VERSION_ATLEAST(2,0,6)
    ComposeCustomBlendMode.enum(srcColorFactor.enum, dstColorFactor.enum, colorOperation.enum, srcAlphaFactor.enum, dstAlphaFactor.enum, alphaOperation.enum) As #FuncPrefix + "SDL_ComposeCustomBlendMode"
  CompilerEndIf
EndImport
;}
;-----------------------
;- SDL_surface.h.pbi
;{

Macro WINDOWPOS_UNDEFINED_DISPLAY(X):  (SDL::#WINDOWPOS_UNDEFINED_MASK|(X)) :EndMacro
Macro WINDOWPOS_ISUNDEFINED(X) : Bool(((X)&$FFFF0000) = SDL::#WINDOWPOS_UNDEFINED_MASK) :EndMacro
Macro WINDOWPOS_CENTERED_DISPLAY(X):  (SDL::#WINDOWPOS_CENTERED_MASK|(X)) :EndMacro
Macro WINDOWPOS_ISCENTERED(X):  Bool(((X)&$FFFF0000) = SDL::#WINDOWPOS_CENTERED_MASK) :EndMacro
#SWSURFACE = 0
#PREALLOC = $00000001
#RLEACCEL = $00000002
#DONTFREE = $00000004
CompilerIf VERSION_ATLEAST(2,0,10)
  #SIMD_ALIGNED = $00000008
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,8)
  Enumeration YUV_CONVERSION_MODE
    #YUV_CONVERSION_JPEG
    #YUV_CONVERSION_BT601
    #YUV_CONVERSION_BT709
    #YUV_CONVERSION_AUTOMATIC
  EndEnumeration
CompilerEndIf
Structure Surface Align #SDLALIGN
  flags.Uint32
  *format.PixelFormat
  w.int
  h.int
  pitch.int
  *pixels.pvoid
  *userdata.pvoid
  locked.int
  *lock_data.pvoid
  clip_rect.Rect
  *map.pBlitMap
  refcount.int
EndStructure
Macro r_Surface: i :EndMacro
Macro blit: integer :EndMacro ;  blit.int(*src.surface, *srcrect.rect, *dst.surface, *dstrect.rect);
ImportC #SDL2_lib
  CreateRGBSurface.r_Surface(flags.Uint32, width.int, height.int, depth.int, Rmask.Uint32, Gmask.Uint32, Bmask.Uint32, Amask.Uint32) As #FuncPrefix + "SDL_CreateRGBSurface"
  CompilerIf VERSION_ATLEAST(2,0,5)
    CreateRGBSurfaceWithFormat.r_Surface(flags.Uint32, width.int, height.int, depth.int, format.Uint32) As #FuncPrefix + "SDL_CreateRGBSurfaceWithFormat"
  CompilerEndIf
  CreateRGBSurfaceFrom.r_Surface(*pixels.pvoid, width.int, height.int, depth.int, pitch.int, Rmask.Uint32, Gmask.Uint32, Bmask.Uint32, Amask.Uint32) As #FuncPrefix + "SDL_CreateRGBSurfaceFrom"
  CompilerIf VERSION_ATLEAST(2,0,5)
    CreateRGBSurfaceWithFormatFrom.r_Surface(*pixels.pvoid, width.int, height.int, depth.int, pitch.int, format.Uint32) As #FuncPrefix + "SDL_CreateRGBSurfaceWithFormatFrom"
  CompilerEndIf
  FreeSurface.void(*surface.Surface) As #FuncPrefix + "SDL_FreeSurface"
  SetSurfacePalette.int(*surface.Surface, *palette.Palette) As #FuncPrefix + "SDL_SetSurfacePalette"
  LockSurface.int(*surface.Surface) As #FuncPrefix + "SDL_LockSurface"
  UnlockSurface.void(*surface.Surface) As #FuncPrefix + "SDL_UnlockSurface"
  LoadBMP_RW.r_Surface(*src.RWops, freesrc.int) As #FuncPrefix + "SDL_LoadBMP_RW"
  SaveBMP_RW.int(*surface.Surface, *dst.RWops, freedst.int) As #FuncPrefix + "SDL_SaveBMP_RW"
  SetSurfaceRLE.int(*surface.Surface, flag.int) As #FuncPrefix + "SDL_SetSurfaceRLE"
  SetColorKey.int(*surface.Surface, flag.int, key.Uint32) As #FuncPrefix + "SDL_SetColorKey"
  CompilerIf VERSION_ATLEAST(2,0,9)
    HasColorKey.t_bool(*surface.Surface) As #FuncPrefix + "SDL_HasColorKey"
  CompilerEndIf
  GetColorKey.int(*surface.Surface, *key.pUint32) As #FuncPrefix + "SDL_GetColorKey"
  SetSurfaceColorMod.int(*surface.Surface, r.Uint8, g.Uint8, b.Uint8) As #FuncPrefix + "SDL_SetSurfaceColorMod"
  GetSurfaceColorMod.int(*surface.Surface, *r.pUint8, *g.pUint8, *b.pUint8) As #FuncPrefix + "SDL_GetSurfaceColorMod"
  SetSurfaceAlphaMod.int(*surface.Surface, alpha.Uint8) As #FuncPrefix + "SDL_SetSurfaceAlphaMod"
  GetSurfaceAlphaMod.int(*surface.Surface, *alpha.pUint8) As #FuncPrefix + "SDL_GetSurfaceAlphaMod"
  SetSurfaceBlendMode.int(*surface.Surface, blendMode.enum) As #FuncPrefix + "SDL_SetSurfaceBlendMode"
  GetSurfaceBlendMode.int(*surface.Surface, *blendMode.penum) As #FuncPrefix + "SDL_GetSurfaceBlendMode"
  SetClipRect.t_bool(*surface.Surface, *rectxx.Rect) As #FuncPrefix + "SDL_SetClipRect"
  GetClipRect.void(*surface.Surface, *rectxx.Rect) As #FuncPrefix + "SDL_GetClipRect"
  CompilerIf VERSION_ATLEAST(2,0,6)
    DuplicateSurface.r_Surface(*surface.Surface) As #FuncPrefix + "SDL_DuplicateSurface"
  CompilerEndIf
  ConvertSurface.r_Surface(*src.Surface, *fmt.PixelFormat, flags.Uint32) As #FuncPrefix + "SDL_ConvertSurface"
  ConvertSurfaceFormat.r_Surface(*src.Surface, pixel_format.Uint32, flags.Uint32) As #FuncPrefix + "SDL_ConvertSurfaceFormat"
  ConvertPixels.int(width.int, height.int, src_format.Uint32, *src.pvoid, src_pitch.int, dst_format.Uint32, *dst.pvoid, dst_pitch.int) As #FuncPrefix + "SDL_ConvertPixels"
  FillRect.int(*dst.Surface, *rectxx.Rect, color.Uint32) As #FuncPrefix + "SDL_FillRect"
  FillRects.int(*dst.Surface, *rectxs.Rect, count.int, color.Uint32) As #FuncPrefix + "SDL_FillRects"
  UpperBlit.int(*src.Surface, *srcrect.Rect, *dst.Surface, *dstrect.Rect) As #FuncPrefix + "SDL_UpperBlit"
  LowerBlit.int(*src.Surface, *srcrect.Rect, *dst.Surface, *dstrect.Rect) As #FuncPrefix + "SDL_LowerBlit"
  SoftStretch.int(*src.Surface, *srcrect.Rect, *dst.Surface, *dstrect.Rect) As #FuncPrefix + "SDL_SoftStretch"
  UpperBlitScaled.int(*src.Surface, *srcrect.Rect, *dst.Surface, *dstrect.Rect) As #FuncPrefix + "SDL_UpperBlitScaled"
  LowerBlitScaled.int(*src.Surface, *srcrect.Rect, *dst.Surface, *dstrect.Rect) As #FuncPrefix + "SDL_LowerBlitScaled"
  CompilerIf VERSION_ATLEAST(2,0,8)
    SetYUVConversionMode.void(mode.enum) As #FuncPrefix + "SDL_SetYUVConversionMode"
    GetYUVConversionMode.enum() As #FuncPrefix + "SDL_GetYUVConversionMode"
    GetYUVConversionModeForResolution.enum(width.int, height.int) As #FuncPrefix + "SDL_GetYUVConversionModeForResolution"
  CompilerEndIf
  Macro LoadBMP(file) : SDL::LoadBMP_RW(SDL::RWFromFile(file, "rb"), 1) :EndMacro
  Macro SaveBMP(surface, file): SDL::SaveBMP_RW(surface, SDL::RWFromFile(file, "wb"), 1) :EndMacro
  Macro BlitSurface(src,srcrect,dst,destrect): SDL::UpperBlit(src,srcrect,dst,destrect) :EndMacro
  Macro BlitScaled(src,srcrect,dst,dstrect): SDL::UpperBlitScaled(src,srcrect,dst,dstrect) :EndMacro
  Macro MUSTLOCK(S): Bool(((S\flags & #RLEACCEL) <> 0) :EndMacro
EndImport
;}
;-----------------------
;- SDL_video.h.pbi
;{

Macro t_GLContext: pvoid :EndMacro
Macro t_Keycode: Sint32 :EndMacro
Macro r_GLContext: i :EndMacro
Macro HitTest: integer :EndMacro ;   HitTest.enum(*win.window, *area.point, *Data.pvoid);
Macro r_Window: i :EndMacro
Structure Window:EndStructure
Enumeration WindowFlags
  #WINDOW_FULLSCREEN=$00000001
  #WINDOW_OPENGL=$00000002
  #WINDOW_SHOWN=$00000004
  #WINDOW_HIDDEN=$00000008
  #WINDOW_BORDERLESS=$00000010
  #WINDOW_RESIZABLE=$00000020
  #WINDOW_MINIMIZED=$00000040
  #WINDOW_MAXIMIZED=$00000080
  #WINDOW_INPUT_GRABBED=$00000100
  #WINDOW_INPUT_FOCUS=$00000200
  #WINDOW_MOUSE_FOCUS=$00000400
  #WINDOW_FULLSCREEN_DESKTOP=(#WINDOW_FULLSCREEN|$00001000)
  #WINDOW_FOREIGN=$00000800
  CompilerIf VERSION_ATLEAST(2,0,1)
    #WINDOW_ALLOW_HIGHDPI=$00002000
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,4)
    #WINDOW_MOUSE_CAPTURE=$00004000
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,5)
    #WINDOW_ALWAYS_ON_TOP=$00008000
    #WINDOW_SKIP_TASKBAR=$00010000
    #WINDOW_UTILITY=$00020000
    #WINDOW_TOOLTIP=$00040000
    #WINDOW_POPUP_MENU=$00080000
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    #WINDOW_VULKAN=$10000000
  CompilerEndIf
EndEnumeration
#WINDOWPOS_UNDEFINED_MASK = $1FFF0000
#WINDOWPOS_CENTERED_MASK = $2FFF0000
#WINDOWPOS_UNDEFINED = WINDOWPOS_UNDEFINED_DISPLAY(0)
#WINDOWPOS_CENTERED = WINDOWPOS_CENTERED_DISPLAY(0)
Enumeration WindowEventID
  #WINDOWEVENT_NONE
  #WINDOWEVENT_SHOWN
  #WINDOWEVENT_HIDDEN
  #WINDOWEVENT_EXPOSED
  #WINDOWEVENT_MOVED
  #WINDOWEVENT_RESIZED
  #WINDOWEVENT_SIZE_CHANGED
  #WINDOWEVENT_MINIMIZED
  #WINDOWEVENT_MAXIMIZED
  #WINDOWEVENT_RESTORED
  #WINDOWEVENT_ENTER
  #WINDOWEVENT_LEAVE
  #WINDOWEVENT_FOCUS_GAINED
  #WINDOWEVENT_FOCUS_LOST
  #WINDOWEVENT_CLOSE
  CompilerIf VERSION_ATLEAST(2,0,5)
    #WINDOWEVENT_TAKE_FOCUS    
    #WINDOWEVENT_HIT_TEST
  CompilerEndIf
EndEnumeration
CompilerIf VERSION_ATLEAST(2,0,9)
  Enumeration DisplayEventID
    #DISPLAYEVENT_NONE
    #DISPLAYEVENT_ORIENTATION
  EndEnumeration
  Enumeration DisplayOrientation
    #ORIENTATION_UNKNOWN
    #ORIENTATION_LANDSCAPE
    #ORIENTATION_LANDSCAPE_FLIPPED
    #ORIENTATION_PORTRAIT
    #ORIENTATION_PORTRAIT_FLIPPED
  EndEnumeration
CompilerEndIf
Enumeration GLattr
  #GL_RED_SIZE
  #GL_GREEN_SIZE
  #GL_BLUE_SIZE
  #GL_ALPHA_SIZE
  #GL_BUFFER_SIZE
  #GL_DOUBLEBUFFER_
  #GL_DEPTH_SIZE
  #GL_STENCIL_SIZE
  #GL_ACCUM_RED_SIZE
  #GL_ACCUM_GREEN_SIZE
  #GL_ACCUM_BLUE_SIZE
  #GL_ACCUM_ALPHA_SIZE
  #GL_STEREO_
  #GL_MULTISAMPLEBUFFERS
  #GL_MULTISAMPLESAMPLES
  #GL_ACCELERATED_VISUAL
  #GL_RETAINED_BACKING
  #GL_CONTEXT_MAJOR_VERSION
  #GL_CONTEXT_MINOR_VERSION
  #GL_CONTEXT_EGL
  #GL_CONTEXT_FLAGS
  #GL_CONTEXT_PROFILE_MASK
  #GL_SHARE_WITH_CURRENT_CONTEXT
  CompilerIf VERSION_ATLEAST(2,0,1)
    #GL_FRAMEBUFFER_SRGB_CAPABLE
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,4)
    #GL_CONTEXT_RELEASE_BEHAVIOR
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    #GL_CONTEXT_RESET_NOTIFICATION
    #GL_CONTEXT_NO_ERROR
  CompilerEndIf
EndEnumeration
Enumeration GLprofile
  #GL_CONTEXT_PROFILE_CORE=$0001
  #GL_CONTEXT_PROFILE_COMPATIBILITY=$0002
  #GL_CONTEXT_PROFILE_ES=$0004
EndEnumeration
Enumeration GLcontextFlag
  #GL_CONTEXT_DEBUG_FLAG=$0001
  #GL_CONTEXT_FORWARD_COMPATIBLE_FLAG=$0002
  #GL_CONTEXT_ROBUST_ACCESS_FLAG=$0004
  #GL_CONTEXT_RESET_ISOLATION_FLAG=$0008
EndEnumeration
CompilerIf VERSION_ATLEAST(2,0,4)
  Enumeration GLcontextReleaseFlag
    #GL_CONTEXT_RELEASE_BEHAVIOR_NONE=$0000
    #GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH=$0001
  EndEnumeration
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,6)
  Enumeration GLContextResetNotification
    #GL_CONTEXT_RESET_NO_NOTIFICATION=$0000
    #GL_CONTEXT_RESET_LOSE_CONTEXT=$0001
  EndEnumeration
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  Enumeration HitTestResult
    #HITTEST_NORMAL
    #HITTEST_DRAGGABLE
    #HITTEST_RESIZE_TOPLEFT
    #HITTEST_RESIZE_TOP
    #HITTEST_RESIZE_TOPRIGHT
    #HITTEST_RESIZE_RIGHT
    #HITTEST_RESIZE_BOTTOMRIGHT
    #HITTEST_RESIZE_BOTTOM
    #HITTEST_RESIZE_BOTTOMLEFT
    #HITTEST_RESIZE_LEFT
  EndEnumeration
CompilerEndIf
Structure DisplayMode Align #SDLALIGN
  format.Uint32
  w.int
  h.int
  refresh_rate.int
  *driverdata.pvoid
EndStructure
Macro r_DisplayMode: i :EndMacro
ImportC #SDL2_lib
  GetNumVideoDrivers.int() As #FuncPrefix + "SDL_GetNumVideoDrivers"
  _GetVideoDriver.r_ascii(index.int) As #FuncPrefix + "SDL_GetVideoDriver"
  Macro GetVideoDriver(index): SDL::_GetAscii(SDL::_GetVideoDriver(index)) :EndMacro
  VideoInit.int(driver_name.p-ascii) As #FuncPrefix + "SDL_VideoInit"
  VideoQuit.void() As #FuncPrefix + "SDL_VideoQuit"
  _GetCurrentVideoDriver.r_ascii() As #FuncPrefix + "SDL_GetCurrentVideoDriver"
  Macro GetCurrentVideoDriver(): SDL::_GetAscii(SDL::_GetCurrentVideoDriver()) :EndMacro
  GetNumVideoDisplays.int() As #FuncPrefix + "SDL_GetNumVideoDisplays"
  _GetDisplayName.r_utf8(displayIndex.int) As #FuncPrefix + "SDL_GetDisplayName"
  Macro GetDisplayName(index): SDL::_GetUTF8(SDL::_GetDisplayName(index)) :EndMacro
  GetDisplayBounds.int(displayIndex.int, *rectxx.Rect) As #FuncPrefix + "SDL_GetDisplayBounds"
  CompilerIf VERSION_ATLEAST(2,0,5)
    GetDisplayUsableBounds.int(displayIndex.int, *rectxx.Rect) As #FuncPrefix + "SDL_GetDisplayUsableBounds"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,4)
    GetDisplayDPI.int(displayIndex.int, *ddpi.pfloat, *hdpi.pfloat, *vdpi.pfloat) As #FuncPrefix + "SDL_GetDisplayDPI"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,9)
    GetDisplayOrientation.enum(displayIndex.int) As #FuncPrefix + "SDL_GetDisplayOrientation"
  CompilerEndIf
  GetNumDisplayModes.int(displayIndex.int) As #FuncPrefix + "SDL_GetNumDisplayModes"
  GetDisplayMode.int(displayIndex.int, modeIndex.int, *mode.DisplayMode) As #FuncPrefix + "SDL_GetDisplayMode"
  GetDesktopDisplayMode.int(displayIndex.int, *mode.DisplayMode) As #FuncPrefix + "SDL_GetDesktopDisplayMode"
  GetCurrentDisplayMode.int(displayIndex.int, *mode.DisplayMode) As #FuncPrefix + "SDL_GetCurrentDisplayMode"
  GetClosestDisplayMode.r_DisplayMode(displayIndex.int, *mode.DisplayMode, *closest.DisplayMode) As #FuncPrefix + "SDL_GetClosestDisplayMode"
  GetWindowDisplayIndex.int(*window.Window) As #FuncPrefix + "SDL_GetWindowDisplayIndex"
  SetWindowDisplayMode.int(*window.Window, *mode.DisplayMode) As #FuncPrefix + "SDL_SetWindowDisplayMode"
  GetWindowDisplayMode.int(*window.Window, *mode.DisplayMode) As #FuncPrefix + "SDL_GetWindowDisplayMode"
  GetWindowPixelFormat.Uint32(*window.Window) As #FuncPrefix + "SDL_GetWindowPixelFormat"
  CreateWindow.r_Window(title.p-utf8, x.int, y.int, w.int, h.int, flags.Uint32) As #FuncPrefix + "SDL_CreateWindow"
  CreateWindowFrom.r_Window(*data.pvoid) As #FuncPrefix + "SDL_CreateWindowFrom"
  GetWindowID.Uint32(*window.Window) As #FuncPrefix + "SDL_GetWindowID"
  GetWindowFromID.r_Window(id.Uint32) As #FuncPrefix + "SDL_GetWindowFromID"
  GetWindowFlags.Uint32(*window.Window) As #FuncPrefix + "SDL_GetWindowFlags"
  _SetWindowTitle.void(*window.Window, title.p-utf8) As #FuncPrefix + "SDL_SetWindowTitle"
  Macro SetWindowTitle(window,title): SDL::_SetWindowTitle(window,title) :EndMacro
  _GetWindowTitle.r_utf8(*window.Window) As #FuncPrefix + "SDL_GetWindowTitle"
  Macro GetWindowTitle(window): SDL::_GetAscii(SDL::_GetWindowTitle(window)) :EndMacro
  SetWindowIcon.void(*window.Window, *icon.Surface) As #FuncPrefix + "SDL_SetWindowIcon"
  _SetWindowData.r_void(*window.Window, name.p-ascii, *userdata.pvoid) As #FuncPrefix + "SDL_SetWindowData"
  Macro SetWindowData(window,name,dat): SDL::_SetWindowData(window,name,dat) : EndMacro  
  _GetWindowData.r_void(*window.Window, name.p-ascii) As #FuncPrefix + "SDL_GetWindowData"
  Macro GetWindowData(window, name): SDL::_GetWindowData(window,name) :EndMacro
  SetWindowPosition.void(*window.Window, x.int, y.int) As #FuncPrefix + "SDL_SetWindowPosition"
  GetWindowPosition.void(*window.Window, *x.pint, *y.pint) As #FuncPrefix + "SDL_GetWindowPosition"
  SetWindowSize.void(*window.Window, w.int, h.int) As #FuncPrefix + "SDL_SetWindowSize"
  GetWindowSize.void(*window.Window, *w.pint, *h.pint) As #FuncPrefix + "SDL_GetWindowSize"
  CompilerIf VERSION_ATLEAST(2,0,5)
    GetWindowBordersSize.int(*window.Window, *top.pint, *left.pint, *bottom.pint, *right.pint) As #FuncPrefix + "SDL_GetWindowBordersSize"
  CompilerEndIf
  SetWindowMinimumSize.void(*window.Window, min_w.int, min_h.int) As #FuncPrefix + "SDL_SetWindowMinimumSize"
  GetWindowMinimumSize.void(*window.Window, *w.pint, *h.pint) As #FuncPrefix + "SDL_GetWindowMinimumSize"
  SetWindowMaximumSize.void(*window.Window, max_w.int, max_h.int) As #FuncPrefix + "SDL_SetWindowMaximumSize"
  GetWindowMaximumSize.void(*window.Window, *w.pint, *h.pint) As #FuncPrefix + "SDL_GetWindowMaximumSize"
  SetWindowBordered.void(*window.Window, bordered.t_bool) As #FuncPrefix + "SDL_SetWindowBordered"
  CompilerIf VERSION_ATLEAST(2,0,5)
    SetWindowResizable.void(*window.Window, resizable.t_bool) As #FuncPrefix + "SDL_SetWindowResizable"
  CompilerEndIf
  ShowWindow.void(*window.Window) As #FuncPrefix + "SDL_ShowWindow"
  _HideWindow.void(*window.Window) As #FuncPrefix + "SDL_HideWindow"
  Macro HideWindow(window): SDL::_HideWindow(window) :EndMacro
  RaiseWindow.void(*window.Window) As #FuncPrefix + "SDL_RaiseWindow"
  MaximizeWindow.void(*window.Window) As #FuncPrefix + "SDL_MaximizeWindow"
  MinimizeWindow.void(*window.Window) As #FuncPrefix + "SDL_MinimizeWindow"
  RestoreWindow.void(*window.Window) As #FuncPrefix + "SDL_RestoreWindow"
  SetWindowFullscreen.int(*window.Window, flags.Uint32) As #FuncPrefix + "SDL_SetWindowFullscreen"
  GetWindowSurface.r_Surface(*window.Window) As #FuncPrefix + "SDL_GetWindowSurface"
  UpdateWindowSurface.int(*window.Window) As #FuncPrefix + "SDL_UpdateWindowSurface"
  UpdateWindowSurfaceRects.int(*window.Window, *rectxs.Rect, numrects.int) As #FuncPrefix + "SDL_UpdateWindowSurfaceRects"
  SetWindowGrab.void(*window.Window, grabbed.t_bool) As #FuncPrefix + "SDL_SetWindowGrab"
  GetWindowGrab.t_bool(*window.Window) As #FuncPrefix + "SDL_GetWindowGrab"
  CompilerIf VERSION_ATLEAST(2,0,4)
    GetGrabbedWindow.r_Window() As #FuncPrefix + "SDL_GetGrabbedWindow"
  CompilerEndIf
  SetWindowBrightness.int(*window.Window, brightness.f) As #FuncPrefix + "SDL_SetWindowBrightness"
  GetWindowBrightness.f(*window.Window) As #FuncPrefix + "SDL_GetWindowBrightness"
  CompilerIf VERSION_ATLEAST(2,0,5)
    SetWindowOpacity.int(*window.Window, opacity.f) As #FuncPrefix + "SDL_SetWindowOpacity"
    GetWindowOpacity.int(*window.Window, *out_opacity.pfloat) As #FuncPrefix + "SDL_GetWindowOpacity"
    SetWindowModalFor.int(*modal_window.Window, *parent_window.Window) As #FuncPrefix + "SDL_SetWindowModalFor"
    SetWindowInputFocus.int(*window.Window) As #FuncPrefix + "SDL_SetWindowInputFocus"
  CompilerEndIf
  SetWindowGammaRamp.int(*window.Window, *red.pUint16, *green.pUint16, *blue.pUint16) As #FuncPrefix + "SDL_SetWindowGammaRamp"
  GetWindowGammaRamp.int(*window.Window, *red.pUint16, *green.pUint16, *blue.pUint16) As #FuncPrefix + "SDL_GetWindowGammaRamp"
  CompilerIf VERSION_ATLEAST(2,0,4)
    SetWindowHitTest.int(*window.Window, *callback.HitTest, *callback_data.pvoid) As #FuncPrefix + "SDL_SetWindowHitTest"
  CompilerEndIf
  DestroyWindow.void(*window.Window) As #FuncPrefix + "SDL_DestroyWindow"
  IsScreenSaverEnabled.t_bool() As #FuncPrefix + "SDL_IsScreenSaverEnabled"
  EnableScreenSaver.void() As #FuncPrefix + "SDL_EnableScreenSaver"
  DisableScreenSaver.void() As #FuncPrefix + "SDL_DisableScreenSaver"
  GL_LoadLibrary.int(path.p-utf8) As #FuncPrefix + "SDL_GL_LoadLibrary"
  GL_GetProcAddress.r_void(proc.p-ascii) As #FuncPrefix + "SDL_GL_GetProcAddress"
  GL_UnloadLibrary.void() As #FuncPrefix + "SDL_GL_UnloadLibrary"
  GL_ExtensionSupported.t_bool(extension.p-ascii) As #FuncPrefix + "SDL_GL_ExtensionSupported"
  CompilerIf VERSION_ATLEAST(2,0,2)
    GL_ResetAttributes.void() As #FuncPrefix + "SDL_GL_ResetAttributes"
  CompilerEndIf
  GL_SetAttribute.int(attr.enum, value.int) As #FuncPrefix + "SDL_GL_SetAttribute"
  GL_GetAttribute.int(attr.enum, *value.pint) As #FuncPrefix + "SDL_GL_GetAttribute"
  GL_CreateContext.r_GLContext (*window.Window) As #FuncPrefix + "SDL_GL_CreateContext"
  GL_MakeCurrent.int(*window.Window, *context.t_GLContext ) As #FuncPrefix + "SDL_GL_MakeCurrent"
  GL_GetCurrentWindow.r_Window() As #FuncPrefix + "SDL_GL_GetCurrentWindow"
  GL_GetCurrentContext.r_GLContext () As #FuncPrefix + "SDL_GL_GetCurrentContext"
  CompilerIf VERSION_ATLEAST(2,0,1)
    GL_GetDrawableSize.void(*window.Window, *w.pint, *h.pint) As #FuncPrefix + "SDL_GL_GetDrawableSize"
  CompilerEndIf
  GL_SetSwapInterval.int(interval.int) As #FuncPrefix + "SDL_GL_SetSwapInterval"
  GL_GetSwapInterval.int() As #FuncPrefix + "SDL_GL_GetSwapInterval"
  GL_SwapWindow.void(*window.Window) As #FuncPrefix + "SDL_GL_SwapWindow"
  GL_DeleteContext.void(*context.t_GLContext ) As #FuncPrefix + "SDL_GL_DeleteContext"
EndImport
;}
;-----------------------
;- SDL_scancode.h.pbi
;{

Enumeration Scancode
  #SCANCODE_UNKNOWN = 0
  #SCANCODE_A = 4
  #SCANCODE_B = 5
  #SCANCODE_C = 6
  #SCANCODE_D = 7
  #SCANCODE_E = 8
  #SCANCODE_F = 9
  #SCANCODE_G = 10
  #SCANCODE_H = 11
  #SCANCODE_I = 12
  #SCANCODE_J = 13
  #SCANCODE_K = 14
  #SCANCODE_L = 15
  #SCANCODE_M = 16
  #SCANCODE_N = 17
  #SCANCODE_O = 18
  #SCANCODE_P = 19
  #SCANCODE_Q = 20
  #SCANCODE_R = 21
  #SCANCODE_S = 22
  #SCANCODE_T = 23
  #SCANCODE_U = 24
  #SCANCODE_V = 25
  #SCANCODE_W = 26
  #SCANCODE_X = 27
  #SCANCODE_Y = 28
  #SCANCODE_Z = 29
  #SCANCODE_1 = 30
  #SCANCODE_2 = 31
  #SCANCODE_3 = 32
  #SCANCODE_4 = 33
  #SCANCODE_5 = 34
  #SCANCODE_6 = 35
  #SCANCODE_7 = 36
  #SCANCODE_8 = 37
  #SCANCODE_9 = 38
  #SCANCODE_0 = 39
  #SCANCODE_RETURN = 40
  #SCANCODE_ESCAPE = 41
  #SCANCODE_BACKSPACE = 42
  #SCANCODE_TAB = 43
  #SCANCODE_SPACE = 44
  #SCANCODE_MINUS = 45
  #SCANCODE_EQUALS = 46
  #SCANCODE_LEFTBRACKET = 47
  #SCANCODE_RIGHTBRACKET = 48
  #SCANCODE_BACKSLASH = 49
  #SCANCODE_NONUSHASH = 50
  #SCANCODE_SEMICOLON = 51
  #SCANCODE_APOSTROPHE = 52
  #SCANCODE_GRAVE = 53
  #SCANCODE_COMMA = 54
  #SCANCODE_PERIOD = 55
  #SCANCODE_SLASH = 56
  #SCANCODE_CAPSLOCK = 57
  #SCANCODE_F1 = 58
  #SCANCODE_F2 = 59
  #SCANCODE_F3 = 60
  #SCANCODE_F4 = 61
  #SCANCODE_F5 = 62
  #SCANCODE_F6 = 63
  #SCANCODE_F7 = 64
  #SCANCODE_F8 = 65
  #SCANCODE_F9 = 66
  #SCANCODE_F10 = 67
  #SCANCODE_F11 = 68
  #SCANCODE_F12 = 69
  #SCANCODE_PRINTSCREEN = 70
  #SCANCODE_SCROLLLOCK = 71
  #SCANCODE_PAUSE = 72
  #SCANCODE_INSERT = 73
  #SCANCODE_HOME = 74
  #SCANCODE_PAGEUP = 75
  #SCANCODE_DELETE = 76
  #SCANCODE_END = 77
  #SCANCODE_PAGEDOWN = 78
  #SCANCODE_RIGHT = 79
  #SCANCODE_LEFT = 80
  #SCANCODE_DOWN = 81
  #SCANCODE_UP = 82
  #SCANCODE_NUMLOCKCLEAR = 83
  #SCANCODE_KP_DIVIDE = 84
  #SCANCODE_KP_MULTIPLY = 85
  #SCANCODE_KP_MINUS = 86
  #SCANCODE_KP_PLUS = 87
  #SCANCODE_KP_ENTER = 88
  #SCANCODE_KP_1 = 89
  #SCANCODE_KP_2 = 90
  #SCANCODE_KP_3 = 91
  #SCANCODE_KP_4 = 92
  #SCANCODE_KP_5 = 93
  #SCANCODE_KP_6 = 94
  #SCANCODE_KP_7 = 95
  #SCANCODE_KP_8 = 96
  #SCANCODE_KP_9 = 97
  #SCANCODE_KP_0 = 98
  #SCANCODE_KP_PERIOD = 99
  #SCANCODE_NONUSBACKSLASH = 100
  #SCANCODE_APPLICATION = 101
  #SCANCODE_POWER = 102
  #SCANCODE_KP_EQUALS = 103
  #SCANCODE_F13 = 104
  #SCANCODE_F14 = 105
  #SCANCODE_F15 = 106
  #SCANCODE_F16 = 107
  #SCANCODE_F17 = 108
  #SCANCODE_F18 = 109
  #SCANCODE_F19 = 110
  #SCANCODE_F20 = 111
  #SCANCODE_F21 = 112
  #SCANCODE_F22 = 113
  #SCANCODE_F23 = 114
  #SCANCODE_F24 = 115
  #SCANCODE_EXECUTE = 116
  #SCANCODE_HELP = 117
  #SCANCODE_MENU = 118
  #SCANCODE_SELECT = 119
  #SCANCODE_STOP = 120
  #SCANCODE_AGAIN = 121
  #SCANCODE_UNDO = 122
  #SCANCODE_CUT = 123
  #SCANCODE_COPY = 124
  #SCANCODE_PASTE = 125
  #SCANCODE_FIND = 126
  #SCANCODE_MUTE = 127
  #SCANCODE_VOLUMEUP = 128
  #SCANCODE_VOLUMEDOWN = 129
  #SCANCODE_KP_COMMA = 133
  #SCANCODE_KP_EQUALSAS400 = 134
  #SCANCODE_INTERNATIONAL1 = 135
  #SCANCODE_INTERNATIONAL2 = 136
  #SCANCODE_INTERNATIONAL3 = 137
  #SCANCODE_INTERNATIONAL4 = 138
  #SCANCODE_INTERNATIONAL5 = 139
  #SCANCODE_INTERNATIONAL6 = 140
  #SCANCODE_INTERNATIONAL7 = 141
  #SCANCODE_INTERNATIONAL8 = 142
  #SCANCODE_INTERNATIONAL9 = 143
  #SCANCODE_LANG1 = 144
  #SCANCODE_LANG2 = 145
  #SCANCODE_LANG3 = 146
  #SCANCODE_LANG4 = 147
  #SCANCODE_LANG5 = 148
  #SCANCODE_LANG6 = 149
  #SCANCODE_LANG7 = 150
  #SCANCODE_LANG8 = 151
  #SCANCODE_LANG9 = 152
  #SCANCODE_ALTERASE = 153
  #SCANCODE_SYSREQ = 154
  #SCANCODE_CANCEL = 155
  #SCANCODE_CLEAR = 156
  #SCANCODE_PRIOR = 157
  #SCANCODE_RETURN2 = 158
  #SCANCODE_SEPARATOR = 159
  #SCANCODE_OUT = 160
  #SCANCODE_OPER = 161
  #SCANCODE_CLEARAGAIN = 162
  #SCANCODE_CRSEL = 163
  #SCANCODE_EXSEL = 164
  #SCANCODE_KP_00 = 176
  #SCANCODE_KP_000 = 177
  #SCANCODE_THOUSANDSSEPARATOR = 178
  #SCANCODE_DECIMALSEPARATOR = 179
  #SCANCODE_CURRENCYUNIT = 180
  #SCANCODE_CURRENCYSUBUNIT = 181
  #SCANCODE_KP_LEFTPAREN = 182
  #SCANCODE_KP_RIGHTPAREN = 183
  #SCANCODE_KP_LEFTBRACE = 184
  #SCANCODE_KP_RIGHTBRACE = 185
  #SCANCODE_KP_TAB = 186
  #SCANCODE_KP_BACKSPACE = 187
  #SCANCODE_KP_A = 188
  #SCANCODE_KP_B = 189
  #SCANCODE_KP_C = 190
  #SCANCODE_KP_D = 191
  #SCANCODE_KP_E = 192
  #SCANCODE_KP_F = 193
  #SCANCODE_KP_XOR = 194
  #SCANCODE_KP_POWER = 195
  #SCANCODE_KP_PERCENT = 196
  #SCANCODE_KP_LESS = 197
  #SCANCODE_KP_GREATER = 198
  #SCANCODE_KP_AMPERSAND = 199
  #SCANCODE_KP_DBLAMPERSAND = 200
  #SCANCODE_KP_VERTICALBAR = 201
  #SCANCODE_KP_DBLVERTICALBAR = 202
  #SCANCODE_KP_COLON = 203
  #SCANCODE_KP_HASH = 204
  #SCANCODE_KP_SPACE = 205
  #SCANCODE_KP_AT = 206
  #SCANCODE_KP_EXCLAM = 207
  #SCANCODE_KP_MEMSTORE = 208
  #SCANCODE_KP_MEMRECALL = 209
  #SCANCODE_KP_MEMCLEAR = 210
  #SCANCODE_KP_MEMADD = 211
  #SCANCODE_KP_MEMSUBTRACT = 212
  #SCANCODE_KP_MEMMULTIPLY = 213
  #SCANCODE_KP_MEMDIVIDE = 214
  #SCANCODE_KP_PLUSMINUS = 215
  #SCANCODE_KP_CLEAR = 216
  #SCANCODE_KP_CLEARENTRY = 217
  #SCANCODE_KP_BINARY = 218
  #SCANCODE_KP_OCTAL = 219
  #SCANCODE_KP_DECIMAL = 220
  #SCANCODE_KP_HEXADECIMAL = 221
  #SCANCODE_LCTRL = 224
  #SCANCODE_LSHIFT = 225
  #SCANCODE_LALT = 226
  #SCANCODE_LGUI = 227
  #SCANCODE_RCTRL = 228
  #SCANCODE_RSHIFT = 229
  #SCANCODE_RALT = 230
  #SCANCODE_RGUI = 231
  #SCANCODE_MODE = 257
  #SCANCODE_AUDIONEXT = 258
  #SCANCODE_AUDIOPREV = 259
  #SCANCODE_AUDIOSTOP = 260
  #SCANCODE_AUDIOPLAY = 261
  #SCANCODE_AUDIOMUTE = 262
  #SCANCODE_MEDIASELECT = 263
  #SCANCODE_WWW = 264
  #SCANCODE_MAIL = 265
  #SCANCODE_CALCULATOR = 266
  #SCANCODE_COMPUTER = 267
  #SCANCODE_AC_SEARCH = 268
  #SCANCODE_AC_HOME = 269
  #SCANCODE_AC_BACK = 270
  #SCANCODE_AC_FORWARD = 271
  #SCANCODE_AC_STOP = 272
  #SCANCODE_AC_REFRESH = 273
  #SCANCODE_AC_BOOKMARKS = 274
  #SCANCODE_BRIGHTNESSDOWN = 275
  #SCANCODE_BRIGHTNESSUP = 276
  #SCANCODE_DISPLAYSWITCH = 277
  #SCANCODE_KBDILLUMTOGGLE = 278
  #SCANCODE_KBDILLUMDOWN = 279
  #SCANCODE_KBDILLUMUP = 280
  #SCANCODE_EJECT = 281
  #SCANCODE_SLEEP = 282
  #SCANCODE_APP1 = 283
  #SCANCODE_APP2 = 284
  #SCANCODE_AUDIOREWIND = 285
  #SCANCODE_AUDIOFASTFORWARD = 286
  #NUM_SCANCODES = 512
EndEnumeration
;}
;-----------------------
;- SDL_keycode.h.pbi
;{

Macro SCANCODE_TO_KEYCODE(X):  (X | SDL::#K_SCANCODE_MASK) :EndMacro
#K_SCANCODE_MASK = (1<<30)
Enumeration KeyCode
  #K_UNKNOWN = 0
  #K_RETURN = #CR;'\r'
  #K_ESCAPE = #ESC;:'\033'
  #K_BACKSPACE = $08;'\b'
  #K_TAB = #TAB;'\t'
  #K_SPACE = ' '
  #K_EXCLAIM = '!'
  #K_QUOTEDBL = '"'
  #K_HASH = '#'
  #K_PERCENT = '%'
  #K_DOLLAR = '$'
  #K_AMPERSAND = '&'
  #K_QUOTE = 39;'\''
  #K_LEFTPAREN = '('
  #K_RIGHTPAREN = ')'
  #K_ASTERISK = '*'
  #K_PLUS = '+'
  #K_COMMA = ','
  #K_MINUS = '-'
  #K_PERIOD = '.'
  #K_SLASH = '/'
  #K_0 = '0'
  #K_1 = '1'
  #K_2 = '2'
  #K_3 = '3'
  #K_4 = '4'
  #K_5 = '5'
  #K_6 = '6'
  #K_7 = '7'
  #K_8 = '8'
  #K_9 = '9'
  #K_COLON = ':'
  #K_SEMICOLON = ';'
  #K_LESS = '<'
  #K_EQUALS = '='
  #K_GREATER = '>'
  #K_QUESTION = '?'
  #K_AT = '@'
  #K_LEFTBRACKET = '['
  #K_BACKSLASH = '\'
  #K_RIGHTBRACKET = ']'
  #K_CARET = '^'
  #K_UNDERSCORE = '_'
  #K_BACKQUOTE = '`'
  #K_a = 'a'
  #K_b = 'b'
  #K_c = 'c'
  #K_d = 'd'
  #K_e = 'e'
  #K_f = 'f'
  #K_g = 'g'
  #K_h = 'h'
  #K_i = 'i'
  #K_j = 'j'
  #K_k = 'k'
  #K_l = 'l'
  #K_m = 'm'
  #K_n = 'n'
  #K_o = 'o'
  #K_p = 'p'
  #K_q = 'q'
  #K_r = 'r'
  #K_s = 's'
  #K_t = 't'
  #K_u = 'u'
  #K_v = 'v'
  #K_w = 'w'
  #K_x = 'x'
  #K_y = 'y'
  #K_z = 'z'
  #K_CAPSLOCK = SCANCODE_TO_KEYCODE ( #SCANCODE_CAPSLOCK )
  #K_F1 = SCANCODE_TO_KEYCODE ( #SCANCODE_F1 )
  #K_F2 = SCANCODE_TO_KEYCODE ( #SCANCODE_F2 )
  #K_F3 = SCANCODE_TO_KEYCODE ( #SCANCODE_F3 )
  #K_F4 = SCANCODE_TO_KEYCODE ( #SCANCODE_F4 )
  #K_F5 = SCANCODE_TO_KEYCODE ( #SCANCODE_F5 )
  #K_F6 = SCANCODE_TO_KEYCODE ( #SCANCODE_F6 )
  #K_F7 = SCANCODE_TO_KEYCODE ( #SCANCODE_F7 )
  #K_F8 = SCANCODE_TO_KEYCODE ( #SCANCODE_F8 )
  #K_F9 = SCANCODE_TO_KEYCODE ( #SCANCODE_F9 )
  #K_F10 = SCANCODE_TO_KEYCODE ( #SCANCODE_F10 )
  #K_F11 = SCANCODE_TO_KEYCODE ( #SCANCODE_F11 )
  #K_F12 = SCANCODE_TO_KEYCODE ( #SCANCODE_F12 )
  #K_PRINTSCREEN = SCANCODE_TO_KEYCODE ( #SCANCODE_PRINTSCREEN )
  #K_SCROLLLOCK = SCANCODE_TO_KEYCODE ( #SCANCODE_SCROLLLOCK )
  #K_PAUSE = SCANCODE_TO_KEYCODE ( #SCANCODE_PAUSE )
  #K_INSERT = SCANCODE_TO_KEYCODE ( #SCANCODE_INSERT )
  #K_HOME = SCANCODE_TO_KEYCODE ( #SCANCODE_HOME )
  #K_PAGEUP = SCANCODE_TO_KEYCODE ( #SCANCODE_PAGEUP )
  #K_DELETE = 127;'\177'
  #K_END = SCANCODE_TO_KEYCODE ( #SCANCODE_END )
  #K_PAGEDOWN = SCANCODE_TO_KEYCODE ( #SCANCODE_PAGEDOWN )
  #K_RIGHT = SCANCODE_TO_KEYCODE ( #SCANCODE_RIGHT )
  #K_LEFT = SCANCODE_TO_KEYCODE ( #SCANCODE_LEFT )
  #K_DOWN = SCANCODE_TO_KEYCODE ( #SCANCODE_DOWN )
  #K_UP = SCANCODE_TO_KEYCODE ( #SCANCODE_UP )
  #K_NUMLOCKCLEAR = SCANCODE_TO_KEYCODE ( #SCANCODE_NUMLOCKCLEAR )
  #K_KP_DIVIDE = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_DIVIDE )
  #K_KP_MULTIPLY = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MULTIPLY )
  #K_KP_MINUS = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MINUS )
  #K_KP_PLUS = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_PLUS )
  #K_KP_ENTER = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_ENTER )
  #K_KP_1 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_1 )
  #K_KP_2 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_2 )
  #K_KP_3 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_3 )
  #K_KP_4 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_4 )
  #K_KP_5 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_5 )
  #K_KP_6 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_6 )
  #K_KP_7 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_7 )
  #K_KP_8 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_8 )
  #K_KP_9 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_9 )
  #K_KP_0 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_0 )
  #K_KP_PERIOD = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_PERIOD )
  #K_APPLICATION = SCANCODE_TO_KEYCODE ( #SCANCODE_APPLICATION )
  #K_POWER = SCANCODE_TO_KEYCODE ( #SCANCODE_POWER )
  #K_KP_EQUALS = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_EQUALS )
  #K_F13 = SCANCODE_TO_KEYCODE ( #SCANCODE_F13 )
  #K_F14 = SCANCODE_TO_KEYCODE ( #SCANCODE_F14 )
  #K_F15 = SCANCODE_TO_KEYCODE ( #SCANCODE_F15 )
  #K_F16 = SCANCODE_TO_KEYCODE ( #SCANCODE_F16 )
  #K_F17 = SCANCODE_TO_KEYCODE ( #SCANCODE_F17 )
  #K_F18 = SCANCODE_TO_KEYCODE ( #SCANCODE_F18 )
  #K_F19 = SCANCODE_TO_KEYCODE ( #SCANCODE_F19 )
  #K_F20 = SCANCODE_TO_KEYCODE ( #SCANCODE_F20 )
  #K_F21 = SCANCODE_TO_KEYCODE ( #SCANCODE_F21 )
  #K_F22 = SCANCODE_TO_KEYCODE ( #SCANCODE_F22 )
  #K_F23 = SCANCODE_TO_KEYCODE ( #SCANCODE_F23 )
  #K_F24 = SCANCODE_TO_KEYCODE ( #SCANCODE_F24 )
  #K_EXECUTE = SCANCODE_TO_KEYCODE ( #SCANCODE_EXECUTE )
  #K_HELP = SCANCODE_TO_KEYCODE ( #SCANCODE_HELP )
  #K_MENU = SCANCODE_TO_KEYCODE ( #SCANCODE_MENU )
  #K_SELECT = SCANCODE_TO_KEYCODE ( #SCANCODE_SELECT )
  #K_STOP = SCANCODE_TO_KEYCODE ( #SCANCODE_STOP )
  #K_AGAIN = SCANCODE_TO_KEYCODE ( #SCANCODE_AGAIN )
  #K_UNDO = SCANCODE_TO_KEYCODE ( #SCANCODE_UNDO )
  #K_CUT = SCANCODE_TO_KEYCODE ( #SCANCODE_CUT )
  #K_COPY = SCANCODE_TO_KEYCODE ( #SCANCODE_COPY )
  #K_PASTE = SCANCODE_TO_KEYCODE ( #SCANCODE_PASTE )
  #K_FIND = SCANCODE_TO_KEYCODE ( #SCANCODE_FIND )
  #K_MUTE = SCANCODE_TO_KEYCODE ( #SCANCODE_MUTE )
  #K_VOLUMEUP = SCANCODE_TO_KEYCODE ( #SCANCODE_VOLUMEUP )
  #K_VOLUMEDOWN = SCANCODE_TO_KEYCODE ( #SCANCODE_VOLUMEDOWN )
  #K_KP_COMMA = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_COMMA )
  #K_KP_EQUALSAS400 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_EQUALSAS400 )
  #K_ALTERASE = SCANCODE_TO_KEYCODE ( #SCANCODE_ALTERASE )
  #K_SYSREQ = SCANCODE_TO_KEYCODE ( #SCANCODE_SYSREQ )
  #K_CANCEL = SCANCODE_TO_KEYCODE ( #SCANCODE_CANCEL )
  #K_CLEAR = SCANCODE_TO_KEYCODE ( #SCANCODE_CLEAR )
  #K_PRIOR = SCANCODE_TO_KEYCODE ( #SCANCODE_PRIOR )
  #K_RETURN2 = SCANCODE_TO_KEYCODE ( #SCANCODE_RETURN2 )
  #K_SEPARATOR = SCANCODE_TO_KEYCODE ( #SCANCODE_SEPARATOR )
  #K_OUT = SCANCODE_TO_KEYCODE ( #SCANCODE_OUT )
  #K_OPER = SCANCODE_TO_KEYCODE ( #SCANCODE_OPER )
  #K_CLEARAGAIN = SCANCODE_TO_KEYCODE ( #SCANCODE_CLEARAGAIN )
  #K_CRSEL = SCANCODE_TO_KEYCODE ( #SCANCODE_CRSEL )
  #K_EXSEL = SCANCODE_TO_KEYCODE ( #SCANCODE_EXSEL )
  #K_KP_00 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_00 )
  #K_KP_000 = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_000 )
  #K_THOUSANDSSEPARATOR = SCANCODE_TO_KEYCODE ( #SCANCODE_THOUSANDSSEPARATOR )
  #K_DECIMALSEPARATOR = SCANCODE_TO_KEYCODE ( #SCANCODE_DECIMALSEPARATOR )
  #K_CURRENCYUNIT = SCANCODE_TO_KEYCODE ( #SCANCODE_CURRENCYUNIT )
  #K_CURRENCYSUBUNIT = SCANCODE_TO_KEYCODE ( #SCANCODE_CURRENCYSUBUNIT )
  #K_KP_LEFTPAREN = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_LEFTPAREN )
  #K_KP_RIGHTPAREN = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_RIGHTPAREN )
  #K_KP_LEFTBRACE = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_LEFTBRACE )
  #K_KP_RIGHTBRACE = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_RIGHTBRACE )
  #K_KP_TAB = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_TAB )
  #K_KP_BACKSPACE = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_BACKSPACE )
  #K_KP_A = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_A )
  #K_KP_B = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_B )
  #K_KP_C = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_C )
  #K_KP_D = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_D )
  #K_KP_E = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_E )
  #K_KP_F = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_F )
  #K_KP_XOR = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_XOR )
  #K_KP_POWER = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_POWER )
  #K_KP_PERCENT = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_PERCENT )
  #K_KP_LESS = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_LESS )
  #K_KP_GREATER = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_GREATER )
  #K_KP_AMPERSAND = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_AMPERSAND )
  #K_KP_DBLAMPERSAND = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_DBLAMPERSAND )
  #K_KP_VERTICALBAR = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_VERTICALBAR )
  #K_KP_DBLVERTICALBAR = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_DBLVERTICALBAR )
  #K_KP_COLON = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_COLON )
  #K_KP_HASH = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_HASH )
  #K_KP_SPACE = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_SPACE )
  #K_KP_AT = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_AT )
  #K_KP_EXCLAM = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_EXCLAM )
  #K_KP_MEMSTORE = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MEMSTORE )
  #K_KP_MEMRECALL = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MEMRECALL )
  #K_KP_MEMCLEAR = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MEMCLEAR )
  #K_KP_MEMADD = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MEMADD )
  #K_KP_MEMSUBTRACT = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MEMSUBTRACT )
  #K_KP_MEMMULTIPLY = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MEMMULTIPLY )
  #K_KP_MEMDIVIDE = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_MEMDIVIDE )
  #K_KP_PLUSMINUS = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_PLUSMINUS )
  #K_KP_CLEAR = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_CLEAR )
  #K_KP_CLEARENTRY = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_CLEARENTRY )
  #K_KP_BINARY = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_BINARY )
  #K_KP_OCTAL = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_OCTAL )
  #K_KP_DECIMAL = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_DECIMAL )
  #K_KP_HEXADECIMAL = SCANCODE_TO_KEYCODE ( #SCANCODE_KP_HEXADECIMAL )
  #K_LCTRL = SCANCODE_TO_KEYCODE ( #SCANCODE_LCTRL )
  #K_LSHIFT = SCANCODE_TO_KEYCODE ( #SCANCODE_LSHIFT )
  #K_LALT = SCANCODE_TO_KEYCODE ( #SCANCODE_LALT )
  #K_LGUI = SCANCODE_TO_KEYCODE ( #SCANCODE_LGUI )
  #K_RCTRL = SCANCODE_TO_KEYCODE ( #SCANCODE_RCTRL )
  #K_RSHIFT = SCANCODE_TO_KEYCODE ( #SCANCODE_RSHIFT )
  #K_RALT = SCANCODE_TO_KEYCODE ( #SCANCODE_RALT )
  #K_RGUI = SCANCODE_TO_KEYCODE ( #SCANCODE_RGUI )
  #K_MODE = SCANCODE_TO_KEYCODE ( #SCANCODE_MODE )
  #K_AUDIONEXT = SCANCODE_TO_KEYCODE ( #SCANCODE_AUDIONEXT )
  #K_AUDIOPREV = SCANCODE_TO_KEYCODE ( #SCANCODE_AUDIOPREV )
  #K_AUDIOSTOP = SCANCODE_TO_KEYCODE ( #SCANCODE_AUDIOSTOP )
  #K_AUDIOPLAY = SCANCODE_TO_KEYCODE ( #SCANCODE_AUDIOPLAY )
  #K_AUDIOMUTE = SCANCODE_TO_KEYCODE ( #SCANCODE_AUDIOMUTE )
  #K_MEDIASELECT = SCANCODE_TO_KEYCODE ( #SCANCODE_MEDIASELECT )
  #K_WWW = SCANCODE_TO_KEYCODE ( #SCANCODE_WWW )
  #K_MAIL = SCANCODE_TO_KEYCODE ( #SCANCODE_MAIL )
  #K_CALCULATOR = SCANCODE_TO_KEYCODE ( #SCANCODE_CALCULATOR )
  #K_COMPUTER = SCANCODE_TO_KEYCODE ( #SCANCODE_COMPUTER )
  #K_AC_SEARCH = SCANCODE_TO_KEYCODE ( #SCANCODE_AC_SEARCH )
  #K_AC_HOME = SCANCODE_TO_KEYCODE ( #SCANCODE_AC_HOME )
  #K_AC_BACK = SCANCODE_TO_KEYCODE ( #SCANCODE_AC_BACK )
  #K_AC_FORWARD = SCANCODE_TO_KEYCODE ( #SCANCODE_AC_FORWARD )
  #K_AC_STOP = SCANCODE_TO_KEYCODE ( #SCANCODE_AC_STOP )
  #K_AC_REFRESH = SCANCODE_TO_KEYCODE ( #SCANCODE_AC_REFRESH )
  #K_AC_BOOKMARKS = SCANCODE_TO_KEYCODE ( #SCANCODE_AC_BOOKMARKS )
  #K_BRIGHTNESSDOWN = SCANCODE_TO_KEYCODE ( #SCANCODE_BRIGHTNESSDOWN )
  #K_BRIGHTNESSUP = SCANCODE_TO_KEYCODE ( #SCANCODE_BRIGHTNESSUP )
  #K_DISPLAYSWITCH = SCANCODE_TO_KEYCODE ( #SCANCODE_DISPLAYSWITCH )
  #K_KBDILLUMTOGGLE = SCANCODE_TO_KEYCODE ( #SCANCODE_KBDILLUMTOGGLE )
  #K_KBDILLUMDOWN = SCANCODE_TO_KEYCODE ( #SCANCODE_KBDILLUMDOWN )
  #K_KBDILLUMUP = SCANCODE_TO_KEYCODE ( #SCANCODE_KBDILLUMUP )
  #K_EJECT = SCANCODE_TO_KEYCODE ( #SCANCODE_EJECT )
  #K_SLEEP = SCANCODE_TO_KEYCODE ( #SCANCODE_SLEEP )
  #K_APP1 = SCANCODE_TO_KEYCODE ( #SCANCODE_APP1 )
  #K_APP2 = SCANCODE_TO_KEYCODE ( #SCANCODE_APP2 )
  #K_AUDIOREWIND = SCANCODE_TO_KEYCODE ( #SCANCODE_AUDIOREWIND )
  #K_AUDIOFASTFORWARD = SCANCODE_TO_KEYCODE ( #SCANCODE_AUDIOFASTFORWARD )
EndEnumeration
Enumeration Keymod
  #KMOD_NONE = $0000
  #KMOD_LSHIFT = $0001
  #KMOD_RSHIFT = $0002
  #KMOD_LCTRL = $0040
  #KMOD_RCTRL = $0080
  #KMOD_LALT = $0100
  #KMOD_RALT = $0200
  #KMOD_LGUI = $0400
  #KMOD_RGUI = $0800
  #KMOD_NUM = $1000
  #KMOD_CAPS = $2000
  #KMOD_MODE = $4000
  #KMOD_RESERVED = $8000
EndEnumeration
#KMOD_CTRL   =(#KMOD_LCTRL|#KMOD_RCTRL)
#KMOD_SHIFT  =(#KMOD_LSHIFT|#KMOD_RSHIFT)
#KMOD_ALT    =(#KMOD_LALT|#KMOD_RALT)
#KMOD_GUI    =(#KMOD_LGUI|#KMOD_RGUI)
;}
;-----------------------
;- SDL_keyboard.h.pbi
;{

Structure Keysym Align #SDLALIGN
  scancode.enum
  sym.t_Keycode
  mod.Uint16
  unused.Uint32
EndStructure
Macro r_Keysym: i :EndMacro
ImportC #SDL2_lib
  GetKeyboardFocus.r_Window() As #FuncPrefix + "SDL_GetKeyboardFocus"
  GetKeyboardState.r_Uint8(*numkeys.pint) As #FuncPrefix + "SDL_GetKeyboardState"
  GetModState.enum() As #FuncPrefix + "SDL_GetModState"
  SetModState.void(modstate.enum) As #FuncPrefix + "SDL_SetModState"
  GetKeyFromScancode.enum(scancode.enum) As #FuncPrefix + "SDL_GetKeyFromScancode"
  GetScancodeFromKey.enum(key.enum) As #FuncPrefix + "SDL_GetScancodeFromKey"
  _GetScancodeName.r_utf8(scancode.enum) As #FuncPrefix + "SDL_GetScancodeName"
  Macro GetScancodeName(scancode): SDL::_GetUTF8(SDL::_GetScancodeName(scancode)) :EndMacro
  GetScancodeFromName.enum(name.p-utf8) As #FuncPrefix + "SDL_GetScancodeFromName"
  _GetKeyName.r_utf8(key.enum) As #FuncPrefix + "SDL_GetKeyName"
  Macro GetKeyName(key): SDL::_GetUTF8(SDL::_GetKeyName(key)) :EndMacro
  GetKeyFromName.enum(name.p-utf8) As #FuncPrefix + "SDL_GetKeyFromName"
  StartTextInput.void() As #FuncPrefix + "SDL_StartTextInput"
  IsTextInputActive.t_bool() As #FuncPrefix + "SDL_IsTextInputActive"
  StopTextInput.void() As #FuncPrefix + "SDL_StopTextInput"
  SetTextInputRect.void(*rectxx.Rect) As #FuncPrefix + "SDL_SetTextInputRect"
  HasScreenKeyboardSupport.t_bool() As #FuncPrefix + "SDL_HasScreenKeyboardSupport"
  IsScreenKeyboardShown.t_bool(*window.Window) As #FuncPrefix + "SDL_IsScreenKeyboardShown"
EndImport
;}
;-----------------------
;- SDL_mouse.h.pbi
;{

Macro BUTTON(X): (1 << ((X)-1)) :EndMacro
Enumeration SystemCursor
  #SYSTEM_CURSOR_ARROW
  #SYSTEM_CURSOR_IBEAM
  #SYSTEM_CURSOR_WAIT
  #SYSTEM_CURSOR_CROSSHAIR
  #SYSTEM_CURSOR_WAITARROW
  #SYSTEM_CURSOR_SIZENWSE
  #SYSTEM_CURSOR_SIZENESW
  #SYSTEM_CURSOR_SIZEWE
  #SYSTEM_CURSOR_SIZENS
  #SYSTEM_CURSOR_SIZEALL
  #SYSTEM_CURSOR_NO
  #SYSTEM_CURSOR_HAND
  #NUM_SYSTEM_CURSORS
EndEnumeration
CompilerIf VERSION_ATLEAST(2,0,4)
  Enumeration MouseWheelDirection
    #MOUSEWHEEL_NORMAL
    #MOUSEWHEEL_FLIPPED
  EndEnumeration
CompilerEndIf
#BUTTON_LEFT = 1
#BUTTON_MIDDLE = 2
#BUTTON_RIGHT = 3
#BUTTON_X1 = 4
#BUTTON_X2 = 5
#BUTTON_LMASK = BUTTON(#BUTTON_LEFT)
#BUTTON_MMASK = BUTTON(#BUTTON_MIDDLE)
#BUTTON_RMASK = BUTTON(#BUTTON_RIGHT)
#BUTTON_X1MASK = BUTTON(#BUTTON_X1)
#BUTTON_X2MASK = BUTTON(#BUTTON_X2)
Macro r_Cursor: i :EndMacro
Structure Cursor:EndStructure
ImportC #SDL2_lib
  GetMouseFocus.r_Window() As #FuncPrefix + "SDL_GetMouseFocus"
  GetMouseState.Uint32(*x.pint, *y.pint) As #FuncPrefix + "SDL_GetMouseState"
  CompilerIf VERSION_ATLEAST(2,0,4)
    GetGlobalMouseState.Uint32(*x.pint, *y.pint) As #FuncPrefix + "SDL_GetGlobalMouseState"
  CompilerEndIf
  GetRelativeMouseState.Uint32(*x.pint, *y.pint) As #FuncPrefix + "SDL_GetRelativeMouseState"
  WarpMouseInWindow.void(*window.Window, x.int, y.int) As #FuncPrefix + "SDL_WarpMouseInWindow"
  CompilerIf VERSION_ATLEAST(2,0,4)
    WarpMouseGlobal.int(x.int, y.int) As #FuncPrefix + "SDL_WarpMouseGlobal"
  CompilerEndIf
  SetRelativeMouseMode.int(enabled.t_bool) As #FuncPrefix + "SDL_SetRelativeMouseMode"
  CompilerIf VERSION_ATLEAST(2,0,4)
    CaptureMouse.int(enabled.t_bool) As #FuncPrefix + "SDL_CaptureMouse"
  CompilerEndIf
  GetRelativeMouseMode.t_bool() As #FuncPrefix + "SDL_GetRelativeMouseMode"
  CreateCursor.r_Cursor(*data.pUint8, *mask.pUint8, w.int, h.int, hot_x.int, hot_y.int) As #FuncPrefix + "SDL_CreateCursor"
  CreateColorCursor.r_Cursor(*surface.Surface, hot_x.int, hot_y.int) As #FuncPrefix + "SDL_CreateColorCursor"
  CreateSystemCursor.r_Cursor(id.enum) As #FuncPrefix + "SDL_CreateSystemCursor"
  SetCursor.void(*cursor.Cursor) As #FuncPrefix + "SDL_SetCursor"
  GetCursor.r_Cursor() As #FuncPrefix + "SDL_GetCursor"
  GetDefaultCursor.r_Cursor() As #FuncPrefix + "SDL_GetDefaultCursor"
  FreeCursor.void(*cursor.Cursor) As #FuncPrefix + "SDL_FreeCursor"
  ShowCursor.int(toggle.int) As #FuncPrefix + "SDL_ShowCursor"
EndImport
;}
;-----------------------
;- SDL_joystick.h.pbi
;{

CompilerIf VERSION_ATLEAST(2,0,6)
  Enumeration JoystickType
    #JOYSTICK_TYPE_UNKNOWN
    #JOYSTICK_TYPE_GAMECONTROLLER
    #JOYSTICK_TYPE_WHEEL
    #JOYSTICK_TYPE_ARCADE_STICK
    #JOYSTICK_TYPE_FLIGHT_STICK
    #JOYSTICK_TYPE_DANCE_PAD
    #JOYSTICK_TYPE_GUITAR
    #JOYSTICK_TYPE_DRUM_KIT
    #JOYSTICK_TYPE_ARCADE_PAD
    #JOYSTICK_TYPE_THROTTLE
  EndEnumeration
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  Enumeration JoystickPowerLevel
    #JOYSTICK_POWER_UNKNOWN = - 1
    #JOYSTICK_POWER_EMPTY
    #JOYSTICK_POWER_LOW
    #JOYSTICK_POWER_MEDIUM
    #JOYSTICK_POWER_FULL
    #JOYSTICK_POWER_WIRED
    #JOYSTICK_POWER_MAX
  EndEnumeration
CompilerEndIf
#JOYSTICK_AXIS_MAX = 32767
#JOYSTICK_AXIS_MIN = -32768
#HAT_CENTERED = $00
#HAT_UP = $01
#HAT_RIGHT = $02
#HAT_DOWN = $04
#HAT_LEFT = $08
#HAT_RIGHTUP    = (#HAT_RIGHT|#HAT_UP)
#HAT_RIGHTDOWN  = (#HAT_RIGHT|#HAT_DOWN)
#HAT_LEFTUP     = (#HAT_LEFT|#HAT_UP)
#HAT_LEFTDOWN   = (#HAT_LEFT|#HAT_DOWN)
Macro t_JoystickID: Sint32 :EndMacro
Macro r_Joystick: i :EndMacro
Structure Joystick:EndStructure
Structure JoystickGUID Align #SDLALIGN
  Data.Uint8 [ 16 ]
EndStructure
Macro r_JoystickGUID: i :EndMacro
ImportC #libSDL2_PB_HelperLib_a
  JoystickGetDeviceGUID.i(device_index.l) As #FuncPrefix + "_Helper_JoystickGetDeviceGUID"
  JoystickGetGUID.i(*joystick) As #FuncPrefix + "_Helper_JoystickGetGUID"
  JoystickGetGUIDFromString.i(*pchGUID.ascii) As #FuncPrefix + "_Helper_JoystickGetGUIDFromString"
  JoystickGetGUIDString.void(*guid.JoystickGUID, *pszGUID.ascii, cbGUID.int) As #FuncPrefix + "_Helper_JoystickGetGUIDString"
EndImport
ImportC #SDL2_lib
  CompilerIf VERSION_ATLEAST(2,0,7)
    LockJoysticks.void() As #FuncPrefix + "SDL_LockJoysticks"
    UnlockJoysticks.void() As #FuncPrefix + "SDL_UnlockJoysticks"
  CompilerEndIf
  NumJoysticks.int() As #FuncPrefix + "SDL_NumJoysticks"
  _JoystickNameForIndex.r_ascii(device_index.int) As #FuncPrefix + "SDL_JoystickNameForIndex"
  Macro JoystickNameForIndex(index): SDL::_GetAscii(SDL::_JoystickNameForIndex(index)) :EndMacro
  CompilerIf VERSION_ATLEAST(2,0,9)
    JoystickGetDevicePlayerIndex.int(device_index.int) As #FuncPrefix + "SDL_JoystickGetDevicePlayerIndex"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    JoystickGetDeviceVendor.Uint16(device_index.int) As #FuncPrefix + "SDL_JoystickGetDeviceVendor"
    JoystickGetDeviceProduct.Uint16(device_index.int) As #FuncPrefix + "SDL_JoystickGetDeviceProduct"
    JoystickGetDeviceProductVersion.Uint16(device_index.int) As #FuncPrefix + "SDL_JoystickGetDeviceProductVersion"
    JoystickGetDeviceType.enum(device_index.int) As #FuncPrefix + "SDL_JoystickGetDeviceType"
    JoystickGetDeviceInstanceID.t_JoystickID(device_index.int) As #FuncPrefix + "SDL_JoystickGetDeviceInstanceID"
  CompilerEndIf
  JoystickOpen.r_Joystick(device_index.int) As #FuncPrefix + "SDL_JoystickOpen"
  CompilerIf VERSION_ATLEAST(2,0,4)
    JoystickFromInstanceID.r_Joystick(instance_id.t_JoystickID) As #FuncPrefix + "SDL_JoystickFromInstanceID"
  CompilerEndIf
  JoystickFromPlayerIndex.r_Joystick(player_index.int) As #FuncPrefix + "SDL_JoystickFromPlayerIndex"
  _JoystickName.r_ascii(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickName"
  Macro JoystickName(joy): SDL::_GetAscii(SDL::_JoystickName(joy)) :EndMacro
  CompilerIf VERSION_ATLEAST(2,0,9)
    JoystickGetPlayerIndex.int(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickGetPlayerIndex"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,12)
    JoystickSetPlayerIndex.void(*joystick.Joystick, player_index.int) As #FuncPrefix + "SDL_JoystickSetPlayerIndex"  
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    JoystickGetVendor.Uint16(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickGetVendor"
    JoystickGetProduct.Uint16(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickGetProduct"
    JoystickGetProductVersion.Uint16(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickGetProductVersion"
    JoystickGetType.enum(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickGetType"
  CompilerEndIf
  JoystickGetAttached.t_bool(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickGetAttached"
  JoystickInstanceID.t_JoystickID(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickInstanceID"
  JoystickNumAxes.int(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickNumAxes"
  JoystickNumBalls.int(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickNumBalls"
  JoystickNumHats.int(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickNumHats"
  JoystickNumButtons.int(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickNumButtons"
  JoystickUpdate.void() As #FuncPrefix + "SDL_JoystickUpdate"
  JoystickEventState.int(state.int) As #FuncPrefix + "SDL_JoystickEventState"
  JoystickGetAxis.Sint16(*joystick.Joystick, axis.int) As #FuncPrefix + "SDL_JoystickGetAxis"
  CompilerIf VERSION_ATLEAST(2,0,6)
    JoystickGetAxisInitialState.t_bool(*joystick.Joystick, axis.int, *state.pSint16) As #FuncPrefix + "SDL_JoystickGetAxisInitialState"
  CompilerEndIf
  JoystickGetHat.Uint8(*joystick.Joystick, hat.int) As #FuncPrefix + "SDL_JoystickGetHat"
  JoystickGetBall.int(*joystick.Joystick, ball.int, *dx.pint, *dy.pint) As #FuncPrefix + "SDL_JoystickGetBall"
  JoystickGetButton.Uint8(*joystick.Joystick, button.int) As #FuncPrefix + "SDL_JoystickGetButton"
  CompilerIf VERSION_ATLEAST(2,0,9)
    JoystickRumble.int(*joystick.Joystick, low_frequency_rumble.Uint16, high_frequency_rumble.Uint16, duration_ms.Uint32) As #FuncPrefix + "SDL_JoystickRumble"
  CompilerEndIf
  JoystickClose.void(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickClose"
  CompilerIf VERSION_ATLEAST(2,0,4)
    JoystickCurrentPowerLevel.enum(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickCurrentPowerLevel"
  CompilerEndIf
EndImport
;}
;-----------------------
;- SDL_gamecontroller.h.pbi
;{

CompilerIf VERSION_ATLEAST(2,0,12)
  Enumeration GameControllerType
    #CONTROLLER_TYPE_UNKNOWN = 0
    #CONTROLLER_TYPE_XBOX360
    #CONTROLLER_TYPE_XBOXONE
    #CONTROLLER_TYPE_PS3
    #CONTROLLER_TYPE_PS4
    #CONTROLLER_TYPE_NINTENDO_SWITCH_PRO
  EndEnumeration
CompilerEndIf
Enumeration GameControllerBindType
  #CONTROLLER_BINDTYPE_NONE = 0
  #CONTROLLER_BINDTYPE_BUTTON
  #CONTROLLER_BINDTYPE_AXIS
  #CONTROLLER_BINDTYPE_HAT
EndEnumeration
Enumeration GameControllerAxis
  #CONTROLLER_AXIS_INVALID = - 1
  #CONTROLLER_AXIS_LEFTX
  #CONTROLLER_AXIS_LEFTY
  #CONTROLLER_AXIS_RIGHTX
  #CONTROLLER_AXIS_RIGHTY
  #CONTROLLER_AXIS_TRIGGERLEFT
  #CONTROLLER_AXIS_TRIGGERRIGHT
  #CONTROLLER_AXIS_MAX
EndEnumeration
Enumeration GameControllerButton
  #CONTROLLER_BUTTON_INVALID = - 1
  #CONTROLLER_BUTTON_A
  #CONTROLLER_BUTTON_B
  #CONTROLLER_BUTTON_X
  #CONTROLLER_BUTTON_Y
  #CONTROLLER_BUTTON_BACK
  #CONTROLLER_BUTTON_GUIDE
  #CONTROLLER_BUTTON_START
  #CONTROLLER_BUTTON_LEFTSTICK
  #CONTROLLER_BUTTON_RIGHTSTICK
  #CONTROLLER_BUTTON_LEFTSHOULDER
  #CONTROLLER_BUTTON_RIGHTSHOULDER
  #CONTROLLER_BUTTON_DPAD_UP
  #CONTROLLER_BUTTON_DPAD_DOWN
  #CONTROLLER_BUTTON_DPAD_LEFT
  #CONTROLLER_BUTTON_DPAD_RIGHT
  #CONTROLLER_BUTTON_MAX
EndEnumeration
Macro r_GameController: i :EndMacro
Structure GameController:EndStructure
Structure _GameControllerButtonBind_hat Align #SDLALIGN
  hat.int
  hat_mask.int    
EndStructure
Structure _GameControllerButtonBind_value Align #SDLALIGN
  StructureUnion
    button.int
    axis.int
    hat._GameControllerButtonBind_hat;
  EndStructureUnion
EndStructure
Structure GameControllerButtonBind Align #SDLALIGN
  bindType.enum
  value._GameControllerButtonBind_value
EndStructure
Macro r_GameControllerButtonBind: i :EndMacro
ImportC #libSDL2_PB_HelperLib_a
  _GameControllerMappingForGUID.r_ascii(*guid.JoystickGuid) As #FuncPrefix + "_Helper_GameControllerMappingForGUID"
  Macro GameControllerMappingForGUID(guid): SDL::_GetFreeAscii(SDL::_GameControllerMappingForGUID(guid)) :EndMacro  
  GameControllerGetBindForAxis.i(*gamecontroller.GameController, axis.enum) As #FuncPrefix + "_Helper_GameControllerGetBindForAxis"
  GameControllerGetBindForButton.i(*gamecontroller.GameController, button.enum) As #FuncPrefix + "_Helper_GameControllerGetBindForButton"
EndImport
ImportC #SDL2_lib
  CompilerIf VERSION_ATLEAST(2,0,2)
    GameControllerAddMappingsFromRW.int(*rw.RWops, freerw.int) As #FuncPrefix + "SDL_GameControllerAddMappingsFromRW"
  CompilerEndIf
  GameControllerAddMapping.int(mappingString.p-ascii) As #FuncPrefix + "SDL_GameControllerAddMapping"
  CompilerIf VERSION_ATLEAST(2,0,6)
    GameControllerNumMappings.int() As #FuncPrefix + "SDL_GameControllerNumMappings"
    _GameControllerMappingForIndex.r_ascii(mapping_index.int) As #FuncPrefix + "SDL_GameControllerMappingForIndex"
    Macro GameControllerMappingForIndex(index): SDL::_GetFreeAscii(SDL::_GameControllerMappingForIndex(index)) :EndMacro
  CompilerEndIf  
  _GameControllerMapping.r_ascii(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerMapping"
  Macro GameControllerMapping(gamec): SDL::_GetFreeAscii(SDL::_GameControllerMapping(gamec)) :EndMacro
  IsGameController.t_bool(joystick_index.int) As #FuncPrefix + "SDL_IsGameController"
  _GameControllerNameForIndex.r_ascii(joystick_index.int) As #FuncPrefix + "SDL_GameControllerNameForIndex"
  Macro GameControllerNameForIndex(index): SDL::_GetAscii(SDL::_GameControllerNameForIndex(index)) :EndMacro
  CompilerIf VERSION_ATLEAST(2,0,12)
    GameControllerTypeForIndex.enum(joystick_index.int) As #FuncPrefix + "SDL_GameControllerTypeForIndex"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,9)
    _GameControllerMappingForDeviceIndex.r_ascii(joystick_index.int) As #FuncPrefix + "SDL_GameControllerMappingForDeviceIndex"
    Macro GameControllerMappingForDeviceIndex(index): SDL::_GetFreeAscii(SDL::_GameControllerMappingForDeviceIndex(index)) :EndMacro
  CompilerEndIf
  GameControllerOpen.r_GameController(joystick_index.int) As #FuncPrefix + "SDL_GameControllerOpen"
  CompilerIf VERSION_ATLEAST(2,0,4)
    GameControllerFromInstanceID.r_GameController(joyid.t_JoystickID) As #FuncPrefix + "SDL_GameControllerFromInstanceID"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,12)
    GameControllerFromPlayerIndex.r_GameController(player_index.int) As #FuncPrefix + "SDL_GameControllerFromPlayerIndex"
  CompilerEndIf
  _GameControllerName.r_ascii(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerName"
  Macro GameControllerName(gamec): SDL::_GetAscii(SDL::_GameControllerName(gamec)) :EndMacro
  CompilerIf VERSION_ATLEAST(2,0,12)
    GameControllerGetType.enum(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerGetType"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,9)
    GameControllerGetPlayerIndex.int(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerGetPlayerIndex"
  CompilerEndIf  
  CompilerIf VERSION_ATLEAST(2,0,12)
    GameControllerSetPlayerIndex.void(*gamecontroller.GameController, player_index.int) As #FuncPrefix + "SDL_GameControllerSetPlayerIndex"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,6)
    GameControllerGetVendor.Uint16(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerGetVendor"
    GameControllerGetProduct.Uint16(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerGetProduct"
    GameControllerGetProductVersion.Uint16(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerGetProductVersion"
  CompilerEndIf
  GameControllerGetAttached.t_bool(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerGetAttached"
  GameControllerGetJoystick.r_Joystick(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerGetJoystick"
  GameControllerEventState.int(state.int) As #FuncPrefix + "SDL_GameControllerEventState"
  GameControllerUpdate.void() As #FuncPrefix + "SDL_GameControllerUpdate"
  GameControllerGetAxisFromString.enum(pchString.p-ascii) As #FuncPrefix + "SDL_GameControllerGetAxisFromString"
  _GameControllerGetStringForAxis.r_ascii(axis.enum) As #FuncPrefix + "SDL_GameControllerGetStringForAxis"
  Macro GameControllerGetStringForAxis(axis): SDL::_GetAscii(SDL::_GameControllerGetStringForAxis(axis)) :EndMacro
  GameControllerGetAxis.Sint16(*gamecontroller.GameController, axis.enum) As #FuncPrefix + "SDL_GameControllerGetAxis"
  GameControllerGetButtonFromString.enum(pchString.p-ascii) As #FuncPrefix + "SDL_GameControllerGetButtonFromString"
  _GameControllerGetStringForButton.r_ascii(button.enum) As #FuncPrefix + "SDL_GameControllerGetStringForButton"
  Macro GameControllerGetStringForButton(button): SDL::_GetAscii(SDL::_GameControllerGetStringForButton(button)) :EndMacro
  GameControllerGetButton.Uint8(*gamecontroller.GameController, button.enum) As #FuncPrefix + "SDL_GameControllerGetButton"
  CompilerIf VERSION_ATLEAST(2,0,9)
    GameControllerRumble.int(*gamecontroller.GameController, low_frequency_rumble.Uint16, high_frequency_rumble.Uint16, duration_ms.Uint32) As #FuncPrefix + "SDL_GameControllerRumble"
  CompilerEndIf
  GameControllerClose.void(*gamecontroller.GameController) As #FuncPrefix + "SDL_GameControllerClose"
  CompilerIf VERSION_ATLEAST(2,0,2)
    Macro GameControllerAddMappingsFromFile(file) :  SDL::GameControllerAddMappingsFromRW(SDL::RWFromFile(file, "rb"), 1) :EndMacro
  CompilerEndIf
EndImport
;}
;-----------------------
;- SDL_quit.h.pbi
;{

ImportC #SDL2_lib
  Macro QuitRequested(): sdl::_QuitRequested() :EndMacro
EndImport
;}
;-----------------------
;- SDL_touch.h.pbi
;{

Macro t_TouchID: Sint64 :EndMacro
Macro t_FingerID: Sint64 :EndMacro
Macro r_Finger: i :EndMacro
#TOUCH_MOUSEID = -1 & $ffffffff
CompilerIf VERSION_ATLEAST(2,0,10)
  #MOUSE_TOUCHID = -1 & $ffffffffffffffff
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,10)
  Enumeration TouchDeviceType
    #TOUCH_DEVICE_INVALID = - 1
    #TOUCH_DEVICE_DIRECT
    #TOUCH_DEVICE_INDIRECT_ABSOLUTE
    #TOUCH_DEVICE_INDIRECT_RELATIVE
  EndEnumeration
CompilerEndIf
Structure Finger Align #SDLALIGN
  id.t_FingerID
  x.f
  y.f
  pressure.f
EndStructure
ImportC #SDL2_lib
  GetNumTouchDevices.int() As #FuncPrefix + "SDL_GetNumTouchDevices"
  GetTouchDevice.t_TouchID(index.int) As #FuncPrefix + "SDL_GetTouchDevice"
  CompilerIf VERSION_ATLEAST(2,0,10)
    GetTouchDeviceType.enum(touchID.t_TouchID) As #FuncPrefix + "SDL_GetTouchDeviceType"
  CompilerEndIf
  GetNumTouchFingers.int(touchID.t_TouchID) As #FuncPrefix + "SDL_GetNumTouchFingers"
  GetTouchFinger.r_Finger(touchID.t_TouchID, index.int) As #FuncPrefix + "SDL_GetTouchFinger"
EndImport
;}
;-----------------------
;- SDL_gesture.h.pbi
;{

Macro t_GestureID: Sint64 :EndMacro
ImportC #SDL2_lib
  RecordGesture.int(touchId.t_TouchID) As #FuncPrefix + "SDL_RecordGesture"
  SaveAllDollarTemplates.int(*dst.RWops) As #FuncPrefix + "SDL_SaveAllDollarTemplates"
  SaveDollarTemplate.int(gestureId.t_GestureID, *dst.RWops) As #FuncPrefix + "SDL_SaveDollarTemplate"
  LoadDollarTemplates.int(touchId.t_TouchID, *src.RWops) As #FuncPrefix + "SDL_LoadDollarTemplates"
EndImport
;}
;-----------------------
;- SDL_events.h.pbi
;{

Macro r_SysWMmsg: i :EndMacro
Structure SysWMmsg: EndStructure
#RELEASED = 0
#PRESSED = 1
Enumeration EventType
  #FIRSTEVENT = 0
  #QUIT = $100
  #APP_TERMINATING
  #APP_LOWMEMORY
  #APP_WILLENTERBACKGROUND
  #APP_DIDENTERBACKGROUND
  #APP_WILLENTERFOREGROUND
  #APP_DIDENTERFOREGROUND
  CompilerIf VERSION_ATLEAST(2,0,9)
    #DISPLAYEVENT = $150
  CompilerEndIf
  #WINDOWEVENT = $200
  #SYSWMEVENT
  #KEYDOWN = $300
  #KEYUP
  #TEXTEDITING
  #TEXTINPUT
  CompilerIf VERSION_ATLEAST(2,0,4)
    #KEYMAPCHANGED
  CompilerEndIf
  #MOUSEMOTION = $400
  #MOUSEBUTTONDOWN
  #MOUSEBUTTONUP
  #MOUSEWHEEL
  #JOYAXISMOTION = $600
  #JOYBALLMOTION
  #JOYHATMOTION
  #JOYBUTTONDOWN
  #JOYBUTTONUP
  #JOYDEVICEADDED
  #JOYDEVICEREMOVED
  #CONTROLLERAXISMOTION = $650
  #CONTROLLERBUTTONDOWN
  #CONTROLLERBUTTONUP
  #CONTROLLERDEVICEADDED
  #CONTROLLERDEVICEREMOVED
  #CONTROLLERDEVICEREMAPPED
  #FINGERDOWN = $700
  #FINGERUP
  #FINGERMOTION
  #DOLLARGESTURE = $800
  #DOLLARRECORD
  #MULTIGESTURE
  #CLIPBOARDUPDATE = $900
  #DROPFILE = $1000
  CompilerIf VERSION_ATLEAST(2,0,5)
    #DROPTEXT
    #DROPBEGIN
    #DROPCOMPLETE
  CompilerEndIf
  #AUDIODEVICEADDED = $1100
  #AUDIODEVICEREMOVED
  CompilerIf VERSION_ATLEAST(2,0,9)
    #SENSORUPDATE = $1200
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,2)
    #RENDER_TARGETS_RESET = $2000
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,4)
    #RENDER_DEVICE_RESET
  CompilerEndIf
  #USEREVENT = $8000
  #LASTEVENT = $FFFF
EndEnumeration
Enumeration eventaction
  #ADDEVENT
  #PEEKEVENT
  #GETEVENT
EndEnumeration
#QUERY = -1
#IGNORE = 0
#DISABLE = 0
#ENABLE = 1
#TEXTEDITINGEVENT_TEXT_SIZE = (32)
#TEXTINPUTEVENT_TEXT_SIZE = (32)
Macro EventFilter: integer :EndMacro ;EventFilter.int (*userdata.pvoid, *event.event);
Structure CommonEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
EndStructure
Macro r_CommonEvent: i :EndMacro
CompilerIf VERSION_ATLEAST(2,0,9)
  Structure DisplayEvent Align #SDLALIGN
    type.Uint32
    timestamp.Uint32
    display.Uint32
    event.Uint8
    padding1.Uint8
    padding2.Uint8
    padding3.Uint8
    data1.Sint32
  EndStructure
  Macro r_DisplayEvent: i :EndMacro
CompilerEndIf
Structure WindowEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  event.Uint8
  padding1.Uint8
  padding2.Uint8
  padding3.Uint8
  data1.Sint32
  data2.Sint32
EndStructure
Macro r_WindowEvent: i :EndMacro
Structure KeyboardEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  state.Uint8
  Repeat.Uint8:CompilerIf #False:Until:CompilerEndIf
  padding2.Uint8
  padding3.Uint8
  keysym.Keysym
EndStructure
Macro r_KeyboardEvent: i :EndMacro
Structure TextEditingEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  text.char [ #TEXTEDITINGEVENT_TEXT_SIZE ]
  start.Sint32
  length.Sint32
EndStructure
Macro r_TextEditingEvent: i :EndMacro
Structure TextInputEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  text.char [ #TEXTINPUTEVENT_TEXT_SIZE ]
EndStructure
Macro r_TextInputEvent: i :EndMacro
Structure MouseMotionEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  which.Uint32
  state.Uint32
  x.Sint32
  y.Sint32
  xrel.Sint32
  yrel.Sint32
EndStructure
Macro r_MouseMotionEvent: i :EndMacro
Structure MouseButtonEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  which.Uint32
  button.Uint8
  state.Uint8
  clicks.Uint8
  padding1.Uint8
  x.Sint32
  y.Sint32
EndStructure
Macro r_MouseButtonEvent: i :EndMacro
Structure MouseWheelEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  which.Uint32
  x.Sint32
  y.Sint32
  CompilerIf VERSION_ATLEAST(2,0,4)
    direction.Uint32
  CompilerEndIf
EndStructure
Macro r_MouseWheelEvent: i :EndMacro
Structure JoyAxisEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.t_JoystickID
  axis.Uint8
  padding1.Uint8
  padding2.Uint8
  padding3.Uint8
  value.Sint16
  padding4.Uint16
EndStructure
Macro r_JoyAxisEvent: i :EndMacro
Structure JoyBallEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.t_JoystickID
  ball.Uint8
  padding1.Uint8
  padding2.Uint8
  padding3.Uint8
  xrel.Sint16
  yrel.Sint16
EndStructure
Macro r_JoyBallEvent: i :EndMacro
Structure JoyHatEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.t_JoystickID
  hat.Uint8
  value.Uint8
  padding1.Uint8
  padding2.Uint8
EndStructure
Macro r_JoyHatEvent: i :EndMacro
Structure JoyButtonEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.t_JoystickID
  button.Uint8
  state.Uint8
  padding1.Uint8
  padding2.Uint8
EndStructure
Macro r_JoyButtonEvent: i :EndMacro
Structure JoyDeviceEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.Sint32
EndStructure
Macro r_JoyDeviceEvent: i :EndMacro
Structure ControllerAxisEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.t_JoystickID
  axis.Uint8
  padding1.Uint8
  padding2.Uint8
  padding3.Uint8
  value.Sint16
  padding4.Uint16
EndStructure
Macro r_ControllerAxisEvent: i :EndMacro
Structure ControllerButtonEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.t_JoystickID
  button.Uint8
  state.Uint8
  padding1.Uint8
  padding2.Uint8
EndStructure
Macro r_ControllerButtonEvent: i :EndMacro
Structure ControllerDeviceEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  which.Sint32
EndStructure
Macro r_ControllerDeviceEvent: i :EndMacro
CompilerIf VERSION_ATLEAST(2,0,4)
  Structure AudioDeviceEvent Align #SDLALIGN
    type.Uint32
    timestamp.Uint32
    which.Uint32
    iscapture.Uint8
    padding1.Uint8
    padding2.Uint8
    padding3.Uint8
  EndStructure
  Macro r_AudioDeviceEvent: i :EndMacro
CompilerEndIf
Structure TouchFingerEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  touchId.t_TouchID
  fingerId.t_FingerID
  x.f
  y.f
  dx.f
  dy.f
  pressure.f
  CompilerIf VERSION_ATLEAST(2,0,12)
    windowID.Uint32
  CompilerEndIf
EndStructure
Macro r_TouchFingerEvent: i :EndMacro
Structure MultiGestureEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  touchId.t_TouchID
  dTheta.f
  dDist.f
  x.f
  y.f
  numFingers.Uint16
  padding.Uint16
EndStructure
Macro r_MultiGestureEvent: i :EndMacro
Structure DollarGestureEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  touchId.t_TouchID
  gestureId.t_GestureID
  numFingers.Uint32
  error.f
  x.f
  y.f
EndStructure
Macro r_DollarGestureEvent: i :EndMacro
Structure DropEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  *file.pchar
  CompilerIf VERSION_ATLEAST(2,0,5)
    windowID.Uint32
  CompilerEndIf
EndStructure
Macro r_DropEvent: i :EndMacro
CompilerIf VERSION_ATLEAST(2,0,9)
  Structure SensorEvent Align #SDLALIGN
    type.Uint32
    timestamp.Uint32
    which.Sint32
    Data.f [ 6 ]
  EndStructure
  Macro r_SensorEvent: i :EndMacro
CompilerEndIf
Structure QuitEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
EndStructure
Macro r_QuitEvent: i :EndMacro
Structure OSEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
EndStructure
Macro r_OSEvent: i :EndMacro
Structure UserEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  windowID.Uint32
  code.Sint32
  *data1.pvoid
  *data2.pvoid
EndStructure
Macro r_UserEvent: i :EndMacro
Structure SysWMEvent Align #SDLALIGN
  type.Uint32
  timestamp.Uint32
  *msg.pSysWMmsg
EndStructure
Macro r_SysWMEvent: i :EndMacro
Structure Event Align #SDLALIGN
  StructureUnion
    type.Uint32
    common.CommonEvent 
    CompilerIf VERSION_ATLEAST(2,0,9)
      display.DisplayEvent 
    CompilerEndIf
    window.WindowEvent   
    key.KeyboardEvent    
    edit.TextEditingEvent
    text.TextInputEvent  
    motion.MouseMotionEvent 
    button.MouseButtonEvent 
    wheel.MouseWheelEvent   
    jaxis.JoyAxisEvent      
    jball.JoyBallEvent      
    jhat.JoyHatEvent        
    jbutton.JoyButtonEvent  
    jdevice.JoyDeviceEvent  
    caxis.ControllerAxisEvent 
    cbutton.ControllerButtonEvent 
    cdevice.ControllerDeviceEvent 
    CompilerIf VERSION_ATLEAST(2,0,4)
      adevice.AudioDeviceEvent      
    CompilerEndIf
    CompilerIf VERSION_ATLEAST(2,0,9)
      sensor.SensorEvent            
    CompilerEndIf
    quit.QuitEvent                
    user.UserEvent                
    syswm.SysWMEvent              
    tfinger.TouchFingerEvent      
    mgesture.MultiGestureEvent    
    dgesture.DollarGestureEvent    
    drop.DropEvent                
    padding.Uint8[56]             
  EndStructureUnion
EndStructure
Macro r_Event: i :EndMacro
CompilerIf VERSION_ATLEAST(2,0,10)
  CompilerIf SizeOf(event) <> 56
    CompilerError("SDL_EVENTS - Structure wrong size!")
  CompilerEndIf
CompilerEndIf
ImportC #SDL2_lib
  PumpEvents.void() As #FuncPrefix + "SDL_PumpEvents"
  PeepEvents.int(*events.event, numevents.int, action.enum, minType.Uint32, maxType.Uint32) As #FuncPrefix + "SDL_PeepEvents"
  HasEvent.t_bool(type.Uint32) As #FuncPrefix + "SDL_HasEvent"
  HasEvents.t_bool(minType.Uint32, maxType.Uint32) As #FuncPrefix + "SDL_HasEvents"
  FlushEvent.void(type.Uint32) As #FuncPrefix + "SDL_FlushEvent"
  FlushEvents.void(minType.Uint32, maxType.Uint32) As #FuncPrefix + "SDL_FlushEvents"
  PollEvent.int(*event.event) As #FuncPrefix + "SDL_PollEvent"
  WaitEvent.int(*event.event) As #FuncPrefix + "SDL_WaitEvent"
  WaitEventTimeout.int(*event.event, timeout.int) As #FuncPrefix + "SDL_WaitEventTimeout"
  PushEvent.int(*event.event) As #FuncPrefix + "SDL_PushEvent"
  SetEventFilter.void(*filter.EventFilter, *userdata.pvoid) As #FuncPrefix + "SDL_SetEventFilter"
  GetEventFilter.t_bool(*pp_filter.EventFilter, *pp_userdata.pvoid) As #FuncPrefix + "SDL_GetEventFilter"
  AddEventWatch.void(*filter.EventFilter, *userdata.pvoid) As #FuncPrefix + "SDL_AddEventWatch"
  DelEventWatch.void(*filter.EventFilter, *userdata.pvoid) As #FuncPrefix + "SDL_DelEventWatch"
  FilterEvents.void(*filter.EventFilter, *userdata.pvoid) As #FuncPrefix + "SDL_FilterEvents"
  EventState.Uint8(type.Uint32, state.int) As #FuncPrefix + "SDL_EventState"
  RegisterEvents.Uint32(numevents.int) As #FuncPrefix + "SDL_RegisterEvents"
  Macro GetEventState(type): SDL::EventState(type, SDL::#QUERY) :EndMacro
EndImport
;}
;-----------------------
;- SDL_filesystem.h.pbi
;{

ImportC #SDL2_lib
  CompilerIf VERSION_ATLEAST(2,0,1)
    _GetBasePath.r_utf8() As #FuncPrefix + "SDL_GetBasePath"
    Macro GetBasePath(): SDL::_GetFreeUTF8(SDL::_GetBasePath()) :EndMacro
    _GetPrefPath.r_utf8(org.p-utf8, app.p-utf8) As #FuncPrefix + "SDL_GetPrefPath"
    Macro GetPrefPath(org,app): SDL::_GetFreeUTF8(SDL::_GetPrefPath(org,app)) :EndMacro
  CompilerEndIf
EndImport
;}
;-----------------------
;- SDL_haptic.h.pbi
;{

#HAPTIC_CONSTANT   =(1<<0)
#HAPTIC_SINE       =(1<<1)
#HAPTIC_LEFTRIGHT  =   (1<<2)
#HAPTIC_TRIANGLE   =(1<<3)
#HAPTIC_SAWTOOTHUP =(1<<4)
#HAPTIC_SAWTOOTHDOWN= (1<<5)
#HAPTIC_RAMP       =(1<<6)
#HAPTIC_SPRING     =(1<<7)
#HAPTIC_DAMPER     =(1<<8)
#HAPTIC_INERTIA    =(1<<9)
#HAPTIC_FRICTION   =(1<<10)
#HAPTIC_CUSTOM     =(1<<11)
#HAPTIC_GAIN       =(1<<12)
#HAPTIC_AUTOCENTER =(1<<13)
#HAPTIC_STATUS     =(1<<14)
#HAPTIC_PAUSE      =(1<<15)
#HAPTIC_POLAR = 0
#HAPTIC_CARTESIAN = 1
#HAPTIC_SPHERICAL = 2
#HAPTIC_INFINITY = 4294967295
Macro r_Haptic: i :EndMacro
Structure Haptic: EndStructure
Structure HapticDirection Align #SDLALIGN
  type.Uint8
  dir.Sint32 [ 3 ]
EndStructure
Macro r_HapticDirection: i :EndMacro
Structure HapticConstant Align #SDLALIGN
  type.Uint16
  direction.HapticDirection
  length.Uint32
  delay.Uint16
  button.Uint16
  interval.Uint16
  level.Sint16
  attack_length.Uint16
  attack_level.Uint16
  fade_length.Uint16
  fade_level.Uint16
EndStructure
Macro r_HapticConstant: i :EndMacro
Structure HapticPeriodic Align #SDLALIGN
  type.Uint16
  direction.HapticDirection
  length.Uint32
  delay.Uint16
  button.Uint16
  interval.Uint16
  period.Uint16
  magnitude.Sint16
  offset.Sint16
  phase.Uint16
  attack_length.Uint16
  attack_level.Uint16
  fade_length.Uint16
  fade_level.Uint16
EndStructure
Macro r_HapticPeriodic: i :EndMacro
Structure HapticCondition Align #SDLALIGN
  type.Uint16
  direction.HapticDirection
  length.Uint32
  delay.Uint16
  button.Uint16
  interval.Uint16
  right_sat.Uint16 [ 3 ]
  left_sat.Uint16 [ 3 ]
  right_coeff.Sint16 [ 3 ]
  left_coeff.Sint16 [ 3 ]
  deadband.Uint16 [ 3 ]
  center.Sint16 [ 3 ]
EndStructure
Macro r_HapticCondition: i :EndMacro
Structure HapticRamp Align #SDLALIGN
  type.Uint16
  direction.HapticDirection
  length.Uint32
  delay.Uint16
  button.Uint16
  interval.Uint16
  start.Sint16
  End.Sint16
  attack_length.Uint16
  attack_level.Uint16
  fade_length.Uint16
  fade_level.Uint16
EndStructure
Macro r_HapticRamp: i :EndMacro
Structure HapticLeftRight Align #SDLALIGN
  type.Uint16
  length.Uint32
  large_magnitude.Uint16
  small_magnitude.Uint16
EndStructure
Macro r_HapticLeftRight: i :EndMacro
Structure HapticCustom Align #SDLALIGN
  type.Uint16
  direction.HapticDirection
  length.Uint32
  delay.Uint16
  button.Uint16
  interval.Uint16
  channels.Uint8
  period.Uint16
  samples.Uint16
  *data.pUint16
  attack_length.Uint16
  attack_level.Uint16
  fade_length.Uint16
  fade_level.Uint16
EndStructure
Macro r_HapticCustom: i :EndMacro
Structure HapticEffect Align #SDLALIGN
  StructureUnion
    type.Uint16
    constant.HapticConstant;
    periodic.HapticPeriodic 
    condition.HapticCondition
    ramp.HapticRamp
    leftright.HapticLeftRight
    custom.HapticCustom
  EndStructureUnion
EndStructure
Macro r_HapticEffect: i :EndMacro
ImportC #SDL2_lib
  NumHaptics.int() As #FuncPrefix + "SDL_NumHaptics"
  _HapticName.r_ascii(device_index.int) As #FuncPrefix + "SDL_HapticName"
  Macro HapticName(index): SDL::_GetAscii(SDL::_HapticName(index)) :EndMacro
  HapticOpen.r_Haptic(device_index.int) As #FuncPrefix + "SDL_HapticOpen"
  HapticOpened.int(device_index.int) As #FuncPrefix + "SDL_HapticOpened"
  HapticIndex.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticIndex"
  MouseIsHaptic.int() As #FuncPrefix + "SDL_MouseIsHaptic"
  HapticOpenFromMouse.r_Haptic() As #FuncPrefix + "SDL_HapticOpenFromMouse"
  JoystickIsHaptic.int(*joystick.Joystick) As #FuncPrefix + "SDL_JoystickIsHaptic"
  HapticOpenFromJoystick.r_Haptic(*joystick.Joystick) As #FuncPrefix + "SDL_HapticOpenFromJoystick"
  HapticClose.void(*haptic.Haptic) As #FuncPrefix + "SDL_HapticClose"
  HapticNumEffects.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticNumEffects"
  HapticNumEffectsPlaying.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticNumEffectsPlaying"
  HapticQuery.unsignedint(*haptic.Haptic) As #FuncPrefix + "SDL_HapticQuery"
  HapticNumAxes.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticNumAxes"
  HapticEffectSupported.int(*haptic.Haptic, *effect.HapticEffect) As #FuncPrefix + "SDL_HapticEffectSupported"
  HapticNewEffect.int(*haptic.Haptic, *effect.HapticEffect) As #FuncPrefix + "SDL_HapticNewEffect"
  HapticUpdateEffect.int(*haptic.Haptic, effect.int, *data.HapticEffect) As #FuncPrefix + "SDL_HapticUpdateEffect"
  HapticRunEffect.int(*haptic.Haptic, effect.int, iterations.Uint32) As #FuncPrefix + "SDL_HapticRunEffect"
  HapticStopEffect.int(*haptic.Haptic, effect.int) As #FuncPrefix + "SDL_HapticStopEffect"
  HapticDestroyEffect.void(*haptic.Haptic, effect.int) As #FuncPrefix + "SDL_HapticDestroyEffect"
  HapticGetEffectStatus.int(*haptic.Haptic, effect.int) As #FuncPrefix + "SDL_HapticGetEffectStatus"
  HapticSetGain.int(*haptic.Haptic, gain.int) As #FuncPrefix + "SDL_HapticSetGain"
  HapticSetAutocenter.int(*haptic.Haptic, autocenter.int) As #FuncPrefix + "SDL_HapticSetAutocenter"
  HapticPause.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticPause"
  HapticUnpause.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticUnpause"
  HapticStopAll.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticStopAll"
  HapticRumbleSupported.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticRumbleSupported"
  HapticRumbleInit.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticRumbleInit"
  HapticRumblePlay.int(*haptic.Haptic, strength.f, length.Uint32) As #FuncPrefix + "SDL_HapticRumblePlay"
  HapticRumbleStop.int(*haptic.Haptic) As #FuncPrefix + "SDL_HapticRumbleStop"
EndImport
;}
;-----------------------
;- SDL_hints.h.pbi
;{

#HINT_FRAMEBUFFER_ACCELERATION = "SDL_FRAMEBUFFER_ACCELERATION"
#HINT_RENDER_DRIVER = "SDL_RENDER_DRIVER"
#HINT_RENDER_OPENGL_SHADERS = "SDL_RENDER_OPENGL_SHADERS"
CompilerIf VERSION_ATLEAST(2,0,1)
  #HINT_RENDER_DIRECT3D_THREADSAFE = "SDL_RENDER_DIRECT3D_THREADSAFE"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,3)
  CompilerIf VERSION_ATLEAST(2,0,4)  
    #HINT_RENDER_DIRECT3D11_DEBUG = "SDL_RENDER_DIRECT3D11_DEBUG"
  CompilerElse
    #HINT_RENDER_DIRECT3D11_DEBUG = "SDL_HINT_RENDER_DIRECT3D11_DEBUG"
  CompilerEndIf  
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,6)
  #HINT_RENDER_LOGICAL_SIZE_MODE = "SDL_RENDER_LOGICAL_SIZE_MODE"
CompilerEndIf
#HINT_RENDER_SCALE_QUALITY = "SDL_RENDER_SCALE_QUALITY"
#HINT_RENDER_VSYNC = "SDL_RENDER_VSYNC"
CompilerIf VERSION_ATLEAST(2,0,2)
  #HINT_VIDEO_ALLOW_SCREENSAVER = "SDL_VIDEO_ALLOW_SCREENSAVER"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,12)
  #HINT_VIDEO_EXTERNAL_CONTEXT = "SDL_VIDEO_EXTERNAL_CONTEXT"
CompilerEndIf
#HINT_VIDEO_X11_XVIDMODE = "SDL_VIDEO_X11_XVIDMODE"
#HINT_VIDEO_X11_XINERAMA = "SDL_VIDEO_X11_XINERAMA"
#HINT_VIDEO_X11_XRANDR = "SDL_VIDEO_X11_XRANDR"
CompilerIf VERSION_ATLEAST(2,0,12)
  #HINT_VIDEO_X11_WINDOW_VISUALID = "SDL_VIDEO_X11_WINDOW_VISUALID"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  #HINT_VIDEO_X11_NET_WM_PING = "SDL_VIDEO_X11_NET_WM_PING"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,8)
  #HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR = "SDL_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,12)
  #HINT_VIDEO_X11_FORCE_EGL = "SDL_VIDEO_X11_FORCE_EGL"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  #HINT_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN = "SDL_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,6)
  #HINT_WINDOWS_INTRESOURCE_ICON = "SDL_WINDOWS_INTRESOURCE_ICON"
  #HINT_WINDOWS_INTRESOURCE_ICON_SMALL = "SDL_WINDOWS_INTRESOURCE_ICON_SMALL"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  #HINT_WINDOWS_ENABLE_MESSAGELOOP = "SDL_WINDOWS_ENABLE_MESSAGELOOP"
CompilerEndIf
#HINT_GRAB_KEYBOARD = "SDL_GRAB_KEYBOARD"
CompilerIf VERSION_ATLEAST(2,0,9)
  #HINT_MOUSE_DOUBLE_CLICK_TIME = "SDL_MOUSE_DOUBLE_CLICK_TIME"
  #HINT_MOUSE_DOUBLE_CLICK_RADIUS = "SDL_MOUSE_DOUBLE_CLICK_RADIUS"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,6)
  #HINT_MOUSE_NORMAL_SPEED_SCALE = "SDL_MOUSE_NORMAL_SPEED_SCALE"
  #HINT_MOUSE_RELATIVE_SPEED_SCALE = "SDL_MOUSE_RELATIVE_SPEED_SCALE"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,2)
  #HINT_MOUSE_RELATIVE_MODE_WARP = "SDL_MOUSE_RELATIVE_MODE_WARP"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,5)
  #HINT_MOUSE_FOCUS_CLICKTHROUGH = "SDL_MOUSE_FOCUS_CLICKTHROUGH"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,6)
  #HINT_TOUCH_MOUSE_EVENTS = "SDL_TOUCH_MOUSE_EVENTS"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,10)
  #HINT_MOUSE_TOUCH_EVENTS = "SDL_MOUSE_TOUCH_EVENTS"
CompilerEndIf
#HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS"
#HINT_IDLE_TIMER_DISABLED = "SDL_IOS_IDLE_TIMER_DISABLED"
#HINT_ORIENTATIONS = "SDL_IOS_ORIENTATIONS"
CompilerIf VERSION_ATLEAST(2,0,5)
  #HINT_APPLE_TV_CONTROLLER_UI_EVENTS = "SDL_APPLE_TV_CONTROLLER_UI_EVENTS"
  #HINT_APPLE_TV_REMOTE_ALLOW_ROTATION = "SDL_APPLE_TV_REMOTE_ALLOW_ROTATION"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,8)
  #HINT_IOS_HIDE_HOME_INDICATOR = "SDL_IOS_HIDE_HOME_INDICATOR"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,2)
  #HINT_ACCELEROMETER_AS_JOYSTICK = "SDL_ACCELEROMETER_AS_JOYSTICK"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,8)
  #HINT_TV_REMOTE_AS_JOYSTICK = "SDL_TV_REMOTE_AS_JOYSTICK"
CompilerEndIf
#HINT_XINPUT_ENABLED = "SDL_XINPUT_ENABLED"
CompilerIf VERSION_ATLEAST(2,0,4)
  #HINT_XINPUT_USE_OLD_JOYSTICK_MAPPING = "SDL_XINPUT_USE_OLD_JOYSTICK_MAPPING"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,12)
  #HINT_GAMECONTROLLERTYPE = "SDL_GAMECONTROLLERTYPE"
CompilerEndIf
#HINT_GAMECONTROLLERCONFIG = "SDL_GAMECONTROLLERCONFIG"
CompilerIf VERSION_ATLEAST(2,0,10)
  #HINT_GAMECONTROLLERCONFIG_FILE = "SDL_GAMECONTROLLERCONFIG_FILE"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,6)
  #HINT_GAMECONTROLLER_IGNORE_DEVICES = "SDL_GAMECONTROLLER_IGNORE_DEVICES"
  #HINT_GAMECONTROLLER_IGNORE_DEVICES_EXCEPT = "SDL_GAMECONTROLLER_IGNORE_DEVICES_EXCEPT"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,12)
  #HINT_GAMECONTROLLER_USE_BUTTON_LABELS = "SDL_GAMECONTROLLER_USE_BUTTON_LABELS"
CompilerEndIf
#HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS = "SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS"
CompilerIf VERSION_ATLEAST(2,0,9)
  #HINT_JOYSTICK_HIDAPI = "SDL_JOYSTICK_HIDAPI"
  #HINT_JOYSTICK_HIDAPI_PS4 = "SDL_JOYSTICK_HIDAPI_PS4"
  #HINT_JOYSTICK_HIDAPI_PS4_RUMBLE = "SDL_JOYSTICK_HIDAPI_PS4_RUMBLE"
  #HINT_JOYSTICK_HIDAPI_STEAM = "SDL_JOYSTICK_HIDAPI_STEAM"
  #HINT_JOYSTICK_HIDAPI_SWITCH = "SDL_JOYSTICK_HIDAPI_SWITCH"
  #HINT_JOYSTICK_HIDAPI_XBOX = "SDL_JOYSTICK_HIDAPI_XBOX"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,12)
  #HINT_JOYSTICK_HIDAPI_GAMECUBE = "SDL_JOYSTICK_HIDAPI_GAMECUBE"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,9)
  #HINT_ENABLE_STEAM_CONTROLLERS = "SDL_ENABLE_STEAM_CONTROLLERS"
CompilerEndIf
#HINT_ALLOW_TOPMOST = "SDL_ALLOW_TOPMOST"
#HINT_TIMER_RESOLUTION = "SDL_TIMER_RESOLUTION"
CompilerIf VERSION_ATLEAST(2,0,6)
  #HINT_QTWAYLAND_CONTENT_ORIENTATION = "SDL_QTWAYLAND_CONTENT_ORIENTATION"
  #HINT_QTWAYLAND_WINDOW_FLAGS = "SDL_QTWAYLAND_WINDOW_FLAGS"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  #HINT_THREAD_STACK_SIZE = "SDL_THREAD_STACK_SIZE"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,1)
  #HINT_VIDEO_HIGHDPI_DISABLED = "SDL_VIDEO_HIGHDPI_DISABLED"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,2)
  #HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK = "SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK"
  #HINT_VIDEO_WIN_D3DCOMPILER = "SDL_VIDEO_WIN_D3DCOMPILER"
  #HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT = "SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,3)
  CompilerIf VERSION_ATLEAST(2,0,4)
    #HINT_WINRT_PRIVACY_POLICY_URL = "SDL_WINRT_PRIVACY_POLICY_URL"
    #HINT_WINRT_PRIVACY_POLICY_LABEL = "SDL_WINRT_PRIVACY_POLICY_LABEL"
    #HINT_WINRT_HANDLE_BACK_BUTTON = "SDL_WINRT_HANDLE_BACK_BUTTON"
  CompilerElse
    #HINT_WINRT_PRIVACY_POLICY_URL = "SDL_HINT_WINRT_PRIVACY_POLICY_URL"
    #HINT_WINRT_PRIVACY_POLICY_LABEL = "SDL_HINT_WINRT_PRIVACY_POLICY_LABEL"
    #HINT_WINRT_HANDLE_BACK_BUTTON = "SDL_HINT_WINRT_HANDLE_BACK_BUTTON"
  CompilerEndIf  
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,2)
  #HINT_VIDEO_MAC_FULLSCREEN_SPACES = "SDL_VIDEO_MAC_FULLSCREEN_SPACES"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  #HINT_MAC_BACKGROUND_APP = "SDL_MAC_BACKGROUND_APP"
  #HINT_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION = "SDL_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION"
  #HINT_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION = "SDL_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION"
  #HINT_IME_INTERNAL_EDITING = "SDL_IME_INTERNAL_EDITING"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,9)
  #HINT_ANDROID_TRAP_BACK_BUTTON = "SDL_ANDROID_TRAP_BACK_BUTTON"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,10)
  #HINT_ANDROID_BLOCK_ON_PAUSE = "SDL_ANDROID_BLOCK_ON_PAUSE"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,8)
  #HINT_RETURN_KEY_HIDES_IME = "SDL_RETURN_KEY_HIDES_IME"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,4)
  #HINT_EMSCRIPTEN_KEYBOARD_ELEMENT = "SDL_EMSCRIPTEN_KEYBOARD_ELEMENT"
  #HINT_NO_SIGNAL_HANDLERS = "SDL_NO_SIGNAL_HANDLERS"
  #HINT_WINDOWS_NO_CLOSE_ON_ALT_F4 = "SDL_WINDOWS_NO_CLOSE_ON_ALT_F4"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,5)
  #HINT_BMP_SAVE_LEGACY_FORMAT = "SDL_BMP_SAVE_LEGACY_FORMAT"
  #HINT_WINDOWS_DISABLE_THREAD_NAMING = "SDL_WINDOWS_DISABLE_THREAD_NAMING"
  #HINT_RPI_VIDEO_LAYER = "SDL_RPI_VIDEO_LAYER"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,8)
  #HINT_VIDEO_DOUBLE_BUFFER = "SDL_VIDEO_DOUBLE_BUFFER"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,6)
  #HINT_OPENGL_ES_DRIVER = "SDL_OPENGL_ES_DRIVER"
  #HINT_AUDIO_RESAMPLING_MODE = "SDL_AUDIO_RESAMPLING_MODE"
  #HINT_AUDIO_CATEGORY = "SDL_AUDIO_CATEGORY"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,10)
  #HINT_RENDER_BATCHING = "SDL_RENDER_BATCHING"
  #HINT_EVENT_LOGGING = "SDL_EVENT_LOGGING"
  #HINT_WAVE_RIFF_CHUNK_SIZE = "SDL_WAVE_RIFF_CHUNK_SIZE"
  #HINT_WAVE_TRUNCATION = "SDL_WAVE_TRUNCATION"
  #HINT_WAVE_FACT_CHUNK = "SDL_WAVE_FACT_CHUNK"
CompilerEndIf
CompilerIf VERSION_ATLEAST(2,0,12)
  #HINT_DISPLAY_USABLE_BOUNDS = "SDL_DISPLAY_USABLE_BOUNDS"
CompilerEndIf
Enumeration HintPriority
  #HINT_DEFAULT
  #HINT_NORMAL
  #HINT_OVERRIDE
EndEnumeration
Macro HintCallback: integer :EndMacro ;HintCallback.void (*userdata.pvoid, *name.ascii, *oldvalue.ascii, *newvalue.aascii)
ImportC #SDL2_lib
  SetHintWithPriority.t_bool(name.p-ascii, value.p-ascii, priority.enum) As #FuncPrefix + "SDL_SetHintWithPriority"
  SetHint.t_bool(name.p-ascii, value.p-ascii) As #FuncPrefix + "SDL_SetHint"
  _GetHint.r_ascii(name.p-ascii) As #FuncPrefix + "SDL_GetHint"
  Macro GetHint(name): SDL::_GetAscii(SDL::_GetHint(name)) : EndMacro
  CompilerIf VERSION_ATLEAST(2,0,5)
    GetHintBoolean.t_bool(name.p-ascii, default_value.t_bool) As #FuncPrefix + "SDL_GetHintBoolean"
  CompilerEndIf
  AddHintCallback.void(name.p-ascii, *callback.HintCallback, *userdata.pvoid) As #FuncPrefix + "SDL_AddHintCallback"
  DelHintCallback.void(name.p-ascii, *callback.HintCallback, *userdata.pvoid) As #FuncPrefix + "SDL_DelHintCallback"
  ClearHints.void() As #FuncPrefix + "SDL_ClearHints"
EndImport
;}
;-----------------------
;- SDL_loadso.h.pbi
;{

ImportC #SDL2_lib
  LoadObject.r_void(sofile.p-utf8) As #FuncPrefix + "SDL_LoadObject"
  LoadFunction.r_void(*handle.pvoid, name.p-ascii) As #FuncPrefix + "SDL_LoadFunction"
  UnloadObject.void(*handle.pvoid) As #FuncPrefix + "SDL_UnloadObject"
EndImport
;}
;-----------------------
;- SDL_log.h.pbi
;{

#MAX_LOG_MESSAGE = 4096
Enumeration LogCategory
  #LOG_CATEGORY_APPLICATION
  #LOG_CATEGORY_ERROR
  #LOG_CATEGORY_ASSERT
  #LOG_CATEGORY_SYSTEM
  #LOG_CATEGORY_AUDIO
  #LOG_CATEGORY_VIDEO
  #LOG_CATEGORY_RENDER
  #LOG_CATEGORY_INPUT
  #LOG_CATEGORY_TEST
  #LOG_CATEGORY_RESERVED1
  #LOG_CATEGORY_RESERVED2
  #LOG_CATEGORY_RESERVED3
  #LOG_CATEGORY_RESERVED4
  #LOG_CATEGORY_RESERVED5
  #LOG_CATEGORY_RESERVED6
  #LOG_CATEGORY_RESERVED7
  #LOG_CATEGORY_RESERVED8
  #LOG_CATEGORY_RESERVED9
  #LOG_CATEGORY_RESERVED10
  #LOG_CATEGORY_CUSTOM
EndEnumeration
Enumeration LogPriority
  #LOG_PRIORITY_VERBOSE = 1
  #LOG_PRIORITY_DEBUG
  #LOG_PRIORITY_INFO
  #LOG_PRIORITY_WARN
  #LOG_PRIORITY_ERROR
  #LOG_PRIORITY_CRITICAL
  #NUM_LOG_PRIORITIES
EndEnumeration
Macro LogOutputFunction: integer :EndMacro ;LogOutputFunction.void (*userdata.pvoid,category.int, priority.enum, *msg.ascii)
ImportC #libSDL2_PB_HelperLib_a
  _Log.void(fmt.p-utf8) As #FuncPrefix + "_Helper_Log"
  Macro Log(fmt): SDL::_Log(fmt): EndMacro
  LogVerbose.void(category.int, fmt.p-utf8) As #FuncPrefix + "_Helper_LogVerbose"
  LogDebug.void(category.int, fmt.p-utf8) As #FuncPrefix + "_Helper_LogDebug"
  LogInfo.void(category.int, fmt.p-utf8) As #FuncPrefix + "_Helper_LogInfo"
  LogWarn.void(category.int, fmt.p-utf8) As #FuncPrefix + "_Helper_LogWarn"
  LogError.void(category.int, fmt.p-utf8) As #FuncPrefix + "_Helper_LogError"
  LogCritical.void(category.int, fmt.p-utf8) As #FuncPrefix + "_Helper_LogCritical"
  LogMessage.void(cat.int,prio.enum,fmt.p-utf8) As #FuncPrefix + "_Helper_LogMessage"
EndImport
ImportC #SDL2_lib
  LogSetAllPriority.void(priority.enum) As #FuncPrefix + "SDL_LogSetAllPriority"
  LogSetPriority.void(category.int, priority.enum) As #FuncPrefix + "SDL_LogSetPriority"
  LogGetPriority.enum(category.int) As #FuncPrefix + "SDL_LogGetPriority"
  LogResetPriorities.void() As #FuncPrefix + "SDL_LogResetPriorities"
  ;LogMessageV.void(category.int, priority.enum, *fmt.pchar, ap.va_list) AS #FuncPrefix + "SDL_LogMessageV"
  LogGetOutputFunction.void(*pp_callback.LogOutputFunction, *pp_userdata.pvoid) As #FuncPrefix + "SDL_LogGetOutputFunction"
  LogSetOutputFunction.void(*callback.LogOutputFunction, *userdata.pvoid) As #FuncPrefix + "SDL_LogSetOutputFunction"
EndImport
;}
;-----------------------
;- SDL_messagebox.h.pbi
;{

Enumeration MessageBoxFlags
  #MESSAGEBOX_ERROR = $00000010
  #MESSAGEBOX_WARNING = $00000020
  #MESSAGEBOX_INFORMATION = $00000040
  CompilerIf VERSION_ATLEAST(2,0,12)
    #MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = $00000080
    #MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = $00000100
  CompilerEndIf
EndEnumeration
Enumeration MessageBoxButtonFlags
  #MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = $00000001
  #MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = $00000002
EndEnumeration
Enumeration MessageBoxColorType
  #MESSAGEBOX_COLOR_BACKGROUND
  #MESSAGEBOX_COLOR_TEXT
  #MESSAGEBOX_COLOR_BUTTON_BORDER
  #MESSAGEBOX_COLOR_BUTTON_BACKGROUND
  #MESSAGEBOX_COLOR_BUTTON_SELECTED
  #MESSAGEBOX_COLOR_MAX
EndEnumeration
Structure MessageBoxButtonData Align #SDLALIGN
  flags.Uint32
  buttonid.int
  *text.pchar
EndStructure
Macro r_MessageBoxButtonData: i :EndMacro
Structure MessageBoxColor Align #SDLALIGN
  r.Uint8
  g.Uint8
  b.Uint8
EndStructure
Macro r_MessageBoxColor: i :EndMacro
Structure MessageBoxColorScheme Align #SDLALIGN
  colors.MessageBoxColor [ #MESSAGEBOX_COLOR_MAX ]
EndStructure
Macro r_MessageBoxColorScheme: i :EndMacro
Structure MessageBoxData Align #SDLALIGN
  flags.Uint32
  *window.pWindow
  *title.pchar
  *message.pchar
  numbuttons.int
  *buttons.MessageBoxButtonData
  *colorScheme.MessageBoxColorScheme
EndStructure
Macro r_MessageBoxData: i :EndMacro
ImportC #SDL2_lib
  ShowMessageBox.int(*messageboxdata.MessageBoxData, *buttonid.pint) As #FuncPrefix + "SDL_ShowMessageBox"
  ShowSimpleMessageBox.int(flags.Uint32, title.p-utf8, message.p-utf8, *window.Window) As #FuncPrefix + "SDL_ShowSimpleMessageBox"
EndImport
;}
;-----------------------
;- SDL_metal.h.pbi
;{

CompilerIf VERSION_ATLEAST(2,0,12)
  Macro t_MetalView: pvoid :EndMacro
  Macro r_MetalView: i :EndMacro
  ImportC #SDL2_lib
    Metal_CreateView.r_MetalView(*window.Window) As #FuncPrefix + "SDL_Metal_CreateView"
    Metal_DestroyView.void(*view.t_MetalView) As #FuncPrefix + "SDL_Metal_DestroyView"
  EndImport
CompilerEndIf
;}
;-----------------------
;- SDL_power.h.pbi
;{

Enumeration PowerState
  #POWERSTATE_UNKNOWN
  #POWERSTATE_ON_BATTERY
  #POWERSTATE_NO_BATTERY
  #POWERSTATE_CHARGING
  #POWERSTATE_CHARGED
EndEnumeration
ImportC #SDL2_lib
  GetPowerInfo.enum(*secs.pint, *pct.pint) As #FuncPrefix + "SDL_GetPowerInfo"
EndImport
;}
;-----------------------
;- SDL_render.h.pbi
;{

Enumeration RendererFlags
  #RENDERER_SOFTWARE = $00000001
  #RENDERER_ACCELERATED = $00000002
  #RENDERER_PRESENTVSYNC = $00000004
  #RENDERER_TARGETTEXTURE = $00000008
EndEnumeration
CompilerIf VERSION_ATLEAST(2,0,12)
  Enumeration ScaleMode
    #ScaleModeNearest
    #ScaleModeLinear
    #ScaleModeBest
  EndEnumeration
CompilerEndIf
Enumeration TextureAccess
  #TEXTUREACCESS_STATIC
  #TEXTUREACCESS_STREAMING
  #TEXTUREACCESS_TARGET
EndEnumeration
Enumeration TextureModulate
  #TEXTUREMODULATE_NONE = $00000000
  #TEXTUREMODULATE_COLOR = $00000001
  #TEXTUREMODULATE_ALPHA = $00000002
EndEnumeration
Enumeration RendererFlip
  #FLIP_NONE = $00000000
  #FLIP_HORIZONTAL = $00000001
  #FLIP_VERTICAL = $00000002
EndEnumeration
Macro r_Renderer: i :EndMacro
Macro r_Texture: i :EndMacro
Structure Renderer: EndStructure
Structure Texture:EndStructure
Structure RendererInfo Align #SDLALIGN
  *name.pchar
  flags.Uint32
  num_texture_formats.Uint32
  texture_formats.Uint32 [ 16 ]
  max_texture_width.int
  max_texture_height.int
EndStructure
Macro r_RendererInfo: i :EndMacro
ImportC #SDL2_lib
  GetNumRenderDrivers.int() As #FuncPrefix + "SDL_GetNumRenderDrivers"
  GetRenderDriverInfo.int(index.int, *info.RendererInfo) As #FuncPrefix + "SDL_GetRenderDriverInfo"
  CreateWindowAndRenderer.int(width.int, height.int, window_flags.Uint32, *pp_window.Window, *pp_renderer.Renderer) As #FuncPrefix + "SDL_CreateWindowAndRenderer"
  CreateRenderer.r_Renderer(*window.Window, index.int, flags.Uint32) As #FuncPrefix + "SDL_CreateRenderer"
  CreateSoftwareRenderer.r_Renderer(*surface.Surface) As #FuncPrefix + "SDL_CreateSoftwareRenderer"
  GetRenderer.r_Renderer(*window.Window) As #FuncPrefix + "SDL_GetRenderer"
  GetRendererInfo.int(*renderer.Renderer, *info.RendererInfo) As #FuncPrefix + "SDL_GetRendererInfo"
  GetRendererOutputSize.int(*renderer.Renderer, *w.pint, *h.pint) As #FuncPrefix + "SDL_GetRendererOutputSize"
  _CreateTexture.r_Texture(*renderer.Renderer, format.Uint32, access.int, w.int, h.int) As #FuncPrefix + "SDL_CreateTexture"
  Macro CreateTexture(rend,format,access,w,h): sdl::_CreateTexture(rend,format,access,w,h) :EndMacro
  CreateTextureFromSurface.r_Texture(*renderer.Renderer, *surface.Surface) As #FuncPrefix + "SDL_CreateTextureFromSurface"
  QueryTexture.int(*texture.Texture, *format.pUint32, *access.pint, *w.pint, *h.pint) As #FuncPrefix + "SDL_QueryTexture"
  SetTextureColorMod.int(*texture.Texture, r.Uint8, g.Uint8, b.Uint8) As #FuncPrefix + "SDL_SetTextureColorMod"
  GetTextureColorMod.int(*texture.Texture, *r.pUint8, *g.pUint8, *b.pUint8) As #FuncPrefix + "SDL_GetTextureColorMod"
  SetTextureAlphaMod.int(*texture.Texture, alpha.Uint8) As #FuncPrefix + "SDL_SetTextureAlphaMod"
  GetTextureAlphaMod.int(*texture.Texture, *alpha.pUint8) As #FuncPrefix + "SDL_GetTextureAlphaMod"
  SetTextureBlendMode.int(*texture.Texture, blendMode.enum) As #FuncPrefix + "SDL_SetTextureBlendMode"
  GetTextureBlendMode.int(*texture.Texture, *blendMode.penum) As #FuncPrefix + "SDL_GetTextureBlendMode"
  CompilerIf VERSION_ATLEAST(2,0,12)
    SetTextureScaleMode.int(*texture.Texture, scaleMode.enum) As #FuncPrefix + "SDL_SetTextureScaleMode"    
    GetTextureScaleMode.int(*texture.Texture, *scaleMode.penum) As #FuncPrefix + "SDL_GetTextureScaleMode"
  CompilerEndIf
  UpdateTexture.int(*texture.Texture, *rectx.Rect, *pixels.pvoid, pitch.int) As #FuncPrefix + "SDL_UpdateTexture"
  CompilerIf VERSION_ATLEAST(2,0,1)
    UpdateYUVTexture.int(*texture.Texture, *rectx.Rect, *Yplane.pUint8, Ypitch.int, *Uplane.pUint8, Upitch.int, *Vplane.pUint8, Vpitch.int) As #FuncPrefix + "SDL_UpdateYUVTexture"
  CompilerEndIf
  LockTexture.int(*texture.Texture, *rectx.Rect, *pp_pixels.pvoid, *pitch.pint) As #FuncPrefix + "SDL_LockTexture"
  CompilerIf VERSION_ATLEAST(2,0,12)
    LockTextureToSurface.int(*texture.Texture, *rectx.Rect, *pp_surface.Surface) As #FuncPrefix + "SDL_LockTextureToSurface"
  CompilerEndIf
  UnlockTexture.void(*texture.Texture) As #FuncPrefix + "SDL_UnlockTexture"
  RenderTargetSupported.t_bool(*renderer.Renderer) As #FuncPrefix + "SDL_RenderTargetSupported"
  SetRenderTarget.int(*renderer.Renderer, *texture.Texture) As #FuncPrefix + "SDL_SetRenderTarget"
  GetRenderTarget.r_Texture(*renderer.Renderer) As #FuncPrefix + "SDL_GetRenderTarget"
  RenderSetLogicalSize.int(*renderer.Renderer, w.int, h.int) As #FuncPrefix + "SDL_RenderSetLogicalSize"
  RenderGetLogicalSize.void(*renderer.Renderer, *w.pint, *h.pint) As #FuncPrefix + "SDL_RenderGetLogicalSize"
  CompilerIf VERSION_ATLEAST(2,0,5)
    RenderSetIntegerScale.int(*renderer.Renderer, enable.t_bool) As #FuncPrefix + "SDL_RenderSetIntegerScale"
    RenderGetIntegerScale.t_bool(*renderer.Renderer) As #FuncPrefix + "SDL_RenderGetIntegerScale"
  CompilerEndIf
  RenderSetViewport.int(*renderer.Renderer, *rectx.Rect) As #FuncPrefix + "SDL_RenderSetViewport"
  RenderGetViewport.void(*renderer.Renderer, *rectx.Rect) As #FuncPrefix + "SDL_RenderGetViewport"
  RenderSetClipRect.int(*renderer.Renderer, *rectx.Rect) As #FuncPrefix + "SDL_RenderSetClipRect"
  RenderGetClipRect.void(*renderer.Renderer, *rectx.Rect) As #FuncPrefix + "SDL_RenderGetClipRect"
  CompilerIf VERSION_ATLEAST(2,0,4)
    RenderIsClipEnabled.t_bool(*renderer.Renderer) As #FuncPrefix + "SDL_RenderIsClipEnabled"
  CompilerEndIf
  RenderSetScale.int(*renderer.Renderer, scaleX.f, scaleY.f) As #FuncPrefix + "SDL_RenderSetScale"
  RenderGetScale.void(*renderer.Renderer, *scaleX.pfloat, *scaleY.pfloat) As #FuncPrefix + "SDL_RenderGetScale"
  SetRenderDrawColor.int(*renderer.Renderer, r.Uint8, g.Uint8, b.Uint8, a.Uint8) As #FuncPrefix + "SDL_SetRenderDrawColor"
  GetRenderDrawColor.int(*renderer.Renderer, *r.pUint8, *g.pUint8, *b.pUint8, *a.pUint8) As #FuncPrefix + "SDL_GetRenderDrawColor"
  SetRenderDrawBlendMode.int(*renderer.Renderer, blendMode.enum) As #FuncPrefix + "SDL_SetRenderDrawBlendMode"
  GetRenderDrawBlendMode.int(*renderer.Renderer, *blendModepenum) As #FuncPrefix + "SDL_GetRenderDrawBlendMode"
  RenderClear.int(*renderer.Renderer) As #FuncPrefix + "SDL_RenderClear"
  RenderDrawPoint.int(*renderer.Renderer, x.int, y.int) As #FuncPrefix + "SDL_RenderDrawPoint"
  RenderDrawPoints.int(*renderer.Renderer, *points.Point, count.int) As #FuncPrefix + "SDL_RenderDrawPoints"
  RenderDrawLine.int(*renderer.Renderer, x1.int, y1.int, x2.int, y2.int) As #FuncPrefix + "SDL_RenderDrawLine"
  RenderDrawLines.int(*renderer.Renderer, *points.Point, count.int) As #FuncPrefix + "SDL_RenderDrawLines"
  RenderDrawRect.int(*renderer.Renderer, *rectx.Rect) As #FuncPrefix + "SDL_RenderDrawRect"
  RenderDrawRects.int(*renderer.Renderer, *rectxs.Rect, count.int) As #FuncPrefix + "SDL_RenderDrawRects"
  RenderFillRect.int(*renderer.Renderer, *rectx.Rect) As #FuncPrefix + "SDL_RenderFillRect"
  RenderFillRects.int(*renderer.Renderer, *rectxs.Rect, count.int) As #FuncPrefix + "SDL_RenderFillRects"
  RenderCopy.int(*renderer.Renderer, *texture.Texture, *srcrect.Rect, *dstrect.Rect) As #FuncPrefix + "SDL_RenderCopy"
  RenderCopyEx.int(*renderer.Renderer, *texture.Texture, *srcrect.Rect, *dstrect.Rect, angle.d, *center.Point, flip.enum) As #FuncPrefix + "SDL_RenderCopyEx"
  CompilerIf VERSION_ATLEAST(2,0,10)
    RenderDrawPointF.int(*renderer.Renderer, x.f, y.f) As #FuncPrefix + "SDL_RenderDrawPointF"
    RenderDrawPointsF.int(*renderer.Renderer, *points.FPoint, count.int) As #FuncPrefix + "SDL_RenderDrawPointsF"
    RenderDrawLineF.int(*renderer.Renderer, x1.f, y1.f, x2.f, y2.f) As #FuncPrefix + "SDL_RenderDrawLineF"
    RenderDrawLinesF.int(*renderer.Renderer, *points.FPoint, count.int) As #FuncPrefix + "SDL_RenderDrawLinesF"
    RenderDrawRectF.int(*renderer.Renderer, *rectx.FRect) As #FuncPrefix + "SDL_RenderDrawRectF"
    RenderDrawRectsF.int(*renderer.Renderer, *rectxs.FRect, count.int) As #FuncPrefix + "SDL_RenderDrawRectsF"
    RenderFillRectF.int(*renderer.Renderer, *rectx.FRect) As #FuncPrefix + "SDL_RenderFillRectF"
    RenderFillRectsF.int(*renderer.Renderer, *rectxs.FRect, count.int) As #FuncPrefix + "SDL_RenderFillRectsF"
    RenderCopyF.int(*renderer.Renderer, *texture.Texture, *srcrect.Rect, *dstrect.FRect) As #FuncPrefix + "SDL_RenderCopyF"
    RenderCopyExF.int(*renderer.Renderer, *texture.Texture, *srcrect.Rect, *dstrect.FRect, angle.d, *center.FPoint, flip.enum) As #FuncPrefix + "SDL_RenderCopyExF"
  CompilerEndIf
  RenderReadPixels.int(*renderer.Renderer, *rectx.Rect, format.Uint32, *pixels.pvoid, pitch.int) As #FuncPrefix + "SDL_RenderReadPixels"
  RenderPresent.void(*renderer.Renderer) As #FuncPrefix + "SDL_RenderPresent"
  DestroyTexture.void(*texture.Texture) As #FuncPrefix + "SDL_DestroyTexture"
  DestroyRenderer.void(*renderer.Renderer) As #FuncPrefix + "SDL_DestroyRenderer"
  CompilerIf VERSION_ATLEAST(2,0,10)
    RenderFlush.int(*renderer.Renderer) As #FuncPrefix + "SDL_RenderFlush"
  CompilerEndIf
  GL_BindTexture.int(*texture.Texture, *texw.pfloat, *texh.pfloat) As #FuncPrefix + "SDL_GL_BindTexture"
  GL_UnbindTexture.int(*texture.Texture) As #FuncPrefix + "SDL_GL_UnbindTexture"
  CompilerIf VERSION_ATLEAST(2,0,8)
    RenderGetMetalLayer.r_void(*renderer.Renderer) As #FuncPrefix + "SDL_RenderGetMetalLayer"
    RenderGetMetalCommandEncoder.r_void(*renderer.Renderer) As #FuncPrefix + "SDL_RenderGetMetalCommandEncoder"
  CompilerEndIf
EndImport
;}
;-----------------------
;- SDL_sensor.h.pbi
;{

CompilerIf VERSION_ATLEAST(2,0,9)
  Enumeration SensorType
    #SENSOR_INVALID = - 1
    #SENSOR_UNKNOWN
    #SENSOR_ACCEL
    #SENSOR_GYRO
  EndEnumeration
  #STANDARD_GRAVITY = 9.80665
  Macro t_SensorID: Sint32 :EndMacro
  Macro r_Sensor: i :EndMacro
  Structure Sensor: EndStructure
  ImportC #SDL2_lib
    NumSensors.int() As #FuncPrefix + "SDL_NumSensors"
    _SensorGetDeviceName.r_ascii(device_index.int) As #FuncPrefix + "SDL_SensorGetDeviceName"
    Macro SensorGetDeviceName(index): SDL::_GetAscii(SDL::_SensorGetDeviceName(index)) :EndMacro
    SensorGetDeviceType.enum(device_index.int) As #FuncPrefix + "SDL_SensorGetDeviceType"
    SensorGetDeviceNonPortableType.int(device_index.int) As #FuncPrefix + "SDL_SensorGetDeviceNonPortableType"
    SensorGetDeviceInstanceID.t_SensorID(device_index.int) As #FuncPrefix + "SDL_SensorGetDeviceInstanceID"
    SensorOpen.r_Sensor(device_index.int) As #FuncPrefix + "SDL_SensorOpen"
    SensorFromInstanceID.r_Sensor(instance_id.t_SensorID) As #FuncPrefix + "SDL_SensorFromInstanceID"
    _SensorGetName.r_ascii(*sensor.Sensor) As #FuncPrefix + "SDL_SensorGetName"
    Macro SensorGetName(sensor): SDL::_GetAscii(SDL::_SensorGetName(sensor)) :EndMacro
    SensorGetType.enum(*sensor.Sensor) As #FuncPrefix + "SDL_SensorGetType"
    SensorGetNonPortableType.int(*sensor.Sensor) As #FuncPrefix + "SDL_SensorGetNonPortableType"
    SensorGetInstanceID.t_SensorID(*sensor.Sensor) As #FuncPrefix + "SDL_SensorGetInstanceID"
    SensorGetData.int(*sensor.Sensor, *data.pfloat, num_values.int) As #FuncPrefix + "SDL_SensorGetData"
    SensorClose.void(*sensor.Sensor) As #FuncPrefix + "SDL_SensorClose"
    SensorUpdate.void() As #FuncPrefix + "SDL_SensorUpdate"
  EndImport  
CompilerEndIf
;}
;-----------------------
;- SDL_shape.h.pbi
;{

#NONSHAPEABLE_WINDOW = -1
#INVALID_SHAPE_ARGUMENT = -2
#WINDOW_LACKS_SHAPE = -3
Enumeration WindowShapeMode
  #ShapeModeDefault
  #ShapeModeBinarizeAlpha
  #ShapeModeReverseBinarizeAlpha
  #ShapeModeColorKey
EndEnumeration
Macro r_WindowShapeMode: i :EndMacro
Macro SHAPEMODEALPHA(mode): Bool(mode = SDL::#ShapeModeDefault Or mode = SDL::#ShapeModeBinarizeAlpha Or mode = SDL::#ShapeModeReverseBinarizeAlpha) :EndMacro
Structure WindowShapeParams Align #SDLALIGN
  StructureUnion
    binarizationCutoff.Uint8
    colorKey.color
  EndStructureUnion
EndStructure
Structure WindowShapeMode Align #SDLALIGN
  mode.enum
  parameters.WindowShapeParams
EndStructure
ImportC #SDL2_lib
  CreateShapedWindow.r_Window(title.p-utf8, x.unsignedint, y.unsignedint, w.unsignedint, h.unsignedint, flags.Uint32) As #FuncPrefix + "SDL_CreateShapedWindow"
  IsShapedWindow.t_bool(*window.Window) As #FuncPrefix + "SDL_IsShapedWindow"
  SetWindowShape.int(*window.Window, *shape.Surface, *shape_mode.WindowShapeMode) As #FuncPrefix + "SDL_SetWindowShape"
  GetShapedWindowMode.int(*window.Window, *shape_mode.WindowShapeMode) As #FuncPrefix + "SDL_GetShapedWindowMode"
EndImport  
;}
;-----------------------
;- SDL_system.h.pbi
;{

CompilerSelect #PB_Compiler_OS
  CompilerCase #PB_OS_Windows
    Macro WindowsMessageHook: integer :EndMacro; WindowsMessageHook.void (*userdata.pvoid, *hWnd.pvoid, message.unsignedint, wparam.unit64, lparam.sint64)
    Macro r_IDirect3DDevice9 : i :EndMacro
    ;Structure IDirect3DDevice9 :EndStructure
    ImportC #SDL2_lib 
      SetWindowsMessageHook.void(*callback.WindowsMessageHook, *userdata.pvoid) As #FuncPrefix + "SDL_SetWindowsMessageHook"
      CompilerIf VERSION_ATLEAST(2,0,1)
        Direct3D9GetAdapterIndex.int(displayIndex.int) As #FuncPrefix + "SDL_Direct3D9GetAdapterIndex"
        RenderGetD3D9Device.r_IDirect3DDevice9(*renderer.Renderer) As #FuncPrefix + "SDL_RenderGetD3D9Device"
      CompilerEndIf
      CompilerIf VERSION_ATLEAST(2,0,2)
        DXGIGetOutputInfo.t_bool(displayIndex.int, *adapterIndex.pint, *outputIndex.pint) As #FuncPrefix + "SDL_DXGIGetOutputInfo"
      CompilerEndIf
    EndImport  
  CompilerCase #PB_OS_Linux
    CompilerIf VERSION_ATLEAST(2,0,9)
      ImportC #SDL2_lib 
        LinuxSetThreadPriority.int(threadID.Sint64, priority.int) As #FuncPrefix + "SDL_LinuxSetThreadPriority"
      EndImport
    CompilerEndIf
CompilerEndSelect
ImportC #SDL2_lib 
  CompilerIf VERSION_ATLEAST(2,0,9)
    IsTablet.t_bool() As #FuncPrefix + "SDL_IsTablet"
  CompilerEndIf
  CompilerIf VERSION_ATLEAST(2,0,12)
    OnApplicationWillTerminate.void() As #FuncPrefix + "SDL_OnApplicationWillTerminate"
    OnApplicationDidReceiveMemoryWarning.void() As #FuncPrefix + "SDL_OnApplicationDidReceiveMemoryWarning"
    OnApplicationWillResignActive.void() As #FuncPrefix + "SDL_OnApplicationWillResignActive"
    OnApplicationDidEnterBackground.void() As #FuncPrefix + "SDL_OnApplicationDidEnterBackground"
    OnApplicationWillEnterForeground.void() As #FuncPrefix + "SDL_OnApplicationWillEnterForeground"
    OnApplicationDidBecomeActive.void() As #FuncPrefix + "SDL_OnApplicationDidBecomeActive"
  CompilerEndIf
EndImport  
;}
;-----------------------
;- SDL_timer.h.pbi
;{

Macro t_TimerID: int :EndMacro
Macro TimerCallback: integer :EndMacro; TimerCallback.uint32(interval.uint32,*param.pvoid)
ImportC #SDL2_lib
  GetTicks.Uint32() As #FuncPrefix + "SDL_GetTicks"
  Macro TICKS_PASSED(A, B):  Bool(((B) - (A)) <= 0) :EndMacro
  GetPerformanceCounter.Uint64() As #FuncPrefix + "SDL_GetPerformanceCounter"
  GetPerformanceFrequency.Uint64() As #FuncPrefix + "SDL_GetPerformanceFrequency"
  _Delay.void(ms.Uint32) As #FuncPrefix + "SDL_Delay"
  Macro Delay(ms): sdl::_Delay(ms) :EndMacro
  AddTimer.t_TimerID(interval.Uint32, *callback.TimerCallback, *param.pvoid) As #FuncPrefix + "SDL_AddTimer"
  RemoveTimer.t_bool(id.t_TimerID) As #FuncPrefix + "SDL_RemoveTimer"
EndImport
;}
;-----------------------
;- SDL_version.h.pbi
;{

Structure version Align #SDLALIGN
  major.Uint8
  minor.Uint8
  patch.Uint8
EndStructure
Macro r_version: i :EndMacro
ImportC #SDL2_lib
  GetVersion.void(*ver.version) As #FuncPrefix + "SDL_GetVersion"
  _GetRevision.r_ascii() As #FuncPrefix + "SDL_GetRevision"
  Macro GetRevision(): SDL::_GetAscii(SDL::_GetRevision()) :EndMacro
  GetRevisionNumber.int() As #FuncPrefix + "SDL_GetRevisionNumber"
EndImport
;}
;-----------------------
;- sdl.h.pbi
;{

#INIT_TIMER = $00000001
#INIT_AUDIO = $00000010
#INIT_VIDEO = $00000020
#INIT_JOYSTICK = $00000200
#INIT_HAPTIC = $00001000
#INIT_GAMECONTROLLER = $00002000
#INIT_EVENTS = $00004000
CompilerIf VERSION_ATLEAST(2,0,9)  
  #INIT_SENSOR = $00008000
CompilerEndIf
#INIT_NOPARACHUTE = $00100000
CompilerIf VERSION_ATLEAST(2,0,9)
  #INIT_EVERYTHING = ( #INIT_TIMER | #INIT_AUDIO | #INIT_VIDEO | #INIT_EVENTS | #INIT_JOYSTICK | #INIT_HAPTIC | #INIT_GAMECONTROLLER | #INIT_SENSOR )
CompilerElse
  #INIT_EVERYTHING = ( #INIT_TIMER | #INIT_AUDIO | #INIT_VIDEO | #INIT_EVENTS | #INIT_JOYSTICK | #INIT_HAPTIC | #INIT_GAMECONTROLLER)
CompilerEndIf
ImportC #SDL2_lib
  Init.int(flags.Uint32) As #FuncPrefix + "SDL_Init"
  InitSubSystem.int(flags.Uint32) As #FuncPrefix + "SDL_InitSubSystem"
  QuitSubSystem.void(flags.Uint32) As #FuncPrefix + "SDL_QuitSubSystem"
  WasInit.Uint32(flags.Uint32) As #FuncPrefix + "SDL_WasInit"
  Quit.void() As #FuncPrefix + "SDL_Quit"
EndImport
;}
  CompilerIf #SDL_USE_IMAGE
;-----------------------
;- SDL_image.h.pbi
;{

#IMAGE_MAJOR_VERSION = 2
#IMAGE_MINOR_VERSION = 0
#IMAGE_PATCHLEVEL = 5
#IMAGE_COMPILEDVERSION = VERSIONNUM(#IMAGE_MAJOR_VERSION,#IMAGE_MINOR_VERSION,#IMAGE_PATCHLEVEL)
Enumeration IMG_InitFlags
  #IMG_INIT_JPG = $00000001
  #IMG_INIT_PNG = $00000002
  #IMG_INIT_TIF = $00000004
  #IMG_INIT_WEBP = $00000008
EndEnumeration
ImportC #SDL2_image_lib
  Macro IMG_SetError(err): SDL::_Call_SetError(err,sdl::@_SetError()) : EndMacro
  Macro IMG_GetError(): SDL::_GetAscii(SDL::_GetError()) :EndMacro
  Macro IMAGE_VERSION_ATLEAST(X, Y, Z): Bool(SDL::#IMAGE_COMPILEDVERSION >= SDL::VERSIONNUM(X, Y, Z)) :EndMacro
  IMG_Linked_Version.r_version() As #FuncPrefix + "IMG_Linked_Version"
  IMG_Init.int(flags.int) As #FuncPrefix + "IMG_Init"
  IMG_Quit.void() As #FuncPrefix + "IMG_Quit"
  IMG_LoadTyped_RW.r_Surface(*src.RWops, freesrc.int, type.p-ascii) As #FuncPrefix + "IMG_LoadTyped_RW"
  IMG_Load.r_Surface(file.p-utf8) As #FuncPrefix + "IMG_Load"
  IMG_Load_RW.r_Surface(*src.RWops, freesrc.int) As #FuncPrefix + "IMG_Load_RW"
  IMG_LoadTexture.r_Texture(*renderer.Renderer, file.p-utf8) As #FuncPrefix + "IMG_LoadTexture"
  IMG_LoadTexture_RW.r_Texture(*renderer.Renderer, *src.RWops, freesrc.int) As #FuncPrefix + "IMG_LoadTexture_RW"
  IMG_LoadTextureTyped_RW.r_Texture(*renderer.Renderer, *src.RWops, freesrc.int, type.p-ascii) As #FuncPrefix + "IMG_LoadTextureTyped_RW"
  IMG_isICO.int(*src.RWops) As #FuncPrefix + "IMG_isICO"
  IMG_isCUR.int(*src.RWops) As #FuncPrefix + "IMG_isCUR"
  IMG_isBMP.int(*src.RWops) As #FuncPrefix + "IMG_isBMP"
  IMG_isGIF.int(*src.RWops) As #FuncPrefix + "IMG_isGIF"
  IMG_isJPG.int(*src.RWops) As #FuncPrefix + "IMG_isJPG"
  IMG_isLBM.int(*src.RWops) As #FuncPrefix + "IMG_isLBM"
  IMG_isPCX.int(*src.RWops) As #FuncPrefix + "IMG_isPCX"
  IMG_isPNG.int(*src.RWops) As #FuncPrefix + "IMG_isPNG"
  IMG_isPNM.int(*src.RWops) As #FuncPrefix + "IMG_isPNM"
  IMG_isSVG.int(*src.RWops) As #FuncPrefix + "IMG_isSVG"
  IMG_isTIF.int(*src.RWops) As #FuncPrefix + "IMG_isTIF"
  IMG_isXCF.int(*src.RWops) As #FuncPrefix + "IMG_isXCF"
  IMG_isXPM.int(*src.RWops) As #FuncPrefix + "IMG_isXPM"
  IMG_isXV.int(*src.RWops) As #FuncPrefix + "IMG_isXV"
  IMG_isWEBP.int(*src.RWops) As #FuncPrefix + "IMG_isWEBP"
  IMG_LoadICO_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadICO_RW"
  IMG_LoadCUR_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadCUR_RW"
  IMG_LoadBMP_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadBMP_RW"
  IMG_LoadGIF_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadGIF_RW"
  IMG_LoadJPG_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadJPG_RW"
  IMG_LoadLBM_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadLBM_RW"
  IMG_LoadPCX_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadPCX_RW"
  IMG_LoadPNG_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadPNG_RW"
  IMG_LoadPNM_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadPNM_RW"
  IMG_LoadSVG_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadSVG_RW"
  IMG_LoadTGA_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadTGA_RW"
  IMG_LoadTIF_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadTIF_RW"
  IMG_LoadXCF_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadXCF_RW"
  IMG_LoadXPM_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadXPM_RW"
  IMG_LoadXV_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadXV_RW"
  IMG_LoadWEBP_RW.r_Surface(*src.RWops) As #FuncPrefix + "IMG_LoadWEBP_RW"
  IMG_ReadXPMFromArray.r_Surface(*pp_xpm) As #FuncPrefix + "IMG_ReadXPMFromArray"
  IMG_SavePNG.int(*surface.Surface, file.p-utf8) As #FuncPrefix + "IMG_SavePNG"
  IMG_SavePNG_RW.int(*surface.Surface, *dst.RWops, freedst.int) As #FuncPrefix + "IMG_SavePNG_RW"
  IMG_SaveJPG.int(*surface.Surface, file.p-utf8, quality.int) As #FuncPrefix + "IMG_SaveJPG"
  IMG_SaveJPG_RW.int(*surface.Surface, *dst.RWops, freedst.int, quality.int) As #FuncPrefix + "IMG_SaveJPG_RW"
EndImport
;}
  CompilerEndIf
  CompilerIf #SDL_USE_MIXER
;-----------------------
;- SDL_mixer.h.pbi
;{

#MIXER_MAJOR_VERSION = 2
#MIXER_MINOR_VERSION = 0
#MIXER_PATCHLEVEL = 4
#MIX_MAJOR_VERSION = #MIXER_MAJOR_VERSION
#MIX_MINOR_VERSION = #MIXER_MINOR_VERSION
#MIX_PATCHLEVEL = #MIXER_PATCHLEVEL
#MIXER_COMPILEDVERSION = VERSIONNUM(#MIXER_MAJOR_VERSION,#MIXER_MINOR_VERSION,#MIXER_PATCHLEVEL)
#MIX_CHANNEL_POST = -2
Enumeration MIX_InitFlags
  #MIX_INIT_FLAC = $00000001
  #MIX_INIT_MOD = $00000002
  #MIX_INIT_MP3 = $00000008
  #MIX_INIT_OGG = $00000010
  #MIX_INIT_MID = $00000020
  #MIX_INIT_OPUS = $00000040
EndEnumeration
#MIX_CHANNELS = 8
#MIX_DEFAULT_FREQUENCY = 22050
CompilerIf #BYTEORDER = #LIL_ENDIAN
  #MIX_DEFAULT_FORMAT = #AUDIO_S16LSB
CompilerElse
  #MIX_DEFAULT_FORMAT = #AUDIO_S16MSB
CompilerEndIf
#MIX_DEFAULT_CHANNELS = 2
#MIX_MAX_VOLUME = #MIX_MAXVOLUME
Enumeration Mix_Fading
  #MIX_NO_FADING
  #MIX_FADING_OUT
  #MIX_FADING_IN
EndEnumeration
Enumeration Mix_MusicType
  #MUS_NONE
  #MUS_CMD
  #MUS_WAV
  #MUS_MOD
  #MUS_MID
  #MUS_OGG
  #MUS_MP3
  #MUS_MP3_MAD_UNUSED
  #MUS_FLAC
  #MUS_MODPLUG_UNUSED
  #MUS_OPUS
EndEnumeration
#MIX_EFFECTSMAXSPEED = "MIX_EFFECTSMAXSPEED"
Structure Mix_Chunk Align #SDLALIGN
  allocated.int
  *abuf.pUint8
  alen.Uint32
  volume.Uint8
EndStructure
Macro r_Mix_Chunk: i :EndMacro
;void (SDLCALL *mix_func)(void *udata, Uint8 *stream, int len)
;void (SDLCALL *music_finished)(void)
;void (SDLCALL *channel_finished)(int channel)
Macro Mix_EffectFunc_T: i :EndMacro;typedef void (SDLCALL *Mix_EffectFunc_t)(int chan, void *stream, int len, void *udata);
Macro Mix_EffectDone_T: i :EndMacro;typedef void (SDLCALL *Mix_EffectDone_t)(int chan, void *udata)                       ;
                                   ;Int (SDLCALL *function)(const char*, void*) - eachsoundfont 
Structure Mix_Music:EndStructure
Macro r_Mix_Music: i :EndMacro
ImportC #SDL2_mixer_lib
  Macro Mix_SetError(err): SDL::_Call_SetError(err,sdl::@_SetError()) : EndMacro
  Macro Mix_GetError(): SDL::_GetAscii(SDL::_GetError()) :EndMacro
  Macro MIXER_VERSION_ATLEAST(X, Y, Z) : Bool(SDL::#MIXER_COMPILEDVERSION >= SDL::VERSIONNUM(X, Y, Z)) :EndMacro
  Mix_Linked_Version.r_version() As #FuncPrefix + "Mix_Linked_Version"
  Mix_Init.int(flags.int) As #FuncPrefix + "Mix_Init"
  Mix_Quit.void() As #FuncPrefix + "Mix_Quit"
  Mix_OpenAudio.int(frequency.int, format.Uint16, channels.int, chunksize.int) As #FuncPrefix + "Mix_OpenAudio"
  Mix_OpenAudioDevice.int(frequency.int, format.Uint16, channels.int, chunksize.int, device.p-ascii, allowed_changes.int) As #FuncPrefix + "Mix_OpenAudioDevice"
  Mix_AllocateChannels.int(numchans.int) As #FuncPrefix + "Mix_AllocateChannels"
  Mix_QuerySpec.int(*frequency.pint, *format.pUint16, *channels.pint) As #FuncPrefix + "Mix_QuerySpec"
  Mix_LoadWAV_RW.r_Mix_Chunk(*src.RWops, freesrc.int) As #FuncPrefix + "Mix_LoadWAV_RW"
  Macro Mix_LoadWAV(file):  SDL::Mix_LoadWAV_RW(SDL::RWFromFile(file, "rb"), 1) :EndMacro
  Mix_LoadMUS.r_Mix_Music(file.p-ascii) As #FuncPrefix + "Mix_LoadMUS"
  Mix_LoadMUS_RW.r_Mix_Music(*src.RWops, freesrc.int) As #FuncPrefix + "Mix_LoadMUS_RW"
  Mix_LoadMUSType_RW.r_Mix_Music(*src.RWops, type.enum, freesrc.int) As #FuncPrefix + "Mix_LoadMUSType_RW"
  Mix_QuickLoad_WAV.r_Mix_Chunk(*mem.pUint8) As #FuncPrefix + "Mix_QuickLoad_WAV"
  Mix_QuickLoad_RAW.r_Mix_Chunk(*mem.pUint8, len.Uint32) As #FuncPrefix + "Mix_QuickLoad_RAW"
  Mix_FreeChunk.void(*chunk.Mix_Chunk) As #FuncPrefix + "Mix_FreeChunk"
  Mix_FreeMusic.void(*music.Mix_Music) As #FuncPrefix + "Mix_FreeMusic"
  Mix_GetNumChunkDecoders.int() As #FuncPrefix + "Mix_GetNumChunkDecoders"
  _Mix_GetChunkDecoder.r_ascii(index.int) As #FuncPrefix + "Mix_GetChunkDecoder"
  Macro Mix_GetChunkDecoder(index): SDL::_GetAscii(SDL::_Mix_GetChunkDecoder(index)) :EndMacro
  Mix_HasChunkDecoder.t_bool(name.p-ascii) As #FuncPrefix + "Mix_HasChunkDecoder"
  Mix_GetNumMusicDecoders.int() As #FuncPrefix + "Mix_GetNumMusicDecoders"
  _Mix_GetMusicDecoder.r_ascii(index.int) As #FuncPrefix + "Mix_GetMusicDecoder"
  Macro Mix_GetMusicDecoder(index): sdl::_GetAscii(SDL::_Mix_GetMusicDecoder(index)) :EndMacro
  ;Mix_HasMusicDecoder.t_bool(*name.p-ascii) As #FuncPrefix + "Mix_HasMusicDecoder"
  Mix_GetMusicType.enum(*music.Mix_Music) As #FuncPrefix + "Mix_GetMusicType"
  Mix_SetPostMix.void(*mix_func, *arg.pvoid) As #FuncPrefix + "Mix_SetPostMix"
  Mix_HookMusic.void(*mix_func, *arg.pvoid) As #FuncPrefix + "Mix_HookMusic"
  Mix_HookMusicFinished.void(*music_finished) As #FuncPrefix + "Mix_HookMusicFinished"
  Mix_GetMusicHookData.r_void() As #FuncPrefix + "Mix_GetMusicHookData"
  Mix_ChannelFinished.void(*channel_finished) As #FuncPrefix + "Mix_ChannelFinished"
  Mix_RegisterEffect.int(chan.int, f.Mix_EffectFunc_t, d.Mix_EffectDone_t, *arg.pvoid) As #FuncPrefix + "Mix_RegisterEffect"
  Mix_UnregisterEffect.int(channel.int, f.Mix_EffectFunc_t) As #FuncPrefix + "Mix_UnregisterEffect"
  Mix_UnregisterAllEffects.int(channel.int) As #FuncPrefix + "Mix_UnregisterAllEffects"
  Mix_SetPanning.int(channel.int, left.Uint8, right.Uint8) As #FuncPrefix + "Mix_SetPanning"
  Mix_SetPosition.int(channel.int, angle.Sint16, distance.Uint8) As #FuncPrefix + "Mix_SetPosition"
  Mix_SetDistance.int(channel.int, distance.Uint8) As #FuncPrefix + "Mix_SetDistance"
  Mix_SetReverseStereo.int(channel.int, flip.int) As #FuncPrefix + "Mix_SetReverseStereo"
  Mix_ReserveChannels.int(num.int) As #FuncPrefix + "Mix_ReserveChannels"
  Mix_GroupChannel.int(which.int, tag.int) As #FuncPrefix + "Mix_GroupChannel"
  Mix_GroupChannels.int(from.int, _to.int, tag.int) As #FuncPrefix + "Mix_GroupChannels"
  Mix_GroupAvailable.int(tag.int) As #FuncPrefix + "Mix_GroupAvailable"
  Mix_GroupCount.int(tag.int) As #FuncPrefix + "Mix_GroupCount"
  Mix_GroupOldest.int(tag.int) As #FuncPrefix + "Mix_GroupOldest"
  Mix_GroupNewer.int(tag.int) As #FuncPrefix + "Mix_GroupNewer"
  Macro Mix_PlayChannel(channel,chunk,loops): SDL::Mix_PlayChannelTimed(channel,chunk,loops,-1) :EndMacro
  Mix_PlayChannelTimed.int(channel.int, *chunk.Mix_Chunk, loops.int, ticks.int) As #FuncPrefix + "Mix_PlayChannelTimed"
  Mix_PlayMusic.int(*music.Mix_Music, loops.int) As #FuncPrefix + "Mix_PlayMusic"
  Mix_FadeInMusic.int(*music.Mix_Music, loops.int, ms.int) As #FuncPrefix + "Mix_FadeInMusic"
  Mix_FadeInMusicPos.int(*music.Mix_Music, loops.int, ms.int, position.d) As #FuncPrefix + "Mix_FadeInMusicPos"
  Macro Mix_FadeInChannel(channel,chunk,loops,ms): SDL::Mix_FadeInChannelTimed(channel,chunk,loops,ms,-1) :EndMacro
  Mix_FadeInChannelTimed.int(channel.int, *chunk.Mix_Chunk, loops.int, ms.int, ticks.int) As #FuncPrefix + "Mix_FadeInChannelTimed"
  Mix_Volume.int(channel.int, volume.int) As #FuncPrefix + "Mix_Volume"
  Mix_VolumeChunk.int(*chunk.Mix_Chunk, volume.int) As #FuncPrefix + "Mix_VolumeChunk"
  Mix_VolumeMusic.int(volume.int) As #FuncPrefix + "Mix_VolumeMusic"
  Mix_HaltChannel.int(channel.int) As #FuncPrefix + "Mix_HaltChannel"
  Mix_HaltGroup.int(tag.int) As #FuncPrefix + "Mix_HaltGroup"
  Mix_HaltMusic.int() As #FuncPrefix + "Mix_HaltMusic"
  Mix_ExpireChannel.int(channel.int, ticks.int) As #FuncPrefix + "Mix_ExpireChannel"
  Mix_FadeOutChannel.int(which.int, ms.int) As #FuncPrefix + "Mix_FadeOutChannel"
  Mix_FadeOutGroup.int(tag.int, ms.int) As #FuncPrefix + "Mix_FadeOutGroup"
  Mix_FadeOutMusic.int(ms.int) As #FuncPrefix + "Mix_FadeOutMusic"
  Mix_FadingMusic.enum() As #FuncPrefix + "Mix_FadingMusic"
  Mix_FadingChannel.enum(which.int) As #FuncPrefix + "Mix_FadingChannel"
  Mix_Pause.void(channel.int) As #FuncPrefix + "Mix_Pause"
  Mix_Resume.void(channel.int) As #FuncPrefix + "Mix_Resume"
  Mix_Paused.int(channel.int) As #FuncPrefix + "Mix_Paused"
  Mix_PauseMusic.void() As #FuncPrefix + "Mix_PauseMusic"
  Mix_ResumeMusic.void() As #FuncPrefix + "Mix_ResumeMusic"
  Mix_RewindMusic.void() As #FuncPrefix + "Mix_RewindMusic"
  Mix_PausedMusic.int() As #FuncPrefix + "Mix_PausedMusic"
  Mix_SetMusicPosition.int(position.d) As #FuncPrefix + "Mix_SetMusicPosition"
  Mix_Playing.int(channel.int) As #FuncPrefix + "Mix_Playing"
  Mix_PlayingMusic.int() As #FuncPrefix + "Mix_PlayingMusic"
  Mix_SetMusicCMD.int(command.p-utf8) As #FuncPrefix + "Mix_SetMusicCMD"
  Mix_SetSynchroValue.int(value.int) As #FuncPrefix + "Mix_SetSynchroValue"
  Mix_GetSynchroValue.int() As #FuncPrefix + "Mix_GetSynchroValue"
  Mix_SetSoundFonts.int(paths.p-utf8) As #FuncPrefix + "Mix_SetSoundFonts"
  _Mix_GetSoundFonts.r_utf8() As #FuncPrefix + "Mix_GetSoundFonts"
  Macro Mix_GetSoundFonts(): SDL::_GetAscii(SDL::_Mix_GetSoundFonts()):EndMacro
  Mix_EachSoundFont.int(*callback, *data.pvoid) As #FuncPrefix + "Mix_EachSoundFont"
  Mix_GetChunk.r_Mix_Chunk(channel.int) As #FuncPrefix + "Mix_GetChunk"
  Mix_CloseAudio.void() As #FuncPrefix + "Mix_CloseAudio"
EndImport
;}
  CompilerEndIf
  CompilerIf #SDL_USE_TTF
;-----------------------
;- SDL_ttf.h.pbi
;{

#TTF_MAJOR_VERSION = 2
#TTF_MINOR_VERSION = 0
#TTF_PATCHLEVEL = 15
#TTF_MAJOR_VERSION = #TTF_MAJOR_VERSION
#TTF_MINOR_VERSION = #TTF_MINOR_VERSION
#TTF_PATCHLEVEL = #TTF_PATCHLEVEL
#TTF_COMPILEDVERSION = SDL::VERSIONNUM(#TTF_MAJOR_VERSION,#TTF_MINOR_VERSION,#TTF_PATCHLEVEL)
#UNICODE_BOM_NATIVE = $FEFF
#UNICODE_BOM_SWAPPED = $FFFE
#TTF_STYLE_NORMAL = $00
#TTF_STYLE_BOLD = $01
#TTF_STYLE_ITALIC = $02
#TTF_STYLE_UNDERLINE = $04
#TTF_STYLE_STRIKETHROUGH = $08
#TTF_HINTING_NORMAL = 0
#TTF_HINTING_LIGHT = 1
#TTF_HINTING_MONO = 2
#TTF_HINTING_NONE = 3
Structure TTF_Font:EndStructure
Macro R_TTF_Font: i :EndMacro
ImportC #libSDL2_TTF_PB_HelperLib_a
  TTF_RenderASCII_Solid.r_Surface(*font.TTF_Font, text.p-ascii, *fg.Color) As #FuncPrefix + "_Helper_RenderText_Solid"
  TTF_RenderUTF8_Solid.r_Surface(*font.TTF_Font, text.p-utf8, *fg.Color) As #FuncPrefix + "_Helper_RenderUTF8_Solid"
  TTF_RenderText_Solid.r_Surface(*font.TTF_Font, text.p-Unicode, *fg.Color) As #FuncPrefix + "_Helper_RenderUNICODE_Solid"
  TTF_RenderGlyph_Solid.r_Surface(*font.TTF_Font, ch.Uint16, *fg.Color) As #FuncPrefix + "_Helper_RenderGlyph_Solid"
  TTF_RenderASCII_Shaded.r_Surface(*font.TTF_Font, text.p-ascii, *fg.Color, *bg.Color) As #FuncPrefix + "_Helper_RenderText_Shaded"
  TTF_RenderUTF8_Shaded.r_Surface(*font.TTF_Font, text.p-utf8, *fg.Color, *bg.Color) As #FuncPrefix + "_Helper_RenderUTF8_Shaded"
  TTF_RenderText_Shaded.r_Surface(*font.TTF_Font, text.p-Unicode, *fg.Color, *bg.Color) As #FuncPrefix + "_Helper_RenderUNICODE_Shaded"
  TTF_RenderGlyph_Shaded.r_Surface(*font.TTF_Font, ch.Uint16, *fg.Color, *bg.Color) As #FuncPrefix + "_Helper_RenderGlyph_Shaded"
  TTF_RenderASCII_Blended.r_Surface(*font.TTF_Font, text.p-ascii, *fg.Color) As #FuncPrefix + "_Helper_RenderText_Blended"
  TTF_RenderUTF8_Blended.r_Surface(*font.TTF_Font, text.p-utf8, *fg.Color) As #FuncPrefix + "_Helper_RenderUTF8_Blended"
  TTF_RenderText_Blended.r_Surface(*font.TTF_Font, text.p-Unicode, *fg.Color) As #FuncPrefix + "_Helper_RenderUNICODE_Blended"
  TTF_RenderASCII_Blended_Wrapped.r_Surface(*font.TTF_Font, text.p-ascii, *fg.Color, wrapLength.Uint32) As #FuncPrefix + "_Helper_RenderText_Blended_Wrapped"
  TTF_RenderUTF8_Blended_Wrapped.r_Surface(*font.TTF_Font, text.p-utf8, *fg.Color, wrapLength.Uint32) As #FuncPrefix + "_Helper_RenderUTF8_Blended_Wrapped"
  TTF_RenderText_Blended_Wrapped.r_Surface(*font.TTF_Font, text.p-Unicode, *fg.Color, wrapLength.Uint32) As #FuncPrefix + "_Helper_RenderUNICODE_Blended_Wrapped"
  TTF_RenderGlyph_Blended.r_Surface(*font.TTF_Font, ch.Uint16, *fg.Color) As #FuncPrefix + "_Helper_RenderGlyph_Blended"
EndImport  
ImportC #SDL2_ttf_lib
  Macro TTF_VERSION_ATLEAST(X, Y, Z): Bool(SDL::#TTF_COMPILEDVERSION >= SDL::VERSIONNUM(X, Y, Z)) :EndMacro
  Macro TTF_SetError(err): SDL::_Call_SetError(err,sdl::@_SetError()) : EndMacro
  Macro TTF_GetError(): SDL::_GetAscii(SDL::_GetError()) :EndMacro
  TTF_Linked_Version.r_version() As #FuncPrefix + "TTF_Linked_Version"
  TTF_ByteSwappedUNICODE.void(swapped.int) As #FuncPrefix + "TTF_ByteSwappedUNICODE"
  TTF_Init.int() As #FuncPrefix + "TTF_Init"
  TTF_OpenFont.r_TTF_Font(file.p-utf8, ptsize.int) As #FuncPrefix + "TTF_OpenFont"
  TTF_OpenFontIndex.r_TTF_Font(file.p-utf8, ptsize.int, index.l) As #FuncPrefix + "TTF_OpenFontIndex"
  TTF_OpenFontRW.r_TTF_Font(*src.RWops, freesrc.int, ptsize.int) As #FuncPrefix + "TTF_OpenFontRW"
  TTF_OpenFontIndexRW.r_TTF_Font(*src.RWops, freesrc.int, ptsize.int, index.l) As #FuncPrefix + "TTF_OpenFontIndexRW"
  TTF_GetFontStyle.int(*font.TTF_Font) As #FuncPrefix + "TTF_GetFontStyle"
  TTF_SetFontStyle.void(*font.TTF_Font, style.int) As #FuncPrefix + "TTF_SetFontStyle"
  TTF_GetFontOutline.int(*font.TTF_Font) As #FuncPrefix + "TTF_GetFontOutline"
  TTF_SetFontOutline.void(*font.TTF_Font, outline.int) As #FuncPrefix + "TTF_SetFontOutline"
  TTF_GetFontHinting.int(*font.TTF_Font) As #FuncPrefix + "TTF_GetFontHinting"
  TTF_SetFontHinting.void(*font.TTF_Font, hinting.int) As #FuncPrefix + "TTF_SetFontHinting"
  TTF_FontHeight.int(*font.TTF_Font) As #FuncPrefix + "TTF_FontHeight"
  TTF_FontAscent.int(*font.TTF_Font) As #FuncPrefix + "TTF_FontAscent"
  TTF_FontDescent.int(*font.TTF_Font) As #FuncPrefix + "TTF_FontDescent"
  TTF_FontLineSkip.int(*font.TTF_Font) As #FuncPrefix + "TTF_FontLineSkip"
  TTF_GetFontKerning.int(*font.TTF_Font) As #FuncPrefix + "TTF_GetFontKerning"
  TTF_SetFontKerning.void(*font.TTF_Font, allowed.int) As #FuncPrefix + "TTF_SetFontKerning"
  TTF_FontFaces.l(*font.TTF_Font) As #FuncPrefix + "TTF_FontFaces"
  TTF_FontFaceIsFixedWidth.int(*font.TTF_Font) As #FuncPrefix + "TTF_FontFaceIsFixedWidth"
  _TTF_FontFaceFamilyName.r_utf8(*font.TTF_Font) As #FuncPrefix + "TTF_FontFaceFamilyName"
  Macro TTF_FontFaceFamilyName(font): SDL::_GetUTF8(SDL::_TTF_FontFaceFamilyName(font)) :EndMacro
  _TTF_FontFaceStyleName.r_utf8(*font.TTF_Font) As #FuncPrefix + "TTF_FontFaceStyleName"
  Macro TTF_FontFaceStyleName(font): SDL::_GetUTF8(SDL::_TTF_FontFaceStyleName(font)) :EndMacro
  TTF_GlyphIsProvided.int(*font.TTF_Font, ch.Uint16) As #FuncPrefix + "TTF_GlyphIsProvided"
  TTF_GlyphMetrics.int(*font.TTF_Font, ch.Uint16, *minx.pint, *maxx.pint, *miny.pint, *maxy.pint, *advance.pint) As #FuncPrefix + "TTF_GlyphMetrics"
  TTF_SizeASCII.int(*font.TTF_Font, text.p-ascii, *w.pint, *h.pint) As #FuncPrefix + "TTF_SizeText"
  TTF_SizeUTF8.int(*font.TTF_Font, text.p-utf8, *w.pint, *h.pint) As #FuncPrefix + "TTF_SizeUTF8"
  TTF_SizeText.int(*font.TTF_Font, text.p-Unicode, *w.pint, *h.pint) As #FuncPrefix + "TTF_SizeUNICODE"
  Macro TTF_RenderText(font, text, fg, bg) : TTF_RenderText_Shaded(font, text, fg, bg) :EndMacro
  Macro TTF_RenderUTF8(font, text, fg, bg) : TTF_RenderUTF8_Shaded(font, text, fg, bg) :EndMacro
  Macro TTF_RenderASCII(font, text, fg, bg) : TTF_RenderASCII_Shaded(font, text, fg, bg) :EndMacro
  TTF_CloseFont.void(*font.TTF_Font) As #FuncPrefix + "TTF_CloseFont"
  TTF_Quit.void() As #FuncPrefix + "TTF_Quit"
  TTF_WasInit.int() As #FuncPrefix + "TTF_WasInit"
  TTF_GetFontKerningSize.int( *font.TTF_Font,  prev_index.int,  index.int); SDL_DEPRECATED
  TTF_GetFontKerningSizeGlyphs.int(*font.TTF_Font ,  previous_ch.Uint16,  ch.Uint16);
EndImport
;}
  CompilerEndIf
  CompilerIf #SDL_USE_NET
;-----------------------
;- SDL_net.h.pbi
;{

Macro Net_Version: SDL::Version :EndMacro
Macro r_Net_Version: SDL::r_Version :EndMacro
#NET_MAJOR_VERSION = 2
#NET_MINOR_VERSION = 0
#NET_PATCHLEVEL = 1
#NET_COMPILEDVERSION = VERSIONNUM(#NET_MAJOR_VERSION,#NET_MINOR_VERSION,#NET_PATCHLEVEL)
#INADDR_ANY = $00000000
#INADDR_NONE = $FFFFFFFF
#INADDR_LOOPBACK = $7f000001
#INADDR_BROADCAST = $FFFFFFFF
#Net_MAX_UDPCHANNELS = 32
#Net_MAX_UDPADDRESSES = 4
Structure IPaddress Align #SDLALIGN
  host.Uint32
  port.Uint16
EndStructure
Macro r_IPaddress: i :EndMacro
Structure UDPpacket Align #SDLALIGN
  channel.int
  *data.pUint8
  len.int
  maxlen.int
  status.int
  address.IPaddress
EndStructure
Macro r_UDPpacket: i :EndMacro
Macro rpp_UDPpacket: i :EndMacro
Structure Net_GenericSocket Align #SDLALIGN ;always pointer
  ready.int
EndStructure
Macro r_Net_GenericSocket: i :EndMacro
Structure TCPSocket:EndStructure
Macro r_TCPSocket: i :EndMacro
Structure UDPsocket:EndStructure
Macro r_UDPsocket: i :EndMacro
Structure Net_SocketSet:EndStructure
Macro r_Net_SocketSet: i :EndMacro
ImportC #SDL2_net_lib
  Net_Linked_Version.r_Net_version() As #FuncPrefix + "SDLNet_Linked_Version"
  Net_Init.int() As #FuncPrefix + "SDLNet_Init"
  Net_Quit.void() As #FuncPrefix + "SDLNet_Quit"
  Net_ResolveHost.int(*address.IPaddress, host.p-ascii, port.Uint16) As #FuncPrefix + "SDLNet_ResolveHost"
  _Net_ResolveIP.r_ascii(*ip.IPaddress) As #FuncPrefix + "SDLNet_ResolveIP"
  Macro Net_ResolveIP(ip): SDL::_GetAscii(SDL::_Net_ResolveIP(ip)) :EndMacro
  Net_GetLocalAddresses.int(*addresses.IPaddress, maxcount.int) As #FuncPrefix + "SDLNet_GetLocalAddresses"
  Net_TCP_Open.r_TCPsocket(*ip.IPaddress) As #FuncPrefix + "SDLNet_TCP_Open"
  Net_TCP_Accept.r_TCPsocket(*server.TCPsocket) As #FuncPrefix + "SDLNet_TCP_Accept"
  Net_TCP_GetPeerAddress.r_IPaddress(*sock.TCPsocket) As #FuncPrefix + "SDLNet_TCP_GetPeerAddress"
  Net_TCP_Send.int(*sock.TCPsocket, *data.pvoid, len.int) As #FuncPrefix + "SDLNet_TCP_Send"
  Net_TCP_Recv.int(*sock.TCPsocket, *data.pvoid, maxlen.int) As #FuncPrefix + "SDLNet_TCP_Recv"
  Net_TCP_Close.void(*sock.TCPsocket) As #FuncPrefix + "SDLNet_TCP_Close"
  Net_AllocPacket.r_UDPpacket(size.int) As #FuncPrefix + "SDLNet_AllocPacket"
  Net_ResizePacket.int(*packet.UDPpacket, newsize.int) As #FuncPrefix + "SDLNet_ResizePacket"
  Net_FreePacket.void(*packet.UDPpacket) As #FuncPrefix + "SDLNet_FreePacket"
  Net_AllocPacketV.rpp_UDPpacket(howmany.int, size.int) As #FuncPrefix + "SDLNet_AllocPacketV"
  Net_FreePacketV.void(*pp_packetV.UDPpacket) As #FuncPrefix + "SDLNet_FreePacketV"
  Net_UDP_Open.r_UDPsocket(port.Uint16) As #FuncPrefix + "SDLNet_UDP_Open"
  Net_UDP_SetPacketLoss.void(*sock.UDPsocket, percent.int) As #FuncPrefix + "SDLNet_UDP_SetPacketLoss"
  Net_UDP_Bind.int(*sock.UDPsocket, channel.int, *address.IPaddress) As #FuncPrefix + "SDLNet_UDP_Bind"
  Net_UDP_Unbind.void(*sock.UDPsocket, channel.int) As #FuncPrefix + "SDLNet_UDP_Unbind"
  Net_UDP_GetPeerAddress.r_IPaddress(*sock.UDPsocket, channel.int) As #FuncPrefix + "SDLNet_UDP_GetPeerAddress"
  Net_UDP_SendV.int(*sock.UDPsocket, *pp_packets.UDPpacket, npackets.int) As #FuncPrefix + "SDLNet_UDP_SendV"
  Net_UDP_Send.int(*sock.UDPsocket, channel.int, *packet.UDPpacket) As #FuncPrefix + "SDLNet_UDP_Send"
  Net_UDP_RecvV.int(*sock.UDPsocket, *pp_packets.UDPpacket) As #FuncPrefix + "SDLNet_UDP_RecvV"
  Net_UDP_Recv.int(*sock.UDPsocket, *packet.UDPpacket) As #FuncPrefix + "SDLNet_UDP_Recv"
  Net_UDP_Close.void(*sock.UDPsocket) As #FuncPrefix + "SDLNet_UDP_Close"
  Net_AllocSocketSet.r_Net_SocketSet(maxsockets.int) As #FuncPrefix + "SDLNet_AllocSocketSet"
  Net_AddSocket.int(*set.Net_SocketSet, *sock.Net_GenericSocket) As #FuncPrefix + "SDLNet_AddSocket"
  Macro Net_TCP_AddSocket(set,sock): SDL::Net_AddSocket(set, sock) :EndMacro
  Macro Net_UDP_AddSocket(set,sock): SDL::Net_AddSocket(set, sock) :EndMacro
  Net_DelSocket.int(*set.Net_SocketSet, *sock.Net_GenericSocket) As #FuncPrefix + "SDLNet_DelSocket"
  Macro Net_TCP_DelSocket(set,sock): SDL::Net_DelSocket(set,sock) :EndMacro
  Macro Net_UDP_DelSocket(set,sock): SDL::Net_DelSocket(set,sock) :EndMacro
  Net_CheckSockets.int(*set.Net_SocketSet, timeout.Uint32) As #FuncPrefix + "SDLNet_CheckSockets"
  Macro Net_SocketReady(sock): Bool (sock <> #Null And sock \ready) :EndMacro
  Net_FreeSocketSet.void(*set.Net_SocketSet) As #FuncPrefix + "SDLNet_FreeSocketSet"
  _Net_SetError.void() As #FuncPrefix + "SDLNet_SetError"
  Macro Net_SetError(err): SDL::_Call_SetError(err,sdl::@_Net_SetError()) : EndMacro
  _Net_GetError.r_ascii() As #FuncPrefix + "SDLNet_GetError"
  Macro Net_GetError(): SDL::_GetAscii(SDL::_Net_GetError()) :EndMacro
EndImport
Declare.void Net_Write16(value.uint16,*areap.puint16)
Declare.void Net_Write32(value.uint32,*areap.puint32)
Declare.uint16 Net_Read16(*areap.puint16)
Declare.uint32 Net_Read32(*areap.puint32)
;}
  CompilerEndIf
  Declare.t_bool _QuitRequested()
  CompilerIf #PB_Compiler_Debugger
    Define.sdl::version version
    Define.sdl::version *version
    Define ver
    sdl::GetVersion(version)
    ver = sdl::VERSIONNUM(version\major,version\minor,version\patch)
    If ver < sdl::#COMPILEDVERSION
      Debug "WARNING! outdateded SDL - expect "+ sdl::#COMPILEDVERSION +" got "+ ver
    EndIf
    CompilerIf SDL::#SDL_USE_MIXER
      *version= sdl::Mix_Linked_Version()
      ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
      If ver < sdl::#MIXER_COMPILEDVERSION
        Debug "WARNING! outdateded SDL_mixer - expect "+ sdl::#MIXER_COMPILEDVERSION +" got "+ ver        
      EndIf
    CompilerEndIf
    CompilerIf SDL::#SDL_USE_IMAGE
      *version= sdl::Img_Linked_Version()
      ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
      If ver < sdl::#IMAGE_COMPILEDVERSION
        Debug "WARNING! outdateded SDL_image - expect "+ sdl::#IMAGE_COMPILEDVERSION +" got "+ ver
      EndIf
    CompilerEndIf
    CompilerIf SDL::#SDL_USE_TTF
      *version= sdl::ttf_Linked_Version()
      ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
      If ver < sdl::#TTF_COMPILEDVERSION
        Debug "WARNING! outdateded SDL_ttf - expect "+ sdl::#TTF_COMPILEDVERSION +" got "+ ver
      EndIf
    CompilerEndIf
    CompilerIf SDL::#SDL_USE_NET
      *version= sdl::net_Linked_Version()
      ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
      If ver < sdl::#NET_COMPILEDVERSION
        Debug "WARNING! outdateded SDL_net - expect "+ sdl::#NET_COMPILEDVERSION +" got "+ ver
      EndIf
    CompilerEndIf
  CompilerEndIf
EndDeclareModule
Module SDL
  Procedure.t_AudioDeviceID OpenAudioDevice(device.s, iscapture.int, *desired.AudioSpec, *obtained.AudioSpec, allowed_changes.int)
    If device=""
      ProcedureReturn _OpenAudioDevice(0, iscapture, *desired, *obtained, allowed_changes)
    EndIf
    Protected *name=UTF8(device)
    Protected ret.t_AudioDeviceID = _OpenAudioDevice(*name, iscapture, *desired, *obtained, allowed_changes)    
    FreeMemory(*name)
    ProcedureReturn ret
  EndProcedure
  Procedure.t_bool _QuitRequested()
    SDL::PumpEvents()
    ProcedureReturn Bool(SDL::PeepEvents(#Null,0,SDL::#PEEKEVENT,SDL::#QUIT,SDL::#QUIT) > 0)
  EndProcedure
  Procedure.s MagicPeekS(*adr,len=-1,format=#PB_Unicode)
    If *adr
      ProcedureReturn PeekS(*adr,len,format)
    EndIf    
    ProcedureReturn ""
  EndProcedure
  Procedure.s _GetFreeAscii(*str)
    If *str=#Null
      ProcedureReturn ""
    EndIf
    Protected str.s=PeekS(*str,-1,#PB_Ascii)
    sdl::free(*str)
    ProcedureReturn str
  EndProcedure
  Procedure.s _GetFreeUTF8(*str)
    If *str=#Null
      ProcedureReturn ""
    EndIf
    Protected str.s=PeekS(*str,-1,#PB_UTF8)
    sdl::free(*str)
    ProcedureReturn str
  EndProcedure
  ;- sdl_endian.pbi
  Structure wordByte
    StructureUnion
      u.u
      a.a[2]
    EndStructureUnion
  EndStructure
  Structure longByte
    StructureUnion
      l.l
      a.a[4]
    EndStructureUnion
  EndStructure
  Structure quadByte
    StructureUnion
      q.q
      a.a[8]
    EndStructureUnion
  EndStructure
  Structure floatlong
    StructureUnion
      f.f
      l.l
    EndStructureUnion
  EndStructure
  Procedure.u Swap16(x.u)
    Protected *x.wordByte = @x
    Swap *x\a[0],*x\a[1]
    ProcedureReturn x
  EndProcedure
  Procedure.l Swap32(x.l)
    Protected *x.longByte = @x
    Swap *x\a[0],*x\a[3]
    Swap *x\a[1],*x\a[2]
    ProcedureReturn x
  EndProcedure
  Procedure.q Swap64(x.q)
    Protected *x.quadByte = @x
    Swap *x\a[0],*x\a[7]
    Swap *x\a[1],*x\a[6]
    Swap *x\a[2],*x\a[5]
    Swap *x\a[3],*x\a[4]    
    ProcedureReturn x
  EndProcedure
  Procedure.f SwapFloat(x.f)
    Protected *x.floatlong = @x
    *x\l= Swap32(*x\l)
    ProcedureReturn x
  EndProcedure
  Procedure.i _iif(a,b,c)
    If a
      ProcedureReturn b
    Else
      ProcedureReturn c
    EndIf
  EndProcedure
  Procedure.i max(a.i,b.i)
    If a>b
      ProcedureReturn a
    EndIf
    ProcedureReturn b
  EndProcedure
  Procedure.i min(a.i,b.i)
    If a<b
      ProcedureReturn a
    EndIf
    ProcedureReturn b
  EndProcedure
  CompilerIf #SDL_USE_NET
    Procedure.void Net_Write16(value.uint16,*areap.puint16)
      *areap\u = SDL::swapBE16(value)
    EndProcedure
    Procedure.void Net_Write32(value.uint32,*areap.puint32)
      *areap\l = sdl::swapBE32(value)
    EndProcedure
    Procedure.uint16 Net_Read16(*areap.puint16)
      ProcedureReturn SDL::swapBE16(*areap\u)
    EndProcedure
    Procedure.uint32 Net_Read32(*areap.puint32)
      ProcedureReturn SDL::swapBE32(*areap\l)
    EndProcedure
  CompilerEndIf
EndModule

; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 73
; FirstLine = 54
; Folding = -------------------------------------------------------------------------------------------------------------------
; EnableXP