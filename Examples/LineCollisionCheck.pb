EnableExplicit

XIncludeFile "../sdl2/SDL.pbi"
XIncludeFile "renderer.pbi"
XIncludeFile "Collision.pbi"





#title="Line Collision Check"

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
  
  If renw<>0 And renh<>0
    render\winSetBound(renw,renh)
  EndIf
  
  
  render\SetLogicalSize(renw,renh,0)
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

Enumeration state
  #state_line1p1
  #state_line1p2
  #state_line2p1
  #state_line2p2
  #state_sline
EndEnumeration



Procedure main()

  
  If  Not SDL_init( SDL::#INIT_EVENTS | SDL::#INIT_VIDEO , #title, 320*3, 200*3, 320,200,0 )
    MessageRequester(#title,"SDL Error" + #LF$ + SDL::GetError())
    End
  EndIf
  
  Protected WinEvent
  Protected.sdl::Event e
  Protected.l quit
  Protected.l relX,relY
  ;Protected.l mouseX,mouseY
  Protected.l MouseButton
  Protected.l w,h
  Protected.sLine line1,line2, sline1,sline2
  Protected.spoint point
  Protected.l col
  Protected.sRect rect
  rect\x=10:rect\y=10:rect\w=15:rect\h=25
  
   ;SDL::SetRelativeMouseMode(#True)
  
  
  ;Render\LockMouse(#True)
  
  ;render\MouseSetRelative(#True)
  ;render\MouseShow(#False)
  
  Protected.l state
  
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
            
          
            
          Case sdl::#MOUSEBUTTONDOWN
            If e\button\windowID = render\winGetId() 
              If e\button\button = sdl::#BUTTON_LEFT
                Select state
                  Case #state_line1p1
                    line1\p1\x = e\button\x
                    line1\p1\y = e\button\y
                    state=#state_line1p2
                    
                  Case #state_line1p2
                    line1\p2\x = e\button\x
                    line1\p2\y = e\button\y
                    CalculateLineFormula(line1)
                    state=#state_line2p1
                    
                  Case #state_line2p1
                    line2\p1\x = e\button\x
                    line2\p1\y = e\button\y
                    state=#state_line2p2
                    
                  Case #state_line2p2
                    line2\p2\x = e\button\x
                    line2\p2\y = e\button\y
                    CalculateLineFormula(line2)
                    state = #state_sline
                    
                  Default
                    state=#state_line1p1
                EndSelect
              ElseIf e\button\button = sdl::#BUTTON_RIGHT
                state-1
                If state<0
                  state=0
                EndIf
              EndIf
              
            EndIf
            
          Case sdl::#KEYDOWN
            If e\key\windowID = Render\winGetId()
              Select e\key\keysym\scancode
                Case sdl::#SCANCODE_ESCAPE
                  ;                 If Render\MouseIsLocked()
                  ;                   render\MouseSetLocked(#False)
                  ;                 Else
                  ;                   render\MouseSetLocked(#True)
                  ;                 EndIf
                                                      
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
      
      Select state
        Case #state_line1p1
          render\MouseGet( @ line1\p1\x, @ line1\p1\y, @ MouseButton )
          If PointOnRectWH(line1\p1, rect)
            render\SetDrawColor(255,0,0,255)
          Else
            render\SetDrawColor(0,255,0,255)
          EndIf
          render\DrawRect(rect)
          
          render\SetDrawColor(0,0,255,128)
          render\DrawPoint( line1\p1\x, line1\p1\y )
                                    
        Case #state_line1p2
          render\MouseGet( @ line1\p2\x, @ line1\p2\y, @ MouseButton )
          CalculateLineFormula(line1)          
          If lineOnRectWH(line1, rect)
            render\SetDrawColor(255,0,0,255)
          Else
            render\SetDrawColor(0,255,0,255)
          EndIf
          render\DrawRect(rect)
          
          render\SetDrawColor(0,0,255,255)
          render\DrawLine( line1\p1\x, line1\p1\y, line1\p2\x, line1\p2\y)
                  
        Case #state_line2p1
          render\MouseGet( @ line2\p1\x, @ line2\p1\y, @ MouseButton )
          If PointOnRectWH(line2\p1, rect)
            render\SetDrawColor(255,0,0,255)
          Else
            render\SetDrawColor(0,255,0,255)
          EndIf
          render\DrawRect(rect)
          
          If PointOnLine(line1, line2\p1)
            render\SetDrawColor(255,0,0,255)
          Else
            render\SetDrawColor(0,255,0,255)
          EndIf
          render\DrawLine( line1\p1\x, line1\p1\y, line1\p2\x, line1\p2\y)
          render\SetDrawColor(255*col,0,255,255)
          render\DrawPoint( line2\p1\x, line2\p1\y )            
          
        Case #state_line2p2
          render\MouseGet( @ line2\p2\x, @ line2\p2\y, @ MouseButton )
          CalculateLineFormula(line2)          
          If lineOnRectWH(line2, rect)
            render\SetDrawColor(255,0,0,255)
          Else
            render\SetDrawColor(0,255,0,255)
          EndIf
          render\DrawRect(rect)
          
          CalculateLineFormula(line2)
          col=LineOnLine(line1,line2)
          If col
            render\SetDrawColor(255,0,0,255)
          Else
            render\SetDrawColor(0,255,0,255)
          EndIf
          render\DrawLine( line1\p1\x, line1\p1\y, line1\p2\x, line1\p2\y)
          render\SetDrawColor(255*col,0,255,255)
          render\DrawLine( line2\p1\x, line2\p1\y, line2\p2\x, line2\p2\y)
          
        Case #state_sline
          render\SetDrawColor(0,255,0,255)
          render\DrawRect(rect)
          
          render\SetDrawColor(0,255,0,255)
          render\DrawLine( line1\p1\x, line1\p1\y, line1\p2\x, line1\p2\y)
          render\DrawLine( line2\p1\x, line2\p1\y, line2\p2\x, line2\p2\y)
          
          render\MouseGet( @ sline1\p1\x, @ sline1\p1\y, @ MouseButton)
          LineNearestPoint(line1, sline1\p1, sline1\p2)
          
          If DistanceSquare(sline1\p1,sline1\p2)<10*10
            render\SetDrawColor(255,0,255,255)
          Else
            render\SetDrawColor(0,0,255,255)
          EndIf
          render\DrawLine( sline1\p1\x, sline1\p1\y, sline1\p2\x, sline1\p2\y)
          render\DrawCircle( sline1\p1\x, sline1\p1\y,10)
          
          sline2\p1\x = sline1\p1\x
          sline2\p1\y = sline1\p1\y
          LineNearestPoint(line2, sline2\p1, sline2\p2)
          If DistanceSquare(sline2\p1,sline2\p2)<10*10
            render\SetDrawColor(255,0,255,255)
          Else
            render\SetDrawColor(0,0,255,255)
          EndIf
          render\DrawLine( sline2\p1\x, sline2\p1\y, sline2\p2\x, sline2\p2\y)
          render\DrawCircle( sline2\p1\x, sline2\p1\y,10)
       
      EndSelect
      
    EndIf
    
    Render\EndDrawing(); <- includes flipping
    
    Render\Present()

    
  Wend
 
  
  SDL_QUIT()

  
  
EndProcedure

main()
  
  
  
; IDE Options = PureBasic 5.72 (MacOS X - x64)
; CursorPosition = 268
; FirstLine = 240
; Folding = -
; EnableXP
; DPIAware