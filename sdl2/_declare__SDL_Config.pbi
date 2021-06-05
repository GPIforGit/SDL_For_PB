DeclareModule _SDL_Config
  Macro dquote
    "
  EndMacro
  Macro SetConst(name,value)
    CompilerIf Not Defined(SDL_Config:: name,#PB_Constant)
      #name = value
      ;Debug "SET" + dquote name dquote + "to default "+ value
    CompilerElse
      #name=SDL_Config::#name
      ;Debug "SET" + dquote name dquote + "to config "+ SDL_Config::#name
    CompilerEndIf
  EndMacro
  SetConst(GL_MAJOR_VERSION,0)
  SetConst(GL_MINOR_VERSION,0)
  SetConst(MAJOR_VERSION,2)
  SetConst(MINOR_VERSION,0)
  SetConst(PATCHLEVEL,14)
  SetConst(UseImage,#False)
  SetConst(UseMixer,#False)
  SetConst(UseTTF,#False)
  SetConst(UseNet,#False)
EndDeclareModule
