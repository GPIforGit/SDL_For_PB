EnableExplicit

Define XML = LoadXML(#PB_Any,"gadgets.xml")

Debug XMLError(xml)+" - line:"+ XMLErrorLine(xml) + "- pos:" + XMLErrorPosition(xml) + "- status:" +XMLStatus(xml)


Procedure OutputNode(*node,deep=0)
  While *node
    Debug Space(deep*2) + GetXMLNodeName(*node)
    
    *node=NextXMLNode(*node)
  Wend
  
EndProcedure

Define *node

*node= MainXMLNode(xml)
If *node And GetXMLNodeName(*node)="Gui"
  OutputNode( ChildXMLNode(*node) )
EndIf

Debug ValF("10e-1.5")
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 23
; Folding = -
; EnableXP