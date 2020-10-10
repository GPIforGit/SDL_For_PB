
XIncludeFile "../sdl2/SDL.pbi"
XIncludeFile "renderer.pbi"


EnableExplicit

#title="Relativ Mouse Movement"

Global.Renderer Render 

Procedure.l SDL_init(init.l, title.s, w.l, h.l, renw.l=0, renh.l=0, IntegerScale=#False)
  If 0 <> SDL::init(init)
    ProcedureReturn #False
  EndIf
  
  render=NewRenderer(title, sdl::#WINDOWPOS_CENTERED, sdl::#WINDOWPOS_CENTERED, w, h, 
                     sdl::#WINDOW_ALLOW_HIGHDPI | sdl::#WINDOW_RESIZABLE, 
                     SDL::#RENDERER_ACCELERATED |  SDL::#RENDERER_TARGETTEXTURE | SDL::#RENDERER_PRESENTVSYNC)
  
  If renw=#PB_Ignore
    renw=w
  EndIf
  If renh=#PB_Ignore
    renh=h
  EndIf  
  
  render\SetLogicalSize(renw,renh,1)
  render\SetIntegerScale(IntegerScale)
  
  If Not Render
    ProcedureReturn #False
  EndIf
    
  ProcedureReturn #True
EndProcedure

Procedure SDL_quit()
  DeleteObject(render)
  
  SDL::Quit()
EndProcedure


Procedure main()

  
  If  Not SDL_init( SDL::#INIT_EVENTS | SDL::#INIT_VIDEO , #title, 640, 400,0,0)
    MessageRequester(#title,"SDL Error" + #LF$ + SDL::GetError())
    End
  EndIf
  
  Protected WinEvent
  Protected.sdl::Event e
  Protected.l quit
  Protected.l relX,relY
  Protected.l mouseX,mouseY,MouseButton
  Protected.l w,h
  
   ;SDL::SetRelativeMouseMode(#True)
  
  
  ;Render\LockMouse(#True)
  
  render\MouseSetRelative(#True)
  ;render\MouseShow(#False)
  
  
  While Not quit
;     Repeat
;       Select WindowEvent()
;         Case 0 : Break
;         Case #PB_Event_CloseWindow : quit=#True
;       EndSelect
;     ForEver
    relx=0
    rely=0
    
      While SDL::PollEvent( e ) 
        render\doEvents(e);allways first!      
        
        Select e\type
          Case sdl::#quit
            quit=#True
            
          Case sdl::#MOUSEMOTION
            relx + e\motion\xrel
            rely + e\motion\yrel
            ;mousex = e\motion\x
            ;mousey = e\motion\y
            
          Case sdl::#KEYDOWN
            If e\key\windowID = Render\winGetId()
              Select e\key\keysym\scancode
                Case sdl::#SCANCODE_ESCAPE
                  ;                 If Render\MouseIsLocked()
                  ;                   render\MouseSetLocked(#False)
                  ;                 Else
                  ;                   render\MouseSetLocked(#True)
                  ;                 EndIf
                  
                  ;Debug render\MouseIsRelative()
                  If render\MouseIsRelative()
                    render\MouseSetRelative(#False)
                  Else
                    render\MouseSetRelative(#True)
                  EndIf
                  
              EndSelect            
            EndIf
            
        EndSelect
        
      Wend
    
    ;complete Screen
    render\SetDrawColor(128,0,0,255)
    render\Clear()
    
    ;drawing on logical!
    render\StartDrawing()
    render\SetDrawColor(0,0,0,255)
    render\Clear()
    
    If render\winHasKeyboard() And render\winHasMouse()
      render\GetSize( @ w,@ h )
      If render\MouseIsRelative()
        Render\SetDrawColor($ff,$ff,0,$ff)
        render\DrawLine(w/2,h/2, w/2+relx,h/2+rely)
      Else
        Render\MouseGet( @mouseX, @mouseY, @MouseButton )
        Render\SetDrawColor( $ff,0,$ff,$ff )
        render\DrawLine( w/2,h/2, MouseX, MouseY )      
      EndIf
    EndIf
    
    Render\EndDrawing(); <- includes flipping
    
    Render\Present()

    
  Wend
 
  
  SDL_QUIT()

  
  
EndProcedure

main()
  
  
  
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 1
; Folding = 0
; EnableXP
; DPIAware
; CurrentDirectory = ..\