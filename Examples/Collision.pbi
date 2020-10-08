
CompilerIf #PB_Compiler_IsMainFile
  EnableExplicit
CompilerEndIf

Structure sPoint
  x.l
  y.l
EndStructure
Structure sCircle
  x.l
  y.l
  r.l
EndStructure

Structure sLine
  p1.sPoint
  p2.sPoint
  min.sPoint
  max.sPoint
  m.f
  d.f
EndStructure

Structure sRect
  x.l
  y.l
  w.l
  h.l
EndStructure

Enumeration
  #ColObject_Point
  #ColObject_Rect
  #ColObject_Line
  #ColObject_Circle
EndEnumeration

Structure sColObject
  type.l
  StructureUnion
    point.sPoint
    rect.sRect
    line.sLine
    circle.sCircle
  EndStructureUnion
EndStructure

Procedure CalculateLineFormula(*line.sLine)
  If *line\p1\x = *line\p2\x
    *line\m=NaN()
  Else
    *line\m=(*line\p2\y - *line\p1\y) / (*line\p2\x - *line\p1\x)
    *line\d=*line\p1\y - *line\p1\x * *line\m
  EndIf
  
  If *line\p1\x < *line\p2\x 
    *line\min\x=*line\p1\x
    *line\max\x=*line\p2\x
  Else
    *line\min\x=*line\p2\x
    *line\max\x=*line\p1\x
  EndIf
  
  If *line\p1\y < *line\p2\y
    *line\min\y=*line\p1\y
    *line\max\y=*line\p2\y
  Else
    *line\min\y=*line\p2\y
    *line\max\y=*line\p1\y
  EndIf  
EndProcedure

Macro SetLine(line,x1,y1,x2,y2)
  line\p1\x=x1 : line\p1\y=y1 : line\p2\x=x2 : line\p2\y=y2  
  CalculateLineFormula( line )
EndMacro

Procedure.l PointOnLine(*line.sline,*p.sPoint)
  If IsNAN(*line\m)
    ProcedureReturn Bool( *p\x=*line\min\x And *line\min\y <= *p\y And *p\y <= *line\max\y )
  EndIf
  
  Protected.f y = *p\x * *line\m + *line\d
  
  ProcedureReturn Bool( *p\y-1 <= y And y <= *p\y+1  And
                        *line\min\y <= *p\y And *p\y <= *line\max\y)
EndProcedure

Procedure.l LineOnLine(*line1.sline,*line2.sLine)
  Protected.l y,x

  If IsNAN(*line1\m)
    If IsNAN(*line2\m)
      ProcedureReturn Bool( *line1\min\x = *line2\min\x And 
                            Not *line1\max\y < *line2\min\y And Not *line1\min\y > *line2\max\y )
    EndIf
    
    y= *line1\min\x * *line2\m + *line2\d
    
    ProcedureReturn Bool ( (*line2\min\x <= *line1\min\x And *line1\min\x <= *line2\max\x) And 
                           (*line1\min\y <= y And y <= *line1\max\y ) And
                           (*line2\min\y <= y And y <= *line2\max\y ) )
  ElseIf IsNAN(*line2\m)
    y= *line2\min\x * *line1\m + *line1\d
    
    ProcedureReturn Bool ( (*line1\min\x <= *line2\min\x And *line2\min\x <= *line1\max\x) And 
                           (*line2\min\y <= y And y <= *line2\max\y ) And 
                           (*line1\min\y <= y And y <= *line1\max\y ) )
        
  ElseIf *line1\m = *line2\m
    ProcedureReturn Bool( *line1\d = *line2\d And 
                          Not *line1\max\y < *line2\min\y And Not *line1\min\y > *line2\max\y )
  EndIf
  
  x= (*line2\d - *line1\d) / (*line1\m - *line2\m)
  
  ProcedureReturn Bool( *line1\min\x <= x And x <= *line1\max\x And
                        *line2\min\x <= x And x <= *line2\max\x )
EndProcedure

