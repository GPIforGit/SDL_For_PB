
#FrameRate_UseDesktop=-1

XIncludeFile "class.pbi"

Enumeration WinState
  #winStateHidden
  #winStateNormal
  #winStateMaximized
  #winStateMinimized
  #winStateFullScreen
EndEnumeration

#SDL_TEXTUREACCESS_STATIC = sdl::#TEXTUREACCESS_STATIC

Interface Renderer Extends _baseclass
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
   
  SetDrawColor(r.a,b.a,g.a,a.a)
  Clear()
  Present()
  Show()
  
  SetFrameRate(hz.l)
    
  SetLogicalSize.l(w.l, h.l, quality=0)
  
  GetSize(*w.long,*h.long)
  GetLogicalSize(*w.long,*h.long)
  
  StartDrawing()
  EndDrawing()
  SetIntegerScale(bool.l)
  
  DrawLine.l(x1.l,y1.l,x2.l,y2.l)  
  DrawPoint.l(x1.l,y1.l)
  DrawRect.l(*sdlrect)
  DrawCircle.l(x.l,y.l,r.l)
EndInterface
Structure sRenderer Extends _sbaseclass
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
  
  
  winState.l
  winMouse.l
  winMouseMask.l
  winKey.l
  isFullscreen.l
  isLockedMouse.l
  isRelativMouse.l
  ignoreNextRelative.l
  isMouseVisible.l
  *firstTextureObj.sTexture
EndStructure
Declare NewRenderer(Titel.s, x.l, y.l, w.l, h.l, winFlag.l, renFlags.l)
CreateClass(Renderer, (Titel.s, x.l, y.l, w.l, h.l, winFlag.l, renFlags.l) )

Interface Texture Extends _baseclass
  Draw(x.l,y.l)
  Center(x.l,y.l)
  GetWidth.l()
  GetHeight.l()
  SetClip(x.l=-1,y.l=-1,w.l=-1,h.l=-1)
EndInterface
Structure sTexture Extends _sBaseclass
  *renderer.sRenderer
  *texture.SDL::Texture
  format.l
  access.l
  w.l
  h.l
  clip.sdl::rect
  *nextTextureObj.sTexture
EndStructure
CreateClass( Texture,(*render,*texture) )

Procedure Renderer__AddTextureList(*self.sRenderer,*tex.sTexture)
  *tex\nextTextureObj = *self\firstTextureObj
  *self\firstTextureObj = *tex
EndProcedure

Procedure Renderer__DelTextureList(*self.sRenderer,*tex.sTexture)
  Protected.sTexture *cur = *self\firstTextureObj

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
  
class Procedure.l Texture__new(*self.sTexture, *render,*texture)
  If *texture = #Null
    ProcedureReturn #False
  EndIf
  
  *self\renderer = *render
  *self\texture = *texture
  
  Renderer__AddTextureList(*render, *self)
  
  SDL::QueryTexture(*texture, @ *self\format, @ *self\access, @ *self\w, @ *self\h)
  *self\clip\x=0
  *self\clip\y=0
  *self\clip\w = *self\w
  *self\clip\h = *self\h
  ProcedureReturn #True
EndProcedure

class Procedure Texture__delete(*self.sTexture)
  Renderer__DelTextureList(*self\renderer, *self)
  
  sdl::DestroyTexture(*self\texture)
  *self\texture=#Null
EndProcedure

class Procedure.l Texture_GetWidth(*self.sTexture)
  ProcedureReturn *self\w
EndProcedure
class Procedure.l Texture_GetHeight(*self.sTexture)
  ProcedureReturn *self\h
EndProcedure
class Procedure Texture_Draw(*self.sTexture,x.l,y.l)
  Protected.sdl::rect destRect
  destRect\x=x:destRect\y=y:destRect\w=*self\clip\w:destRect\h=*self\clip\h
  SDL::RenderCopy(*self\renderer\renderer,*self\texture, *self\clip, destRect)
