


XIncludeFile "class.pbi"

;-Declare
DeclareModule renderer
  EnableExplicit
  
  #FrameRate_UseDesktop=-1
  Enumeration WinState
    #winStateHidden
    #winStateNormal
    #winStateMaximized
    #winStateMinimized
    #winStateFullScreen
  EndEnumeration
  
  #SDL_TEXTUREACCESS_STATIC = sdl::#TEXTUREACCESS_STATIC
  
  Interface Class Extends class::base
    CreateBlankTexture( w.l, h.l, ScaleQuality.l = 1, access.l=#SDL_TEXTUREACCESS_STATIC )
    LoadTexture( file.s, colorKeyRGB.l = -1, ScaleQuality.l = 1, access.l=#SDL_TEXTUREACCESS_STATIC ) 
    CompilerIf sdl::#SDL_USE_TTF
      RenderText( *sdl_font, Text.s, *sdl_color , ScaleQuality.l=1)
      RenderTextShaded( *sdl_font, Text.s, *fg_sdl_color, *bg_sdl_color, ScaleQuality.l=1)
      RenderTextBlended( *sdl_font, Text.s, *sdl_color , ScaleQuality.l=1)
      RenderTextBlendedWrapped( *sdl_font, Text.s, *sdl_color, Warp.l, ScaleQuality.l=1)
    CompilerEndIf
    
    doEvents( *sdlEvent )
    
    winGetState.l()
    winHasMouse.l()
    winHasKeyboard.l()  
    winGetId.l()
    winGetDisplayIndex.l()
    winGetBound( *minWidth.long=#Null, *minHeight.long=#Null, *maxWidth.long=#Null, *maxHeight.long=#Null)
    winSetBound( minWidth.l=#PB_Ignore, minHeight.l=#PB_Ignore, maxWidth.l=#PB_Ignore, maxHeight.l=#PB_Ignore)
    winGetOpacity.f()
    winSetOpacity(opacity.f)
    winGetPosition( *x.long=#Null, *y.long=#Null, *w.long=#Null, *h.long=#Null)
    winSetPosition( x.l=#PB_Ignore, y.l=#PB_Ignore, width=#PB_Ignore, height=#PB_Ignore)
    winGetTitle.s()
    winSetTitle(title.s)
    winSetState(state.l)
    winRaise()  
    
    MouseSetRelative(bool.l)
    MouseIsRelative.l()
    MouseSetLocked(bool.l)  
    MouseIsLocked.l()
    MouseShow(bool.l)
    MouseGet(*x.long,*y.long,*buttonBitMap.long)  
    
    SetDrawColor(r.a,g.a,b.a,a.a)
    Clear()
    Present()
    Show()
    
    SetFrameRate(hz.l)
    
    SetLogicalSize.l(w.l, h.l, quality=0)
    
    GetSize(*w.long,*h.long)
    GetLogicalSize(*w.long,*h.long)
    
    SetClip(*sdlrect)
    
    StartDrawing()
    EndDrawing()
    SetIntegerScale(bool.l)
    
    DrawLine.l(x1.l,y1.l,x2.l,y2.l)  
    DrawPoint.l(x1.l,y1.l)
    DrawRect.l(*sdlrect)
    DrawCircle.l(x.l,y.l,r.l)
  EndInterface
  Structure mClass Extends class::mBase
    *renderer
    *targetTexture
    renderW.l
    renderH.l
    targetW.l
    targetH.l
    *window
    windowId.l
    pixelformat.l
    targetRect.sdl::rect
    targetIntegerScale.l
    targetScale.f
    
    DisplayFPS.l
    TargetFPS.l
    TargetFPSms.d
    
    wastedMS.q
    
    winState.l
    winMouse.l
    winMouseMask.l
    winKey.l
    isFullscreen.l
    isLockedMouse.l
    isRelativMouse.l
    ignoreNextRelative.l
    isMouseVisible.l
    *firstTextureObj.mTexture
  EndStructure
  class::Announce(Class,(Titel.s, x.l, y.l, w.l, h.l, winFlag.l, renFlags.l) )
  Macro New(Titel, x, y, w, h, winFlag, renFlags)
    Object::New( Renderer::Class, (Titel, x, y, w, h, winFlag, renFlags) )
  EndMacro
  
  
  Interface Texture Extends class::Base
    Draw(x.l,y.l,w.l=0,h.l=0)
    Center(x.l,y.l)
    GetWidth.l()
    GetHeight.l()
    SetClip(x.l=-1,y.l=-1,w.l=-1,h.l=-1)
  EndInterface
  ;no announce, because Texture should not be created outside this module!
EndDeclareModule

;-Module
Module renderer
  Structure mTexture Extends class::mBase
    *renderer.mClass
    *texture.SDL::Texture
    format.l
    access.l
    w.l
    h.l
    clip.sdl::rect
    CompilerIf #PB_Compiler_Debugger
      *nextTextureObj.mTexture
    CompilerEndIf
  EndStructure
  
  
  class::Create( Texture,(*render,*texture) )
  class::Create( Class, (Titel.s, x.l, y.l, w.l, h.l, winFlag.l, renFlags.l) )
  
  CompilerIf #PB_Compiler_Debugger
    Procedure Class__AddTextureList(*self.mClass,*tex.mTexture)
      *tex\nextTextureObj = *self\firstTextureObj
      *self\firstTextureObj = *tex
    EndProcedure
  
  
    Procedure Class__DelTextureList(*self.mClass,*tex.mTexture)
      Protected.mTexture *cur = *self\firstTextureObj
      
      If *cur = *tex
        *self\firstTextureObj = *tex\nextTextureObj
        
      Else
        
        While *cur
          If *cur\nextTextureObj = *tex
            *cur\nextTextureObj = *tex\nextTextureObj
            Break
          EndIf    
          *cur = *cur\nextTextureObj
        Wend
        
      EndIf  
      
    EndProcedure
  CompilerElse
    Macro Class__AddTextureList(self,tex) : EndMacro
    Macro Class__DelTextureList(self,tex) : EndMacro
  CompilerEndIf
  
  class::Method Procedure.l Texture_Texture(*self.mTexture, *render,*texture)
    If *texture = #Null
      ProcedureReturn #False
    EndIf
    
    *self\renderer = *render
    *self\texture = *texture
    
    Class__AddTextureList(*render, *self)
    
    SDL::QueryTexture(*texture, @ *self\format, @ *self\access, @ *self\w, @ *self\h)
    *self\clip\x=0
    *self\clip\y=0
    *self\clip\w = *self\w
    *self\clip\h = *self\h
    ProcedureReturn #True
  EndProcedure
  
  class::Method Procedure Texture__delete(*self.mTexture)
    Class__DelTextureList(*self\renderer, *self)
    
    sdl::DestroyTexture(*self\texture)
    *self\texture=#Null
  EndProcedure
  
  class::Method Procedure.l Texture_GetWidth(*self.mTexture)
    ProcedureReturn *self\w
  EndProcedure
  class::Method Procedure.l Texture_GetHeight(*self.mTexture)
    ProcedureReturn *self\h
  EndProcedure
  class::Method Procedure Texture_Draw(*self.mTexture,x.l,y.l,w.l=0,h.l=0)
    Protected.sdl::rect destRect
    destRect\x=x:destRect\y=y
    If w=0 
      destRect\w=*self\clip\w
    Else
      destRect\w=w
    EndIf
    If h=0 
      destRect\h=*self\clip\h
    Else
      destRect\h=h
    EndIf
    SDL::RenderCopy(*self\renderer\renderer,*self\texture, *self\clip, destRect)
    
    ;   
    ;   sdl::SetRenderDrawColor(*self\renderer\renderer,255,255,255,255)
    ;    sdl::RenderDrawRect(*self\renderer\renderer,destRect)
    ;    Debug "dest:"+destRect\x+" "+destRect\y+" "+destRect\w+" "+destRect\h
    
  EndProcedure
  class::Method Procedure Texture_Center(*self.mTexture,x.l,y.l)
    Protected.sdl::rect destRect
    destRect\x = x - *self\clip\w / 2
    destRect\y = y - *self\clip\h / 2
    destRect\w=*self\clip\w:destRect\h=*self\clip\h
    SDL::RenderCopy(*self\renderer\renderer,*self\texture, *self\clip, destRect)
  EndProcedure
  class::Method Procedure Texture_SetClip(*self.mTexture,x.l=-1,y.l=-1,w.l=-1,h.l=-1)
    If x<0 Or y<0 Or w<=0 Or h<=0
      *self\clip\x = 0
      *self\clip\y = 0
      *self\clip\w = *self\w
      *self\clip\h = *self\h
    Else
      *self\clip\x = x
      *self\clip\y = y
      *self\clip\w = w
      *self\clip\h = h
    EndIf
  EndProcedure
  
  Declare Class__CreateTargetRect(*self.mClass)
  Declare Class__CheckRefresh(*self.mClass)
  
  class::Method Procedure.l Class__new(*self.mClass, Titel.s, x.l, y.l, w.l, h.l, winFlag=SDL::#WINDOW_ALLOW_HIGHDPI, renFlags.l=SDL::#RENDERER_ACCELERATED | SDL::#RENDERER_ACCELERATED | SDL::#RENDERER_TARGETTEXTURE)
    *self\window = SDL::CreateWindow(Titel, x, y, w, h, winflag)
    If *self\window = #Null
      ProcedureReturn #False
    EndIf
    
    *self\renderer = SDL::CreateRenderer( *self\window, -1, renFlags)
    If *self\renderer = #Null
      sdl::DestroyWindow(*self\window)
      ProcedureReturn #False
    EndIf
    *self\windowId = sdl::GetWindowID( *self\window )
    *self\pixelformat = SDL::GetWindowPixelFormat( *self\window )  
    
    *self\winMouseMask=#True
    *self\isMouseVisible=#True
    
    If renFlags & SDL::#RENDERER_PRESENTVSYNC
      *self\TargetFPS=0
    Else
      *self\TargetFPS=#FrameRate_UseDesktop
    EndIf
    
    *self\TargetFPSms=1
    
    
    Class__CreateTargetRect(*self)
    Class__CheckRefresh(*self)
    
    ProcedureReturn #True
  EndProcedure
  
  class::Method Procedure Class__delete(*self.mClass)
    Protected *cur.mTexture, *thisCur.Texture
    
    ; unload textures!
    CompilerIf #PB_Compiler_Debugger
      *cur = *self\firstTextureObj
      While *cur
        *thisCur=*cur
        *cur = *cur\nextTextureObj
        Debug "FOUND UNDELETED TEXTURE OBJECT!"
        Object::Delete(*thisCur)
      Wend      
    CompilerEndIf
    
    If *self\targetTexture
      SDL::DestroyTexture(*self\targetTexture)
      *self\targetTexture=#Null
    EndIf
    If *self\renderer
      sdl::DestroyRenderer(*self\renderer)
      *self\renderer=#Null
    EndIf    
    If *self\window
      sdl::DestroyWindow(*self\window)
      *self\window=#Null
    EndIf
  EndProcedure
  
  Procedure Class__CheckRefresh(*self.mClass)
    Protected.l DeskId
    Protected.SDL::DisplayMode DM
    
    *self\DisplayFPS = 0
    DeskId=SDL::GetWindowDisplayIndex(*self\window)  
    If DeskId>=0
      If SDL::GetDesktopDisplayMode(DeskId,DM) = 0
        *self\DisplayFPS = dm\refresh_rate
        
        If *self\TargetFPS = #FrameRate_UseDesktop
          If *self\DisplayFPS
            *self\TargetFPSms = 1000.0 / *self\DisplayFPS
          Else
            *self\TargetFPSms = 2
          EndIf
        EndIf      
        
      EndIf
      
    EndIf
    
  EndProcedure  
  Procedure Class__CreateTargetRect(*self.mClass)
    SDL::GetRendererOutputSize(*self\renderer,@ *self\renderW,@ *self\renderH)
    Protected.f sx,sy
    sx=*self\renderW / *self\targetW 
    sy=*self\renderH / *self\targetH
    If sx>sy
      *self\targetScale=sy
    Else
      *self\targetScale=sx
    EndIf
    If *self\targetIntegerScale And *self\targetScale>1
      *self\targetScale=Int(*self\targetScale)
    EndIf
    *self\targetRect\w = *self\targetW * *self\targetScale
    *self\targetRect\h = *self\targetH * *self\targetScale
    *self\targetRect\x = (*self\renderW - *self\targetRect\w) /2
    *self\targetRect\y = (*self\renderH - *self\targetRect\h) /2  
  EndProcedure
  Procedure Class__CheckRelativeMouse(*self.mClass)
    If *self\winKey
      If *self\isRelativMouse 
        If Not sdl::GetRelativeMouseMode()
          sdl::SetRelativeMouseMode(#True)
        EndIf
      Else
        If sdl::GetRelativeMouseMode()
          sdl::SetRelativeMouseMode(#False)
        EndIf
      EndIf
      
      If *self\isMouseVisible
        While sdl::ShowCursor(sdl::#QUERY) = sdl::#DISABLE
          sdl::ShowCursor(sdl::#ENABLE)
        Wend
      Else
        While sdl::ShowCursor(sdl::#QUERY) = sdl::#ENABLE
          sdl::ShowCursor(sdl::#DISABLE)
        Wend      
      EndIf
      
    EndIf
    *self\ignoreNextRelative=#True
  EndProcedure
  Procedure Class__MouseConvertLogical(*self.mClass,*x.long,*y.long)
    If *self\targetTexture
      *x\l =Int( (*x\l - *self\targetRect\x) / *self\targetScale)
      *y\l =Int( (*y\l - *self\targetRect\y) / *self\targetScale)
      
      If *x\l < 0 Or *x\l >= *self\targetW Or *y\l < 0 Or *y\l >= *self\targetH
        *x\l=-1
        *y\l=-1
      EndIf    
    EndIf
  EndProcedure  
  
  class::Method Procedure Class_SetFrameRate(*self.mClass,hz.l)
    *self\TargetFPS=hz
    If hz=0
      *self\TargetFPSms = 1
    ElseIf hz = #FrameRate_UseDesktop
      Class__CheckRefresh(*self)
    Else
      *self\TargetFPSms = 1000.0 / hz
    EndIf
    
  EndProcedure
  
  class::Method Procedure Class_doEvents(*self.mClass, *e.sdl::event )
    Protected.class this = *self
    Protected.l isMovedOrSized = #False
    If *e\type = sdl::#WINDOWEVENT And *e\window\windowID = *self\windowId
      Select *e\window\event 
        Case sdl::#WINDOWEVENT_SHOWN : *self\winState = #winStateNormal
        Case sdl::#WINDOWEVENT_HIDDEN : *self\winState = #winStateHidden
        Case sdl::#WINDOWEVENT_MINIMIZED : *self\winState= #winStateMinimized 
        Case sdl::#WINDOWEVENT_MAXIMIZED : *self\winState= #winStateMaximized : isMovedOrSized = #True
        Case sdl::#WINDOWEVENT_RESTORED : *self\winState= #winStateNormal : isMovedOrSized = #True
        Case sdl::#WINDOWEVENT_ENTER: *self\winMouse = #True 
        Case sdl::#WINDOWEVENT_LEAVE: *self\winMouse = #False 
        Case sdl::#WINDOWEVENT_FOCUS_GAINED: *self\winKey = #True
        Case sdl::#WINDOWEVENT_FOCUS_LOST: *self\winKey = #False
        Case SDL::#WINDOWEVENT_RESIZED : isMovedOrSized = #True
        Case SDL::#WINDOWEVENT_MOVED : isMovedOrSized = #True        
      EndSelect
      
      If isMovedOrSized
        Class__CheckRefresh(*self)
        Class__CreateTargetRect(*self)
      EndIf
      
      
      If *self\winKey<>#winStateHidden And *self\winKey<>#winStateMinimized
        Class__CheckRelativeMouse(*self)
      EndIf
    ElseIf (*e\type= sdl::#MOUSEBUTTONDOWN Or *e\type=sdl::#MOUSEBUTTONUP) And *e\button\windowID = *self\windowId
      Class__MouseConvertLogical(*self, @ *e\button\x, @ *e\button\y)
      
    ElseIf *e\type= sdl::#MOUSEMOTION And *e\motion\windowID = *self\windowId
      Class__MouseConvertLogical(*self, @ *e\motion\x, @ *e\motion\y)
      If *e\motion\x<0 Or *e\motion\y<0
        *self\winMouseMask=#False
      Else
        *self\winMouseMask=#True
      EndIf
      If *self\ignoreNextRelative
        *self\ignoreNextRelative=#False
        *e\motion\xrel=0
        *e\motion\yrel=0
      EndIf
      
    ElseIf *e\type= sdl::#KEYDOWN And *e\key\windowID = *self\windowId And
           *e\key\keysym\sym = sdl::#K_RETURN And *e\key\keysym\mod & sdl::#KMOD_ALT And *e\key\Repeat=0
      If *self\isFullscreen
        this\winSetState(#winStateNormal)
      Else
        this\winSetState(#winStateFullScreen)
      EndIf
      
    EndIf
    
  EndProcedure
  class::Method Procedure.l Class_winGetId(*self.mClass) : ProcedureReturn *self\windowId : EndProcedure
  class::Method Procedure.l Class_winGetState(*self.mClass) 
    If *self\isFullscreen
      ProcedureReturn #winStateFullScreen
    EndIf
    ProcedureReturn *self\winState
  EndProcedure
  class::Method Procedure.l Class_winHasMouse(*self.mClass) : ProcedureReturn *self\winMouse & *self\winMouseMask: EndProcedure
  class::Method Procedure.l Class_winHasKeyboard(*self.mClass) : ProcedureReturn *self\winKey : EndProcedure
  class::Method Procedure.l Class_winGetDisplayIndex(*self.mClass) : ProcedureReturn SDL::GetWindowDisplayIndex( *self\window ) : EndProcedure
  class::Method Procedure Class_winGetBound(*self.mClass, *minWidth.long, *minHeight.long, *maxWidth.long, *maxHeight.long)
    sdl::GetWindowMaximumSize(*self\window, *maxWidth, *maxHeight)
    sdl::GetWindowMinimumSize(*self\window, *minWidth, *minHeight)
  EndProcedure
  class::Method Procedure.f Class_winGetOpacity(*self.mClass)
    Protected ret.f 
    sdl::GetWindowOpacity(*self\window, @ ret)
    ProcedureReturn ret.f
  EndProcedure
  class::Method Procedure Class_winGetPosition( *self.mClass, *x.long=#Null, *y.long=#Null, *w.long=#Null, *h.long=#Null )
    SDL::GetWindowPosition( *self\window, *x, *y )
    SDL::GetWindowSize( *self\window, *w, *h)
  EndProcedure
  class::Method Procedure.s Class_winGetTitle( *self.mClass ) : ProcedureReturn SDL::GetWindowTitle( *self\window ) :EndProcedure
  class::Method Procedure Class_winSetState( *self.mClass, state.l )
    Select state
      Case #winStateHidden 
        If *self\isFullscreen
          SDL::SetWindowFullscreen(*self\window,0)
          *self\isFullscreen=#False
        EndIf
        If *self\winState=#winStateMaximized Or *self\winState=#winStateMinimized
          sdl::RestoreWindow(*self\window)       
        EndIf
        sdl::HideWindow(*self\window)
        
      Case #winStateMinimized 
        If *self\isFullscreen
          SDL::SetWindowFullscreen(*self\window,0)
          *self\isFullscreen=#False
        EndIf
        If *self\winState=#winStateHidden
          sdl::ShowWindow(*self\window)
        EndIf
        sdl::MinimizeWindow(*self\window)
        
      Case #winStateMaximized 
        If *self\isFullscreen
          SDL::SetWindowFullscreen(*self\window,0)
          *self\isFullscreen=#False
        EndIf
        If *self\winState=#winStateHidden
          sdl::ShowWindow(*self\window)
        EndIf
        sdl::MaximizeWindow(*self\window)
        
      Case #winStateNormal
        If *self\isFullscreen
          SDL::SetWindowFullscreen(*self\window,0)
          *self\isFullscreen=#False
        EndIf      
        If *self\winState=#winStateMaximized Or *self\winState=#winStateMinimized
          sdl::RestoreWindow(*self\window) 
        ElseIf *self\winState=#winStateHidden
          sdl::ShowWindow(*self\window)
        EndIf
        
      Case #winStateFullScreen
        If *self\winState=#winStateMaximized Or *self\winState=#winStateMinimized
          sdl::RestoreWindow(*self\window) 
        ElseIf *self\winState=#winStateHidden
          sdl::ShowWindow(*self\window)
        EndIf
        sdl::SetWindowFullscreen(*self\window, SDL::#WINDOW_FULLSCREEN_DESKTOP)     
        *self\isFullscreen = #True
    EndSelect
    
    If *self\winState <> #winStateHidden And *self\winState <> #winStateMinimized
      Class__CreateTargetRect(*self)
      Class__CheckRelativeMouse(*self)
    EndIf
    
  EndProcedure
  class::Method Procedure Class_winRaise( *self.mClass ) : sdl::RaiseWindow( *self\window ) :EndProcedure
  class::Method Procedure Class_winSetBound( *self.mClass, minWidth.l, minHeight.l, maxWidth.l, maxHeight.l)
    If maxWidth>=0 And maxHeight>0 : sdl::SetWindowMaximumSize(*self\window, maxWidth, maxHeight) : EndIf
    If minWidth>=0 And minHeight>0 : sdl::SetWindowMinimumSize(*self\window, minWidth, minHeight) : EndIf
  EndProcedure
  class::Method Procedure Class_winSetOpacity( *self.mClass, opacity.f ): Sdl::SetWindowOpacity( *self\window, opacity ) : EndProcedure
  class::Method Procedure Class_winSetPosition(  *self.mClass, x.l, y.l, width, height)
    If x<>#PB_Ignore And y<>#PB_Ignore
      sdl::SetWindowPosition( *self\window, x, y)
    EndIf
    If width>0 And height>0
      sdl::SetWindowSize( *self\window, width, height )
    EndIf
  EndProcedure
  class::Method Procedure Class_winSetTitle(*self.mClass, title.s): SDL::SetWindowTitle( *self\window, title ) : EndProcedure
  
  class::Method Procedure Class_mouseSetLocked(*self.mClass, bool.l)
    sdl::SetWindowGrab(*self\window, bool)
    *self\isLockedMouse=bool
  EndProcedure
  class::Method Procedure.l Class_mouseIsLocked(*self.mClass) : ProcedureReturn *self\isLockedMouse : EndProcedure
  class::Method Procedure Class_mouseSetRelative(*self.mClass, bool.l)
    *self\isRelativMouse = bool
    Class__CheckRelativeMouse(*self)
  EndProcedure
  class::Method Procedure.l Class_mouseIsRelative(*self.mClass) : ProcedureReturn *self\isRelativMouse : EndProcedure
  class::Method Procedure Class_MouseShow(*self.mClass,bool.l)
    *self\isMouseVisible=bool
    Class__CheckRelativeMouse(*self)
  EndProcedure
  class::Method Procedure Class_MouseGet(*self.mClass,*x.long,*y.long,*buttonBitMap.long)  
    *buttonBitMap\l = SDL::GetMouseState(*x,*y)
    Class__MouseConvertLogical(*self, *x, *y)
  EndProcedure
  
  class::Method Procedure.i Class_CreateBlankTexture(*self.mClass, w.l, h.l, ScaleQuality.l = 1, access.l=sdl::#TEXTUREACCESS_STATIC )
    Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
    Protected *tex = Object::New( Texture, (*self, SDL::CreateTexture(*self\renderer, *self\pixelformat, access, w, h) ) )
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
    ProcedureReturn *tex
  EndProcedure
  class::Method Procedure.i Class_LoadTexture(*self.mClass, file.s, colorKeyRGB.l = -1, ScaleQuality.l = 1, access.l=#SDL_TEXTUREACCESS_STATIC ) 
    Protected.s old
    Protected *TexObject
    CompilerIf SDL::#SDL_USE_IMAGE
      If colorKeyRGB = -1
        old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
        SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
        *TexObject = object::New( Texture, (*self, SDL::IMG_LoadTexture( *self\renderer, file)) )
        SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
        ProcedureReturn *TexObject
        
      EndIf      
      Protected.SDL::Surface *loadedSurface = SDL::IMG_Load( file )
    CompilerElse            
      Protected.SDL::Surface *loadedSurface = SDL::LoadBMP( file )
    CompilerEndIf
    
    If *loadedSurface = #Null
      ProcedureReturn #Null
    EndIf
    
    old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
    
    If colorKeyRGB<>-1
      SDL::SetColorKey(*loadedSurface, #True, SDL::MapRGB( *loadedSurface\format, Red(colorKeyRGB), Green(colorKeyRGB), Blue(colorKeyRGB) ) )
    EndIf
    
    *TexObject = Object::New( Texture, (*self, SDL::CreateTextureFromSurface( *self\renderer, *loadedSurface)) )
    
    
    sdl::FreeSurface( *loadedSurface)
    
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
    
    ProcedureReturn *TexObject
  EndProcedure    
  
  CompilerIf sdl::#SDL_USE_TTF
    class::Method Procedure.i Class_RenderText(*self.mClass, *sdl_font, Text.s, *sdl_color , ScaleQuality.l=1)
      Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
      Protected *surface =  SDL::TTF_RenderText_Solid(*sdl_font, Text, *sdl_color) 
      If *surface
        Protected *tex = Object::New( Texture, (*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) ) )
        
        sdl::FreeSurface(*surface)
      EndIf
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
      ProcedureReturn *tex
    EndProcedure
    class::Method Procedure.i Class_RenderTextShaded(*self.mClass, *sdl_font, Text.s, *fg_sdl_color, *bg_sdl_color, ScaleQuality.l=1)
      Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
      Protected *surface = SDL::TTF_RenderText_Shaded(*sdl_font, Text, *fg_sdl_color, *bg_sdl_color)
      If *surface
        Protected *tex = Object::New( Texture, (*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) ) )
        
        sdl::FreeSurface(*surface)
      EndIf
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
      ProcedureReturn *tex
    EndProcedure
    class::Method Procedure.i Class_RenderTextBlended(*self.mClass, *sdl_font, Text.s, *sdl_color , ScaleQuality.l=1)
      Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
      Protected *surface = SDL::TTF_RenderText_Blended(*sdl_font, Text, *sdl_color)
      If *surface
        Protected *tex = Object::New( Texture, (*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) ) )
        
        sdl::FreeSurface(*surface)
      EndIf
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
      ProcedureReturn *tex
    EndProcedure
    class::Method Procedure.i Class_RenderTextBlendedWrapped(*self.mClass, *sdl_font, Text.s, *sdl_color, Warp.l, ScaleQuality.l=1)
      Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
      Protected *surface = SDL::TTF_RenderText_Blended_Wrapped(*sdl_font, Text, *sdl_color,warp)
      If *surface
        Protected *tex = Object::New( Texture, (*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) ) )
        
        sdl::FreeSurface(*surface)
      EndIf
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
      ProcedureReturn *tex
    EndProcedure
  CompilerEndIf
  
  class::Method Procedure Class_SetClip(*self.mClass, *rect.sdl::rect)
    SDL::RenderSetClipRect(*self\renderer, *rect)
  EndProcedure
  
  class::Method Procedure Class_SetDrawColor(*self.mClass,r.a, g.a, b.a, a.a)
    SDL::SetRenderDrawColor(*self\renderer, r, g, b, a)
  EndProcedure
  
  class::Method Procedure Class_Clear(*self.mClass)
    SDL::RenderClear(*self\renderer)
  EndProcedure
  
  class::Method Procedure Class_Present(*self.mClass)
    SDL::RenderPresent(*self\renderer)
  EndProcedure
  class::Method Procedure.l Class_Show(*self.mClass)
    Static.q frameInMs=0
    Static.d TargetFPSTimer=-1
    Static.l TargetFPSTimerINT=0
    Protected.l ret
    Protected.l delay
    Protected.q wastedTimer=ElapsedMilliseconds()
    
    If *self\TargetFPS=0
      TargetFPSTimer=-1
    Else
      ;Free some CPU-Time
      Delay = TargetFPSTimerINT - ElapsedMilliseconds()-2
      If delay>0
        SDL::Delay(delay)
      EndIf  
      ;delay may not be accurate, so while-loop
      While TargetFPSTimerINT > ElapsedMilliseconds()
      Wend
    EndIf
    
    ;sdl - switch picture
    SDL::RenderPresent(*self\renderer)
    *self\wastedMS = ElapsedMilliseconds()-wastedTimer  
    
    ;calculate needed time for the last frame
    If frameInMs
      ret=ElapsedMilliseconds()-frameInMs
    Else
      ret=1
    EndIf
    frameInMs=ElapsedMilliseconds()
    
    If TargetFPSTimer<0
      ;Start TargetFPSTimer  
      TargetFPSTimer = ElapsedMilliseconds() + *self\TargetFPSms
      TargetFPSTimerINT = TargetFPSTimer
    Else
      ;find the next frame-timer
      While TargetFPSTimerINT <= ElapsedMilliseconds()
        TargetFPSTimer + *self\TargetFPSms
        TargetFPSTimerINT = TargetFPSTimer
      Wend
    EndIf
    
    ProcedureReturn ret
  EndProcedure
  
  class::Method Procedure.l Class_DrawLine(*self.mClass,x1.l,y1.l,x2.l,y2.l)
    ProcedureReturn SDL::RenderDrawLine(*self\renderer,x1,y1,x2,y2)
  EndProcedure
  
  class::Method Procedure.l Class_DrawPoint(*self.mClass,x1.l,y1.l)
    ProcedureReturn SDL::RenderDrawPoint(*self\renderer,x1,y1)
  EndProcedure
  
  class::Method Procedure.l Class_DrawRect(*self.mClass,*sdlrect)
    ProcedureReturn sdl::RenderDrawRect(*self\renderer,*sdlrect)
  EndProcedure
  
  Structure _sDrawCirclePoint
    *renderer
    cx.l
    cy.l
    x.l
    y.l
    oldy.l
  EndStructure
  
  Procedure Class__DrawCirclePoint(*d._sDrawCirclePoint)
    
    If *d\x = 0
      SDL::RenderDrawPoint( *d\renderer, *d\cx, *d\cy + *d\y )
      SDL::RenderDrawPoint( *d\renderer, *d\cx, *d\cy - *d\y)
      SDL::RenderDrawPoint( *d\renderer, *d\cx + *d\y, *d\cy)
      SDL::RenderDrawPoint( *d\renderer, *d\cx - *d\y, *d\cy)
    ElseIf *d\x = *d\y 
      SDL::RenderDrawPoint( *d\renderer, *d\cx + *d\x, *d\cy + *d\y)
      SDL::RenderDrawPoint( *d\renderer, *d\cx - *d\x, *d\cy + *d\y)
      SDL::RenderDrawPoint( *d\renderer, *d\cx + *d\x, *d\cy - *d\y)
      SDL::RenderDrawPoint( *d\renderer, *d\cx - *d\x, *d\cy - *d\y)
    ElseIf *d\x < *d\y 
      ;If oldy <> y
      
      SDL::RenderDrawPoint( *d\renderer, *d\cx + *d\x, *d\cy + *d\y)
      SDL::RenderDrawPoint( *d\renderer, *d\cx - *d\x, *d\cy + *d\y)
      SDL::RenderDrawPoint( *d\renderer, *d\cx + *d\x, *d\cy - *d\y)
      SDL::RenderDrawPoint( *d\renderer, *d\cx - *d\x, *d\cy - *d\y)
      ;EndIf
      ;oldy=y
      
      SDL::RenderDrawPoint( *d\renderer, *d\cx + *d\y, *d\cy + *d\x)
      SDL::RenderDrawPoint( *d\renderer, *d\cx - *d\y, *d\cy + *d\x)
      SDL::RenderDrawPoint( *d\renderer, *d\cx + *d\y, *d\cy - *d\x)
      SDL::RenderDrawPoint( *d\renderer, *d\cx - *d\y, *d\cy - *d\x)
      
    EndIf
  EndProcedure
  
  class::Method Procedure.l Class_DrawCircle(*self.mClass,xCenter.l,yCenter.l,radius.l)
    Protected d._sDrawCirclePoint
    d\cx=xCenter
    d\cy=yCenter
    d\x=0
    d\y=radius
    d\oldy=-radius
    d\renderer = *self\renderer
    
    Protected.l p=(5 - radius*4)/4
    Class__DrawCirclePoint( d )
    While d\x<d\y
      d\x+1
      If p<0
        p + (2*d\x+1)
      Else
        d\y-1
        p + (2*(d\x-d\y)+1)
      EndIf
      Class__DrawCirclePoint(d)
    Wend  
  EndProcedure
  
  class::Method Procedure.l Class_SetLogicalSize(*self.mClass, w.l, h.l, quality=0)
    If *self\targetTexture
      sdl::DestroyTexture(*self\targetTexture)
      *self\targetTexture=#Null
    EndIf
    
    If w>0 And h>0
      Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
      *self\targetW=w
      *self\targetH=h    
      Class__CreateTargetRect(*self)
      If *self\targetScale<1
        SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, "1")     
      Else
        SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(quality) )     
      EndIf
      
      *self\targetTexture=sdl::CreateTexture(*self\renderer, *self\pixelformat, SDL::#TEXTUREACCESS_TARGET,w,h)
      
      
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old)     
    EndIf  
  EndProcedure
  class::Method Procedure.l Class_GetSize(*self.mClass, *w.long, *h.long)
    *w\l=*self\renderW
    *h\l=*self\renderH
  EndProcedure
  class::Method Procedure.l Class_GetLogicalSize(*self.mClass, *w.long, *h.long)
    If *self\targetTexture
      *w\l=*self\targetW
      *h\l=*self\targetH
    Else
      *w\l=*self\renderW
      *h\l=*self\renderH
    EndIf
  EndProcedure
  
  
  class::Method Procedure Class_StartDrawing(*self.mClass)
    If *self\renderer
      SDL::SetRenderTarget(*self\renderer, *self\targetTexture)
    EndIf  
  EndProcedure
  
  class::Method Procedure Class_EndDrawing(*self.mClass)
    If *self\renderer
      SDL::SetRenderTarget(*self\renderer, #Null)
      SDL::RenderCopy(*self\renderer, *self\targetTexture, #Null, *self\targetRect)    
    EndIf  
  EndProcedure
  
  class::Method Procedure Class_SetIntegerScale(*self.mClass, bool.l)
    *self\targetIntegerScale=bool
    Class__CreateTargetRect(*self)
  EndProcedure
  
EndModule





; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 172
; FirstLine = 142
; Folding = -------------
; EnableXP