; small class helper library
; this file has no copyright!
; use it as you want.

Interface _baseclass
  _new.l()
  _delete()
EndInterface

Structure _sbaseclass
  *_functions
EndStructure

Procedure.i _DefaultNewDelete(*self._sbaseclass)
  ProcedureReturn #True
EndProcedure

Macro NewObject(_type_,_para_=() ) : New#_type_ _para_ :EndMacro

Macro DeleteObject(_class_): _class_\_delete() : FreeStructure(_class_) : _class_=#Null : EndMacro

Macro class: Runtime :EndMacro

Macro _dquote
  "
EndMacro

Macro DimDeleteObject(_name_) 
  CompilerIf Not Defined(_dimdeleteobject_i,#PB_Variable)
    CompilerIf #PB_Compiler_Procedure<>""
      Protected _dimdeleteobject_i.l
    CompilerElse
      Define _dimdeleteobject_i.l
    CompilerEndIf
  CompilerEndIf
    
  For _dimdeleteobject_i=0 To ArraySize(_name_())
    _name_(_dimdeleteobject_i)\_delete()
    FreeStructure( _name_(_dimdeleteobject_i) )
    _name_(_dimdeleteobject_i)=#Null
  Next    
  
EndMacro

Macro DimNewObject(_name_,_type_,_para_=() )
  CompilerIf Not Defined(_dimnewobject_#_type_,#PB_Procedure)
    Procedure _dimnewobject_#_type_(Array objects._type_(1))
      Protected i
      For i=0 To ArraySize(objects())
        objects(i) = New#_type_ _para_
      Next
    EndProcedure
  CompilerEndIf
  _dimnewobject_#_type_( _name_ () )
EndMacro

Macro CreateClass(_type_,_para_=() )
  Global *_#_type_#_functions
  
  Interface _baseclass_#_type_
    _new.l _para_
  EndInterface
  
  Procedure New#_type_# _para_
    Protected *adr._baseclass_#_type_ = AllocateStructure(s#_type_)
    PokeI(*adr,*_#_type_#_functions)
    If *adr\_new _para_ 
      ProcedureReturn *adr
    EndIf
    FreeStructure(*adr)
    ProcedureReturn #Null
  EndProcedure
  
  Procedure _#_type_#_init ()
    Protected json
    
    Protected *SetMem.integer
    Protected i
    
    *_#_type_#_functions=AllocateMemory(SizeOf(_type_))
    *SetMem=*_#_type_#_functions 
    For i=1 To SizeOf(_type_) / SizeOf(Integer)
      *SetMem\i=(i-1) * SizeOf(integer)
      *SetMem+SizeOf(Integer)
    Next
    
    json=CreateJSON(#PB_Any)    
    InsertJSONStructure(JSONValue(json), *_#_type_#_functions, _type_)
    
    FillMemory(*_#_type_#_functions, SizeOf(_type_))
    
    Define ObjectValue = JSONValue(json), offset.i
    If ExamineJSONMembers(ObjectValue)
      While NextJSONMember(ObjectValue)
        *SetMem= *_#_type_#_functions + GetJSONInteger(JSONMemberValue(ObjectValue))
        *SetMem\i = GetRuntimeInteger( _dquote#_type_#_dquote + "_" + JSONMemberKey(ObjectValue)+"()" )   
      Wend
    EndIf
    
    *SetMem=*_#_type_#_functions 
    For i=1 To SizeOf(_type_) / SizeOf(Integer)
      If *SetMem\i=#Null
        If i=1
          *SetMem\i = GetRuntimeInteger( _dquote#_type_#_dquote + "_" + _dquote#_type_#_dquote + "()" )
          If *SetMem=0
            *SetMem\i=@_DefaultNewDelete()
          EndIf
        ElseIf i=2
          *SetMem\i=@_DefaultNewDelete()
        Else
          Debug _dquote#_type_#_dquote + "MISSING FUNCTION: "+i
        EndIf
      EndIf
      *SetMem+SizeOf(Integer)
    Next
    
    
    FreeJSON(json)
  EndProcedure
  _#_type_#_init ()
EndMacro  
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 12
; Folding = --
; EnableXP