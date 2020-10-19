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
  Structure sSliderHorizontalStyle
    *texture
  EndStructure
  
  Declare Button(*parentGuiFrame, x.l,y.l,w.l,h.l, *sButtonStyle, Text.s, name.s="")
  Declare SliderHorizontal(*frame.gui::frame, x.l, y.l, w.l, h.l, *style.sSliderHorizontalStyle,name.s="")
  Declare CreateFrame(*ele.gui::frame, *TexFrame.renderer::texture, sizeable.l=#False, moveable.l=#False, BorderSize.f = 1.0/3.0, CornerSize.f = -99.0)
EndDeclareModule

;- Gadget
Module Gadget
  EnableExplicit
  Enumeration type
    #type_button
    #type_sliderHorizontal
    #type_max
  EndEnumeration
    
  Structure sButtonData
    *style.sButtonStyle
    *TexText.renderer::Texture
    *TexTextHighlight.renderer::Texture
    *TexTextDisabled.renderer::Texture
  EndStructure
  Structure sSliderHData
    *style.sSliderHorizontalStyle
  EndStructure
  
  Structure sGadgetData
    type.l
    state.l   
    StructureUnion
      button.sButtonData
      SliderH.sSliderHData
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
  
  Procedure SliderHorizontalUpdate(*but.gui::Frame, *bData.sGadgetData)
    Protected.gui::frame frame
    Protected.f top, bot
    Protected.l what
        
    If *bData\type <> #type_sliderHorizontal
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
    
    frame = *but\GetFrame(".Slider")
    frame\SetTexture( *bData\SliderH\style\texture, 0.0,top, 0.25,bot)
        
    frame = *but\GetFrame(".Left")
    frame\SetTexture( *bData\SliderH\style\texture, 0.25,top, 0.50,bot)
    
    frame = *but\GetFrame(".Right")
    frame\SetTexture( *bData\SliderH\style\texture, 0.75,top, 1.0,bot)
    
    frame = *but\GetFrame(".Mid")
    frame\SetTexture( *bData\SliderH\style\texture, 0.50,top, 0.75,bot)
    
    
  EndProcedure
  
  Procedure GadgetUpdate(*gad.gui::Frame, *bData.sGadgetData)
    Select *bData\type
      Case #type_button
        ButtonUpdate( *gad, *bData )
      Case #type_sliderHorizontal
        SliderHorizontalUpdate(*gad.gui::Frame, *bData)
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
    *parent\SetUserDataF("Value", *gad\GetX() / (*parent\GetW()-*gad\GetW()),#True)
    *parent\DoOn(gui::#Event_LeftClick)    
  EndProcedure
  Procedure Slider_UserData(event, *parent.gui::frame, *bData.sGadgetData)
    Protected.gui::Frame *gad 
    If PeekS(event)="Value"
      *gad= *parent\GetFrame(".Slider")
      *gad\setx( (*parent\GetW()-*gad\GetW()) * *parent\GetUserDataF("Value") )      
    EndIf
  EndProcedure
  Procedure Slider_Click(event, *parent.gui::Frame, *bData.sGadgetData)
    Protected.gui::Frame *gad = *parent\GetFrame(".Slider")
    Protected m.sdl::point
    Protected value.f
    *parent\GetRelativMouse(m)
    m\x - *gad\geth()/2
    value.f = m\x / (*parent\GetW()-*gad\GetW())
    If value.f < 0
      value.f = 0
    ElseIf value.f > 1.0
      value.f = 1.0
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
    Debug "move "+ *frame\GetName()
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
  
  Procedure SliderHorizontal(*frame.gui::frame, x.l, y.l, w.l, h.l, *style.sSliderHorizontalStyle,name.s="")
    Static count.l
    If name=""
      count+1
      name="Slider_"+count
    EndIf
    Protected.gui::frame *slider = *frame\NewChild(name)
    Protected.gui::frame deco
    Protected.sGadgetData *bData = AllocateStructure(sGadgetData)
    *bData\state = #state_none
    *bData\type = #type_sliderHorizontal
    *bData\SliderH\style = *style
    
    
    *slider\SetPosition(x,y,w,h)
    
    
    deco=*slider\NewChild("Left", gui::#State_OnBack)    
    deco\SetPosition(h/2,0, h, h)
    
    deco=*slider\NewChild("Right", gui::#State_OnBack)
    deco\SetPosition(0,0, h, h)
    deco\setX(-h*3/2, gui::#Anchor_Right,"..")
    
    deco=*slider\NewChild("Mid", gui::#State_OnBack)
    deco\SetX(0, gui::#Anchor_Right, "..Left")
    deco\Sety(0, gui::#Anchor_Top, "..Left")
    deco\SetW(0, gui::#Anchor_Left, "..Right")
    deco\setH(0, gui::#Anchor_Bottom, "..Right")
    
    deco=*slider\NewChild("Slider")
    deco\SetPosition(0,0, h, h)
    
    *slider\SetUserData(#UserData, *bData)
    SliderHorizontalUpdate(*slider, *bData)
    
    deco\SetOn(gui::#Event_LeftDown, @Slider_LeftDown(), *bData)
    deco\SetOn(gui::#Event_LeftUp, @Slider_LeftUp(), *bData)
    deco\SetOn(gui::#Event_enter, @GadgetParent_Enter(), *bData)
    deco\SetOn(gui::#Event_leave, @GadgetParent_Leave(), *bData)
    deco\SetOn(gui::#Event_moving, @Slider_moving(), *bData)
    *slider\SetOn(gui::#Event_StateChange, @Gadget_State(), *bData)
    *slider\SetOn(gui::#Event_Destroy, @Gadget_Destroy(), *bData)
    *slider\SetOn(gui::#Event_UserData, @Slider_UserData(), *bData)
    *slider\SetOn(gui::#Event_LeftDown, @Slider_Click(), *bData)
    
    ProcedureReturn *slider
  EndProcedure
  
  Procedure CreateFrame(*ele.gui::frame, *TexFrame.renderer::texture, sizeable.l=#False, moveable.l=#False, BorderSize.f = 1.0/3.0, CornerSize.f = -99.0)
    Protected.GUI::frame deco
    Protected.l outside
    
    If BorderSize<0
      BorderSize = -BorderSize
      outside = gui::#State_ClipOutside
    Else
      outside = 0
    EndIf
        
    If CornerSize<-90
      CornerSize=BorderSize
    ElseIf CornerSize<0
      CornerSize = -CornerSize
    EndIf
    
    If BorderSize < 0.0
      BorderSize = 0.0
    ElseIf BorderSize > 1.0
      BorderSize = 1.0
    EndIf
    
    If CornerSize < 0.0
      CornerSize = 0.0
    ElseIf CornerSize > 1.0
      CornerSize = 1.0
    EndIf
    
    
    deco=*ele\NewChild("Top", outside | gui::#State_OnBack)
    deco\SetTexture( *TexFrame, BorderSize,0,   1.0-BorderSize,BorderSize, GUI::#tex_tile)
    deco\SetPosition(#PB_Ignore, #PB_Ignore, #PB_Ignore, GUI::#Offset_TextureSize)
    deco\setx(0, GUI::#Anchor_Left, "..")
    If outside
      deco\sety(- GUI::#Offset_TextureSize, GUI::#Anchor_top, ".."  )
    Else
      deco\sety(0, GUI::#Anchor_top, ".."  )
    EndIf
    deco\setw(0, GUI::#Anchor_right, ".." )
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Top)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    deco=*ele\NewChild("Bottom", outside | gui::#State_OnBack)
    deco\SetTexture( *TexFrame, BorderSize,1.0-BorderSize,   1.0-BorderSize,1.0, GUI::#tex_tile)
    deco\SetPosition(#PB_Ignore,#PB_Ignore,#PB_Ignore,GUI::#Offset_TextureSize)
    deco\setx(0, GUI::#Anchor_Left, "..")
    If outside
      deco\sety(0, GUI::#Anchor_Bottom, ".."  )
    Else
      deco\sety(-GUI::#Offset_FrameSize, GUI::#Anchor_Bottom, ".."  )
    EndIf
    deco\setw(0, GUI::#Anchor_right, ".." )
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Bottom)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    deco=*ele\NewChild("Left", outside | gui::#State_OnBack)
    deco\SetTexture(*TexFrame, 0, BorderSize,  BorderSize,1.0-BorderSize, GUI::#tex_tile)
    deco\SetPosition(#PB_Ignore,#PB_Ignore,GUI::#Offset_TextureSize,#PB_Ignore)
    If outside
      deco\setx(-GUI::#Offset_FrameSize, GUI::#Anchor_Left, "..")
    Else
      deco\setx(0, GUI::#Anchor_Left, "..")
    EndIf
    deco\sety(0, GUI::#Anchor_Top, "..")
    deco\seth(0, GUI::#Anchor_Bottom, "..")
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Left)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    deco=*ele\NewChild("Right", outside | gui::#State_OnBack)
    deco\SetTexture(*TexFrame, 1.0-BorderSize, BorderSize,  1.0,1.0-BorderSize, GUI::#tex_tile)
    deco\SetPosition(#PB_Ignore,#PB_Ignore,GUI::#Offset_TextureSize,#PB_Ignore)
    If outside
      deco\setx(0, GUI::#Anchor_Right, "..")
    Else
      deco\setx(-GUI::#Offset_FrameSize, GUI::#Anchor_Right, "..")
    EndIf
    deco\sety(0, GUI::#Anchor_Top, "..")
    deco\seth(0, GUI::#Anchor_Bottom, "..")
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Right)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    deco=*ele\NewChild("Mid", outside | gui::#State_OnBack)
    deco\SetTexture( *TexFrame, CornerSize, CornerSize, 1.0-CornerSize, 1.0-CornerSize, GUI::#tex_tile)
    deco\setx(0, GUI::#Anchor_Right, "..Left" )
    deco\sety(0, GUI::#Anchor_Bottom, "..Top" )
    deco\setw(0, GUI::#Anchor_Left, "..Right" )
    deco\seth(0, GUI::#Anchor_Top, "..Bottom" )      
    If moveable
      *ele\SetOn(GUI::#Event_LeftDown, @FrameMove_LeftDown())
      *ele\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    
    deco=*ele\NewChild("LeftTop", outside | gui::#State_OnBack)
    deco\SetTexture( *TexFrame, 0, 0, CornerSize, CornerSize)
    deco\SetPosition(#PB_Ignore,#PB_Ignore,GUI::#Offset_TextureSize,GUI::#Offset_TextureSize)
    deco\setx(0, GUI::#Anchor_Left, "..Left" )
    deco\sety(0, GUI::#Anchor_top, "..Top" )
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Left | GUI::#Size_Top)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    deco=*ele\NewChild("RightTop", outside | gui::#State_OnBack)
    deco\SetTexture( *TexFrame, 1.0-CornerSize, 0, 1.0, CornerSize)
    deco\SetPosition(#PB_Ignore,#PB_Ignore,GUI::#Offset_TextureSize,GUI::#Offset_TextureSize)
    deco\setx(-GUI::#Offset_FrameSize, GUI::#Anchor_right, "..Right" )
    deco\sety(0,GUI::#Anchor_top, "..Top" )
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Right | GUI::#Size_Top)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    deco=*ele\NewChild("LeftBottom", outside | gui::#State_OnBack)
    deco\SetTexture( *TexFrame, 0, 1.0-CornerSize, CornerSize, 1.0)
    deco\SetPosition(#PB_Ignore,#PB_Ignore,GUI::#Offset_TextureSize,GUI::#Offset_TextureSize)
    deco\setx(0, GUI::#Anchor_Left, "..Left" )
    deco\sety(-GUI::#Offset_FrameSize, GUI::#Anchor_Bottom, "..Bottom" )
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Left | GUI::#Size_Bottom)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
    EndIf
    
    deco=*ele\NewChild("RightBottom", outside | gui::#State_OnBack)
    deco\SetTexture( *TexFrame, 1.0-CornerSize, 1.0-CornerSize, 1.0, 1.0)
    deco\SetPosition(#PB_Ignore,#PB_Ignore,GUI::#Offset_TextureSize,GUI::#Offset_TextureSize)
    deco\setx(-GUI::#Offset_FrameSize, GUI::#Anchor_right, "..Right" )
    deco\sety(-GUI::#Offset_FrameSize, GUI::#Anchor_Bottom, "..Bottom" )
    If sizeable
      deco\SetOn(GUI::#Event_LeftDown, @FrameSize_LeftDown(), GUI::#Size_Right | GUI::#Size_Bottom)
      deco\SetOn(GUI::#Event_LeftUp, @FraneStop_OnLeftUp())
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
Global.Gui::Class Gui
Global.sdl::TTF_Font *font
Global.gadget::sButtonStyle MyButtonStyle
Global.gadget::sSliderHorizontalStyle MySliderStyle

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
  
  
  gui = gui::New( render )
  
  Protected ele.gui::frame
  Protected deco.gui::frame
  
  ele = gui\NewElement("Frame1")  
  ele\setx(30)
  ele\sety(30)
  ele\setw(100)
  ele\seth(100)  
  ele\SetOn(gui::#Event_enter, @OnCallback(),1 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),1 )
  gadget::CreateFrame(ele,*TexFrame,#False,#True)
  ele\SetOn(gui::#Event_LeftClick,@Frame1_OnClick())
  
  ele = ele\NewChild("Frame2")  
  ele\setx(-10)
  ele\sety(20)
  ele\setw(150)
  ele\seth(30)
  gadget::CreateFrame(ele,*TexFrame,#False,#False,2.0/64.0, 5.0/64.0)
  ele\SetOn(gui::#Event_enter, @OnCallback(),2 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),2 )
  
  ele = gui\NewElement("Frame3")
  ele\setx(50)
  ele\sety(120)
  ele\setw(35)
  ele\seth(30)
  ele\SetOn(gui::#Event_enter, @OnCallback(),3 )
  ele\SetOn(gui::#Event_leave, @OnCallback(),3 )
  gadget::CreateFrame(ele,*TexFrame,#True,#True,-2.0/64.0,-5.0/64.0)
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
  
  MySliderStyle\texture = *TexSliderHorizontal
  
  Protected.gui::frame slider
  
  slider = Gadget::SliderHorizontal(ele,10,10,100,16, MySliderStyle, "Volume")
  slider\SetX(0, gui::#Anchor_Center,"..")
  slider\SetY(2, gui::#Anchor_Bottom,"..btn3")
  
  slider\SetUserDataF("Value",0.5)
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
; CursorPosition = 722
; FirstLine = 702
; Folding = -------
; EnableXP