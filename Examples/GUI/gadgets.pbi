
;-declaremodule
DeclareModule Gadget
  
EndDeclareModule

;- Gadget
Module Gadget
  EnableExplicit
    
  Structure sButtonData
    *TexText.renderer::Texture
    *TexTextHighlight.renderer::Texture
    *TexTextDisabled.renderer::Texture
    ownTexture.l
  EndStructure
    
  #UserData = "GadgetData"
   

  Procedure Button_Update(*but.gui::Frame, *gadData.sButtonData)
    Protected.gui::frame frame
    Protected.f top, bot
    Protected.l what, offset
    Protected.l pushed = *but\GetState(gui::#State_UserPushed)
    Protected.l highlight = *but\GetState(gui::#State_UserHighlight)

    If *but\GetState(gui::#State_disabled)
      what = gui::#State_disabled
    ElseIf pushed And highlight
      what = gui::#State_UserPushed
    ElseIf pushed Or highlight
      what = gui::#State_UserHighlight
    Else
      what = 0; #state_none
    EndIf
    
    frame = *but\GetFrame(".Text")
    Select what
      Case 0;#state_none
        frame\SetX(0, gui::#Anchor_Center, "..")
        frame\SetY(0, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\TexText,0,0,1,1)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case gui::#State_UserHighlight
        frame\SetX(0, gui::#Anchor_Center, "..")
        frame\SetY(0, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\TexTextHighlight,0,0,1,1)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case gui::#State_UserPushed
        offset = *but\GetUserData("OffsetPushedText")
        frame\SetX(offset, gui::#Anchor_Center, "..")
        frame\SetY(offset, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\TexTextHighlight,0,0,1,1)
        top = 2.0/4.0
        bot = 3.0/4.0
      Case gui::#State_disabled
        frame\SetX(0, gui::#Anchor_Center, "..")
        frame\SetY(0, gui::#Anchor_Center, "..")
        frame\SetTexture(*gadData\TexTextDisabled,0,0,1,1)
        top = 3.0/4.0
        bot = 4.0/4.0
    EndSelect
    
    Protected *texBackground = *but\GetNamedTexture( *but\GetUserDataS("Texture") )    
    
    frame = *but\GetFrame(".dLeft")
    frame\SetTexture( *texBackground, 0.0,top, 0.25,bot)
    
    frame = *but\GetFrame(".dRight")
    frame\SetTexture( *texBackground, 0.75,top, 1.0,bot)
    
    frame = *but\GetFrame(".dMid")
    frame\SetTexture( *texBackground, 0.25,top, 0.75,bot)    
    
  EndProcedure
  Procedure Button_CreateTextures(*but.gui::frame, *gadData.sButtonData)
    Protected.s text = *but\GetUserDataS("Text")
    Protected *font = *but\GetNamedFont( *but\GetUserDataS("Font") )
    Protected.l textColor = *but\GetUserData("TextColor")
    Protected.l textColorDisabled = *but\GetUserData("TextColorDisabled")
    Protected.l textColorHighlight = *but\GetUserData("TextColorHighlight")
    
    If *gadData\ownTexture 
      Object::delete(*gadData\TexText)
      Object::delete(*gadData\TexTextDisabled)
      Object::delete(*gadData\TexTextHighlight)
    EndIf
    
    If text=""
      text=" "
    EndIf
    
    Protected.renderer::Class *render = *but\GetRenderer()
    Protected.sdl::color col
    
    col\ r = Red(textColor) : col\g = Green(textColor) : col\b = Blue(textColor) : col\a = Alpha(textColor)
    *gadData\TexText          = *render\RenderText( *font, text, col) 
    
    col\ r = Red(textColorDisabled) : col\g = Green(textColorDisabled) : col\b = Blue(textColorDisabled) : col\a = Alpha(textColorDisabled)
    *gadData\TexTextDisabled  = *render\RenderText( *font, text, col) 
    
    col\ r = Red(textColorHighlight) : col\g = Green(textColorHighlight) : col\b = Blue(textColorHighlight) : col\a = Alpha(textColorHighlight)
    *gadData\TexTextHighlight = *render\RenderText( *font, text, col) 
    
    *gadData\ownTexture = #True
        
  EndProcedure
  
  Runtime Procedure Button_UserData(*but.gui::frame, *whatStr)    
    If PeekS(*whatStr) = "Text"         
      Protected.sButtonData *gadData = *but\GetUserData( #UserData )
      Button_CreateTextures(*but, *gadData)
      Button_Update(*but, *gadData)            
    EndIf
  EndProcedure
  
  Runtime Procedure Button_State(*gad.gui::frame, whichState )
    If whichState = gui::#state_disabled Or
       whichState = gui::#State_UserHighlight Or
       whichState = gui::#State_UserPushed

      Button_Update(*gad, *gad\GetUserData( #UserData )  )
    EndIf
  EndProcedure  
  
  Runtime Procedure Button_Load(*but.gui::Frame, *data)
    Protected.sButtonData *gadData = *but\GetUserData( #UserData )  
    
    *gadData = AllocateStructure(sButtonData)
    
    *but\SetUserData(#UserData, *gadData, #True) 
    
    Button_CreateTextures(*but, *gadData)
    Button_Update(*but, *gadData)

  EndProcedure
  
  Runtime Procedure Button_Delete(*gad.gui::Frame, *data )
    Protected.sButtonData *gadData = *gad\GetUserData( #UserData )  
    If *gadData\ownTexture
      Object::delete(*gadData\TexText)
      Object::delete(*gadData\TexTextDisabled)
      Object::delete(*gadData\TexTextHighlight)
    EndIf          
    
    FreeStructure(*gadData)
  EndProcedure
  
  ;-
  Procedure Slider_Update(*slider.gui::frame)
    Protected.gui::frame frameSlider,frameLeft,frameRight,frameMid
    Protected.f top, bot
    Protected.l what    
    Protected.l pushed = *slider\GetState(gui::#State_UserPushed)
    Protected.l highlight = *slider\GetState(gui::#State_UserHighlight)
    Protected.renderer::Texture *tex = *slider\GetNamedTexture ( *slider\GetUserDataS("Texture") )
    
    If *slider\GetState( gui::#State_disabled )
      what = gui::#State_disabled
    ElseIf pushed And highlight
      what = gui::#State_UserPushed
    ElseIf pushed Or highlight
      what = gui::#State_UserHighlight
    Else
      what = 0;#state_none
    EndIf
    
    Select what
      Case 0;#state_none
        top = 0.0/4.0
        bot = 1.0/4.0
      Case gui::#State_UserHighlight
        top = 0.0/4.0
        bot = 1.0/4.0
      Case gui::#State_UserPushed
        top = 2.0/4.0
        bot = 3.0/4.0
      Case gui::#State_disabled
        top = 3.0/4.0
        bot = 4.0/4.0
    EndSelect
    
    frameSlider = *slider\GetFrame(".Slider")
    frameLeft = *slider\GetFrame(".dLeft")
    frameRight = *slider\GetFrame(".dRight")
    frameMid = *slider\GetFrame(".dMid")
    
    If *slider\GetUserData("Vertical")
      frameSlider\SetTexture( *tex, top, 0.0, bot, 0.25)
      frameLeft\SetTexture( *tex, top, 0.25, bot, 0.50)
      frameRight\SetTexture( *tex, top, 0.75, bot, 1.0)
      frameMid\SetTexture( *tex, top, 0.50, bot, 0.75)
    Else
      frameSlider\SetTexture( *tex, 0.0,top, 0.25,bot)
      frameLeft\SetTexture( *tex, 0.25,top, 0.50,bot)
      frameRight\SetTexture( *tex, 0.75,top, 1.0,bot)
      frameMid\SetTexture( *tex, 0.50,top, 0.75,bot)
    EndIf
    
  EndProcedure
  Runtime Procedure Slider_LeftDown(*gad.gui::frame, *data)
    Protected.gui::Frame *parent = *gad\GetParent()
    *parent\SetState(gui::#State_UserPushed, #True)
    *gad\StartUserMoving()
  EndProcedure
  
  Runtime Procedure Slider_LeftUp(*gad.gui::frame, *data)
    Protected.gui::Frame *parent = *gad\GetParent()
    *parent\SetState(gui::#State_UserPushed, #False)
    *gad\StopUserSizingMoving()
  EndProcedure
  
  Runtime Procedure Slider_moving(*gad.gui::Frame, *data)
    Protected.gui::Frame *parent = *gad\GetParent()
    ;Protected.sGadgetData *gadData = *parent\GetUserData( #UserData )  
    Protected.f value
    If *parent\GetUserData("Vertical")
      value= *gad\GetY() / (*parent\GetH()-*gad\GetH())
    Else
      value= *gad\GetX() / (*parent\GetW()-*gad\GetW())
    EndIf
    If value < 0.0 : value = 0.0 : ElseIf value > 1.0 : value = 1.0 : EndIf
    If *parent\GetUserData("Flipped")
      value = 1.0-value
    EndIf
    *parent\SetUserDataF("Value", value, #True)
    
    *parent\CallEventBinding(gui::#Event_UserAction,#Null)    
  EndProcedure
  
  Runtime Procedure Slider_UserData(*parent.gui::frame, *whatStr)
    ;Protected.sGadgetData *gadData = *parent\GetUserData( #UserData )  
    Protected.gui::Frame *gad     
    Protected.f value
    
    If PeekS(*whatStr)="Value"
      *gad= *parent\GetFrame(".Slider")
      value =  *parent\GetUserDataF("Value")
      If value < 0.0 : value = 0.0 : ElseIf value > 1.0 : value = 1.0 : EndIf
      If *parent\GetUserData("Flipped")
        value = 1.0-value
      EndIf
      
      If *parent\GetUserData("Vertical")
        *gad\SetY( (*parent\GetH()-*gad\GetH()) * Value )  
      Else
        *gad\SetX( (*parent\GetW()-*gad\GetW()) * Value )      
      EndIf
    EndIf
  EndProcedure
  
  Runtime Procedure Slider_Click(*parent.gui::Frame, *data)
    ;Protected.sGadgetData *gadData = *parent\GetUserData( #UserData )  

    Protected.gui::Frame *gad = *parent\GetFrame(".Slider")
    Protected m.sdl::point
    Protected value.f
    *parent\GetRelativMouse(m)
    
    If *parent\GetUserData("Vertical")
      m\y - *gad\GetW()/2
      value.f = m\y / (*parent\GetH()-*gad\GetH())
    Else
      m\x - *gad\geth()/2
      value.f = m\x / (*parent\GetW()-*gad\GetW())
    EndIf
        
    If value.f < 0.0 : value.f = 0.0 : ElseIf value.f > 1.0 : value.f = 1.0 : EndIf
    If *parent\GetUserData("Flipped")
      value = 1.0-value
    EndIf
    
    *parent\SetUserDataF("Value",value)
    ;simulate left click on slider
    *parent\SetState(gui::#State_UserHighlight, #True)
    Slider_LeftDown(*gad, #Null)
  EndProcedure
  
  Runtime Procedure Slider_Load(*slider.gui::Frame, *data)
    Slider_Update(*slider)
    Slider_UserData(*slider, @"Value"); Update slider position
  EndProcedure
  
  Runtime Procedure Slider_State(*gad.gui::frame, whichState )
    If whichState = gui::#state_disabled Or
       whichState = gui::#State_UserHighlight Or
       whichState = gui::#State_UserPushed
      
      Slider_Update(*gad)
    EndIf
  EndProcedure
  ;-
  
  Procedure Checkbox_Update(*but.gui::Frame, *gadData.sButtonData)
    Protected.gui::frame frame
    Protected.f top, bot, CheckedOffset
    Protected.l what
    Protected.l pushed = *but\GetState(gui::#State_UserPushed)
    Protected.l highlight = *but\GetState(gui::#State_UserHighlight)
    
    
    If *but\GetUserData("Value")
      CheckedOffset = 0.5
    EndIf
        
    If *but\GetState(gui::#State_disabled)
      what = gui::#State_disabled
    ElseIf pushed And highlight
      what = gui::#State_UserPushed
    ElseIf pushed Or highlight
      what = gui::#State_UserHighlight
    Else
      what = 0; #state_none
    EndIf
    
    frame = *but\GetFrame(".Text")
    Select what
      Case 0;#state_none
        frame\SetTexture(*gadData\TexText,0,0,1,1,gui::#tex_single)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case gui::#State_UserHighlight
        frame\SetTexture(*gadData\TexTextHighlight,0,0,1,1,gui::#tex_single)
        top = 0.0/4.0
        bot = 1.0/4.0
      Case gui::#State_UserPushed
        frame\SetTexture(*gadData\TexTextHighlight,0,0,1,1,gui::#tex_single)
        top = 2.0/4.0
        bot = 3.0/4.0
      Case gui::#State_disabled
        frame\SetTexture(*gadData\TexTextDisabled,0,0,1,1,gui::#tex_single)
        top = 3.0/4.0
        bot = 4.0/4.0
    EndSelect
    
    Protected *texBackground = *but\GetNamedTexture( *but\GetUserDataS("Texture") )    
    
    frame = *but\GetFrame(".Box")
    frame\SetTexture( *texBackground, CheckedOffset,top, CheckedOffset+0.5,bot)
        
  EndProcedure
  
  Procedure Checkbox_CreateTextures(*but.gui::frame, *gadData.sButtonData)
    Protected.s text = *but\GetUserDataS("Text")
    Protected *font = *but\GetNamedFont( *but\GetUserDataS("Font") )
    Protected.l textColor = *but\GetUserData("TextColor")
    Protected.l textColorDisabled = *but\GetUserData("TextColorDisabled")
    Protected.l textColorHighlight = *but\GetUserData("TextColorHighlight")
    
    If *gadData\ownTexture 
      Object::delete(*gadData\TexText)
      Object::delete(*gadData\TexTextDisabled)
      Object::delete(*gadData\TexTextHighlight)
    EndIf
    
    If text=""
      text=" "
    EndIf
    
    Protected.renderer::Class *render = *but\GetRenderer()
    Protected.sdl::color col
    
    col\ r = Red(textColor) : col\g = Green(textColor) : col\b = Blue(textColor) : col\a = Alpha(textColor)
    *gadData\TexText          = *render\RenderText( *font, text, col) 
    
    col\ r = Red(textColorDisabled) : col\g = Green(textColorDisabled) : col\b = Blue(textColorDisabled) : col\a = Alpha(textColorDisabled)
    *gadData\TexTextDisabled  = *render\RenderText( *font, text, col) 
    
    col\ r = Red(textColorHighlight) : col\g = Green(textColorHighlight) : col\b = Blue(textColorHighlight) : col\a = Alpha(textColorHighlight)
    *gadData\TexTextHighlight = *render\RenderText( *font, text, col) 
    
    *gadData\ownTexture = #True
        
  EndProcedure
  
  Runtime Procedure Checkbox_UserData(*but.gui::frame, *whatStr)    
    Protected.s str = PeekS(*whatStr) 
    Protected.sButtonData *gadData
    If str = "Text" 
      *gadData = *but\GetUserData( #UserData )
      Checkbox_CreateTextures(*but, *gadData)
      Checkbox_Update(*but, *gadData)            
    ElseIf str = "Value"
      *gadData = *but\GetUserData( #UserData )
      Checkbox_Update(*but, *gadData)        
    EndIf
  EndProcedure
  
  Runtime Procedure Checkbox_State(*gad.gui::frame, whichState )
    If whichState = gui::#state_disabled Or
       whichState = gui::#State_UserHighlight Or
       whichState = gui::#State_UserPushed

      Checkbox_Update(*gad, *gad\GetUserData( #UserData )  )
    EndIf
  EndProcedure  
  
  Runtime Procedure Checkbox_Load(*but.gui::Frame, *data)
    Protected.sButtonData *gadData = *but\GetUserData( #UserData )  
    
    *gadData = AllocateStructure(sButtonData)    
    *but\SetUserData(#UserData, *gadData, #True) 
    
    Debug "LOAD CHECKBOX"
    
    Checkbox_CreateTextures(*but, *gadData)
    Checkbox_Update(*but, *gadData)

  EndProcedure
  
  Runtime Procedure Checkbox_Delete(*gad.gui::Frame, *data )
    Protected.sButtonData *gadData = *gad\GetUserData( #UserData )  
    If *gadData\ownTexture
      Object::delete(*gadData\TexText)
      Object::delete(*gadData\TexTextDisabled)
      Object::delete(*gadData\TexTextHighlight)
    EndIf  
    FreeStructure(*gadData)
  EndProcedure
  
  Runtime Procedure Checkbox_Click(*gad.gui::Frame, *data)
    Protected state = Bool( Not *gad\GetUserData("Value") )  
    *gad\SetUserData("Value", state)
    *gad\CallEventBinding( gui::#Event_UserAction, *data )    
  EndProcedure  
  
  ;-
  Runtime Procedure GadgetParent_Pushed(*gad.gui::frame, *data)
    Protected.gui::Frame *parent = *gad\GetParent()
    *parent\SetState(gui::#State_UserPushed, #True)
  EndProcedure
  Runtime Procedure GadgetParent_DePushed(*gad.gui::frame, *data)
    Protected.gui::Frame *parent = *gad\GetParent()
    *parent\SetState(gui::#State_UserPushed, #False)
  EndProcedure
  Runtime Procedure GadgetParent_Highlight(*gad.gui::frame, *data)
    Protected.gui::Frame *parent = *gad\GetParent()
    *parent\SetState(gui::#State_UserHighlight, #True)  
  EndProcedure
  Runtime Procedure GadgetParent_DeHighlight(*gad.gui::frame, *data)
    Protected.gui::Frame *parent = *gad\GetParent()
    *parent\SetState(gui::#State_UserHighlight, #False)
  EndProcedure
  
  ;-
  
  Runtime Procedure Gadget_Pushed(*gad.gui::frame, *data )
    *gad\SetState(gui::#State_UserPushed, #True)
  EndProcedure
  Runtime Procedure Gadget_DePushed(*gad.gui::frame, *data )
    *gad\SetState(gui::#State_UserPushed, #False)
  EndProcedure
  Runtime Procedure Gadget_Highlight(*gad.gui::frame, *data )
    *gad\SetState(gui::#State_UserHighlight, #True)        
  EndProcedure
  Runtime Procedure Gadget_DeHighlight(*gad.gui::frame, *data )
    *gad\SetState(gui::#State_UserHighlight, #False)
  EndProcedure
  Runtime Procedure Gadget_Click(*gad.gui::frame, *data)
    *gad\CallEventBinding( gui::#Event_UserAction, #Null)
  EndProcedure
  
  ;-
  
  
  Runtime Procedure WindowMove_LeftDown(*frame.GUI::frame, *data)
    Protected.GUI::frame *parent = *frame\GetParent()    
    If *parent\GetUserData("Moveable")      
      *parent\SortUp()
      *parent\StartUserMoving()
    EndIf
  EndProcedure
  
  Runtime Procedure WindowSize_LeftDown(*frame.GUI::frame, *data)
    Protected.GUI::frame *parent = *frame\GetParent()
    If *parent\GetUserData("Sizeable")
      *parent\SortUp()
      
      Select *frame\GetName(#False)
        Case "dTop" : *parent\StartUserSizing(gui::#Size_Top)
        Case "dBottom" : *parent\StartUserSizing(gui::#Size_Bottom)
        Case "dLeft" : *parent\StartUserSizing(gui::#Size_Left)
        Case "dRight" : *parent\StartUserSizing(gui::#Size_Right)
        Case "dLeftTop" : *parent\StartUserSizing(gui::#Size_Top | gui::#Size_Left)
        Case "dRightTop" : *parent\StartUserSizing(gui::#Size_Top | gui::#Size_Right)
        Case "dLeftBottom" : *parent\StartUserSizing(gui::#Size_Bottom | gui::#Size_Left)
        Case "dRightBottom" : *parent\StartUserSizing(gui::#Size_Bottom | gui::#Size_Right)
      EndSelect
    ElseIf *parent\GetUserData("Moveable") 
      *parent\SortUp()
      *parent\StartUserMoving()
    EndIf
  
  EndProcedure
  
  Runtime Procedure WindowStop_LeftUp(*frame.GUI::Frame, *data)
    *frame\StopUserSizingMoving()
  EndProcedure
  

EndModule
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 425
; FirstLine = 398
; Folding = -------
; EnableXP