Procedure LineNearestPoint(*line1.sline,*p.sPoint,*ret.sPoint)
  Protected.f m, d, x
  If IsNAN(*line1\m)
    *ret\x=*line1\min\x
    
    If *p\y < *line1\min\y
      *ret\y = *line1\min\y
    ElseIf *p\y > *line1\max\y
      *ret\y = *line1\max\y
    Else
      *ret\y=*p\y
    EndIf
    ProcedureReturn
  ElseIf *line1\m=0
    *ret\y=*line1\min\y
    
    If *p\x < *line1\min\x
      *ret\x = *line1\min\x
    ElseIf *p\x > *line1\max\x
      *ret\x = *line1\max\x
    Else
      *ret\x=*p\x
    EndIf
    ProcedureReturn    
  Else
    m=- 1 / *line1\m
  EndIf
  
  d= *p\y - *p\x * m
  
  x= (d - *line1\d) / (*line1\m - m)
  If x < *line1\min\x
    x=*line1\min\x
  ElseIf x> *line1\max\x
    x=*line1\max\x
  EndIf
  
  *ret\x=x
  *ret\y=x * *line1\m + *line1\d
  
EndProcedure

Procedure.l DistanceSquare(*p1.sPoint,*p2.sPoint)
  Protected.l x = *p1\x - *p2\x
  Protected.l y = *p1\y - *p2\y
  ProcedureReturn x*x + y*y
EndProcedure

Procedure.l PointOnRectWH(*p.sPoint, *rect.sRect)
  ProcedureReturn Bool ( Not *p\x < *rect\x And Not *p\x >=*rect\x + *rect\w And 
                         Not *p\y < *rect\y And Not *p\y >=*rect\y + *rect\h)
EndProcedure

Procedure.l LineOnRectWH(*line.sLine, *rect.sRect)
  Protected x2=*rect\x + *rect\w -1
  Protected y2=*rect\y + *rect\h -1
  
  ;Quickcheck
  If Not ( Not *line\max\x < *rect\x And Not *line\min\x >= x2 And
           Not *line\max\y < *rect\y And Not *line\min\y >= y2 )
    ProcedureReturn #False
  EndIf
  
  Protected.sLine line2
  
  SetLine(line2, *rect\x, *rect\y, x2, *rect\y )
  If LineOnLine(line2,*line)
    ProcedureReturn #True
  EndIf
  
  SetLine(line2, *rect\x, *rect\y, *rect\x, y2 )
  If LineOnLine(line2,*line)
    ProcedureReturn #True
  EndIf
  
  SetLine(line2, x2, *rect\y, x2, y2 )
  If LineOnLine(line2,*line)
    ProcedureReturn #True
  EndIf
  
  SetLine(line2, *rect\x, y2, x2, y2 )
  If LineOnLine(line2,*line)
    ProcedureReturn #True
  EndIf
  ProcedureReturn #False  
  
;   ProcedureReturn Bool ( Not *line\max\x < *rect\x And Not *line\min\x >= *rect\x + *rect\w And
;                          Not *line\max\y < *rect\y And Not *line\min\y >= *rect\y + *rect\h )
EndProcedure

Procedure.l RectWHOnRectWH(*rect1.sRect,*rect2.sRect)
  ProcedureReturn Bool( Not *rect1\x+*rect1\w-1 < *rect2\x And
                        Not *rect1\y+*rect1\h-1 < *rect2\y And
                        Not *rect1\x > *rect2\x + *rect2\w-1 And
                        Not *rect1\y > *rect2\y + *rect2\h-1 )
EndProcedure

Procedure.l PointOnCircle(*point.sPoint,*circle.sCircle)
  ProcedureReturn Bool( DistanceSquare(*point,*circle) < *circle\r * *Circle\r)
EndProcedure

Procedure.l LineOnCircle(*line.sline,*circle.sCircle)
  Protected.sPoint p
  LineNearestPoint(*line,*circle,p)
  ProcedureReturn Bool( DistanceSquare(p,*circle) < *circle\r * *circle\r )
EndProcedure

Procedure.l CircleOncCircle(*circle1.sCircle,*circle2.sCircle)
  Protected.l distance = *circle1\r + *circle2\r
  ProcedureReturn Bool( DistanceSquare(*circle1,*circle2) < distance*distance )
EndProcedure

