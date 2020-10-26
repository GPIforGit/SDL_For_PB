EnableExplicit

;TODO größenangaben auslagern...
;TODO Gadgets auf Größenänderungen reagieren
;TODO Checkboxen
;TODO Optionboxen
;TODO GrafikButtons
;TODO Text-Input-Buttons

XIncludeFile "../../sdl2/SDL_image.pbi"
XIncludeFile "../../sdl2/SDL_ttf.pbi"
XIncludeFile "../../sdl2/SDL.pbi"
XIncludeFile "../class.pbi"
XIncludeFile "../renderer.pbi"
XIncludeFile "../gui.pbi"
XIncludeFile "gadgets.pbi"

#title="GUI-Demo"
#width=640*2
#height=400*2
#LogicalWidth=320
#LogicalHeight=200

Global.Renderer::Class Render 
Global.Gui::Class Gui
Global.sdl::TTF_Font *font

#sdl_flags = SDL::#INIT_EVENTS | SDL::#INIT_VIDEO
#sdl_img_flags = SDL::#IMG_INIT_PNG ; only png (&zip)
#integerScale=#False

Runtime Procedure Frame1_OnClick(*frame.gui::Frame,*data)
    *frame\SortUp()
EndProcedure

Runtime Procedure Frame3_OnClick(*frame.gui::Frame,*data)
  *frame\SortUp()
EndProcedure

Runtime Procedure Button_OnClick(*frame.gui::frame,*data)
  Static count
  ;MessageRequester("Test","Pressed "+*frame\GetName())
  sdl::ShowSimpleMessageBox(sdl::#MESSAGEBOX_INFORMATION, "test", "Pressed " + *frame\GetName(), #Null)
EndProcedure

Runtime Procedure Button1_OnClick(*frame.gui::Frame,*data)
  If gui\GetState("Frame1", gui::#State_Hide)
    gui\SetState("Frame1", gui::#State_Hide, #False)
    *frame\SetUserDataS("Text","Hide")
  Else
    gui\SetState("Frame1", gui::#State_Hide, #True)
    *frame\SetUserDataS("Text","Show")
  EndIf
EndProcedure

Runtime Procedure Slider_OnClick(*frame.gui::Frame,*data)
  Debug *frame\GetName()+" "+*frame\GetUserDataF("Value")
EndProcedure


Procedure.l SDL_init()
  
  If SDL::init(#sdl_flags) 
    ProcedureReturn #False
  EndIf
  If SDL::IMG_Init(#sdl_img_flags) & #sdl_img_flags <> #sdl_img_flags
    ProcedureReturn #False
  EndIf
  If SDL::TTF_Init()
    ProcedureReturn #False
  EndIf
  
  *font = sdl::TTF_OpenFont("Early GameBoy.ttf",8)
  If *font = #Null
    ProcedureReturn #False
  EndIf
  
  render=Renderer::New(#title, sdl::#WINDOWPOS_CENTERED, sdl::#WINDOWPOS_CENTERED, #width, #height, 
                       sdl::#WINDOW_ALLOW_HIGHDPI | sdl::#WINDOW_RESIZABLE, 
                       SDL::#RENDERER_ACCELERATED |  SDL::#RENDERER_TARGETTEXTURE | SDL::#RENDERER_PRESENTVSYNC)
  
  
  If render = #Null
    ProcedureReturn #False
  EndIf
  
  render\winSetBound(#LogicalWidth,#LogicalHeight)
  
  render\SetLogicalSize(#LogicalWidth,#LogicalHeight,0)
  render\SetIntegerScale(#integerScale)
   
  gui = gui::New( render )
  
  gui\LoadXML("gadgets.xml")
  
  gui\LoadXML("frames.xml")
    
  ProcedureReturn #True
EndProcedure

Procedure SDL_quit()
  
  Object::Delete(gui)
  
  Object::delete(render)
  
  If *font
    sdl::TTF_CloseFont(*font)
  EndIf  
  
  If SDL::TTF_WasInit()
    SDL::TTF_Quit()
  EndIf
  SDL::IMG_Quit()
  SDL::Quit()
EndProcedure




Procedure Main()
  If  Not SDL_init()
    ;MessageRequester(#title,"SDL Error" + #LF$ + SDL::GetError())
    sdl::ShowSimpleMessageBox(sdl::#MESSAGEBOX_ERROR, #title, "SDL Error" + #LF$ + SDL::GetError(), #Null)
    SDL_quit()
    ProcedureReturn
  EndIf
  
  Protected.sdl::Event e
  Protected.l quit
  Protected.l lastFrameMS
  Protected.sdl::point mouse
  Protected.gui::Frame *frame
  Protected.l mouseButton
  Protected.l mouseClicks
  
  ; Clear background
  render\SetDrawColor(0,0,0,255)
  render\Clear()
  Render\Show()
  render\Clear()
  render\Show()
  
  While Not quit
    While SDL::PollEvent( e ) 
      render\doEvents(e);allways first!
      Select e\type
        Case sdl::#quit
          quit=#True
        Case sdl::#MOUSEBUTTONDOWN, sdl::#MOUSEBUTTONUP
          mouse\x=e\button\x
          mouse\y=e\button\y
          
          If e\type= sdl::#MOUSEBUTTONDOWN
            mouseButton | (1 << (e\button\button-1))
          Else
            mouseButton & ~(1 << (e\button\button-1))
          EndIf
          
          If e\button\clicks > 1
            mouseClicks | (1 << (e\button\button-1))
          Else
            mouseClicks & ~(1 << (e\button\button-1))
          EndIf
          
        Case sdl::#MOUSEMOTION
          mouse\x=e\motion\x
          mouse\y=e\motion\y
      EndSelect
    Wend
    
    Protected testrect.sdl::rect
    testrect\x=30
    testrect\y=30
    testrect\w=100
    testrect\h=100
    
    
    render\SetDrawColor(128,0,0,255)
    render\Clear()
    render\StartDrawing()
    render\SetDrawColor(0,0,0,255)
    render\Clear()
    
    render\SetDrawColor(255,255,255,255)
    render\DrawRect(testrect)
    
    
    
    *frame = gui\GetHit(mouse,MouseButton,mouseClicks)
;     If *frame
;       ;Debug ""+mouse\x+" "+mouse\y+ *Frame
;     EndIf
    
    gui\Draw()
    
    render\EndDrawing()
    lastFrameMS = Render\Show()
    
  Wend
  
  *frame=gui\GetFrame("Frame3.Volume")
  If *frame
    Debug "Volume:" + *frame\GetUserDataF("Value")
  EndIf
  
  
  
  SDL_quit()
  
EndProcedure
Main()
class::check()

; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 51
; FirstLine = 47
; Folding = --
; EnableXP