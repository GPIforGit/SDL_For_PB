
#Title ="Gamepad test"
XIncludeFile "../sdl2/SDL.pbi"

EnableExplicit
Global win,gadList,gadButton

Enumeration stage
  #stage_Normal
  #stage_ScanAxis
  #stage_ScanButton
  #stage_OutputCode
EndEnumeration

Global.l stage = #stage_Normal,substage

Structure sController
  name.s
  guid.SDL::JoystickGUID
  guidStr.s
  *pad.SDL::GameController
  *joy.SDL::Joystick
  JoyID.sdl::t_JoystickId 
  ButtonSet.l
  
  axis.w[sdl::#CONTROLLER_AXIS_MAX]
  button.w[sdl::#CONTROLLER_BUTTON_MAX]
EndStructure

Global NewList Controller.sController()

Global Dim ControllerAxisName.s(5,sdl::#CONTROLLER_AXIS_MAX -1)
Global Dim ControllerButtonName.s(5,sdl::#CONTROLLER_BUTTON_MAX-1)

Declare UpdateListeEntry(line)

Procedure InitController()
  Protected.l a
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_AXIS_LEFTX)="LeftStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_AXIS_LEFTY)="LeftStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_AXIS_RIGHTX)="RightStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_AXIS_RIGHTY)="RightStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_AXIS_TRIGGERLEFT)="L2"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_AXIS_TRIGGERRIGHT)="R2"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_A)="Cross"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_B)="Circle"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_X)="Square"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_Y)="Triangle"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_GUIDE)="PS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_LEFTSHOULDER)="L1"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_RIGHTSHOULDER)="R1"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_START)="Start"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_BACK)="Select"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_LEFTSTICK)="L3"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_RIGHTSTICK)="R3"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_DPAD_UP)="Up"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_DPAD_LEFT)="Left"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_DPAD_RIGHT)="Right"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS3, sdl::#CONTROLLER_BUTTON_DPAD_DOWN)="Down"
  
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_AXIS_LEFTX)="LeftStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_AXIS_LEFTY)="LeftStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_AXIS_RIGHTX)="RightStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_AXIS_RIGHTY)="RightStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_AXIS_TRIGGERLEFT)="L2"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_AXIS_TRIGGERRIGHT)="R2"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_A)="Cross"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_B)="Circle"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_X)="Square"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_Y)="Triangle"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_GUIDE)="PS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_LEFTSHOULDER)="L1"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_RIGHTSHOULDER)="R1"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_START)="Options"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_BACK)="Share"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_LEFTSTICK)="L3"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_RIGHTSTICK)="R3"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_DPAD_UP)="Up"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_DPAD_LEFT)="Left"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_DPAD_RIGHT)="Right"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_PS4, sdl::#CONTROLLER_BUTTON_DPAD_DOWN)="Down"
  
  ControllerAxisName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_AXIS_LEFTX)="LeftStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_AXIS_LEFTY)="LeftStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_AXIS_RIGHTX)="RightStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_AXIS_RIGHTY)="RightStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_AXIS_TRIGGERLEFT)="ZL"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_AXIS_TRIGGERRIGHT)="ZR"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_A)="B"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_B)="A"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_X)="Y"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_Y)="X"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_GUIDE)="Home"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_LEFTSHOULDER)="L"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_RIGHTSHOULDER)="R"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_START)="+"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_BACK)="-"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_LEFTSTICK)="RS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_RIGHTSTICK)="LS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_DPAD_UP)="Up"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_DPAD_LEFT)="Left"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_DPAD_RIGHT)="Right"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_NINTENDO_SWITCH_PRO, sdl::#CONTROLLER_BUTTON_DPAD_DOWN)="Down"
  
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_AXIS_LEFTX)="LeftStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_AXIS_LEFTY)="LeftStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_AXIS_RIGHTX)="RightStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_AXIS_RIGHTY)="RightStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_AXIS_TRIGGERLEFT)="LT"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_AXIS_TRIGGERRIGHT)="RT"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_A)="A"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_B)="B"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_X)="X"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_Y)="Y"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_GUIDE)="Guide"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_LEFTSHOULDER)="LB"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_RIGHTSHOULDER)="RB"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_START)="Start"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_BACK)="Back"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_LEFTSTICK)="RS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_RIGHTSTICK)="LS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_DPAD_UP)="Up"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_DPAD_LEFT)="Left"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_DPAD_RIGHT)="Right"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOX360, sdl::#CONTROLLER_BUTTON_DPAD_DOWN)="Down"
  
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_AXIS_LEFTX)="LeftStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_AXIS_LEFTY)="LeftStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_AXIS_RIGHTX)="RightStickX"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_AXIS_RIGHTY)="RightStickY"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_AXIS_TRIGGERLEFT)="LT"
  ControllerAxisName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_AXIS_TRIGGERRIGHT)="RT"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_A)="A"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_B)="B"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_X)="X"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_Y)="Y"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_GUIDE)="Guide"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_LEFTSHOULDER)="LB"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_RIGHTSHOULDER)="RB"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_START)="Start"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_BACK)="Back"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_LEFTSTICK)="RS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_RIGHTSTICK)="LS"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_DPAD_UP)="Up"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_DPAD_LEFT)="Left"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_DPAD_RIGHT)="Right"
  ControllerButtonName(sdl::#CONTROLLER_TYPE_XBOXONE, sdl::#CONTROLLER_BUTTON_DPAD_DOWN)="Down"
  
  For a=0 To sdl::#CONTROLLER_AXIS_MAX-1
    ControllerAxisName(sdl::#CONTROLLER_TYPE_UNKNOWN,a) = SDL::GameControllerGetStringForAxis(a)
  Next
  For a=0 To sdl::#CONTROLLER_BUTTON_MAX-1
    ControllerButtonName(sdl::#CONTROLLER_TYPE_UNKNOWN,a) = SDL::GameControllerGetStringForButton(a)
  Next
  
  
  Protected.s mapStr.s="030000004c050000da0c000000000000,Playstation Mini Pad,a:b2,b:b1,x:b3,y:b0,leftshoulder:b6,rightshoulder:b7,lefttrigger:b4,righttrigger:b5,leftx:a0,lefty:a1,dpleft:a0.-32768,dpright:a0.32767,back:b8,start:b9"
  sdl::GameControllerAddMapping(mapStr)
  mapStr.s="03000000a30c00002500000000000000,MegaDrive Mini Pad,x:b2,a:b1,b:b5,leftx:a0,lefty:a4,start:b9"
  sdl::GameControllerAddMapping(mapStr)
  mapStr="030000006d0400000ac2000000000000,WingMan RumblePad,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:b6,righttrigger:b7,a:b0,b:b1,x:b3,y:b4,start:b8,leftshoulder:b5,rightshoulder:b2,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2"
  sdl::GameControllerAddMapping(mapStr)

EndProcedure

Procedure ExitController()
  ForEach Controller()
    With Controller()
      If \pad
        sdl::GameControllerClose( \pad )
        \pad = #Null
        \joy = #Null
      ElseIf \joy
        sdl::JoystickClose( \joy )
        \joy = #Null
      EndIf
    EndWith
  Next
  ClearList( Controller() )
EndProcedure

Procedure RemoveController(removeJoyId.sdl::t_JoystickID)
  ForEach Controller()
    With Controller()
      If \JoyID = removeJoyId
        If \pad
          sdl::GameControllerClose( \pad )
          \pad = #Null
        ElseIf \joy
          sdl::JoystickClose( \joy )
          \joy = #Null
        EndIf
        DeleteElement( Controller() )
        Break
      EndIf
    EndWith
  Next
EndProcedure

Procedure AddController()  
  Protected.sdl::GameController *pad
  Protected.sdl::GameController *joy
  Protected.sdl::t_JoystickID id
  Protected.l count = SDL::NumJoysticks()
  Protected.l i
  Protected.l do
  
  For i=0 To count-1
    *pad=#Null
    *joy=#Null
    id=-1
    If sdl::IsGameController(i)
      *pad=SDL::GameControllerOpen(i)
      If *pad
        *joy=SDL::GameControllerGetJoystick( *pad)
      EndIf
    Else
      *joy=SDL::JoystickOpen(i)
    EndIf
    
    If *joy
      id=SDL::JoystickInstanceID( *joy )      
    EndIf
    
    do=#True
    ForEach Controller()
      If Controller()\JoyID = id
        do=#False
        Break
      EndIf
    Next
    
    If do=#False
      If *pad 
        SDL::GameControllerClose(*pad)
      Else
        SDL::JoystickClose(*joy)
      EndIf
      
    Else
      AddElement(Controller())
      
      With Controller()        
        
        \pad = *pad
        If \pad
          \Name = SDL::GameControllerName( \pad )    
          \ButtonSet = sdl::GameControllerGetType( \pad )
        EndIf
        
        \joy = *joy
        
        If \joy
          If \name=""
            \name= sdl::JoystickName( \joy )
          EndIf
          
          Protected.ascii *guidstring = AllocateMemory(33)
          CopyStructure( SDL::JoystickGetGUID(\joy) , \guid, sdl::JoystickGUID )      
          SDL::JoystickGetGUIDString( \guid, *guidstring, 33)      
          \guidStr = PeekS(*guidstring,33,#PB_Ascii)
          
          FreeMemory(*guidstring)
          
        EndIf
        \JoyID=id
        
      EndWith
    EndIf
  Next
  
  
EndProcedure

Procedure FillList()
  Protected.l a,i
  ClearGadgetItems(gadList)
  
  ForEach Controller()
    With Controller()
      
      AddGadgetItem( gadList,i, \name + #LF$ +
                                \guidStr + #LF$ +
                                \JoyID + #LF$ +
                                \ButtonSet)
      SetGadgetItemData( gadList,i, @controller())
      
      UpdateListeEntry( i )
      i+1
    EndWith
  Next
  
EndProcedure

Procedure findControllerEntry(joyId.sdl::t_JoystickID)
  Protected *find=#Null  
  ForEach Controller()
    If Controller()\JoyID = joyId
      *find=@Controller()
      Break
    EndIf
  Next
  ProcedureReturn *find
EndProcedure

Procedure findListEntry(*find.sController)
  Protected ret=-1
  If *find
    Protected.l i
    Protected.l count = CountGadgetItems( gadList )
    For i=0 To count-1
      If GetGadgetItemData( gadList, i) = *find
        ret=i
        Break
      EndIf
    Next
  EndIf

  ProcedureReturn ret    
EndProcedure

Procedure UpdateListeEntry(line)
  If line<0
    ProcedureReturn
  EndIf
  
  Protected *con.sController = GetGadgetItemData(gadList,line)
  If *con=#Null
    ProcedureReturn
  EndIf
  
  Protected str.s
  Protected.l i
  str=""
  For i=0 To sdl::#CONTROLLER_AXIS_MAX-1
    str+ ControllerAxisName(*con\ButtonSet,i)+":"+StrF(*con\axis[i] / 32767.0,2)+" "
  Next
  SetGadgetItemText(gadList,line,str,4)
  
  str=""
  For i=0 To sdl::#CONTROLLER_BUTTON_MAX-1
    str+ ControllerButtonName(*con\ButtonSet,i)+":"+*con\button[i]+" "
  Next
  SetGadgetItemText(gadList,line,str,5)
    
EndProcedure

Global.l _scanID=-1
Global.s _scanString
Global.l _lastaxis

Procedure DoNextStage()
  Select stage
    Case #stage_Normal
      stage=#stage_ScanAxis
      substage=0
      _lastaxis=-1
      HideGadget(gadList,#True)
      HideGadget(gadButton,#False)
      
    Case #stage_ScanAxis
      substage+1
      If substage >= SDL::#CONTROLLER_AXIS_MAX
        stage=#stage_ScanButton
        substage=0
      EndIf
      
    Case #stage_ScanButton
      substage+1
      If substage >= SDL::#CONTROLLER_Button_MAX
        stage=#stage_Normal        
        substage=0
        HideGadget(gadList,#False)
        HideGadget(gadButton,#True)
        SetClipboardText(_scanString)
        
        RemoveController(_scanID)
        sdl::GameControllerAddMapping(_scanString)
        AddController()
        
        Debug _scanString
        MessageRequester(#Title,"Copy Messagestring to clipboard.")      
        _scanID=-1
      EndIf     
  EndSelect
  
  ; Change button-text
  Select stage
    Case #stage_ScanAxis
      SetGadgetText(gadButton,"Move Axis "+ControllerAxisName(0,substage)+#LF$+"or click here for skip")
    Case #stage_ScanButton
      SetGadgetText(gadButton,"Press Button "+ControllerButtonName(0,substage) + " (XBOX-Design!)"+#LF$+"or click here For skip")
  EndSelect
EndProcedure
Procedure RegisterScan(x.s)
  Select stage
    Case #stage_ScanAxis
      _scanString+ControllerAxisName(0,substage)+":"+x+","
    Case #stage_ScanButton
      _scanstring+ControllerButtonName(0,substage)+":"+x+","
  EndSelect
  Debug "SCAN:"+x
EndProcedure

Procedure DoSDLMessages()
  Protected.sdl::event SDLEvent
  Protected *con.sController
    
  While sdl::PollEvent( SDLEvent )
    Select SDLEvent\type 
        
      Case SDL::#JOYAXISMOTION
        If SDLEvent\jaxis\which = _scanID And stage <> #stage_Normal
          If SDLEVENT\jaxis\axis<>_lastaxis And (SDLEvent\jaxis\value>32000 Or SDLEvent\jaxis\value<-32000)
            _lastaxis=SDLEVENT\jaxis\axis
            RegisterScan("a" + SDLEvent\jaxis\axis)
            DoNextStage()
          EndIf
        EndIf
        
      Case SDL::#JOYBUTTONDOWN
        If SDLEvent\jbutton\which = _scanID And stage <> #stage_Normal
          RegisterScan("b" + SDLEvent\jbutton\button )
          DoNextStage()
        EndIf
        
      Case SDL::#JOYHATMOTION
        If SDLEvent\jbutton\which = _scanID And stage <> #stage_Normal
          If SDLEvent\jhat\value <> SDL::#HAT_CENTERED
            RegisterScan("h"+ SDLEvent\jhat\hat+"."+SDLEvent\jhat\value )
            DoNextStage()
          EndIf
        EndIf        
        
      Case SDL::#JOYDEVICEADDED
        ;SDLEvent\jdevice\which doen't work, so we simple scan for new joysticks
        AddController()
        FillList()
        
        
      Case sdl::#JOYDEVICEREMOVED
        RemoveController( SDLEvent\jdevice\which )
        FillList()
        
      Case sdl::#CONTROLLERAXISMOTION
        *con=findControllerEntry( SDLEvent\caxis\which )
        If *con
          *con\axis[SDLEvent\caxis\axis] = SDLEvent\caxis\value
          UpdateListeEntry( findListEntry(*con) )
          
          If SDLEvent\caxis\axis = SDL::#CONTROLLER_AXIS_TRIGGERLEFT Or SDLEvent\caxis\axis = SDL::#CONTROLLER_AXIS_TRIGGERRIGHT
            SDL::GameControllerRumble(*con\pad, 
                                      *con\axis[ SDL::#CONTROLLER_AXIS_TRIGGERLEFT ] * $ffff /32768 ,
                                      *con\axis[ SDL::#CONTROLLER_AXIS_TRIGGERRIGHT ] * $ffff/32768 ,
                                      200)
          
          EndIf
          
        EndIf        
        
      Case sdl::#CONTROLLERBUTTONDOWN, sdl::#CONTROLLERBUTTONUP
        *con=findControllerEntry( SDLEvent\cbutton\which )
        If *con
          *con\button[ SDLEvent\cbutton\button] = SDLEvent\cbutton\state
          UpdateListeEntry( findListEntry(*con) )
        EndIf
        
    EndSelect
    
  Wend
  
EndProcedure

Procedure main()
  
  If SDL::Init(SDL::#INIT_GAMECONTROLLER | SDL::#INIT_JOYSTICK | SDL::#INIT_EVENTS | sdl::#INIT_HAPTIC) <> 0
    MessageRequester(#Title, "Can't open SDL.")
    End
  EndIf
    
  win = OpenWindow(#PB_Any,0,0,1000,300,#Title + " - rightclick to change mapping",#PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  If win=0
    MessageRequester(#Title, "Can't open Window.")
    End
  EndIf
  
  gadButton=ButtonGadget(#PB_Any,0,(WindowHeight(win)-100)/2,WindowWidth(win),100,"",#PB_Button_MultiLine)
  
  gadList=ListIconGadget(#PB_Any,0,0,1000,300,"JoyName",150,#PB_ListIcon_GridLines | #PB_ListIcon_FullRowSelect | #PB_ListIcon_AlwaysShowSelection)
  AddGadgetColumn(gadList,1,"GUID",250)
  AddGadgetColumn(gadlist,2,"InstanceID",30)
  AddGadgetColumn(gadList,3,"Type",25)
  AddGadgetColumn(gadList,4,"Axis",450)
  AddGadgetColumn(gadList,5,"Button",700)
  
  InitController()
  AddController()
  FillList()
  
  HideGadget(gadButton,#True)
  
  Protected WinEvent
  
  Protected quit
  
  While Not quit
        
    Repeat
      WinEvent=WindowEvent()
      Select WinEvent
        Case 0 ; nothing
          Break
        Case #PB_Event_CloseWindow
          quit=#True
        Case #PB_Event_Gadget
          Select EventGadget() 
            Case gadButton
              DoNextStage()
            Case gadList
              If EventType()=#PB_EventType_RightClick
                Protected.sController *con
                Protected item=GetGadgetState(gadList)
                If item=>0
                  *con=GetGadgetItemData(gadList,item)
                  If *con <> #Null
                    _scanString = *con\guidStr + "," + *con\name +","
                    _scanID = *con\JoyID
                    DoNextStage()
                  EndIf
                EndIf
                
              EndIf                
          EndSelect
      EndSelect
    ForEver
    
    DoSDLMessages()
    
    
    
  Wend
  
  ExitController()
  
  SDL::Quit()
  
EndProcedure


main()
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 549
; FirstLine = 510
; Folding = ---
; EnableXP