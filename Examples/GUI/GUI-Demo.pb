EnableExplicit

XIncludeFile "../../sdl2/SDL_image.pbi"
XIncludeFile "../../sdl2/SDL_ttf.pbi"
XIncludeFile "../../sdl2/SDL.pbi"
XIncludeFile "../class.pbi"
XIncludeFile "../renderer.pbi"
XIncludeFile "../gui.pbi"
;- declare Gadget
DeclareModule Gadget
  Structure sButtonStyle
    *font
    *texBackground
    textColor.i
    textColorHighlight.i
    textColorDisabled.i
    offset.sdl::Point
    offsetPushed.sdl::point  
  EndStructure
  Structure sSliderStyle
    *texture.renderer::Texture
    vertical.l
    flipped.l
  EndStructure
  Structure sFrameStyle
    *Texture.renderer::Texture
    border.l
    corner.l
    stretch.l
  EndStructure
  
  EnumerationBinary
    #Frame_Moveable
    #Frame_Sizeable
  EndEnumeration
  
   
  Declare Button(*parentGuiFrame, x.l,y.l,w.l,h.l, *sButtonStyle, Text.s, name.s="")
  Declare Slider(*frame.gui::frame, x.l, y.l, w.l, h.l, *sSliderStyle,name.s="")
  Declare CreateFrame(*ele.gui::frame, *sFrameStyle, flags.l = #Null)
EndDeclareModule

;- Gadget
Module Gadget
  EnableExplicit
  Enumeration type
    #type_button
    #type_slider
    #type_max
  EndEnumeration
    
  Structure sButtonData
    *style.sButtonStyle
    *TexText.renderer::Texture
    *TexTextHighlight.renderer::Texture
    *TexTextDisabled.renderer::Texture
  EndStructure
  Structure sSliderData
    *style.sSliderStyle
  EndStructure
  
  Structure sGadgetData
    type.l
    state.l   
    StructureUnion
      button.sButtonData
      Slider.sSliderData
    EndStructureUnion
  EndStructure
  #UserData = "GadgetData"
  
  EnumerationBinary 
    #state_none = 0
    #state_highlight
    #state_pushed
    #state_disabled
  EndEnumeration
  
  
  Procedure ButtonUpdate(*but.gui::Frame, *bData.sGadgetData)
    Protected.gui::frame frame
    Protected.f top, bot
    Protected.l what
        
    If *bData\type <> #type_button
      ProcedureReturn 
    EndIf    
    
    If *bData\state & #state_disabled
      what = #state_disabled
    ElseIf *bdata\state & (#state_pushed | #state_highlight) = (#state_pushed | #state_highlight)
      what = #state_pushed
    ElseIf *bdata\state & (#state_highlight|#state_pushed)
      what = #state_highlight
    Else
      what = #state_none
    EndIf
    
    frame = *but\GetFrame(".Text")
    Select what
      Case #state_none
        frame\SetX(*bData\button\style\offset\x, gui::#Anchor_Center, "..")
        frame\SetY(*bData\button\style\offset\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*bData\button\TexText,0,0,1,1)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case #state_highlight
        frame\SetX(*bData\button\style\offset\x, gui::#Anchor_Center, "..")
        frame\SetY(*bData\button\style\offset\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*bData\button\TexTextHighlight,0,0,1,1)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case #state_pushed
        frame\SetX(*bData\button\style\offsetPushed\x, gui::#Anchor_Center, "..")
        frame\SetY(*bData\button\style\offsetPushed\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*bData\button\TexTextHighlight,0,0,1,1)
        top = 2.0/4.0
        bot = 3.0/4.0
      Case #state_disabled
        frame\SetX(*bData\button\style\offset\x, gui::#Anchor_Center, "..")
        frame\SetY(*bData\button\style\offset\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*bData\button\TexTextDisabled,0,0,1,1)
        top = 3.0/4.0
        bot = 4.0/4.0
    EndSelect
    
    
    frame = *but\GetFrame(".Left")
    frame\SetTexture( *bData\button\style\texBackground, 0.0,top, 0.25,bot)
    
    frame = *but\GetFrame(".Right")
    frame\SetTexture( *bData\button\style\texBackground, 0.75,top, 1.0,bot)
    
    frame = *but\GetFrame(".Mid")
    frame\SetTexture( *bData\button\style\texBackground, 0.25,top, 0.75,bot)
    
    
  EndProcedure
  
  Procedure SliderUpdate(*but.gui::frame, *bData.sGadgetData)
    Protected.gui::frame frameSlider,frameLeft,frameRight,frameMid
    Protected.f top, bot
    Protected.l what
    
    If *bData\type <> #type_slider
      ProcedureReturn 
    EndIf    
    
    If *bData\state & #state_disabled
      what = #state_disabled
    ElseIf *bdata\state & (#state_pushed | #state_highlight) = (#state_pushed | #state_highlight)
      what = #state_pushed
    ElseIf *bdata\state & (#state_highlight|#state_pushed)
      what = #state_highlight
    Else
      what = #state_none
    EndIf
    
    Select what
      Case #state_none
        top = 0.0/4.0
        bot = 1.0/4.0
      Case #state_highlight
        top = 0.0/4.0
        bot = 1.0/4.0
      Case #state_pushed
        top = 2.0/4.0
        bot = 3.0/4.0
      Case #state_disabled
        top = 3.0/4.0
        bot = 4.0/4.0
    EndSelect
    
    frameSlider = *but\GetFrame(".Slider")
    frameLeft = *but\GetFrame(".Left")
    frameRight = *but\GetFrame(".Right")
    frameMid = *but\GetFrame(".Mid")
    
    If *bData\Slider\style\vertical
      frameSlider\SetTexture( *bData\Slider\style\texture, top, 0.0, bot, 0.25)
      frameLeft\SetTexture( *bData\Slider\style\texture, top, 0.25, bot, 0.50)
      frameRight\SetTexture( *bData\Slider\style\texture, top, 0.75, bot, 1.0)
      frameMid\SetTexture( *bData\Slider\style\texture, top, 0.50, bot, 0.75)
    Else
      frameSlider\SetTexture( *bData\Slider\style\texture, 0.0,top, 0.25,bot)
      frameLeft\SetTexture( *bData\Slider\style\texture, 0.25,top, 0.50,bot)
      frameRight\SetTexture( *bData\Slider\style\texture, 0.75,top, 1.0,bot)
      frameMid\SetTexture( *bData\Slider\style\texture, 0.50,top, 0.75,bot)
    EndIf
    
  EndProcedure
  
  Procedure GadgetUpdate(*gad.gui::Frame, *bData.sGadgetData)
    Select *bData\type
      Case #type_button
        ButtonUpdate( *gad, *bData )
      Case #type_slider
        SliderUpdate(*gad.gui::Frame, *bData)
    EndSelect
  EndProcedure
  
  Procedure Button_UserData(event, *but.gui::frame, *bData.sGadgetData)
    Protected.s text
    If PeekS(event) = "Value"
      text = *but\GetUserDataS("Value")
      Object::delete(*bData\button\TexText)
      Object::delete(*bData\button\TexTextDisabled)
      Object::delete(*bData\button\TexTextHighlight)
      
      *bData\button\TexText          = *but\GetTextTexture( *bdata\button\style\font, text, *bdata\button\style\textColor, gui::#tex_single)
      *bData\button\TexTextDisabled  = *but\GetTextTexture( *bdata\button\style\font, text, *bdata\button\style\textColorDisabled, gui::#tex_single)
      *bData\button\TexTextHighlight = *but\GetTextTexture( *bdata\button\style\font, text, *bdata\button\style\textColorHighlight, gui::#tex_single)
      
      ButtonUpdate(*but, *bData)            
    EndIf
  EndProcedure
  
  Procedure Slider_LeftDown(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state | #state_pushed
    GadgetUpdate(*gad\GetParent(), *bData)
    *gad\StartUserMoving()
  EndProcedure
  Procedure Slider_LeftUp(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state & (~#state_pushed)
    GadgetUpdate(*gad\GetParent(), *bData)
    *gad\StopUserSizingMoving()
  EndProcedure
  
  Procedure Slider_moving(event, *gad.gui::Frame, *bData.sGadgetData)
    Protected.gui::Frame *parent = *gad\GetParent()
    Protected.f value
    If *bData\Slider\style\vertical
      value= *gad\GetY() / (*parent\GetH()-*gad\GetH())
    Else
      value= *gad\GetX() / (*parent\GetW()-*gad\GetW())
    EndIf
    If value < 0.0 : value = 0.0 : ElseIf value > 1.0 : value = 1.0 : EndIf
    If *bData\Slider\style\flipped
      value = 1.0-value
    EndIf
    *parent\SetUserDataF("Value", value, #True)
    
    *parent\DoOn(gui::#Event_LeftClick)    
  EndProcedure
  
  Procedure Slider_UserData(event, *parent.gui::frame, *bData.sGadgetData)
    Protected.gui::Frame *gad 
    Protected.f value
    If PeekS(event)="Value"
      *gad= *parent\GetFrame(".Slider")
      value =  *parent\GetUserDataF("Value")
      If value < 0.0 : value = 0.0 : ElseIf value > 1.0 : value = 1.0 : EndIf
      If *bData\Slider\style\flipped
        value = 1.0-value
      EndIf
      
      If *bData\Slider\style\vertical
        *gad\SetY( (*parent\GetH()-*gad\GetH()) * Value )      
      Else
        *gad\SetX( (*parent\GetW()-*gad\GetW()) * Value )      
      EndIf
    EndIf
  EndProcedure
  
  Procedure Slider_Click(event, *parent.gui::Frame, *bData.sGadgetData)
    Protected.gui::Frame *gad = *parent\GetFrame(".Slider")
    Protected m.sdl::point
    Protected value.f
    *parent\GetRelativMouse(m)
    
    If *bData\Slider\style\vertical
      m\y - *gad\GetW()/2
      value.f = m\y / (*parent\GetH()-*gad\GetH())
    Else
      m\x - *gad\geth()/2
      value.f = m\x / (*parent\GetW()-*gad\GetW())
    EndIf
        
    If value.f < 0.0 : value.f = 0.0 : ElseIf value.f > 1.0 : value.f = 1.0 : EndIf
    If *bData\Slider\style\flipped
      value = 1.0-value
    EndIf
    
    ;Debug value.f
    *parent\SetUserDataF("Value",value)
    ;simulate left click on slider
    *bData\state | #state_highlight
    Slider_LeftDown(event, *gad, *bData)
  EndProcedure
  
    
  Procedure GadgetParent_LeftDown(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state | #state_pushed
    GadgetUpdate(*gad\GetParent(), *bData)
  EndProcedure
  Procedure GadgetParent_LeftUp(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state & (~#state_pushed)
    GadgetUpdate(*gad\GetParent(), *bData)
  EndProcedure
  Procedure GadgetParent_Enter(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state | #state_highlight
    GadgetUpdate(*gad\GetParent(), *bData)        
  EndProcedure
  Procedure GadgetParent_Leave(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state & (~#state_highlight)
    GadgetUpdate(*gad\GetParent(), *bData)
  EndProcedure
  
  Procedure Gadget_LeftDown(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state | #state_pushed
    GadgetUpdate(*gad, *bData)
  EndProcedure
  Procedure Gadget_LeftUp(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state & (~#state_pushed)
    GadgetUpdate(*gad, *bData)
  EndProcedure
  Procedure Gadget_Enter(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state | #state_highlight
    GadgetUpdate(*gad, *bData)        
  EndProcedure
  Procedure Gadget_Leave(event,*gad.gui::frame, *bData.sGadgetData)
    *bData\state & (~#state_highlight)
    GadgetUpdate(*gad, *bData)
  EndProcedure
  Procedure Gadget_State(event,*gad.gui::frame, *bData.sGadgetData)    
    If *gad\GetState( gui::#state_disabled )
      *bData\state | #state_disabled
    Else
      *bData\state & (~#state_disabled)
    EndIf
    GadgetUpdate(*gad, *bData)
  EndProcedure
  Procedure Gadget_Destroy(event,*but.gui::Frame, *bData.sGadgetData)
    If *bData
      Select *bData\type
        Case #type_button
          Object::delete(*bData\button\TexText)
          Object::delete(*bData\button\TexTextDisabled)
          Object::delete(*bData\button\TexTextHighlight)
      EndSelect
      
      FreeStructure(*bData)
    EndIf
  EndProcedure
  
  Procedure FrameSize_LeftDown(event.l, *frame.GUI::frame, what.l)
    Protected.GUI::frame *ele = *frame\GetParent()
    *ele\SortUp()
    *ele\StartUserSizing(what)
  EndProcedure
  Procedure FrameMove_LeftDown(event.l, *frame.GUI::frame, what.l)
    *frame\SortUp()
    *frame\StartUserMoving()
  EndProcedure
  Procedure FraneStop_OnLeftUp(event.l, *frame.GUI::Frame, what.l)
    *frame\StopUserSizingMoving()
  EndProcedure
    
  Procedure Button(*frame.gui::frame, x.l, y.l, w.l, h.l, *style.sButtonStyle, text.s,name.s="")
    If name=""
      name="BTN_"+text
    EndIf
    Protected.gui::frame *but = *frame\NewChild(name)
    Protected.gui::frame deco
    Protected.sGadgetData *bData = AllocateStructure(sGadgetData)
    *bData\state = #state_none
    *bData\type = #type_button
    *bData\button\style = *style
    
    *bData\button\TexText          = *but\GetTextTexture( *bdata\button\style\font, text, *bdata\button\style\textColor, gui::#tex_single)
    *bData\button\TexTextDisabled  = *but\GetTextTexture( *bdata\button\style\font, text, *bdata\button\style\textColorDisabled, gui::#tex_single)
    *bData\button\TexTextHighlight = *but\GetTextTexture( *bdata\button\style\font, text, *bdata\button\style\textColorHighlight, gui::#tex_single)
        
    If h<=0
      h = *bData\button\TexText\GetHeight() *3 /2
    EndIf
    If w<=0
      w= *bData\button\TexText\GetWidth() + h/2
    EndIf
    
    *but\SetPosition(x,y,w,h)
    *but\SetUserDataS("Value", text)
    *but\SetUserData(#UserData, *bData)
    
    
    deco=*but\NewChild("Left", gui::#State_OnBack)
    deco\SetPosition(0,0, gui::#Offset_TextureSize,h)
    deco\setX(0, gui::#Anchor_Left,"..")
    deco\setY(0, gui::#Anchor_Top,"..")
    
    deco=*but\NewChild("Right", gui::#State_OnBack)
    deco\SetPosition(0,0, gui::#Offset_TextureSize, h)
    deco\setX(- gui::#Offset_FrameSize, gui::#Anchor_Right,"..")
    deco\setY(0, gui::#Anchor_Top,"..")
    
    deco=*but\NewChild("Mid", gui::#State_OnBack)
    deco\SetX(0, gui::#Anchor_Right, "..Left")
    deco\Sety(0, gui::#Anchor_Top, "..Left")
    deco\SetW(0, gui::#Anchor_Left, "..Right")
    deco\setH(0, gui::#Anchor_Bottom, "..Right")
    
    deco=*but\NewChild("Text")
    deco\SetPosition(0,0, gui::#Offset_TextureSize, gui::#Offset_TextureSize)
    deco\SetX(0, gui::#Anchor_Center, "..")
    deco\SetY(0, gui::#Anchor_Center, "..")
    
    
    ButtonUpdate(*but, *bData)
    
    *but\SetOn(gui::#Event_LeftDown, @Gadget_LeftDown(), *bData)
    *but\SetOn(gui::#Event_LeftUp, @Gadget_LeftUp(), *bData)
    *but\SetOn(gui::#Event_enter, @Gadget_Enter(), *bData)
    *but\SetOn(gui::#Event_leave, @Gadget_Leave(), *bData)
    *but\SetOn(gui::#Event_StateChange, @Gadget_State(), *bData)
    *but\SetOn(gui::#Event_Destroy, @Gadget_Destroy(), *bData)
    *but\SetOn(gui::#Event_UserData, @Button_UserData(), *bData)
    
    
    
    ProcedureReturn *but
  EndProcedure
  
  Procedure Slider(*frame.gui::frame, x.l, y.l, w.l, h.l, *style.sSliderStyle,name.s="")
    Static count.l
    If name=""
      count+1
      name="Slider_"+count
    EndIf
    Protected.gui::frame *slider = *frame\NewChild(name)
    Protected.gui::frame deco
    Protected.sGadgetData *bData = AllocateStructure(sGadgetData)
    *bData\state = #state_none
    *bData\type = #type_slider
    *bData\Slider\style = *style
        
    *slider\SetPosition(x,y,w,h)
        
    deco=*slider\NewChild("Left", gui::#State_OnBack)
    If *bData\Slider\style\vertical
      deco\SetPosition(0,0, w, w)
    Else
      deco\SetPosition(0,0, h, h)
    EndIf
         
    deco=*slider\NewChild("Right", gui::#State_OnBack)
    If *bData\Slider\style\vertical
      deco\SetPosition(0,0, w, w)
      deco\SetY(-w,gui::#Anchor_Bottom,"..")
    Else
      deco\SetPosition(0,0, h, h)
      deco\SetX(-h,gui::#Anchor_Right,"..")
    EndIf
    
    deco=*slider\NewChild("Mid", gui::#State_OnBack)
    If *bData\Slider\style\vertical
      deco\SetX(0, gui::#Anchor_Left, "..Left")
      deco\Sety(0, gui::#Anchor_Bottom, "..Left")
      deco\SetW(0, gui::#Anchor_Right, "..Right")
      deco\setH(0, gui::#Anchor_Top, "..Right")
    Else
      deco\SetX(0, gui::#Anchor_Right, "..Left")
      deco\Sety(0, gui::#Anchor_Top, "..Left")
      deco\SetW(0, gui::#Anchor_Left, "..Right")
      deco\setH(0, gui::#Anchor_Bottom, "..Right")
    EndIf
    
    deco=*slider\NewChild("Slider")
    If *bData\Slider\style\vertical
      deco\SetPosition(0,0, w, w)
    Else
      deco\SetPosition(0,0, h, h)
    EndIf
    
    *slider\SetUserData(#UserData, *bData)
    SliderUpdate(*slider, *bData)
    
    deco\SetOn(gui::#Event_LeftDown, @Slider_LeftDown(), *bData)
    deco\SetOn(gui::#Event_LeftUp, @Slider_LeftUp(), *bData)
    deco\SetOn(gui::#Event_enter, @GadgetParent_Enter(), *bData)
    deco\SetOn(gui::#Event_leave, @GadgetParent_Leave(), *bData)
    deco\SetOn(gui::#Event_moving, @Slider_moving(), *bData)
    *slider\SetOn(gui::#Event_StateChange, @Gadget_State(), *bData)
    *slider\SetOn(gui::#Event_Destroy, @Gadget_Destroy(), *bData)
    *slider\SetOn(gui::#Event_UserData, @Slider_UserData(), *bData)
    *slider\SetOn(gui::#Event_LeftDown, @Slider_Click(), *bData)
    
    *slider\SetUserDataF("Value",0.0)
    
    ProcedureReturn *slider
  EndProcedure
  
  Procedure CreateFrame(*ele.gui::frame, *style.sFrameStyle, flags.l = #Null)
    Protected.GUI::frame decoTop,decoBot,decoLeft,decoRight,decoLT,decoRT,decoLB,decoRB,decoMid
    Protected.l outside
    Protected.l offx,offy,offw,offh,offmid,offCorner
    #OneThird=1.0/3.0
    
    Protected.l tw = *style\Texture\GetWidth() * #OneThird
    Protected.l border = *style\border
    Protected.l corner = *style\corner
    Protected.l stretch
        
    If border = 0
      border = tw
    EndIf
       
    If Border < 0
      outside = gui::#State_ClipOutside
      border = -Border
      offx = -border
      offy = -border
      offw = 0
      offh = 0
      offmid = border
      offCorner = 0
      If corner <= Border
        corner = Border
      EndIf
    Else
      outside = 0
      offx = 0
      offy = 0
      offw = -Border
      offh = -Border
      offmid = Border
      If corner <= Border
        corner = Border
      EndIf
      offCorner = Corner
    EndIf
    
    If *style\Stretch
      Stretch = gui::#tex_stretch
    Else
      Stretch = gui::#tex_tile
    EndIf
    
    decoTop=*ele\NewChild("Top", outside | gui::#State_OnBack)
    decoTop\SetTexture( *style\Texture, #OneThird,0,   1.0-#OneThird,#OneThird, Stretch | gui::#tex_AnchorTop)
    
    decoBot=*ele\NewChild("Bottom", outside | gui::#State_OnBack)
    decoBot\SetTexture( *style\Texture, #OneThird,1.0-#OneThird,   1.0-#OneThird,1.0, Stretch | gui::#tex_AnchorBottom)
    
    decoLeft=*ele\NewChild("Left", outside | gui::#State_OnBack)
    decoLeft\SetTexture(*style\Texture, 0, #OneThird,  #OneThird,1.0-#OneThird, Stretch | gui::#tex_AnchorLeft)
    
    decoRight=*ele\NewChild("Right", outside | gui::#State_OnBack)
    decoRight\SetTexture(*style\Texture, 1.0-#OneThird, #OneThird,  1.0,1.0-#OneThird, Stretch | gui::#tex_AnchorRight)
    
    decoMid=*ele\NewChild("Mid", outside | gui::#State_OnBack)
    decoMid\SetTexture( *style\Texture, #OneThird, #OneThird, 1.0-#OneThird, 1.0-#OneThird, Stretch)
    
    decoLT=*ele\NewChild("LeftTop", outside | gui::#State_OnBack)
    decoLT\SetTexture( *style\Texture, 0, 0, #OneThird, #OneThird,gui::#tex_tile | gui::#tex_AnchorTop|gui::#tex_AnchorLeft)
    
    decoRT=*ele\NewChild("RightTop", outside | gui::#State_OnBack)
    decoRT\SetTexture( *style\Texture, 1.0-#OneThird, 0, 1.0, #OneThird,gui::#tex_tile | gui::#tex_AnchorTop|gui::#tex_AnchorRight)
    
    decoLB=*ele\NewChild("LeftBottom", outside | gui::#State_OnBack)
    decoLB\SetTexture( *style\Texture, 0, 1.0-#OneThird, #OneThird, 1.0,gui::#tex_tile | gui::#tex_AnchorBottom|gui::#tex_AnchorLeft)
    
    decoRB=*ele\NewChild("RightBottom", outside | gui::#State_OnBack)
    decoRB\SetTexture( *style\Texture, 1.0-#OneThird, 1.0-#OneThird, 1.0, 1.0,gui::#tex_tile | gui::#tex_AnchorBottom|gui::#tex_AnchorRight)
        
    decoTop\SetX(offCorner, GUI::#Anchor_Left, "..")
    decoTop\SetY(offy, GUI::#Anchor_Top, ".."  )
    decoTop\SetW(-offCorner, GUI::#Anchor_Right, ".." )
    decoTop\Seth(Border)
        
    decoBot\SetX(offCorner, GUI::#Anchor_Left, "..")
    decoBot\SetY(offh, GUI::#Anchor_Bottom, ".."  )
    decoBot\SetW(-offCorner, GUI::#Anchor_Right, ".." )
    decoBot\Seth(Border)
    
    decoLeft\SetX(offx, GUI::#Anchor_Left, "..")
    decoLeft\SetY(offCorner, GUI::#Anchor_Top, "..")
    decoLeft\SetW(Border)
    decoLeft\SetH(-offCorner, GUI::#Anchor_Bottom, "..")
    
    decoRight\setx(offw, GUI::#Anchor_Right, "..")
    decoRight\sety(offCorner, GUI::#Anchor_Top, "..")
    decoRight\SetW(Border)
    decoRight\seth(-offCorner, GUI::#Anchor_Bottom, "..")
    
    decoLT\SetPosition(#PB_Ignore,#PB_Ignore,Corner,Corner)
    decoLT\setx(0, GUI::#Anchor_Left, "..Left" )
    decoLT\sety(0, GUI::#Anchor_Top, "..Top" )
     
    decoRT\SetPosition(#PB_Ignore,#PB_Ignore,Corner,Corner)
    decoRT\setx(-GUI::#Offset_FrameSize, GUI::#Anchor_right, "..Right" )
    decoRT\sety(0,GUI::#Anchor_top, "..Top" )
   
    decoLB\SetPosition(#PB_Ignore,#PB_Ignore,Corner,Corner)
    decoLB\setx(0, GUI::#Anchor_Left, "..Left" )
    decoLB\sety(-GUI::#Offset_FrameSize, GUI::#Anchor_Bottom, "..Bottom" )
     
    decoRB\SetPosition(#PB_Ignore,#PB_Ignore,Corner,Corner)
    decoRB\setx(-GUI::#Offset_FrameSize, GUI::#Anchor_right, "..Right" )
    decoRB\sety(-GUI::#Offset_FrameSize, GUI::#Anchor_Bottom, "..Bottom" )
       
    decoMid\setx(0, GUI::#Anchor_Right, "..Left" )
    decoMid\sety(0, GUI::#Anchor_Bottom, "..Top" )
    decoMid\setw(0, GUI::#Anchor_Left, "..Right" )
    decoMid\seth(0, GUI::#Anchor_Top, "..Bottom" )      
    
    If flags & #Frame_Sizeable
      decoTop\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Top)
      decoTop\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
      decoBot\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Bottom)
      decoBot\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
      decoLeft\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Left)
      decoLeft\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
      decoRight\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Right)
      decoRight\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
      decoLT\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Left | GUI::#Size_Top)
      decoLT\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
      decoRT\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Right | GUI::#Size_Top)
      decoRT\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
      decoLB\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Left | GUI::#Size_Bottom)
      decoLB\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
      decoRB\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Right | GUI::#Size_Bottom)
      decoRB\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
        
    If flags & #Frame_Moveable
      *ele\SetOn(GUI::#Event_LeftDown, @FrameMove_LeftDown())
      *ele\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
  EndProcedure

  
EndModule


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
Global.gadget::sFrameStyle MyFrameStyle

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
  MessageRequester("Test","Pressed "+*frame\GetName())
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
  
  Protected ele.gui::frame
  Protected deco.gui::frame
  
  MyFrameStyle\Texture = *TexFrame
  MyFrameStyle\border = -3
  MyFrameStyle\corner = 5
    
  
  ele = gui\NewElement("Frame1")  
  ele\setx(30)
  ele\sety(30)
  ele\setw(100)
  ele\seth(100)  
  ele\SetOn(gui::#Event_enter, @OnCallback(),1 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),1 )
  gadget::CreateFrame(ele, MyFrameStyle, Gadget::#Frame_Moveable | gadget::#Frame_Sizeable)
  ele\SetOn(gui::#Event_LeftClick,@Frame1_OnClick())
  
  ele = ele\NewChild("Frame2")  
  ele\setx(-10)
  ele\sety(20)
  ele\setw(150)
  ele\seth(30)
  gadget::CreateFrame(ele, MyFrameStyle)
  ele\SetOn(gui::#Event_enter, @OnCallback(),2 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),2 )
  
  ele = gui\NewElement("Frame3")
  ele\setx(50)
  ele\sety(120)
  ele\setw(35)
  ele\seth(30)
  ele\SetOn(gui::#Event_enter, @OnCallback(),3 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),3 )
  gadget::CreateFrame(ele, MyFrameStyle, gadget::#Frame_Moveable)
  ele\SetOn(gui::#Event_LeftClick, @Frame3_OnClick() )
  
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
  but = Gadget::Button(ele, 10,10,-1,-1,MyButtonStyle,"Hallo","btn1")
  But\SetX(0, gui::#Anchor_Center,"..")
  but\SetOn(gui::#Event_LeftClick, @Button_OnClick())
  but\SetUserDataS("Value","Hide")
  
  But = Gadget::Button(ele, 10,10,-1,-1,MyButtonStyle,"Button2","btn2")
  But\SetX(0, gui::#Anchor_Center,"..")
  But\SetY(2, gui::#Anchor_Bottom,"..btn1")
  but\SetOn(gui::#Event_LeftClick, @Button_OnClick())
  
  But = Gadget::Button(ele, 10,10,-1,-1,MyButtonStyle,"Quit","btn3")
  But\SetX(0, gui::#Anchor_Center,"..")
  But\SetY(2, gui::#Anchor_Bottom,"..btn2")
  but\SetOn(gui::#Event_LeftClick, @Button_OnClick())
  
  but\SetState(gui::#state_disabled, #True)
  
  ele\seth(5, gui::#Anchor_MaxHeight,".")
  ele\setw(50,gui::#Anchor_MaxWidth,".")
  
  MySliderStyleHorizontal\texture = *TexSliderHorizontal
  MySliderStyleHorizontal\vertical = #False
  MySliderStyleHorizontal\flipped = #False
  
  MySliderStyleVertical\texture = *TexSliderVertical
  MySliderStyleVertical\vertical = #True
  MySliderStyleVertical\flipped = #True
     
  Protected.gui::frame slider
  
  slider = Gadget::Slider(ele,10,10,100,16, MySliderStyleHorizontal, "Volume")
  slider\SetX(0, gui::#Anchor_Center,"..")
  slider\SetY(2, gui::#Anchor_Bottom,"..btn3")
  
  slider\SetUserDataF("Value",0.25)
  slider\SetOn(gui::#Event_LeftClick,@Slider_OnClick())
  
  slider = Gadget::Slider(ele,10,10,16,100, MySliderStyleVertical, "Sound")
  slider\SetUserDataF("Value",0.25)
  slider\SetOn(gui::#Event_LeftClick,@Slider_OnClick())
  
  ProcedureReturn #True
EndProcedure

Procedure SDL_quit()
  
  Object::Delete(gui)
  Object::Delete(*TexFrame)
  Object::Delete(*TexButton)
  object::Delete(*TexSliderHorizontal)
  
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
    MessageRequester(#title,"SDL Error" + #LF$ + SDL::GetError())
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
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 562
; FirstLine = 353
; Folding = -LfAA+-
; EnableXP