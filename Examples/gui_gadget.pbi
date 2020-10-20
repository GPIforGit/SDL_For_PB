XIncludeFile "gui.pbi"
;-declaremodule
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
  Structure sWindowStyle
    *Texture.renderer::Texture
    border.l
    corner.l
    stretch.l
  EndStructure
  
  EnumerationBinary
    #Window_Moveable
    #Window_Sizeable
  EndEnumeration
  
   
  Declare Button(*parentGuiBoth,name.s, x.l, y.l, w.l, h.l, *sButtonStyle, Text.s)
  Declare Slider(*parentGuiBoth,name.s, x.l, y.l, w.l, h.l, *sSliderStyle, value.f)
  Declare Window(*parentGuiBoth,name.s, x.l, y.l, w.l, h.l, *sWindowStyle, flags.l = #Null)    
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
    style.sButtonStyle
    *TexText.renderer::Texture
    *TexTextHighlight.renderer::Texture
    *TexTextDisabled.renderer::Texture
  EndStructure
  Structure sSliderData
    style.sSliderStyle
  EndStructure
  
  Structure sGadgetData
    type.l
    state.l   
    StructureUnion
      button.sButtonData
      slider.sSliderData
    EndStructureUnion
  EndStructure
  #UserData = "GadgetData"
  
  EnumerationBinary 
    #state_none = 0
    #state_highlight
    #state_pushed
    #state_disabled
  EndEnumeration
  
  
  Procedure ButtonUpdate(*but.gui::Frame, *gadData.sGadgetData)
    Protected.gui::frame frame
    Protected.f top, bot
    Protected.l what
        
    If *gadData\type <> #type_button
      ProcedureReturn 
    EndIf    
    
    If *gadData\state & #state_disabled
      what = #state_disabled
    ElseIf *gadData\state & (#state_pushed | #state_highlight) = (#state_pushed | #state_highlight)
      what = #state_pushed
    ElseIf *gadData\state & (#state_highlight|#state_pushed)
      what = #state_highlight
    Else
      what = #state_none
    EndIf
    
    frame = *but\GetFrame(".Text")
    Select what
      Case #state_none
        frame\SetX(*gadData\button\style\offset\x, gui::#Anchor_Center, "..")
        frame\SetY(*gadData\button\style\offset\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\button\TexText,0,0,1,1)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case #state_highlight
        frame\SetX(*gadData\button\style\offset\x, gui::#Anchor_Center, "..")
        frame\SetY(*gadData\button\style\offset\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\button\TexTextHighlight,0,0,1,1)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case #state_pushed
        frame\SetX(*gadData\button\style\offsetPushed\x, gui::#Anchor_Center, "..")
        frame\SetY(*gadData\button\style\offsetPushed\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\button\TexTextHighlight,0,0,1,1)
        top = 2.0/4.0
        bot = 3.0/4.0
      Case #state_disabled
        frame\SetX(*gadData\button\style\offset\x, gui::#Anchor_Center, "..")
        frame\SetY(*gadData\button\style\offset\y, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\button\TexTextDisabled,0,0,1,1)
        top = 3.0/4.0
        bot = 4.0/4.0
    EndSelect
    
    
    frame = *but\GetFrame(".Left")
    frame\SetTexture( *gadData\button\style\texBackground, 0.0,top, 0.25,bot)
    
    frame = *but\GetFrame(".Right")
    frame\SetTexture( *gadData\button\style\texBackground, 0.75,top, 1.0,bot)
    
    frame = *but\GetFrame(".Mid")
    frame\SetTexture( *gadData\button\style\texBackground, 0.25,top, 0.75,bot)
    
    
  EndProcedure
  
  Procedure SliderUpdate(*but.gui::frame, *gadData.sGadgetData)
    Protected.gui::frame frameSlider,frameLeft,frameRight,frameMid
    Protected.f top, bot
    Protected.l what
    
    If *gadData\type <> #type_slider
      ProcedureReturn 
    EndIf    
    
    If *gadData\state & #state_disabled
      what = #state_disabled
    ElseIf *gadData\state & (#state_pushed | #state_highlight) = (#state_pushed | #state_highlight)
      what = #state_pushed
    ElseIf *gadData\state & (#state_highlight|#state_pushed)
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
    
    If *gadData\Slider\style\vertical
      frameSlider\SetTexture( *gadData\Slider\style\texture, top, 0.0, bot, 0.25)
      frameLeft\SetTexture( *gadData\Slider\style\texture, top, 0.25, bot, 0.50)
      frameRight\SetTexture( *gadData\Slider\style\texture, top, 0.75, bot, 1.0)
      frameMid\SetTexture( *gadData\Slider\style\texture, top, 0.50, bot, 0.75)
    Else
      frameSlider\SetTexture( *gadData\Slider\style\texture, 0.0,top, 0.25,bot)
      frameLeft\SetTexture( *gadData\Slider\style\texture, 0.25,top, 0.50,bot)
      frameRight\SetTexture( *gadData\Slider\style\texture, 0.75,top, 1.0,bot)
      frameMid\SetTexture( *gadData\Slider\style\texture, 0.50,top, 0.75,bot)
    EndIf
    
  EndProcedure
  
  Procedure GadgetUpdate(*gad.gui::Frame, *gadData.sGadgetData)
    Select *gadData\type
      Case #type_button
        ButtonUpdate( *gad, *gadData )
      Case #type_slider
        SliderUpdate(*gad.gui::Frame, *gadData)
    EndSelect
  EndProcedure
  
  Procedure Button_UserData(event, *but.gui::frame, *gadData.sGadgetData)
    Protected.s text
    If PeekS(event) = "Value"
      text = *but\GetUserDataS("Value")
      Object::delete(*gadData\button\TexText)
      Object::delete(*gadData\button\TexTextDisabled)
      Object::delete(*gadData\button\TexTextHighlight)
      
      *gadData\button\TexText          = *but\GetTextTexture( *gadData\button\style\font, text, *gadData\button\style\textColor, gui::#tex_single)
      *gadData\button\TexTextDisabled  = *but\GetTextTexture( *gadData\button\style\font, text, *gadData\button\style\textColorDisabled, gui::#tex_single)
      *gadData\button\TexTextHighlight = *but\GetTextTexture( *gadData\button\style\font, text, *gadData\button\style\textColorHighlight, gui::#tex_single)
      
      ButtonUpdate(*but, *gadData)            
    EndIf
  EndProcedure
  
  Procedure Slider_LeftDown(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state | #state_pushed
    GadgetUpdate(*gad\GetParent(), *gadData)
    *gad\StartUserMoving()
  EndProcedure
  
  Procedure Slider_LeftUp(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state & (~#state_pushed)
    GadgetUpdate(*gad\GetParent(), *gadData)
    *gad\StopUserSizingMoving()
  EndProcedure
  
  Procedure Slider_moving(event, *gad.gui::Frame, *gadData.sGadgetData)
    Protected.gui::Frame *parent = *gad\GetParent()
    Protected.f value
    If *gadData\Slider\style\vertical
      value= *gad\GetY() / (*parent\GetH()-*gad\GetH())
    Else
      value= *gad\GetX() / (*parent\GetW()-*gad\GetW())
    EndIf
    If value < 0.0 : value = 0.0 : ElseIf value > 1.0 : value = 1.0 : EndIf
    If *gadData\Slider\style\flipped
      value = 1.0-value
    EndIf
    *parent\SetUserDataF("Value", value, #True)
    
    *parent\DoOn(gui::#Event_LeftClick)    
  EndProcedure
  
  Procedure Slider_UserData(event, *parent.gui::frame, *gadData.sGadgetData)
    Protected.gui::Frame *gad 
    Protected.f value
    If PeekS(event)="Value"
      *gad= *parent\GetFrame(".Slider")
      value =  *parent\GetUserDataF("Value")
      If value < 0.0 : value = 0.0 : ElseIf value > 1.0 : value = 1.0 : EndIf
      If *gadData\Slider\style\flipped
        value = 1.0-value
      EndIf
      
      If *gadData\Slider\style\vertical
        *gad\SetY( (*parent\GetH()-*gad\GetH()) * Value )      
      Else
        *gad\SetX( (*parent\GetW()-*gad\GetW()) * Value )      
      EndIf
    EndIf
  EndProcedure
  
  Procedure Slider_Click(event, *parent.gui::Frame, *gadData.sGadgetData)
    Protected.gui::Frame *gad = *parent\GetFrame(".Slider")
    Protected m.sdl::point
    Protected value.f
    *parent\GetRelativMouse(m)
    
    If *gadData\Slider\style\vertical
      m\y - *gad\GetW()/2
      value.f = m\y / (*parent\GetH()-*gad\GetH())
    Else
      m\x - *gad\geth()/2
      value.f = m\x / (*parent\GetW()-*gad\GetW())
    EndIf
        
    If value.f < 0.0 : value.f = 0.0 : ElseIf value.f > 1.0 : value.f = 1.0 : EndIf
    If *gadData\Slider\style\flipped
      value = 1.0-value
    EndIf
    
    ;Debug value.f
    *parent\SetUserDataF("Value",value)
    ;simulate left click on slider
    *gadData\state | #state_highlight
    Slider_LeftDown(event, *gad, *gadData)
  EndProcedure
  
    
  Procedure GadgetParent_LeftDown(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state | #state_pushed
    GadgetUpdate(*gad\GetParent(), *gadData)
  EndProcedure
  Procedure GadgetParent_LeftUp(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state & (~#state_pushed)
    GadgetUpdate(*gad\GetParent(), *gadData)
  EndProcedure
  Procedure GadgetParent_Enter(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state | #state_highlight
    GadgetUpdate(*gad\GetParent(), *gadData)        
  EndProcedure
  Procedure GadgetParent_Leave(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state & (~#state_highlight)
    GadgetUpdate(*gad\GetParent(), *gadData)
  EndProcedure
  
  Procedure Gadget_LeftDown(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state | #state_pushed
    GadgetUpdate(*gad, *gadData)
  EndProcedure
  Procedure Gadget_LeftUp(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state & (~#state_pushed)
    GadgetUpdate(*gad, *gadData)
  EndProcedure
  Procedure Gadget_Enter(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state | #state_highlight
    GadgetUpdate(*gad, *gadData)        
  EndProcedure
  Procedure Gadget_Leave(event,*gad.gui::frame, *gadData.sGadgetData)
    *gadData\state & (~#state_highlight)
    GadgetUpdate(*gad, *gadData)
  EndProcedure
  Procedure Gadget_State(event,*gad.gui::frame, *gadData.sGadgetData)    
    If *gad\GetState( gui::#state_disabled )
      *gadData\state | #state_disabled
    Else
      *gadData\state & (~#state_disabled)
    EndIf
    GadgetUpdate(*gad, *gadData)
  EndProcedure
  
  Procedure Gadget_Delete(event,*but.gui::Frame, *gadData.sGadgetData)
    If *gadData
      Select *gadData\type
        Case #type_button
          Object::delete(*gadData\button\TexText)
          Object::delete(*gadData\button\TexTextDisabled)
          Object::delete(*gadData\button\TexTextHighlight)
      EndSelect
      
      FreeStructure(*gadData)
    EndIf
  EndProcedure
  
  Procedure WindowSize_LeftDown(event.l, *frame.GUI::frame, what.l)
    Protected.GUI::frame *ele = *frame\GetParent()
    *ele\SortUp()
    *ele\StartUserSizing(what)
  EndProcedure
  Procedure WindowMove_LeftDown(event.l, *frame.GUI::frame, what.l)
    *frame\SortUp()
    *frame\StartUserMoving()
  EndProcedure
  Procedure WindowStop_OnLeftUp(event.l, *frame.GUI::Frame, what.l)
    *frame\StopUserSizingMoving()
  EndProcedure
  
  Procedure Button(*parent.gui::_both, name.s, x.l, y.l, w.l, h.l, *style.sButtonStyle, text.s)
    Protected.gui::frame *but = *parent\NewChild(name)
    Protected.gui::frame deco
    Protected.sGadgetData *gadData = AllocateStructure(sGadgetData)
    
    *gadData\state = #state_none
    *gadData\type = #type_button
    CopyStructure(*style, *gadData\button\style, sButtonStyle)
    
    *gadData\button\TexText          = *but\GetTextTexture( *gadData\button\style\font, text, *gadData\button\style\textColor, gui::#tex_single)
    *gadData\button\TexTextDisabled  = *but\GetTextTexture( *gadData\button\style\font, text, *gadData\button\style\textColorDisabled, gui::#tex_single)
    *gadData\button\TexTextHighlight = *but\GetTextTexture( *gadData\button\style\font, text, *gadData\button\style\textColorHighlight, gui::#tex_single)
        
    If h<=0
      h = *gadData\button\TexText\GetHeight() *3 /2
    EndIf
    If w<=0
      w= *gadData\button\TexText\GetWidth() + h/2
    EndIf
    
    *but\SetPosition(x,y,w,h)
    *but\SetUserDataS("Value", text)
    *but\SetUserData(#UserData, *gadData)    
    
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
        
    ButtonUpdate(*but, *gadData)
    
    *but\SetOn(gui::#Event_LeftDown, @Gadget_LeftDown(), *gadData)
    *but\SetOn(gui::#Event_LeftUp, @Gadget_LeftUp(), *gadData)
    *but\SetOn(gui::#Event_enter, @Gadget_Enter(), *gadData)
    *but\SetOn(gui::#Event_leave, @Gadget_Leave(), *gadData)
    *but\SetOn(gui::#Event_StateChange, @Gadget_State(), *gadData)
    *but\SetOn(gui::#Event_Delete, @Gadget_Delete(), *gadData)
    *but\SetOn(gui::#Event_UserData, @Button_UserData(), *gadData)
    
    ProcedureReturn *but
  EndProcedure
  
  Procedure Slider(*parent.gui::_both, name.s, x.l, y.l, w.l, h.l, *style.sSliderStyle, value.f)
    Protected.gui::frame *slider = *parent\NewChild(name)
    Protected.gui::frame deco
    Protected.sGadgetData *gadData = AllocateStructure(sGadgetData)
    
    *gadData\state = #state_none
    *gadData\type = #type_slider
    CopyStructure(*style, *gadData\Slider\style, sSliderStyle)
        
    *slider\SetPosition(x,y,w,h)
        
    deco=*slider\NewChild("Left", gui::#State_OnBack)
    If *gadData\Slider\style\vertical
      deco\SetPosition(0,0, w, w)
    Else
      deco\SetPosition(0,0, h, h)
    EndIf
         
    deco=*slider\NewChild("Right", gui::#State_OnBack)
    If *gadData\Slider\style\vertical
      deco\SetPosition(0,0, w, w)
      deco\SetY(-w,gui::#Anchor_Bottom,"..")
    Else
      deco\SetPosition(0,0, h, h)
      deco\SetX(-h,gui::#Anchor_Right,"..")
    EndIf
    
    deco=*slider\NewChild("Mid", gui::#State_OnBack)
    If *gadData\Slider\style\vertical
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
    If *gadData\Slider\style\vertical
      deco\SetPosition(0,0, w, w)
    Else
      deco\SetPosition(0,0, h, h)
    EndIf
    
    *slider\SetUserData(#UserData, *gadData)
    SliderUpdate(*slider, *gadData)
    
    deco\SetOn(gui::#Event_LeftDown, @Slider_LeftDown(), *gadData)
    deco\SetOn(gui::#Event_LeftUp, @Slider_LeftUp(), *gadData)
    deco\SetOn(gui::#Event_enter, @GadgetParent_Enter(), *gadData)
    deco\SetOn(gui::#Event_leave, @GadgetParent_Leave(), *gadData)
    deco\SetOn(gui::#Event_moving, @Slider_moving(), *gadData)
    *slider\SetOn(gui::#Event_StateChange, @Gadget_State(), *gadData)
    *slider\SetOn(gui::#Event_Delete, @Gadget_Delete(), *gadData)
    *slider\SetOn(gui::#Event_UserData, @Slider_UserData(), *gadData)
    *slider\SetOn(gui::#Event_LeftDown, @Slider_Click(), *gadData)
    
    
    *slider\SetUserDataF("Value", value)
    
    ProcedureReturn *slider
  EndProcedure
  
  Procedure Window(*parent.gui::_both, name.s, x.l, y.l, w.l, h.l, *style.sWindowStyle, flags.l = #Null)
    #OneThird=1.0/3.0
    Protected.gui::frame *win = *parent\NewChild(name)
    Protected.GUI::frame decoTop,decoBot,decoLeft,decoRight,decoLT,decoRT,decoLB,decoRB,decoMid
    Protected.l outside
    Protected.l offx,offy,offw,offh,offmid,offCorner
    Protected.l tw = *style\Texture\GetWidth() * #OneThird
    Protected.l border = *style\border
    Protected.l corner = *style\corner
    Protected.l stretch
    
    
        
    *win\SetPosition(x, y, w, h)
        
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
    
    decoTop=*win\NewChild("Top", outside | gui::#State_OnBack)
    decoTop\SetTexture( *style\Texture, #OneThird,0,   1.0-#OneThird,#OneThird, Stretch | gui::#tex_AnchorTop)
    
    decoBot=*win\NewChild("Bottom", outside | gui::#State_OnBack)
    decoBot\SetTexture( *style\Texture, #OneThird,1.0-#OneThird,   1.0-#OneThird,1.0, Stretch | gui::#tex_AnchorBottom)
    
    decoLeft=*win\NewChild("Left", outside | gui::#State_OnBack)
    decoLeft\SetTexture(*style\Texture, 0, #OneThird,  #OneThird,1.0-#OneThird, Stretch | gui::#tex_AnchorLeft)
    
    decoRight=*win\NewChild("Right", outside | gui::#State_OnBack)
    decoRight\SetTexture(*style\Texture, 1.0-#OneThird, #OneThird,  1.0,1.0-#OneThird, Stretch | gui::#tex_AnchorRight)
    
    decoMid=*win\NewChild("Mid", outside | gui::#State_OnBack)
    decoMid\SetTexture( *style\Texture, #OneThird, #OneThird, 1.0-#OneThird, 1.0-#OneThird, Stretch)
    
    decoLT=*win\NewChild("LeftTop", outside | gui::#State_OnBack)
    decoLT\SetTexture( *style\Texture, 0, 0, #OneThird, #OneThird,gui::#tex_tile | gui::#tex_AnchorTop|gui::#tex_AnchorLeft)
    
    decoRT=*win\NewChild("RightTop", outside | gui::#State_OnBack)
    decoRT\SetTexture( *style\Texture, 1.0-#OneThird, 0, 1.0, #OneThird,gui::#tex_tile | gui::#tex_AnchorTop|gui::#tex_AnchorRight)
    
    decoLB=*win\NewChild("LeftBottom", outside | gui::#State_OnBack)
    decoLB\SetTexture( *style\Texture, 0, 1.0-#OneThird, #OneThird, 1.0,gui::#tex_tile | gui::#tex_AnchorBottom|gui::#tex_AnchorLeft)
    
    decoRB=*win\NewChild("RightBottom", outside | gui::#State_OnBack)
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
    
    If flags & #Window_Sizeable
      decoTop\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Top)
      decoTop\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
      decoBot\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Bottom)
      decoBot\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
      decoLeft\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Left)
      decoLeft\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
      decoRight\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Right)
      decoRight\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
      decoLT\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Left | GUI::#Size_Top)
      decoLT\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
      decoRT\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Right | GUI::#Size_Top)
      decoRT\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
      decoLB\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Left | GUI::#Size_Bottom)
      decoLB\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
      decoRB\SetOn(GUI::#Event_LeftDown, @WindowSize_LeftDown(), GUI::#Size_Right | GUI::#Size_Bottom)
      decoRB\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
    EndIf
        
    If flags & #Window_Moveable
      *win\SetOn(GUI::#Event_LeftDown, @WindowMove_LeftDown())
      *win\SetOn(GUI::#Event_LeftUp, @WindowStop_OnLeftUp())
    EndIf
    
    ProcedureReturn *win
  EndProcedure

  
EndModule
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 478
; FirstLine = 466
; Folding = ------
; EnableXP