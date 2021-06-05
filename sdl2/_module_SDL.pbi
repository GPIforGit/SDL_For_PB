Module SDL
  Global OneOverPerformanceFrequency.d
  Procedure.int Init(flags.Uint32)
    Protected.int ret
    ret=_Init(flags)
    CompilerIf _SDL_Config::#GL_MAJOR_VERSION > 0
      SDL::GL_SetAttribute(SDL::#GL_CONTEXT_MAJOR_VERSION, _SDL_Config::#GL_MAJOR_VERSION)
      SDL::GL_SetAttribute(SDL::#GL_CONTEXT_MINOR_VERSION, _SDL_Config::#GL_MINOR_VERSION)
    CompilerEndIf
    If Not ret And flags & sdl::#INIT_TIMER
      OneOverPerformanceFrequency = 1 / sdl::GetPerformanceFrequency() 
      ;10000000
    EndIf    
    ProcedureReturn ret
  EndProcedure
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
  CompilerIf _SDL_Config::#UseNET
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
;-----------------------
;- ext_inl.pbi
;{

Procedure ext_Surface_FlipVertical(*sur.surface)
  If sdl::LockSurface(*sur) = 0
    Protected *buf = AllocateMemory(*sur\pitch)
    Protected *start = *sur\pixels
    Protected *end = *sur\pixels + (*sur\h - 1) * *sur\pitch
    Protected.l i
    For i=0 To *sur\h / 2 -1
      CopyMemory(*start, *buf, *sur\pitch)
      CopyMemory(*end, *start, *sur\pitch)
      CopyMemory(*buf, *end, *sur\pitch)
      *start + *sur\pitch
      *end - *sur\pitch
    Next    
    sdl::UnlockSurface(*sur)
    FreeMemory(*buf)
  EndIf
  ProcedureReturn *sur
EndProcedure
Procedure.d ext_GetElapsedSeconds()  
  ProcedureReturn sdl::GetPerformanceCounter() * OneOverPerformanceFrequency
EndProcedure
Procedure.d ext_DeltaSeconds(*Timer.ext_Timer, max.d = 1.0/15.0)  
  Protected.d value,ret 
  value = sdl::GetPerformanceCounter() * OneOverPerformanceFrequency
  ret = value - *Timer\oldvalue
  *timer\oldvalue = value
  If ret > max
    ProcedureReturn max
  EndIf  
  ProcedureReturn ret  
EndProcedure
Procedure ext_DeltaDelay(*timer.ext_Timer, delay.d)
  Protected.d value
  Repeat
    value = sdl::GetPerformanceCounter() * OneOverPerformanceFrequency
  Until value >= *timer\oldvalue
  *timer\oldvalue + delay
  If *timer\oldvalue < value
    *timer\oldvalue = value + delay
  EndIf
EndProcedure
;}
EndModule
