EnableExplicit

;TODO CreateFrame -> Frame und frame in procedure erzeugen.
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
XIncludeFile "../gui_gadget.pbi"

#title="GUI-Demo"
#width=640*2
#height=400*2
#LogicalWidth=320
#LogicalHeight=200

Global.Renderer::Class Render 
Global.renderer::texture *TexFrame
Global.renderer::texture *TexButton
Global.Renderer::Texture *TexSliderHorizontal
Global.Renderer::Texture *TexSliderVertical
Global.Gui::Class Gui
Global.sdl::TTF_Font *font
Global.gadget::sButtonStyle MyButtonStyle
Global.gadget::sSliderStyle MySliderStyleHorizontal
Global.gadget::sSliderStyle MySliderStyleVertical
Global.gadget::sWindowStyle MyWindowStyle

#sdl_flags = SDL::#INIT_EVENTS | SDL::#INIT_VIDEO
#sdl_img_flags = SDL::#IMG_INIT_PNG ; only png (&zip)
#integerScale=#False

Procedure OnCallback(what,*frame.gui::Frame,dat)
  Debug "callback:"+what+" "+*frame\GetName()+" "+*frame+" "+dat
EndProcedure

Procedure Frame1_OnClick(what,*frame.gui::Frame,dat)
  Debug "click:"+what+" "+*frame\GetName()+" "+*frame+" "+dat
  Protected *frame2.gui::Frame = gui\GetFrame("Frame1.Frame2")
  *frame2\SetState(gui::#state_hide,gui::#Toogle)
  Debug "TOOGLE "+ *frame2\GetState(gui::#State_hide)
  
  *frame\SortUp()
EndProcedure

Procedure Frame3_OnClick(what,*frame.gui::Frame,dat)
  *frame\SortUp()
EndProcedure

Procedure Button_OnClick(what,*frame.gui::frame,dat)
  ;MessageRequester("Test","Pressed "+*frame\GetName())
  sdl::ShowSimpleMessageBox(sdl::#MESSAGEBOX_INFORMATION, "test", "Pressed " + *frame\GetName(), #Null)
EndProcedure
Procedure Slider_OnClick(what,*frame.gui::Frame,dat)
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
  
  
  *TexFrame = render\LoadTexture("Frame.png",-1,1)
  If *TexFrame = #Null    
    ProcedureReturn #False
  EndIf
  
  *TexButton = render\LoadTexture("Button.png",-1,1)
  If *TexButton = #Null
    ProcedureReturn #False
  EndIf
  
  *TexSliderHorizontal = render\LoadTexture("SliderHorizontal.png",-1,1)
  If *TexSliderHorizontal = #Null
    ProcedureReturn #False
  EndIf
  
  *TexSliderVertical = render\LoadTexture("SliderVertical.png",-1,1)
  If *TexSliderVertical = #Null
    ProcedureReturn #False
  EndIf
  
  gui = gui::New( render )
  
  ;- create windows
  
  Protected ele.gui::frame
  Protected deco.gui::frame
  
  MyWindowStyle\Texture = *TexFrame
  MyWindowStyle\border = -3
  MyWindowStyle\corner = 5
    
  
  ele = gadget::Window( gui, "Frame1", 30,30,100,100, MyWindowStyle, Gadget::#Window_Moveable | gadget::#Window_Sizeable )
  ele\SetOn(gui::#Event_enter, @OnCallback(),1 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),1 )
  ele\SetOn(gui::#Event_LeftClick,@Frame1_OnClick())
  
  ele = gadget::Window( ele, "Frame2", -10,20,150,30, MyWindowStyle)
  ele\SetOn(gui::#Event_enter, @OnCallback(),2 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),2 )
  
  ele = gadget::Window( gui, "Frame3", 50,50,0,0, MyWindowStyle, Gadget::#Window_Moveable)
  ele\seth(5, gui::#Anchor_MaxHeight,".")
  ele\setw(50,gui::#Anchor_MaxWidth,".")
  ele\SetOn(gui::#Event_enter, @OnCallback(),3 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),3 )
  ele\SetOn(gui::#Event_LeftClick, @Frame3_OnClick() )
  
  ;header for frame3
  deco = ele\NewChild("Text")
  deco\SetText(*font,"Frame3",RGBA(255,0,255,255))
  deco\SetX(0, gui::#Anchor_Center,"..")
  deco\SetY(0, gui::#anchor_top,"..")
  deco\setW(gui::#Offset_TextureSize,gui::#Anchor_Direct,".")
  deco\seth(gui::#Offset_TextureSize,gui::#Anchor_Direct,".")
  
  
  MyButtonStyle\font = *font
  MyButtonStyle\offset\x = 1
  MyButtonStyle\offset\y = 0
  MyButtonStyle\offsetPushed\x = 2
  MyButtonStyle\offsetPushed\y = 1
  MyButtonStyle\texBackground = *TexButton
  MyButtonStyle\textColor = RGBA(255,255,255,255)
  MyButtonStyle\textColorDisabled = RGBA(0,0,0,255)
  MyButtonStyle\textColorHighlight = RGBA(255,128,128,255)
  
  Protected.gui::frame but
  but = Gadget::Button(ele, "btn1", 10,10,-1,-1,MyButtonStyle,"Hallo")
  But\SetX(0, gui::#Anchor_Center,"..")
  but\SetOn(gui::#Event_LeftClick, @Button_OnClick())
  but\SetUserDataS("Value","Hide")
  
  But = Gadget::Button(ele, "btn2", 10,10,-1,-1,MyButtonStyle,"Button2")
  But\SetX(0, gui::#Anchor_Center,"..")
  But\SetY(2, gui::#Anchor_Bottom,"..btn1")
  but\SetOn(gui::#Event_LeftClick, @Button_OnClick())
  
  But = Gadget::Button(ele, "btn3", 10,10,-1,-1,MyButtonStyle,"Quit")
  But\SetX(0, gui::#Anchor_Center,"..")
  But\SetY(2, gui::#Anchor_Bottom,"..btn2")
  but\SetOn(gui::#Event_LeftClick, @Button_OnClick())
  
  but\SetState(gui::#state_disabled, #True)
  
  
  
  MySliderStyleHorizontal\texture = *TexSliderHorizontal
  MySliderStyleHorizontal\vertical = #False
  MySliderStyleHorizontal\flipped = #False
  
  MySliderStyleVertical\texture = *TexSliderVertical
  MySliderStyleVertical\vertical = #True
  MySliderStyleVertical\flipped = #True
     
  Protected.gui::frame slider
  
  slider = Gadget::Slider(ele,"Volume",10,10,100,16, MySliderStyleHorizontal, 0.25)
  slider\SetX(0, gui::#Anchor_Center,"..")
  slider\SetY(2, gui::#Anchor_Bottom,"..btn3")
  slider\SetOn(gui::#Event_LeftClick,@Slider_OnClick())
  
  slider = Gadget::Slider(ele,"Sound",10,10,16,100, MySliderStyleVertical, 0.25)
  slider\SetOn(gui::#Event_LeftClick,@Slider_OnClick())
  
  ProcedureReturn #True
EndProcedure

Procedure SDL_quit()
  
  Object::Delete(gui)
  Object::Delete(*TexFrame)
  Object::Delete(*TexButton)
  object::Delete(*TexSliderHorizontal)
  Object::Delete(*TexSliderVertical)
  
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
    If *frame
      ;Debug ""+mouse\x+" "+mouse\y+ *Frame
    EndIf
    
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
; CursorPosition = 164
; FirstLine = 143
; Folding = --
; EnableXP