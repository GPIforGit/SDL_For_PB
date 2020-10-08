; small vector helper library
; this file has no copyright!
; use it as you want.

Structure _vectorHeader
  size.l
  nb.l
EndStructure

Macro CreateVector(type,nb=1): _CreateVector(SizeOf(type),nb) :EndMacro

Procedure.i _CreateVector(size,nb=1)
  Protected *mem._vectorHeader=AllocateMemory(size * nb+SizeOf(_vectorHeader))
  Protected *set._vectorHeader=*mem
  
  *mem\size=size
  *mem\nb=nb
  ProcedureReturn *mem+SizeOf(_vectorHeader)
EndProcedure

Procedure.i FreeVector(*mem)
  *mem-SizeOf(_vectorHeader)
  FreeMemory(*mem)
EndProcedure

Procedure.i _ResizeVector(*mem._vectorHeader,nb)
  *mem-SizeOf(_vectorHeader)
  *mem=ReAllocateMemory(*mem, *mem\size*nb)
  *mem\nb=nb
  ProcedureReturn *mem+SizeOf(_vectorHeader)
EndProcedure
Macro ResizeVector(vec,nb): vec=_ResizeVector(vec,nb) :EndMacro

Procedure.l GetVectorSize(*mem._vectorHeader)
  *mem-SizeOf(_vectorHeader)
  ProcedureReturn *mem\nb
EndProcedure

; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 14
; Folding = --
; EnableXP