EndProcedure
class Procedure Texture_Center(*self.sTexture,x.l,y.l)
  Protected.sdl::rect destRect
  destRect\x = x - *self\clip\w / 2
  destRect\y = y - *self\clip\h / 2
  destRect\w=*self\clip\w:destRect\h=*self\clip\h
  SDL::RenderCopy(*self\renderer\renderer,*self\texture, *self\clip, destRect)
EndProcedure
class Procedure Texture_SetClip(*self.sTexture,x.l=-1,y.l=-1,w.l=-1,h.l=-1)
  If x<0 Or y<0 Or w<0 Or h<0
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

Declare Renderer__CreateTargetRect(*self.sRenderer)
Declare Renderer__CheckRefresh(*self.sRenderer)
 
class Procedure.l Renderer__new(*self.sRenderer, Titel.s, x.l, y.l, w.l, h.l, winFlag=SDL::#WINDOW_ALLOW_HIGHDPI, renFlags.l=SDL::#RENDERER_ACCELERATED | SDL::#RENDERER_PRESENTVSYNC | SDL::#RENDERER_TARGETTEXTURE)
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
  
  
  Renderer__CreateTargetRect(*self)
  Renderer__CheckRefresh(*self)
  
  ProcedureReturn #True
EndProcedure

class Procedure Renderer__delete(*self.sRenderer)
  Protected *cur.sTexture, *thisCur.Texture
  
  ; unload textures!
  *cur = *self\firstTextureObj
  While *cur
    *thisCur=*cur
    *cur = *cur\nextTextureObj
    Debug "FOUND UNDELETED TEXTURE OBJECT!"
    DeleteObject(*thisCur)
  Wend      
  
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

Procedure Renderer__CheckRefresh(*self.sRenderer)
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
Procedure Renderer__CreateTargetRect(*self.sRenderer)
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
Procedure Renderer__CheckRelativeMouse(*self.sRenderer)
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
Procedure Renderer__MouseConvertLogical(*self.sRenderer,*x.long,*y.long)
  If *self\targetTexture
    *x\l =Int( (*x\l - *self\targetRect\x) / *self\targetScale)
    *y\l =Int( (*y\l - *self\targetRect\y) / *self\targetScale)
    
    If *x\l < 0 Or *x\l >= *self\targetW Or *y\l < 0 Or *y\l >= *self\targetH
      *x\l=-1
      *y\l=-1
    EndIf    
  EndIf
EndProcedure  

class Procedure Renderer_SetFrameRate(*self.sRenderer,hz.l)
  *self\TargetFPS=hz
  If hz=0
    *self\TargetFPSms = 1
  ElseIf hz = #FrameRate_UseDesktop
    Renderer__CheckRefresh(*self)
  Else
    *self\TargetFPSms = 1000.0 / hz
  EndIf
  
EndProcedure
  
class Procedure Renderer_doEvents(*self.sRenderer, *e.sdl::event )
  Protected.renderer this = *self
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
      Renderer__CheckRefresh(*self)
      Renderer__CreateTargetRect(*self)
    EndIf
    
    
    If *self\winKey<>#winStateHidden And *self\winKey<>#winStateMinimized
      Renderer__CheckRelativeMouse(*self)
    EndIf
  ElseIf (*e\type= sdl::#MOUSEBUTTONDOWN Or *e\type=sdl::#MOUSEBUTTONUP) And *e\button\windowID = *self\windowId
    Renderer__MouseConvertLogical(*self, @ *e\button\x, @ *e\button\y)
    
  ElseIf *e\type= sdl::#MOUSEMOTION And *e\motion\windowID = *self\windowId
    Renderer__MouseConvertLogical(*self, @ *e\motion\x, @ *e\motion\y)
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
class Procedure.l Renderer_winGetId(*self.sRenderer) : ProcedureReturn *self\windowId : EndProcedure
class Procedure.l Renderer_winGetState(*self.sRenderer) 
  If *self\isFullscreen
    ProcedureReturn #winStateFullScreen
  EndIf
  ProcedureReturn *self\winState
EndProcedure
class Procedure.l Renderer_winHasMouse(*self.sRenderer) : ProcedureReturn *self\winMouse & *self\winMouseMask: EndProcedure
class Procedure.l Renderer_winHasKeyboard(*self.sRenderer) : ProcedureReturn *self\winKey : EndProcedure
class Procedure.l Renderer_winGetDisplayIndex(*self.sRenderer) : ProcedureReturn SDL::GetWindowDisplayIndex( *self\window ) : EndProcedure
class Procedure Renderer_winGetBound(*self.sRenderer, *minWidth.long, *minHeight.long, *maxWidth.long, *maxHeight.long)
  sdl::GetWindowMaximumSize(*self\window, *maxWidth, *maxHeight)
  sdl::GetWindowMinimumSize(*self\window, *minWidth, *minHeight)
EndProcedure
class Procedure.f Renderer_winGetOpacity(*self.sRenderer)
  Protected ret.f 
  sdl::GetWindowOpacity(*self\window, @ ret)
  ProcedureReturn ret.f
EndProcedure
class Procedure Renderer_winGetPosition( *self.sRenderer, *x.long=#Null, *y.long=#Null, *w.long=#Null, *h.long=#Null )
  SDL::GetWindowPosition( *self\window, *x, *y )
  SDL::GetWindowSize( *self\window, *w, *h)
EndProcedure
class Procedure.s Renderer_winGetTitle( *self.sRenderer ) : ProcedureReturn SDL::GetWindowTitle( *self\window ) :EndProcedure
class Procedure Renderer_winSetState( *self.sRenderer, state.l )
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
    Renderer__CreateTargetRect(*self)
    Renderer__CheckRelativeMouse(*self)
  EndIf
  
EndProcedure
class Procedure Renderer_winRaise( *self.sRenderer ) : sdl::RaiseWindow( *self\window ) :EndProcedure
class Procedure Renderer_winSetBound( *self.sRenderer, minWidth.l, minHeight.l, maxWidth.l, maxHeight.l)
  If maxWidth>=0 And maxHeight>0 : sdl::SetWindowMaximumSize(*self\window, maxWidth, maxHeight) : EndIf
  If minWidth>=0 And minHeight>0 : sdl::SetWindowMinimumSize(*self\window, minWidth, minHeight) : EndIf
EndProcedure
class Procedure Renderer_winSetOpacity( *self.sRenderer, opacity.f ): Sdl::SetWindowOpacity( *self\window, opacity ) : EndProcedure
class Procedure Renderer_winSetPosition(  *self.sRenderer, x.l, y.l, width, height)
  If x<>#PB_Ignore And y<>#PB_Ignore
    sdl::SetWindowPosition( *self\window, x, y)
  EndIf
  If width>0 And height>0
    sdl::SetWindowSize( *self\window, width, height )
  EndIf
EndProcedure
class Procedure Renderer_winSetTitle(*self.sRenderer, title.s): SDL::SetWindowTitle( *self\window, title ) : EndProcedure

class Procedure Renderer_mouseSetLocked(*self.sRenderer, bool.l)
  sdl::SetWindowGrab(*self\window, bool)
  *self\isLockedMouse=bool
EndProcedure
class Procedure.l Renderer_mouseIsLocked(*self.sRenderer) : ProcedureReturn *self\isLockedMouse : EndProcedure
class Procedure renderer_mouseSetRelative(*self.srenderer, bool.l)
  *self\isRelativMouse = bool
  Renderer__CheckRelativeMouse(*self)
EndProcedure
class Procedure.l Renderer_mouseIsRelative(*self.sRenderer) : ProcedureReturn *self\isRelativMouse : EndProcedure
class Procedure Renderer_MouseShow(*self.sRenderer,bool.l)
  *self\isMouseVisible=bool
  Renderer__CheckRelativeMouse(*self)
EndProcedure
class Procedure Renderer_MouseGet(*self.sRenderer,*x.long,*y.long,*buttonBitMap.long)  
  *buttonBitMap\l = SDL::GetMouseState(*x,*y)
  Renderer__MouseConvertLogical(*self, *x, *y)
EndProcedure

class Procedure.i Renderer_CreateBlankTexture(*self.sRenderer, w.l, h.l, ScaleQuality.l = 1, access.l=sdl::#TEXTUREACCESS_STATIC )
  Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
  SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
  Protected *tex = NewTexture(*self, SDL::CreateTexture(*self\renderer, *self\pixelformat, access, w, h) )
  SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
  ProcedureReturn *tex
EndProcedure
class Procedure.i Renderer_LoadTexture(*self.sRenderer, file.s, colorKeyRGB.l = -1, ScaleQuality.l = 1, access.l=#SDL_TEXTUREACCESS_STATIC ) 
  CompilerIf SDL::#SDL_USE_IMAGE
    Protected.SDL::Surface *loadedSurface = SDL::IMG_Load( file )
  CompilerElse
    Protected.SDL::Surface *loadedSurface = SDL::LoadBMP( file )
  CompilerEndIf
  If *loadedSurface = #Null
    ProcedureReturn #Null
  EndIf
  
  Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
  SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
  
  If colorKeyRGB<>-1
    SDL::SetColorKey(*loadedSurface, #True, SDL::MapRGB( *loadedSurface\format, Red(colorKeyRGB), Green(colorKeyRGB), Blue(colorKeyRGB) ) )
  EndIf
  
  Protected *TexObject = NewTexture(*self, SDL::CreateTextureFromSurface( *self\renderer, *loadedSurface))
  
  
  sdl::FreeSurface( *loadedSurface)
  
  SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
  
  ProcedureReturn *TexObject
EndProcedure    

CompilerIf sdl::#SDL_USE_TTF
  class Procedure.i Renderer_RenderText(*self.sRenderer, *sdl_font, Text.s, *sdl_color , ScaleQuality.l=1)
    Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
    Protected *surface =  SDL::TTF_RenderText_Solid(*sdl_font, Text, *sdl_color) 
    If *surface
      Protected *tex = NewTexture(*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) )
      
      sdl::FreeSurface(*surface)
    EndIf
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
    ProcedureReturn *tex
  EndProcedure
  class Procedure.i Renderer_RenderTextShaded(*self.sRenderer, *sdl_font, Text.s, *fg_sdl_color, *bg_sdl_color, ScaleQuality.l=1)
    Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
    Protected *surface = SDL::TTF_RenderText_Shaded(*sdl_font, Text, *fg_sdl_color, *bg_sdl_color)
    If *surface
      Protected *tex = NewTexture(*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) )
      
      sdl::FreeSurface(*surface)
    EndIf
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
    ProcedureReturn *tex
  EndProcedure
  class Procedure.i Renderer_RenderTextBlended(*self.sRenderer, *sdl_font, Text.s, *sdl_color , ScaleQuality.l=1)
    Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
    Protected *surface = SDL::TTF_RenderText_Blended(*sdl_font, Text, *sdl_color)
    If *surface
      Protected *tex = NewTexture(*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) )
      
      sdl::FreeSurface(*surface)
    EndIf
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
    ProcedureReturn *tex
  EndProcedure
  class Procedure.i Renderer_RenderTextBlendedWrapped(*self.sRenderer, *sdl_font, Text.s, *sdl_color, Warp.l, ScaleQuality.l=1)
    Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(ScaleQuality) )
    Protected *surface = SDL::TTF_RenderText_Blended_Wrapped(*sdl_font, Text, *sdl_color,warp)
    If *surface
      Protected *tex = NewTexture(*self, SDL::CreateTextureFromSurface(*self\renderer,*surface) )
      
      sdl::FreeSurface(*surface)
    EndIf
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old )
    ProcedureReturn *tex
  EndProcedure
CompilerEndIf



class Procedure Renderer_SetDrawColor(*self.sRenderer,r.a, b.a, g.a, a.a)
  SDL::SetRenderDrawColor(*self\renderer, r, g, b, a)
EndProcedure

class Procedure Renderer_Clear(*self.sRenderer)
  SDL::RenderClear(*self\renderer)
EndProcedure

class Procedure Renderer_Present(*self.sRenderer)
  SDL::RenderPresent(*self\renderer)
EndProcedure
class Procedure.l Renderer_Show(*self.sRenderer)
  Static.q frameInMs=0
  Static.d TargetFPSTimer=-1
  Static.l TargetFPSTimerINT=0
  Protected.l ret
  Protected.l delay
  
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

class Procedure.l Renderer_DrawLine(*self.sRenderer,x1.l,y1.l,x2.l,y2.l)
  ProcedureReturn SDL::RenderDrawLine(*self\renderer,x1,y1,x2,y2)
EndProcedure

class Procedure.l Renderer_DrawPoint(*self.sRenderer,x1.l,y1.l)
  ProcedureReturn SDL::RenderDrawPoint(*self\renderer,x1,y1)
EndProcedure

class Procedure.l Renderer_DrawRect(*self.sRenderer,*sdlrect)
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
  
Procedure Renderer__DrawCirclePoint(*d._sDrawCirclePoint)
  
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

class Procedure.l Renderer_DrawCircle(*self.sRenderer,xCenter.l,yCenter.l,radius.l)
  Protected d._sDrawCirclePoint
  d\cx=xCenter
  d\cy=yCenter
  d\x=0
  d\y=radius
  d\oldy=-radius
  d\renderer = *self\renderer
  
  Protected.l p=(5 - radius*4)/4
  Renderer__DrawCirclePoint( d )
  While d\x<d\y
    d\x+1
    If p<0
      p + (2*d\x+1)
    Else
      d\y-1
      p + (2*(d\x-d\y)+1)
    EndIf
    Renderer__DrawCirclePoint(d)
  Wend  
EndProcedure

class Procedure.l Renderer_SetLogicalSize(*self.sRenderer, w.l, h.l, quality=0)
  If *self\targetTexture
    sdl::DestroyTexture(*self\targetTexture)
    *self\targetTexture=#Null
  EndIf
  
  ;-
  ;- quality ist hier unsinn, da sich die Größe ändern kann!
  ;-
  If w>0 And h>0
    Protected.s old = SDL::GetHint( SDL::#HINT_RENDER_SCALE_QUALITY )
    *self\targetW=w
    *self\targetH=h    
    Renderer__CreateTargetRect(*self)
    If *self\targetScale<1
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, "1")     
    Else
      SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, Str(quality) )     
    EndIf
    
    *self\targetTexture=sdl::CreateTexture(*self\renderer, *self\pixelformat, SDL::#TEXTUREACCESS_TARGET,w,h)
    
    
    SDL::SetHint( SDL::#HINT_RENDER_SCALE_QUALITY, old)     
  EndIf  
EndProcedure
class Procedure.l Renderer_GetSize(*self.sRenderer, *w.long, *h.long)
  *w\l=*self\renderW
  *h\l=*self\renderH
EndProcedure
class Procedure.l Renderer_GetLogicalSize(*self.sRenderer, *w.long, *h.long)
  If *self\targetTexture
    *w\l=*self\targetW
    *h\l=*self\targetH
  Else
    *w\l=*self\renderW
    *h\l=*self\renderH
  EndIf
  Debug ""+ *w\l+" "+*h\l
EndProcedure
    

class Procedure Renderer_StartDrawing(*self.sRenderer)
  If *self\renderer
    SDL::SetRenderTarget(*self\renderer, *self\targetTexture)
  EndIf  
EndProcedure

class Procedure Renderer_EndDrawing(*self.sRenderer)
  If *self\renderer
    SDL::SetRenderTarget(*self\renderer, #Null)
    SDL::RenderCopy(*self\renderer, *self\targetTexture, #Null, *self\targetRect)    
  EndIf  
EndProcedure

class Procedure Renderer_SetIntegerScale(*self.sRenderer, bool.l)
  *self\targetIntegerScale=bool
  Renderer__CreateTargetRect(*self)
EndProcedure





; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 5
; Folding = -BH4RVl-668
; EnableXP