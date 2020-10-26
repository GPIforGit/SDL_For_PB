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

Procedure DeleteObject(*class._baseclass)
  *class\_delete() 
  PokeI(*class, #Null)
  FreeStructure(*class)
EndProcedure

Macro IsClass(_object_, _type_)
  Bool( PeekI( _object_) = *_#_type_#_functions )
EndMacro

Macro class: Runtime :EndMacro
Macro _dquote
  "
EndMacro

Global *__baseclass_functions=AllocateMemory(SizeOf(_baseclass))
PokeI(*__baseclass_functions, @_DefaultNewDelete() )
PokeI(*__baseclass_functions + SizeOf(Integer), @_DefaultNewDelete() )

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

Macro CreateClass(_type_,_para_=(),_extends_=_baseclass )
  Global *_#_type_#_functions
  
  
  CompilerIf OffsetOf(_type_\_new())<> 0 Or
             OffsetOf(_type_\_delete()) <> SizeOf(Integer) Or
             OffsetOf(s#_type_\_functions) <> 0 
    CompilerError "forgott Extends _baseclass?"
  CompilerEndIf
  
  
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
    Protected i,offset
    Protected *func
    
    *_#_type_#_functions=AllocateMemory(SizeOf(_type_))
    *SetMem=*_#_type_#_functions 
    For i=1 To SizeOf(_type_) / SizeOf(Integer)
      *SetMem\i=(i-1) * SizeOf(integer)
      *SetMem+SizeOf(Integer)
    Next
    
    json=CreateJSON(#PB_Any)    
    InsertJSONStructure(JSONValue(json), *_#_type_#_functions, _type_)
    
    FillMemory(*_#_type_#_functions, SizeOf(_type_))
    
    CopyMemory( *_#_extends_#_functions, *_#_type_#_functions, SizeOf(_extends_) )
    
    Define ObjectValue = JSONValue(json), offset.i
    If ExamineJSONMembers(ObjectValue)
      While NextJSONMember(ObjectValue)
        offset=GetJSONInteger(JSONMemberValue(ObjectValue))
        *SetMem= *_#_type_#_functions + offset
        *func = GetRuntimeInteger( _dquote#_type_#_dquote + "_" + JSONMemberKey(ObjectValue)+"()" )   
        If *func = 0 And offset = 0 
          *func = GetRuntimeInteger( _dquote#_type_#_dquote + "_" + _dquote#_type_#_dquote + "()" )
        EndIf
        
        If *func
          *SetMem\i = *func
        EndIf
        
        If *setMem\i = 0
          Debug _dquote#_type_#_dquote + " MISSING FUNCTION: " + _dquote#_type_#_dquote + "_" + JSONMemberKey(ObjectValue)
        EndIf
        
      Wend
    EndIf
    
    *SetMem=*_#_type_#_functions 
    For i=1 To SizeOf(_type_) / SizeOf(Integer)
      If *SetMem\i=#Null
        Debug _dquote#_type_#_dquote + " MISSING FUNCTION: "+i
        CallDebugger
      EndIf
      *SetMem+SizeOf(Integer)
    Next
    
    
    FreeJSON(json)
  EndProcedure
  _#_type_#_init ()
EndMacro  
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 147
; FirstLine = 111
; Folding = --
; EnableXP