Module gl
  Procedure.l Init()
    Protected *adr
    Protected.l ret = #True
    Protected.l x,y
    SDL::GL_GetAttribute(SDL::#GL_CONTEXT_MAJOR_VERSION, @x)
    SDL::GL_GetAttribute(SDL::#GL_CONTEXT_MINOR_VERSION, @y)
    Protected.l version = sdl::VERSIONNUM(x,y,0)
    If _gl::#NEEDEDVERSION < version
      Debug "[OPENGL] NEEDEDVERSION < CONTEXT_MAJOR/MINOR_VERSION"
      ret=#False
    ElseIf _gl::#NEEDEDVERSION > version
      Debug "[OPENGL/INFO] NEEDEDVERSION > CONTEXT_MAJOR/MINOR_VERSION"
    EndIf
    ForEach _gl::functions()
      *adr = sdl::GL_GetProcAddress( _gl::functions()\name )
      If *adr = #Null Or *adr=1 Or *adr=2 Or *adr=3 Or *adr=-1
        If _gl::functions()\version And _gl::functions()\version <= version 
          Debug "[OpenGL] Function not found: "+ _gl::functions()\name 
          ret=#False
        EndIf
        *adr = #Null
      EndIf
      _gl::functions()\pointer\i = *adr
    Next
    ProcedureReturn ret
  EndProcedure
  Procedure Quit()
    ForEach _gl::functions()
      _gl::functions()\pointer\i = #Null
    Next
  EndProcedure
EndModule