Procedure RectWHOnCircle(*rect.sRect,*circle.sCircle)
  Protected.sPoint p

  Protected.l x2=*rect\x + *rect\w -1
  Protected.l y2=*rect\y + *rect\h -1
  
  If *circle\x < *rect\x
    p\x = *rect\x
    If *circle\y < *rect\y
      p\y = *rect\y
    ElseIf *circle\y > y2
      p\y = y2
    Else
      p\y = *circle\y
    EndIf
    ProcedureReturn Bool( DistanceSquare(p,*circle) < *circle\r * *circle\r )
  ElseIf *circle\x > x2
    p\x = x2
    If *circle\y < *rect\y
      p\y = *rect\y
    ElseIf *circle\y > y2
      p\y = y2
    Else
      p\y = *circle\y
    EndIf
    ProcedureReturn Bool( DistanceSquare(p,*circle) < *circle\r * *circle\r )
  ElseIf *circle\y < *rect\y
    p\y = *rect\y
    If *circle\x < *rect\x
      P\x = *rect\x
    ElseIf *circle\x > x2
      p\x = x2
    Else
      p\x = *circle\x
    EndIf
    ProcedureReturn Bool( DistanceSquare(p,*circle) < *circle\r * *circle\r )
  ElseIf *circle\y > y2
    p\y = y2
    If *circle\x < *rect\x
      P\x = *rect\x
    ElseIf *circle\x > x2
      p\x = x2
    Else
      p\x = *circle\x
    EndIf
    ProcedureReturn Bool( DistanceSquare(p,*circle) < *circle\r * *circle\r )  
  EndIf
  ProcedureReturn #True    
EndProcedure

Procedure.l CheckCollision(*obj1.sColObject,*obj2.sColObject)
  Select *obj1\type<<8 | *obj2\type
    Case #ColObject_Line<<8 | #ColObject_Line
      ProcedureReturn LineOnLine(*obj1\line, *obj2\line)
    Case #ColObject_Line<<8 | #ColObject_Point
      ProcedureReturn PointOnLine(*obj2\point,*obj1\line)
    Case #ColObject_Line<<8 | #ColObject_Rect
      ProcedureReturn LineOnRectWH(*obj2\rect,*obj1\line)
    Case #ColObject_Line<<8 | #ColObject_Circle
      ProcedureReturn LineOnCircle(*obj1\line,*obj2\circle)
      
    Case #ColObject_Point<<8 | #ColObject_Line
      ProcedureReturn PointOnLine(*obj1\point,*obj2\line)
    Case #ColObject_Point<<8 | #ColObject_Point
      ProcedureReturn Bool( *obj1\point\x = *obj2\point\x And *obj1\point\y = *obj2\point\y )
    Case #ColObject_Point<<8 | #ColObject_Rect
      ProcedureReturn PointOnRectWH(*obj1\point,*obj2\rect)
    Case #ColObject_Point<<8 | #ColObject_Circle
      ProcedureReturn PointOnCircle(*obj1\point,*obj2\circle)
      
    Case #ColObject_Rect<<8 | #ColObject_Line
      ProcedureReturn LineOnRectWH(*obj2\line,*obj1\rect)
    Case #ColObject_Rect<<8 | #ColObject_Point
      ProcedureReturn PointOnRectWH(*obj2\point,*obj1\rect)
    Case #ColObject_Rect<<8 | #ColObject_Rect
      ProcedureReturn RectWHOnRectWH(*obj1\rect,*obj2\rect)
    Case #ColObject_Rect<<8 | #ColObject_Circle  
      ProcedureReturn RectWHOnCircle(*obj1\rect,*obj2\circle)
      
    Case #ColObject_Circle<<8 | #ColObject_Line
      ProcedureReturn LineOnCircle(*obj2\line,*obj1\circle)
    Case #ColObject_Circle<<8 | #ColObject_Point
      ProcedureReturn PointOnCircle(*obj2\point,*obj1\circle)
    Case #ColObject_Circle<<8 | #ColObject_Rect
      ProcedureReturn RectWHOnCircle(*obj2\rect,*obj1\circle)
    Case #ColObject_Circle<<8 | #ColObject_Circle  
      ProcedureReturn CircleOncCircle(*obj1\circle,*obj2\circle)
      
    Default 
      Debug "Collision - UNKNOWN OBJECTS! " + *obj1\type + " " + *obj2\type      
      
  EndSelect
  ProcedureReturn #False
EndProcedure


; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 5
; FirstLine = 2
; Folding = ----
; EnableXP