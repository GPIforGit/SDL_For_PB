; small Class lib
XIncludeFile "class.pbi"
XIncludeFile "renderer.pbi"

;declare
DeclareModule GUI
  EnableExplicit
  ;-
  ;- Enumerations
  
  Enumeration flag
    #Disable=#False
    #Enable=#True
    #Toogle
  EndEnumeration
  
  EnumerationBinary state
    #State_hide 
    #State_disabled
    #State_OnTop
    #State_OnBack
    #State_HandleKeyboard
    #State_ClipOutside
  EndEnumeration

  
  Enumeration Class_tex
    #tex_stretch
    #tex_single
    #tex_tile
    #tex_tileCenter
  EndEnumeration
  
  Enumeration Class_anchor
    #Anchor_None=0
    #Anchor_Top
    #Anchor_Bottom    
    #Anchor_Left
    #Anchor_Right
    #Anchor_Center
    #Anchor_Direct
    #Anchor_MaxWidth
    #Anchor_MaxHeight
  EndEnumeration
  
  EnumerationBinary Size
    #Size_none = 0
    #Size_Top
    #Size_Left
    #Size_Right
    #Size_Bottom
  EndEnumeration
  
  Enumeration OffsetType
    #Offset_SpecialStart = 1000000000
    #Offset_FrameSize
    #Offset_TextureSize
    ;
  EndEnumeration
  
  Enumeration hitbox
    #Event_enter
    #Event_leave
    #Event_LeftClick
    #Event_LeftDoubleClick
    #Event_LeftDown
    #Event_LeftUp
    #Event_RightClick
    #Event_RightDoubleClick
    #Event_RightDown       
    #Event_RightUp         
    #Event_sizing
    #Event_moving
    #Event_StateChange    
    #Event_Destroy
    #Event_UserData
    
    #Event_MaxEvent
  EndEnumeration
  
  ;- structures
  Structure sAnchor    
    offset.l
    fromAnchor.l
    *FromFrame.mFrame
  EndStructure
  Structure sHitbox
    rect.sdl::rect
    *frame.mFrame  
  EndStructure
  
  ;- Prototypes
  Prototype _ProtHitboxCallback(what,*frame,dat.i)
  
  ;- Class declarations
  ;- -Frame
  Interface Frame Extends class::Base
    SetX(offset.l, anchor.l = #Anchor_None, name.s = "")
    SetY(offset.l, anchor.l = #Anchor_None, name.s = "")
    SetW(offset.l, anchor.l = #Anchor_None, name.s = "")
    SetH(offset.l, anchor.l = #Anchor_None, name.s = "")
    
    GetX.l()
    GetY.l()
    GetW.l()
    GetH.l()
    
    GetRelativMouse(*sdlPoint)
    
    SetPosition(x.l = #PB_Ignore, y.l = #PB_Ignore, w.l = #PB_Ignore, h.l = #PB_Ignore)
    SetState(state.l, flag.l)
    GetState.l(state.l)
    GetName.s()
    SetOn(event.l,*func,dat.i=#Null)
    DoOn(event.l)
    StartUserSizing(what.l)
    StartUserMoving()
    StopUserSizingMoving()    
    SetBound(minWidth.l, minHeight.l, maxWidth.l, minWidth.l)
    SetUserData(name.s,value,silent=#False)
    GetUserData(name.s)
    SetUserDataF(name.s,value.f,silent=#False)
    GetUserDataF.f(name.s)
    SetUserDataS(name.s,value.s,silent=#False)
    GetUserDataS.s(name.s)
    GetFrame(name.s)
  
    SetTexture(*rendererTexture,x1.f,y1.f,x2.f,y2.f,style.l=#tex_stretch)
    SetText(*font,text.s,colorRGBA,style.l=#tex_stretch)
    GetTextTexture(*font,text.s,colorRGBA,style.l)
    
    GetParent()
    NewChild(name.s, state.l = 0)
    SortUp()
    
  EndInterface
  
  ;- -Class
  
  Interface Class Extends class::Base
    NewElement(name.s, state.l = 0)
    Draw()
    GetFrame(name.s)
    ReCalculate()
    GetHit(*sdlpoint, MouseButton.l, MouseClicks.l)    
  EndInterface  
  class::Announce( Class,(*render.renderer::Class) )
  
  Macro New( render )
    Object::New( GUI::class, ( render ) )
  EndMacro
  
EndDeclareModule
;-
;- module
;-
Module GUI
  #BaseElementName = "/"
  
  Structure sUserData_base
    name.s
    *next.sUserData
  EndStructure
  Structure sUserdata_i Extends sUserData_base
    value.i
  EndStructure
  Structure sUserdata_f Extends sUserData_base
    value.f
  EndStructure 
  Structure sUserdata_s Extends sUserData_base
    value.s
  EndStructure
  
  ;- -Frame
  Structure mFrame Extends class::mBase
    *mClass.mClass
    name.s
    state.l
    rect.sdl::Rect
    base.sdl::Point
    valid.sdl::Rect
    Top.sAnchor
    Bottom.sAnchor
    Left.sAnchor
    Right.sAnchor 
    
    on._ProtHitboxCallback[#Event_MaxEvent]
    onData.i[#Event_MaxEvent]
    MinWidth.l
    MaxWidth.l
    MinHeight.l
    MaxHeight.l
    *userData.sUserData
    
    *parent.mFrame
    *next.mFrame
    *child.mFrame
    
    *tex.renderer::texture
    texClip.sdl::rect
    texStyle.l    
    texOwnerSelf.l
  
    globalClip.sdl::rect
  EndStructure
  class::Create( Frame, (*Class, name.s) )
  
  ;- -Class
  Structure mClass Extends class::mBase
    render.renderer::Class
    NeedRecalc.l
    *baseElement.mFrame
    *LastMouseFrame.mFrame
    List HitBox.sHitbox()
    MouseButton.l
    MouseClicks.l
    MousePoint.sdl::point
    
    *MouseClickFrame.mFrame    
    *movingFrame.mFrame
    *sizingFrame.mFrame
    movingPoint.sdl::point
    difPoint.sdl::point
    sizingWhat.l
    globalValid.l
  EndStructure
  class::Create( Class,(*render.renderer::Class) )
  
  ;-
  ;- declares
  Declare Class_GetFrame(*self.mClass, name.s)
  Declare Frame_SortUp(*self.mFrame)
  Declare.s Frame_GetName(*self.mFrame)
  ;-
  ;- procedures
  ;-
  
  
  Procedure.s Frame__GetName(*ele.mFrame)
    Protected.s name
    If *ele = #Null
      ProcedureReturn "#NULL"
    EndIf
    name = *ele\name
    
    While *ele\parent
      *ele = *ele\parent
      If *ele\name = #BaseElementName
        Break
      EndIf
      name=*ele\name + "." + name
    Wend
    ProcedureReturn name
  EndProcedure
  
  Procedure Frame__NeedHitbox(*frame.mFrame)
    Protected i.l
    For i=0 To #Event_MaxEvent-1
      If *frame\on[i]
        ProcedureReturn #True
      EndIf
    Next
    ProcedureReturn #False
  EndProcedure
  
  Procedure Frame__MaxWidth(*frame.mFrame, *valid.integer)
    Protected.mframe *cur = *frame\child
    Protected.l max,off
    
    While *cur      
      If Not *cur\state & #State_OnBack
        If *cur\Left\FromFrame = *frame And *cur\left\fromAnchor = #Anchor_Center
          off =0          
        ElseIf *cur\left\fromAnchor = #Anchor_Direct
          Select *cur\left\offset
            Case #Offset_FrameSize : off = *cur\rect\w
            Case -#Offset_FrameSize : off = -*cur\rect\w
            Case #Offset_TextureSize : off = *cur\texClip\w
            Case -#Offset_TextureSize : off = -*cur\texClip\w
            Default : off = *cur\left\offset          
          EndSelect
        Else
          off = *cur\rect\x
          If Not ( *cur\left\FromFrame = #Null Or *cur\left\FromFrame\valid\x )
            *valid\i = #False
          EndIf
        EndIf
        
        If *cur\Right\FromFrame = *frame And *cur\Right\fromAnchor = #Anchor_Center
          ;off + 0
        ElseIf *cur\right\fromAnchor = #Anchor_Direct
          Select *cur\right\offset
            Case #Offset_FrameSize : off + *cur\rect\w
            Case -#Offset_FrameSize : off - *cur\rect\w
            Case #Offset_TextureSize : off + *cur\texClip\w
            Case -#Offset_TextureSize : off -*cur\texClip\w
            Default : off + *cur\Right\offset          
          EndSelect
        Else
          off + *cur\rect\w
          If Not ( *cur\right\FromFrame = #Null Or *cur\Right\FromFrame\valid\w )
            *valid\i = #False
          EndIf
        EndIf
        
        If off > max
          max = off
        EndIf
       
        
      EndIf
      *cur = *cur\next
      
    Wend
    ProcedureReturn max
  EndProcedure
  
  Procedure Frame__MaxHeight(*frame.mFrame, *valid.integer)
    Protected.mframe *cur = *frame\child
    Protected.l max,off
    
    While *cur      
      If Not *cur\state & #State_OnBack
        If *cur\top\FromFrame = *frame And *cur\top\fromAnchor = #Anchor_Center
          off =0          
        ElseIf *cur\top\fromAnchor = #Anchor_Direct
          Select *cur\top\offset
            Case #Offset_FrameSize : off = *cur\rect\h
            Case -#Offset_FrameSize : off = -*cur\rect\h
            Case #Offset_TextureSize : off = *cur\texClip\h
            Case -#Offset_TextureSize : off = -*cur\texClip\h
            Default : off = *cur\top\offset          
          EndSelect
        Else
          off = *cur\rect\y
          If Not( *cur\top\FromFrame = #Null Or *cur\top\FromFrame\valid\y )
            *valid\i = #False
          EndIf
        EndIf
        
        If *cur\Bottom\FromFrame = *frame And *cur\bottom\fromAnchor = #Anchor_Center 
          ;off + 0
        ElseIf *cur\Bottom\fromAnchor = #Anchor_Direct
          Select *cur\Bottom\offset
            Case #Offset_FrameSize : off + *cur\rect\h
            Case -#Offset_FrameSize : off - *cur\rect\h
            Case #Offset_TextureSize : off + *cur\texClip\h
            Case -#Offset_TextureSize : off -*cur\texClip\h
            Default : off + *cur\Bottom\offset          
          EndSelect
        Else
          off + *cur\rect\h
          If Not ( *cur\Bottom\FromFrame = #Null Or *cur\Bottom\FromFrame\valid\h )
            *valid\i = #False
          EndIf
        EndIf
        
        If off > max
          max = off
        EndIf
        
        
      EndIf
      *cur = *cur\next
      
    Wend
    ProcedureReturn max
  EndProcedure
  
  Procedure Frame__CalculateFrame(*frame.mFrame)
    Protected.l off
    Protected.l old,CorrectW.l, CorrectH.l
    *frame\valid\x=#True
    *frame\valid\y=#True
    *frame\valid\w=#True
    *frame\valid\h=#True

    With *frame\Bottom
      If \FromFrame
        Select \offset
          Case #Offset_FrameSize : off = *frame\rect\h
          Case -#Offset_FrameSize : off = -*frame\rect\h
          Case #Offset_TextureSize : off = *frame\texClip\h
          Case -#Offset_TextureSize : off = -*frame\texClip\h
          Default : off = \offset          
        EndSelect 
        
        Select \fromAnchor
          Case #Anchor_MaxHeight
            *frame\rect\h = Frame__MaxHeight( *frame, @*frame\valid\h ) + off
            
          Case #Anchor_Top
            *frame\rect\h = \FromFrame\rect\y + off - *frame\rect\y  + \FromFrame\base\y - *frame\base\y
            CorrectH = #True
            *frame\valid\h & \FromFrame\valid\y 
            
          Case #Anchor_Bottom
            *frame\rect\h = (\FromFrame\rect\y + \FromFrame\rect\h ) + off - *frame\rect\y  + \FromFrame\base\y - *frame\base\y
            CorrectH = #True
            *frame\valid\h & (\FromFrame\valid\y & \FromFrame\valid\h)
            
          Case #Anchor_Left, #Anchor_Right, #Anchor_Center
            *frame\rect\h = (\FromFrame\rect\y + \FromFrame\rect\h /2) + off - *frame\rect\y  + \FromFrame\base\y - *frame\base\y
            CorrectH = #True
            *frame\valid\h & (\FromFrame\valid\y & \FromFrame\valid\h)
            
          Case #Anchor_Direct
            *frame\rect\h = off  
        EndSelect
      EndIf
    EndWith
    
    With *frame\Right
      If \FromFrame
        Select \offset
          Case #Offset_FrameSize : off = *frame\rect\w
          Case -#Offset_FrameSize : off = -*frame\rect\w
          Case #Offset_TextureSize : off = *frame\texClip\w
          Case -#Offset_TextureSize : off = -*frame\texClip\w
          Default : off = \offset          
        EndSelect
        
        Select \fromAnchor
          Case #Anchor_MaxWidth
            *frame\rect\w = Frame__MaxWidth( *frame, @*frame\valid\w ) + off
             
          Case #Anchor_Left
            *frame\rect\w = \FromFrame\rect\x + off - *frame\rect\x + \FromFrame\base\x - *frame\base\x
            CorrectW = #True
            *frame\valid\w & \FromFrame\valid\x 
            
          Case #Anchor_Right
            *frame\rect\w = (\FromFrame\rect\x + \FromFrame\rect\w ) + off - *frame\rect\x + \FromFrame\base\x - *frame\base\x
            CorrectW = #True
            *frame\valid\w & (\FromFrame\valid\x & \FromFrame\Valid\w)
            
          Case #Anchor_Top, #Anchor_Bottom, #Anchor_Center
            *frame\rect\w = (\FromFrame\rect\x + \FromFrame\rect\w /2) + off - *frame\rect\x + \FromFrame\base\x - *frame\base\x
            CorrectW = #True
            *frame\valid\w & (\FromFrame\valid\x & \FromFrame\Valid\w)
            
          Case #Anchor_Direct
            *frame\rect\w = off
        EndSelect
      EndIf
    EndWith
    
    With *frame\Top
      If \FromFrame 
        Select \offset
          Case #Offset_FrameSize : off = *frame\rect\h
          Case -#Offset_FrameSize : off = -*frame\rect\h
          Case #Offset_TextureSize : off = *frame\texClip\h
          Case -#Offset_TextureSize : off = -*frame\texClip\h 
          Default : off = \offset          
        EndSelect           
        old=*frame\rect\y
        Select \fromAnchor
          Case #Anchor_Top
            *frame\rect\y = \FromFrame\rect\y + off + \FromFrame\base\y - *frame\base\y
            *frame\valid\y & \FromFrame\valid\y
            
          Case #Anchor_Bottom
            *frame\rect\y = (\FromFrame\rect\y + \FromFrame\rect\h ) + off + \FromFrame\base\y - *frame\base\y
            *frame\valid\y & (\FromFrame\valid\y & \FromFrame\valid\h)
            
          Case #Anchor_Left, #Anchor_Right, #Anchor_Center
            *frame\rect\y = (\FromFrame\rect\y + \FromFrame\rect\h /2) + off + \FromFrame\base\y - *frame\base\y
            *frame\valid\y & (\FromFrame\valid\y & \FromFrame\valid\h)
            
          Case #Anchor_Direct
            *frame\rect\y = off
        EndSelect
        If old <> *frame\rect\y And CorrectH
          *frame\rect\h + old - *frame\rect\y
        EndIf        
      EndIf
    EndWith
    
    With *frame\Left
      If \FromFrame
        Select \offset
          Case #Offset_FrameSize : off = *frame\rect\w
          Case -#Offset_FrameSize : off = -*frame\rect\w
          Case #Offset_TextureSize : off = *frame\texClip\w 
          Case -#Offset_TextureSize :off = -*frame\texClip\w 
          Default : off = \offset          
        EndSelect 
        old=*frame\rect\x
        Select \fromAnchor
          Case #Anchor_Left
            *frame\rect\x = \FromFrame\rect\x + off + \FromFrame\base\x - *frame\base\x
            *frame\valid\x & \FromFrame\valid\x
            
          Case #Anchor_Right
            *frame\rect\x = (\FromFrame\rect\x + \FromFrame\rect\w ) + off + \FromFrame\base\x - *frame\base\x
            *frame\valid\x & (\FromFrame\valid\x & \FromFrame\valid\w)
            
          Case #Anchor_Top, #Anchor_Bottom, #Anchor_Center
            *frame\rect\x = (\FromFrame\rect\x + \FromFrame\rect\w /2) + off + \FromFrame\base\x - *frame\base\x
            *frame\valid\x & (\FromFrame\valid\x & \FromFrame\valid\w)
            
          Case #Anchor_Direct
            *frame\rect\x = off
        EndSelect
        If old <> *frame\rect\x And CorrectW
          *frame\rect\w + old - *frame\rect\x
        EndIf
      EndIf
    EndWith
    
    If *frame\Top\fromAnchor = #Anchor_Center
      *frame\rect\y - *frame\rect\h / 2
    EndIf
    If *frame\Left\fromAnchor = #Anchor_Center
      *frame\rect\x - *frame\rect\w /2
    EndIf
    
    *frame\mClass\globalValid & (*frame\valid\x & *frame\valid\y & *frame\valid\w & *frame\valid\h)
    
    ;Debug Frame__GetName(*frame)+" "+*frame\rect\x+" "+*frame\rect\y+" "+*frame\rect\w+" "+*frame\rect\h

  EndProcedure  
  
  Procedure Frame__InvalideAllElements(*frame.mFrame)
    Protected.mFrame *cur = *frame  
    
    While *cur
      *cur\valid\x = #False
      *cur\valid\y = #False
      *cur\valid\w = #False
      *cur\valid\h = #False
            
      If Not *cur\state & #State_hide      
        If *cur\child
          Frame__InvalideAllElements( *cur\child)
        EndIf
      EndIf  
      
      *cur = *cur\next
    Wend
  EndProcedure
    
  
  Procedure Frame__CalculateAllElements(*frame.mframe)
    Protected.mFrame *cur = *frame  
    
    While *cur
      *cur\base\x = *cur\parent\base\x + *cur\parent\rect\x
      *cur\base\y = *cur\parent\base\y + *cur\parent\rect\y
      If Not *cur\valid\x Or Not *cur\valid\y Or Not *cur\valid\w Or Not *cur\valid\h
        Frame__CalculateFrame( *cur )
      EndIf
            
      If Not *cur\state & #State_hide      
        If *cur\child
          Frame__CalculateAllElements( *cur\child)
        EndIf
      EndIf  
      
      *cur = *cur\next
    Wend
  EndProcedure
  
  Procedure Frame__CalculateAllHitboxes(*frame.mframe)
    Protected.mFrame *cur = *frame  
    Protected.sdl::rect rect
    Protected.l ok
    
    While *cur
      
      If *cur\state & #State_hide      
        *cur\globalClip\x=0
        *cur\globalClip\y=0
        *cur\globalClip\w=0
        *cur\globalClip\h=0
      Else
        rect = *cur\rect
        rect\x + *cur\base\x
        rect\y + *cur\base\y
        If (*cur\state & #State_ClipOutside) And *cur\parent\parent
          ok = sdl::IntersectRect(rect, *cur\parent\parent\globalClip, *cur\globalClip)        
        Else
          ok = sdl::IntersectRect(rect, *cur\parent\globalClip, *cur\globalClip)
        EndIf
        
        If ok
          
          
          If Frame__NeedHitbox(*cur)
            FirstElement( *cur\mClass\HitBox() )
            InsertElement( *cur\mClass\HitBox() )
            With *cur\mClass\HitBox()
              \frame = *cur
              \rect = *cur\globalClip
            EndWith
          EndIf
          
          If *cur\child
            Frame__CalculateAllHitboxes( *cur\child)
          EndIf
        EndIf
      EndIf  
      
      *cur = *cur\next
    Wend
  EndProcedure
  
  
  Procedure Frame__SetAnchor(*frame.mFrame,which.l,offset.l,anchor.l = #Anchor_None, *AnchorFrame = #Null)
    Protected *anchor.sAnchor
    
    *frame\mClass\NeedRecalc = #True
    
    If anchor = #Anchor_None Or *AnchorFrame = #Null
      Select which
        Case #Anchor_Left : *frame\rect\x = offset : *anchor = *frame\Left
        Case #Anchor_Top : *frame\rect\y = offset : *anchor = *frame\Top
        Case #Anchor_Right : *frame\rect\w = offset : *anchor = *frame\Right
        Case #Anchor_Bottom : *frame\rect\h = offset : *anchor = *frame\Bottom
      EndSelect
      *anchor\fromAnchor = #Anchor_None    
      *anchor\FromFrame = #Null
      ProcedureReturn
    EndIf
    
    If (which=#anchor_top And anchor = #anchor_top And *AnchorFrame = *frame\parent) Or 
       (which=#anchor_left And anchor = #Anchor_Left And *AnchorFrame = *frame\parent)
      anchor = #Anchor_Direct 
      *AnchorFrame = *frame
    EndIf       
    
    Select which
      Case #Anchor_Left : *anchor = *frame\Left
      Case #Anchor_Right : *anchor = *frame\Right
      Case #Anchor_Top : *anchor = *frame\Top
      Case #Anchor_Bottom : *anchor = *frame\Bottom      
      Default
        ProcedureReturn
    EndSelect
    
    *anchor\offset = offset
    *anchor\fromAnchor = anchor
    *anchor\FromFrame = *AnchorFrame     
    
    Frame__CalculateFrame(*frame)
        
  EndProcedure
  
  Procedure Frame__DrawAllElements(*frame.mFrame)
    Protected.mFrame *cur = *frame  
    Protected.l offx,offy
    Protected.l x,y,w,h,ok
    Protected.sdl::rect rect,  combinedClip
    
    ;Debug ""+Frame_GetName(*frame\parent)+" "+*frame+" "+*cur
    
    While *cur
      rect = *cur\rect
      rect\x + *cur\base\x
      rect\y + *cur\base\y
      ;Debug Frame_GetName(*cur)+":"+*cur\tex
      
      If *cur\globalClip\w > 0 And *cur\globalClip\h > 0
        
        If *cur\tex
          *cur\tex\SetClip( *cur\texClip\x, *cur\texClip\y, *cur\texClip\w, *cur\texClip\h )
          *frame\mClass\render\SetClip( *cur\globalClip )
;           *frame\mclass\render\SetDrawColor(128,128,128,255)
;           *frame\mClass\render\DrawRect( *cur\globalClip )
          
          ;Debug "draw:"+rect\x+" "+rect\y+" "+rect\w+" "+rect\h
          
          Select *cur\texStyle
            Case #tex_stretch
              *cur\tex\Draw( rect\x, rect\y, rect\w, rect\h)
            Case #tex_single
              *cur\tex\Draw( rect\x, rect\y)
              
            Case #tex_tile, #tex_tileCenter
              If *cur\texStyle=#tex_tile
                offx = 0
                w = *cur\texClip\w
                offy = 0
                h = *cur\texClip\h
                
              Else
                If rect\w > *cur\texClip\w
                  offx= (rect\w % *cur\texClip\w) 
                  w = *cur\texClip\w
                  If offx
                    offx = (*cur\texClip\w- offx)/2
                  EndIf
                Else
                  offx = 0
                  w = rect\w
                EndIf
                
                If rect\h > *cur\texClip\h
                  offy= (rect\h % *cur\texClip\h) 
                  h = *cur\texClip\h
                  If offy
                    offy = (*cur\texClip\h- offy)/2
                  EndIf
                Else 
                  offy = 0
                  h = rect\h
                EndIf
              EndIf            
              
              y=rect\y - offy
              While y < rect\y+rect\h
                x=rect\x - offx
                While x < rect\x+rect\w
                  *cur\tex\Draw(x,y,w,h)
                  x + w
                Wend
                y + h
              Wend
              
          EndSelect
          
          *cur\mClass\render\SetClip(#Null)  
        EndIf
        
        If *cur\child
          Frame__DrawAllElements(*cur\child)      
        EndIf
      EndIf
      *cur = *cur\next
    Wend
    
    
  EndProcedure
  
  Procedure Frame__FindFrame(*cur.mFrame, name.s)  
    Protected.s curName,nextName
    Protected.l pos
    Protected.mFrame *ret
   
    If name=""
      ProcedureReturn #Null
    EndIf
    
    pos=FindString(name,".")
    If pos>0
      curName=Left(name,pos-1)
      nextName=Mid(name,pos+1)
    Else
      curName=name
      nextName=""
    EndIf
        
    While *cur
      If *cur\name=curName Or curName=""
        If nextName=""
          *ret = *cur
          
        ElseIf *cur\child
          *ret=Frame__FindFrame(*cur\child, nextName)
        EndIf
        
        Break
      EndIf  
      
      *cur = *cur\next
    Wend
    
    ProcedureReturn *ret
  EndProcedure
  
  Macro Frame__CallEventCallback(_frame_,_event_,_info_=#Null)
    If _frame_\on[_event_]
      _frame_\on[_event_]( _info_, _frame_, _frame_\onData[_event_] )
    EndIf
  EndMacro
    
  Procedure.l Frame__IsInheritedState(*frame.mFrame,state.l)
    While *frame
      If *frame\state & state
        ProcedureReturn #True
      EndIf
      *frame = *frame\parent
    Wend
    ProcedureReturn #False
  EndProcedure
  
  Procedure Frame__FreeTexture(*self.mFrame)
    If *self\texOwnerSelf
      Object::Delete(*self\tex)
      *self\texOwnerSelf=#False
    EndIf
    *self\tex = #Null
  EndProcedure
  
  ;-
  class::Method Procedure Frame_Frame(*self.mFrame, *Class, name.s)
    ;Debug "[Frame] VIRTUAL CLASS!"
    *self\MinHeight = 10
    *self\MaxHeight = #Offset_SpecialStart-1
    *self\MinWidth = 10
    *self\MaxWidth = #Offset_SpecialStart-1
    
    *self\name=name
    *self\mClass = *Class
    ProcedureReturn #True
  EndProcedure
  
  class::Method Procedure Frame__Delete(*self.mFrame)    
    Frame__CallEventCallback(*self, #Event_Destroy)
    
    Frame__FreeTexture(*self)
    
    
    Protected.mframe *frame,*nextFrame
    *frame = *self\child
    While *frame
      *nextFrame = *frame\next
      Object::Delete( *frame )
      *frame = *nextFrame
    Wend  
    
    Protected.sUserData_base *userdata, *nextUserdata
    *userdata = *self\userData
    While *userdata
      *nextUserdata = *userdata\next
      FreeStructure(*userdata)
      *userdata = *nextUserdata
    Wend
    
  EndProcedure

  ;-
  
  class::Method Procedure Frame_GetFrame(*self.mframe, name.s)
    Protected *AnchorFrame
    
    If name="."
      ProcedureReturn *self
      
    ElseIf name=".."
      ProcedureReturn *self\parent
      
    ElseIf Left(name,2)=".."      
      If *self\parent
        ProcedureReturn Frame__FindFrame(*self\parent,Mid(name,2))
      EndIf
      ProcedureReturn #Null
      
    ElseIf Left(name,1)="."     
      If *self\child
        ProcedureReturn Frame__FindFrame(*self\child,Mid(name,2))
      EndIf
      ProcedureReturn #Null  
      
    ElseIf Left(name,1)="@"
      ProcedureReturn Val(Mid(name,2))      
    EndIf   
    ProcedureReturn Frame__FindFrame(*self\mClass\baseElement\child,name)
  EndProcedure
  
  class::Method Procedure Frame_SetX(*self.mFrame, offset.l, anchor.l, name.s)
    Frame__SetAnchor(*self, #Anchor_Left, offset, anchor,Frame_GetFrame(*self,name) )
    Frame__CallEventCallback( *self, #Event_moving )
  EndProcedure
  class::Method Procedure Frame_SetY(*self.mFrame, offset.l, anchor.l, name.s)
    Frame__SetAnchor(*self, #Anchor_Top, offset, anchor, Frame_GetFrame(*self,name))
    Frame__CallEventCallback( *self, #Event_moving )
  EndProcedure
  class::Method Procedure Frame_SetW(*self.mFrame, offset.l, anchor.l, name.s)
    Frame__SetAnchor(*self, #Anchor_Right, offset, anchor, Frame_GetFrame(*self,name))
    Frame__CallEventCallback( *self, #Event_sizing )
  EndProcedure
  class::Method Procedure Frame_SetH(*self.mFrame, offset.l, anchor.l, name.s)
    Frame__SetAnchor(*self, #Anchor_Bottom, offset, anchor, Frame_GetFrame(*self,name))
    Frame__CallEventCallback( *self, #Event_sizing )
  EndProcedure
  class::Method Procedure.l Frame_GetX(*self.mFrame)
    ProcedureReturn *self\rect\x
  EndProcedure
  class::Method Procedure.l Frame_GetY(*self.mFrame)
    ProcedureReturn *self\rect\y
  EndProcedure
  class::Method Procedure.l Frame_GetW(*self.mFrame)
    ProcedureReturn *self\rect\w
  EndProcedure
  class::Method Procedure.l Frame_GetH(*self.mFrame)
    ProcedureReturn *self\rect\h
  EndProcedure
  
  class::Method Procedure Frame_SetPosition(*self.mFrame, x.l = #PB_Ignore, y.l = #PB_Ignore, w.l = #PB_Ignore, h.l = #PB_Ignore)
    With *self\rect
      If x <> #PB_Ignore
        Frame__SetAnchor(*self,#Anchor_Left,x)
      EndIf
      If y <> #PB_Ignore
        Frame__SetAnchor(*self,#Anchor_Top,y)
      EndIf
      If w <> #PB_Ignore
        If w > #Offset_SpecialStart Or w < -#Offset_SpecialStart
          Frame__SetAnchor(*self,#Anchor_Right, w, #Anchor_Direct, *self)
        Else
          Frame__SetAnchor(*self,#Anchor_Right, w)
        EndIf
      EndIf
      If h <> #PB_Ignore
        If h > #Offset_SpecialStart Or h < -#Offset_SpecialStart
          Frame__SetAnchor(*self,#Anchor_Bottom, h, #Anchor_Direct, *self)
        Else
          Frame__SetAnchor(*self,#Anchor_Bottom, h)
        EndIf
      EndIf
      
      If w <> #PB_Ignore Or h <> #PB_Ignore
        Frame__CallEventCallback( *self, #Event_sizing )
      ElseIf x <> #PB_Ignore And y <> #PB_Ignore
        ;don't send move when sizing!
        Frame__CallEventCallback( *self, #Event_moving )
      EndIf
      
    EndWith
  EndProcedure
  
  class::Method Procedure Frame_SetOn(*self.mFrame,event.l,*func,dat.i=#Null)
    *self\on[event] = *func
    *self\onData[event] = dat
  EndProcedure
  
  class::Method Procedure Frame_DoOn(*self.mFrame,event.l)
    Frame__CallEventCallback( *self, event )
  EndProcedure
    
  
  class::Method Procedure Frame_GetRelativMouse(*self.mFrame, *point.sdl::Point)
    *point\x = *self\mClass\MousePoint\x - *self\rect\x - *self\base\x
    *point\y = *self\mClass\MousePoint\y - *self\rect\y - *self\base\y
    
  EndProcedure
  
  class::Method Procedure Frame_SetState(*self.mFrame,state.l,flag.l)
    Select flag
      Case #Enable : *self\state | state
      Case #Disable : *self\state & ~state
      Case #Toogle : *self\state ! state
    EndSelect
    
    Frame__CallEventCallback(*self, #Event_StateChange)
    
    *self\mClass\NeedRecalc = #True
  EndProcedure
  class::Method Procedure.l Frame_GetState(*self.mFrame,state.l)
    ProcedureReturn Bool(*self\state & state)
  EndProcedure
  class::Method Procedure.s Frame_GetName(*self.mFrame)
    ProcedureReturn Frame__GetName(*self)
  EndProcedure
  class::Method Procedure Frame_StartUserSizing(*self.mFrame, what.l)
    *self\mClass\movingFrame = #Null
    *self\mClass\sizingFrame = *self
    *self\mClass\sizingWhat = what
    *self\mClass\movingPoint\x = *self\mClass\MousePoint\x
    *self\mClass\movingPoint\y = *self\mClass\MousePoint\y
    *self\mClass\difPoint\x = 0
    *self\mClass\difPoint\y = 0
  EndProcedure
  class::Method Procedure Frame_StartUserMoving(*self.mFrame)
    *self\mClass\movingFrame = *self
    *self\mClass\sizingFrame = #Null
    *self\mClass\movingPoint\x = *self\mClass\MousePoint\x
    *self\mClass\movingPoint\y = *self\mClass\MousePoint\y
    *self\mClass\difPoint\x = 0
    *self\mClass\difPoint\y = 0
  EndProcedure
  class::Method Procedure Frame_StopUserSizingMoving(*self.mFrame)
    *self\mClass\movingFrame = #Null
    *self\mClass\sizingFrame = #Null
  EndProcedure
  class::Method Procedure Frame_SetBound(*self.mFrame,minWidth.l, minHeight.l, maxWidth.l, maxHeight.l)
    If minWidth <> #PB_Ignore
      *self\MinWidth = minWidth
    EndIf
    If minHeight <> #PB_Ignore
      *self\MinHeight = minHeight
    EndIf
    If maxWidth <> #PB_Ignore
      *self\MaxWidth = maxWidth
    EndIf
    If maxHeight <> #PB_Ignore
      *self\MaxHeight = maxHeight
    EndIf
  EndProcedure
  
  Procedure frame__FindUserData(*self.mframe,name.s)
    Protected.sUserData_base *cur = *self\userData
    While *cur
      If *cur\name = name
        ProcedureReturn *cur
      EndIf
      *cur = *cur\next
    Wend
    ProcedureReturn #Null
  EndProcedure
  
  class::Method Procedure Frame_SetUserData(*self.mFrame, name.s, value.i,silent=#False)
    Protected.sUserData_i *cur = *self\userData
    
    *cur = frame__FindUserData(*self,"i_"+name)
    
    If *cur = #Null
      *cur = AllocateStructure(sUserData_i)
      *cur\name = "i_"+name
      *cur\next = *self\userData
      *self\userData = *cur      
    EndIf
    *cur\value = value
    If Not silent
      Frame__CallEventCallback(*self, #Event_UserData,@name)
    EndIf
    
  EndProcedure
  class::Method Procedure Frame_GetUserData(*self.mFrame, name.s)
    Protected.sUserData_i *cur = *self\userData
    *cur = frame__FindUserData(*self,"i_"+name)
    If *cur
      ProcedureReturn *cur\value
    EndIf
    ProcedureReturn #Null
  EndProcedure
  
  class::Method Procedure Frame_SetUserDataF(*self.mFrame, name.s, value.f,silent=#False)
    Protected.sUserData_f *cur = *self\userData
    
    *cur = frame__FindUserData(*self,"f_"+name)
    
    If *cur = #Null
      *cur = AllocateStructure(sUserData_f)
      *cur\name = "f_"+name
      *cur\next = *self\userData
      *self\userData = *cur      
    EndIf
    *cur\value = value
    If Not silent
      Frame__CallEventCallback(*self, #Event_UserData,@name)
    EndIf
    
  EndProcedure
  class::Method Procedure.f Frame_GetUserDataF(*self.mFrame, name.s)
    Protected.sUserData_f *cur = *self\userData
    *cur = frame__FindUserData(*self,"f_"+name)
    If *cur
      ProcedureReturn *cur\value
    EndIf
    ProcedureReturn 0.0
  EndProcedure
  
  class::Method Procedure Frame_SetUserDataS(*self.mFrame, name.s, value.s,silent=#False)
    Protected.sUserData_s *cur = *self\userData
    
    *cur = frame__FindUserData(*self,"s_"+name)
    
    If *cur = #Null
      *cur = AllocateStructure(sUserData_s)
      *cur\name = "s_"+name
      *cur\next = *self\userData
      *self\userData = *cur      
    EndIf
    *cur\value = value
    If Not silent
      Frame__CallEventCallback(*self, #Event_UserData, @name)
    EndIf
    
  EndProcedure
  class::Method Procedure.s Frame_GetUserDataS(*self.mFrame, name.s)
    Protected.sUserData_s *cur = *self\userData
    *cur = frame__FindUserData(*self,"s_"+name)
    If *cur
      ProcedureReturn *cur\value
    EndIf
    ProcedureReturn #Null$
  EndProcedure
  
  class::Method Procedure Frame_SetTexture(*self.mFrame, *tex.renderer::texture, x1.f, y1.f, x2.f, y2.f, style.l)
    Protected.l tw = *tex\GetWidth()
    Protected.l th = *tex\GetHeight()
    
    Frame__FreeTexture(*self)
    
    With *self
      \tex = *tex
      \texClip\x = tw * x1
      \texClip\y = th * y1
      \texClip\w = tw * (x2-x1) 
      \texClip\h = th * (y2-y1)
      \texStyle = style    
      \texOwnerSelf = #False
    EndWith
  EndProcedure
  
  class::Method Procedure Frame_GetTextTexture(*self.mFrame,*font,text.s,colorRGBA,style.l)
    Protected.sdl::Color color
    color\a=Alpha(colorRGBA):color\r=Red(colorRGBA):color\g=Green(colorRGBA):color\b=Blue(colorRGBA)
    ProcedureReturn *self\mClass\render\RenderText( *font, text, color)
  EndProcedure
    
    
  class::Method Procedure Frame_SetText(*self.mFrame,*font,text.s,colorRGBA,style.l)
    Frame__FreeTexture(*self)
    Frame_SetTexture(*self, Frame_GetTextTexture(*self,*font,text,colorRGBA,style), 0,0,1,1,style)
    *self\texOwnerSelf = #True    
  EndProcedure
  
  
  
  class::Method Procedure Frame_GetParentElement(*self.mFrame)
    ProcedureReturn *self\parent
  EndProcedure

  class::Method Procedure Frame_SortUp(*self.mFrame)
    Protected.mFrame *cur,*base
    Protected.mFrame topStart, *top = @topStart
    Protected.mFrame midStart, *mid = @midStart
    Protected.mFrame backStart, *back = @backStart
    
    *base=*self\parent
    
    If *base\child <> *self
      If *base\child\state & #state_OnTop
        *top\next = *base\child
        *top = *top\next
      ElseIf *base\child\state & #State_OnBack
        *back\next = *base\child
        *back = *back\next
      Else        
        *mid\next = *base\child
        *mid = *mid\next
      EndIf
    EndIf    
    
    *cur = *base\child\next
    While *cur    
      If *cur <> *self
        If *cur\state & #state_OnTop
          *top\next = *cur
          *top = *top\next
        ElseIf *cur\state & #State_OnBack
          *back\next = *cur
          *back = *back\next
        Else
          *mid\next = *cur
          *mid = *mid\next
        EndIf    
      EndIf
      *cur = *cur\next
    Wend
    
    If *self
      If *self\state & #State_OnTop
        *top\next = *self
        *top = *top\next  
      ElseIf *self\state & #State_OnBack
        *back\next = *self
        *back = *back\next  
      Else
        *mid\next = *self
        *mid = *mid\next  
      EndIf
    EndIf
    
    *base\child = #Null
    
    If topStart\next
      *top\next = *base\child
      *base\child = topStart\next    
    EndIf    
    
    If midStart\next
      *mid\next = *base\child
      *base\child = midStart\next
    EndIf
    
    If backStart\next
      *back\next = *base\child
      *base\child = backStart\next    
    EndIf 
    
    *self\mClass\NeedRecalc = #True
  EndProcedure  
 
  class::Method Procedure Frame_NewChild(*self.mFrame, name.s, state.l)
    Protected.mFrame *new = Object::New( Frame, (*self\mClass, name ) )
    *new\parent = *self
    *new\state = state
    ;Debug name+" = "+state
    
    If *self\child = #Null
      *self\child = *new
      ProcedureReturn *new
    EndIf
    
    *self = *self\child
    While *self\next
      *self = *self\next
    Wend
    *self\next = *new
    
    ProcedureReturn *new
  EndProcedure  
  class::Method Procedure Frame_GetParent(*self.mFrame)
    ProcedureReturn *self\parent
  EndProcedure
  
  
  ;-
  
  
  
  class::Method Procedure.l Class_Class(*self.mClass, *render.renderer::Class)
    *self\baseElement = Object::New(Frame,(*self, #BaseElementName))
    
    With *self
      \render = *render  
      \render\GetSize(@ \baseElement\rect\w,@ \baseElement\rect\h )    
    EndWith
    
    *self\NeedRecalc = #True
    
    ProcedureReturn #True    
  EndProcedure
  
  class::Method Procedure.l Class__Delete(*self.mClass)
    Object::Delete( *self\baseElement )
  EndProcedure
  
  class::Method Procedure.l Class_NewElement(*self.mClass, name.s, state.l)
    ProcedureReturn Frame_NewChild( *self\baseElement, name.s, state)
  EndProcedure
  
  class::Method Procedure Class_ReCalculate(*self.mClass) 
    Protected.l i
    *self\baseElement\globalClip = *self\baseElement\rect
    
    Frame__InvalideAllElements( *self\baseElement\child)
    Repeat
      *self\globalValid = #True    
      Frame__CalculateAllElements( *self\baseElement\child )
      i+1
    Until i >= 5 Or *self\globalValid = #True
    ClearList(*self\HitBox())    
    Frame__CalculateAllHitboxes( *self\baseElement\child )
    
    
    ;Debug "globalvalid:"+ *self\globalValid+" "+i
    
    *self\NeedRecalc = #False
  EndProcedure
  
  class::Method Procedure Class_GetHit(*self.mClass, *point.sdl::Point, MouseButton.l, MouseClicks.l)
    Protected.mFrame *ret,*ele
    Protected.l dx,dy
    
    With *self
      \render\GetLogicalSize(@ \baseElement\rect\w,@ \baseElement\rect\h )    
    EndWith
    
    *self\MousePoint\x = *point\x
    *self\MousePoint\y = *point\y
    
    If *self\NeedRecalc
      Class_ReCalculate(*self)
    EndIf
    
    ForEach *self\HitBox()
      With *self\HitBox()
        If sdl::PointInRect(*point, \rect)
          *ret = \frame
          
;                    *self\render\SetDrawColor(255,0,0,255)
;                    *self\render\DrawRect( \rect )
;           Debug Frame_GetName(*ret)
          Break
        Else
;                    *self\render\SetDrawColor(0,255,255,255)
;                    *self\render\DrawRect( \rect )
          
        EndIf
      EndWith
    Next
    
    ;Leave/enter (don't if sizing/moving)
    If *self\sizingFrame = #Null And *self\movingFrame = #Null
      If *ret <> *self\LastMouseFrame
        
        If *self\LastMouseFrame 
          Frame__CallEventCallback(*self\LastMouseFrame, #Event_leave)          
        EndIf
        
        If *ret 
          Frame__CallEventCallback(*ret, #Event_enter)
        EndIf
        
        *self\LastMouseFrame = *ret
      EndIf
    EndIf
    
    ;down, click, doubleclick
    If MouseButton <> *self\MouseButton
      
      ;Left Mouse button
      If (MouseButton & sdl::#BUTTON_LMASK) And Not (*self\MouseButton & sdl::#BUTTON_LMASK)
        If *ret And Not Frame__IsInheritedState(*ret,#state_disabled)            
          Frame__CallEventCallback( *ret, #Event_LeftDown )
          *self\MouseClickFrame = *ret
        EndIf  
        
      ElseIf Not (MouseButton & sdl::#BUTTON_LMASK) And (*self\MouseButton & sdl::#BUTTON_LMASK)
        If *ret And Not Frame__IsInheritedState(*ret,#state_disabled)
          If *ret = *self\MouseClickFrame 
            If MouseClicks & sdl::#BUTTON_LMASK
              Frame__CallEventCallback( *ret, #Event_LeftDoubleClick )
            Else 
              Frame__CallEventCallback( *ret, #Event_LeftClick )
            EndIf              
          EndIf
        
          Frame__CallEventCallback( *ret, #Event_LeftUp )          
        EndIf
        If *self\MouseClickFrame And *ret <> *self\MouseClickFrame
          Frame__CallEventCallback( *self\MouseClickFrame, #Event_LeftUp )
        EndIf
        *self\MouseClickFrame = #Null
      EndIf
      
      ;Right Mouse Button
      If (MouseButton & sdl::#BUTTON_RMASK) And Not (*self\MouseButton & sdl::#BUTTON_RMASK)
        If *ret And Not Frame__IsInheritedState(*ret,#state_disabled)            
          Frame__CallEventCallback( *ret, #Event_RightDown )
          *self\MouseClickFrame = *ret
        EndIf  
        
      ElseIf Not (MouseButton & sdl::#BUTTON_RMASK) And (*self\MouseButton & sdl::#BUTTON_RMASK)
        If *ret And Not Frame__IsInheritedState(*ret,#state_disabled)
          If *ret = *self\MouseClickFrame 
            If MouseClicks & sdl::#BUTTON_RMASK
              Frame__CallEventCallback( *ret, #Event_RightDoubleClick )
            Else 
              Frame__CallEventCallback( *ret, #Event_RightClick )
            EndIf              
          EndIf
        
          Frame__CallEventCallback( *ret, #Event_RightUp )
        EndIf
        If *self\MouseClickFrame And *ret <> *self\MouseClickFrame
          Frame__CallEventCallback( *self\MouseClickFrame, #Event_LeftUp )
        EndIf
        *self\MouseClickFrame = #Null
      EndIf

      
      *self\MouseButton = MouseButton
      *self\MouseClicks = MouseClicks
    EndIf
    
    ; sizing/moving
    
    If *self\movingFrame Or *self\sizingFrame
      dx = *Point\x - *self\movingPoint\x 
      dy = *Point\y - *self\movingPoint\y          
      If dx <> 0 Or dy <> 0
        
        ; correct dx/dy, if the cursor is outside min/max
        If *self\difPoint\x < 0 
          *self\difPoint\x + dx
          If *self\difPoint\x > 0
            dx = *self\difPoint\x
            *self\difPoint\x = 0
          Else
            dx = 0
          EndIf
        ElseIf *self\difPoint\x>0
          *self\difPoint\x + dx
          If *self\difPoint\x < 0
            dx = *self\difPoint\x
            *self\difPoint\x = 0
          Else
            dx = 0
          EndIf            
        EndIf   
        
        If *self\difPoint\y < 0 
          *self\difPoint\y + dy
          If *self\difPoint\y > 0
            dy = *self\difPoint\y
            *self\difPoint\y = 0
          Else
            dy = 0
          EndIf
        ElseIf *self\difPoint\y>0
          *self\difPoint\y + dy
          If *self\difPoint\y < 0
            dy = *self\difPoint\y
            *self\difPoint\y = 0
          Else
            dy = 0
          EndIf            
        EndIf   
                
        
        ;handle moving
        If *self\movingFrame
          If dx And *self\movingFrame\Left\fromAnchor=#Anchor_None 
            *self\movingFrame\rect\x + dx
          EndIf
          If dy And *self\movingFrame\Top\fromAnchor=#Anchor_None 
            *self\movingFrame\rect\y + dy
          EndIf
          
          If *self\movingFrame\rect\x < 0
            *self\difPoint\x + *self\movingFrame\rect\x
            *self\movingFrame\rect\x = 0
          EndIf
                    
          If *self\movingFrame\rect\y < 0
            *self\difPoint\y + *self\movingFrame\rect\y
            *self\movingFrame\rect\y = 0
          EndIf
          
          *ele = *self\movingFrame\parent
          If *self\movingFrame\rect\x + *self\movingFrame\rect\w > *ele\rect\w
            dx = *self\movingFrame\rect\x + *self\movingFrame\rect\w - *ele\rect\w            
            *self\movingFrame\rect\x - dx
            *self\difPoint\x + dx
          EndIf
          If *self\movingFrame\rect\y + *self\movingFrame\rect\h > *ele\rect\h
            dy = *self\movingFrame\rect\y + *self\movingFrame\rect\h - *ele\rect\h
            *self\movingFrame\rect\y - dy
            *self\difPoint\y + dy
          EndIf
          
          Frame__CallEventCallback(*self\movingFrame, #Event_Moving)
          
          ;handling sizing
        ElseIf *self\sizingFrame
          
          If dx And *self\sizingWhat & #Size_Right And *self\sizingFrame\Right\fromAnchor=#Anchor_None 
            *self\sizingFrame\rect\w + dx
          EndIf            
          If dy And *self\sizingWhat & #Size_Bottom And *self\sizingFrame\Bottom\fromAnchor=#Anchor_None
            *self\sizingFrame\rect\h + dy
          EndIf
          If dx And *self\sizingWhat & #Size_Left And *self\sizingFrame\Left\fromAnchor=#Anchor_None And *self\sizingFrame\Right\fromAnchor=#Anchor_None
            *self\sizingFrame\rect\x + dx
            *self\sizingFrame\rect\w - dx
          EndIf   
          If dy And *self\sizingWhat & #Size_Top And *self\sizingFrame\Top\fromAnchor=#Anchor_None And *self\sizingFrame\Bottom\fromAnchor=#Anchor_None
            *self\sizingFrame\rect\y + dy
            *self\sizingFrame\rect\h - dy
          EndIf              
          
          ;Check min/max and set "correction"-Value
          If *self\sizingWhat & #Size_Right
            If *self\sizingFrame\rect\w < *self\sizingFrame\MinWidth
              *self\difPoint\x + (*self\sizingFrame\rect\w - *self\sizingFrame\MinWidth)
              *self\sizingFrame\rect\w = *self\sizingFrame\MinWidth
            ElseIf *self\sizingFrame\rect\w > *self\sizingFrame\MaxWidth
              *self\difPoint\x + (*self\sizingFrame\rect\w - *self\sizingFrame\MaxWidth)
              *self\sizingFrame\rect\w = *self\sizingFrame\MaxWidth
            EndIf
          EndIf
          If *self\sizingWhat & #Size_Left
            If *self\sizingFrame\rect\w < *self\sizingFrame\MinWidth
              dx=(*self\sizingFrame\rect\w - *self\sizingFrame\MinWidth)
              *self\difPoint\x - dx
              *self\sizingFrame\rect\w - dx
              *self\sizingFrame\rect\x + dx
            ElseIf *self\sizingFrame\rect\w > *self\sizingFrame\MaxWidth
              dx=(*self\sizingFrame\rect\w - *self\sizingFrame\MaxWidth)
              *self\difPoint\x - dx
              *self\sizingFrame\rect\w - dx
              *self\sizingFrame\rect\x + dx
            EndIf
          EndIf            
          If *self\sizingWhat & #Size_Bottom
            If *self\sizingFrame\rect\h < *self\sizingFrame\MinHeight
              *self\difPoint\y + (*self\sizingFrame\rect\h - *self\sizingFrame\MinHeight)
              *self\sizingFrame\rect\h = *self\sizingFrame\MinHeight
            ElseIf *self\sizingFrame\rect\h > *self\sizingFrame\MaxHeight
              *self\difPoint\y + (*self\sizingFrame\rect\h - *self\sizingFrame\MaxHeight)
              *self\sizingFrame\rect\h = *self\sizingFrame\MaxHeight
            EndIf
          EndIf
          If *self\sizingWhat & #Size_Top
            If *self\sizingFrame\rect\h < *self\sizingFrame\MinHeight 
              dy=(*self\sizingFrame\rect\h - *self\sizingFrame\MinHeight)
              *self\difPoint\y - dy
              *self\sizingFrame\rect\h - dy
              *self\sizingFrame\rect\y + dy
            ElseIf *self\sizingFrame\rect\h > *self\sizingFrame\MaxHeight
              dx=(*self\sizingFrame\rect\h - *self\sizingFrame\MaxHeight)
              *self\difPoint\y - dy
              *self\sizingFrame\rect\h - dy
              *self\sizingFrame\rect\y + dy
            EndIf
          EndIf
          
          Frame__CallEventCallback(*self\sizingFrame, #Event_Sizing)
          
        EndIf
        
        ;redraw and "reset" relativ
        *self\NeedRecalc = #True   
        *self\movingPoint\x = *Point\x
        *self\movingPoint\y = *point\y
      EndIf
    EndIf
    
    
    ProcedureReturn *ret
  EndProcedure
  
  class::Method Procedure.l Class_Draw(*self.mClass)
    If *self\NeedRecalc
      Class_ReCalculate(*self)
    EndIf    
    
    Frame__DrawAllElements(*self\baseElement\child )
  EndProcedure
  
  class::Method Procedure Class_GetFrame(*self.mClass, name.s)
    ProcedureReturn Frame__FindFrame(*self\baseElement\child,name.s)
  EndProcedure
  
EndModule
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 1068
; FirstLine = 1055
; Folding = ------------
; EnableXP