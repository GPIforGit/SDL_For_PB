XIncludeFile "sdl2\SDL_mixer.pbi"
XIncludeFile "sdl2\SDL_image.pbi"
XIncludeFile "sdl2\SDL_ttf.pbi"
XIncludeFile "sdl2\SDL_net.pbi"


XIncludeFile "sdl2\SDL.pbi"


Define.sdl::version version
Define.sdl::version *version
Define ver
Define.s message


message = "SDL "+ sdl::#MAJOR_VERSION + "." + sdl::#MINOR_VERSION + "." + sdl::#PATCHLEVEL + #LF$

sdl::GetVersion(version)
message + "  linked version: " + version\major + "." + version\minor + "." + version\patch +" - "
ver = sdl::VERSIONNUM(version\major,version\minor,version\patch)
If ver < sdl::#COMPILEDVERSION
  message + "outdated" + #LF$ + #lf$
Else
  message + "ok" + #LF$ + #LF$
EndIf


CompilerIf SDL::#SDL_USE_MIXER
  message + "SDL_mixer "+ sdl::#MIX_MAJOR_VERSION + "." + sdl::#MIX_MINOR_VERSION + "." + sdl::#MIX_PATCHLEVEL + #LF$
  
  *version = sdl::Mix_Linked_Version()
  ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
  message + "  linked version: " + *version\major + "." + *version\minor + "." + *version\patch +" - "
  If ver < sdl::#MIXER_COMPILEDVERSION
    message + "outdated" + #LF$ + #LF$
  Else
    message + "ok" + #LF$ + #LF$
  EndIf
CompilerEndIf

CompilerIf SDL::#SDL_USE_IMAGE
  message + "SDL_image "+ sdl::#IMAGE_MAJOR_VERSION + "." + sdl::#IMAGE_MINOR_VERSION + "." + sdl::#IMAGE_PATCHLEVEL + #LF$
  
  *version = sdl::Img_Linked_Version()
  ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
  message + "  linked version: " + *version\major + "." + *version\minor + "." + *version\patch +" - "
  If ver < sdl::#IMAGE_COMPILEDVERSION
    message + "outdated" + #LF$ + #LF$
  Else
    message + "ok" + #LF$ + #LF$
  EndIf
CompilerEndIf

CompilerIf SDL::#SDL_USE_TTF
  message + "SDL_image "+ sdl::#TTF_MAJOR_VERSION + "." + sdl::#TTF_MINOR_VERSION + "." + sdl::#TTF_PATCHLEVEL + #LF$
  
  *version= sdl::ttf_Linked_Version()
  ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
  message + "  linked version: " + *version\major + "." + *version\minor + "." + *version\patch +" - "
  If ver < sdl::#TTF_COMPILEDVERSION
    message + "outdated" + #LF$ + #LF$
  Else
    message + "ok" + #LF$ + #LF$
  EndIf
CompilerEndIf

CompilerIf SDL::#SDL_USE_NET
  message+ "SDL_net "+ sdl::#NET_MAJOR_VERSION + "." + sdl::#NET_MINOR_VERSION + "." + sdl::#NET_PATCHLEVEL + #LF$
  
  *version= sdl::Net_Linked_Version()
  ver = sdl::VERSIONNUM(*version\major,*version\minor,*version\patch)
  message + "  linked version: " + *version\major + "." + *version\minor + "." + *version\patch +" - "
  If ver < sdl::#NET_COMPILEDVERSION
    message + "outdated" + #LF$ + #LF$
  Else
    message + "ok" + #LF$ + #LF$
  EndIf
CompilerEndIf

MessageRequester("SDL",message)

; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 21
; FirstLine = 14
; Folding = -
; EnableXP
; DisableDebugger