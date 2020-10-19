; small class library
; this file has no copyright!
; use it as you want.
 
CompilerIf #PB_Compiler_IsMainFile 
  EnableExplicit
CompilerEndIf
 
DeclareModule _Class
  Macro dquote
    "
  EndMacro
 
  Declare FillFunctions (ClassFunctions, size, json, type.s, mod.s)
  Declare AllocateCountedMemory(Count,offset)
  Declare IsClass (*object, *functionlist)
  
  Macro Hide_Global_base_ClassFunctions_
    Global base_ClassFunctions_
  EndMacro 
  
  Structure Header_Functions
    *parentFunctions
    ;name.s
  EndStructure
 
EndDeclareModule
;-

DeclareModule Class
  Interface Base
    _new.l()
    _delete()
  EndInterface 
  
  Structure mBase
    *_functions
  EndStructure
 
  _class::Hide_Global_base_ClassFunctions_
  
  Macro Method
    Runtime
  EndMacro
  
  Macro Is(object, _type_)
    _class::IsClass(Object, _type_#_ClassFunctions_)
  EndMacro
    
  Macro Announce(_type_, _para_=(), _extends_ = Class::Base)
    Declare.i _type_#_new_ _para_
    Global _type_#_ClassFunctions_
  EndMacro
 
  Macro Create(_type_, _para_=(), _extends_ = Class::Base)
    
    CompilerIf Not Defined( _type_#_ClassFunctions_, #PB_Variable )
      Global _type_#_ClassFunctions_
    CompilerEndIf
     
    Interface _class_#_type_
      _new.l _para_
      _delete ()
    EndInterface
   
    Procedure.i _type_#_new_ _para_     
      Protected *adr._class_#_type_ = AllocateStructure(m#_type_)     
      
      CompilerIf _class::dquote#_extends_#_class::dquote = "Class::Base"
        PokeI(*adr, _type_#_ClassFunctions_)
        If *adr\_new _para_
          ProcedureReturn *adr
        EndIf
        FreeStructure(*adr)
        ProcedureReturn #Null
        
      CompilerElse
        Protected *newFunc, *newFuncOld
       
        NewList *functions()
        Protected *header._class::Header_Functions       
        
        *header=_type_#_ClassFunctions_
        While *header And *header <> class::base_ClassFunctions_
          *newFunc = PeekI(*header + OffsetOf( class::base\_new() ) )
          If *newFunc <> *newFuncOld       
            InsertElement( *functions() )
            *functions() = *header
            *newFuncOld=*newFunc
          EndIf
          *header - SizeOf(_Class::Header_Functions)
          *header=*header\parentFunctions
        Wend
       
        ForEach *functions()
          PokeI(*adr,*functions())
          If *adr\_new _para_ = 0
            If PreviousElement(*functions())
              PokeI(*adr,*functions())
              object::Delete(*adr)
              *adr=#Null
              Break
            Else
              FreeStructure(*adr)
              *adr=#Null
              Break
            EndIf
          EndIf
        Next
        
        If *adr
          PokeI(*adr, _type_#_ClassFunctions_)
        EndIf
       
        ProcedureReturn *adr
      CompilerEndIf
    EndProcedure
 
    Procedure _#_type_#_init ()
      Protected json
     
      _type_#_ClassFunctions_ = _class::AllocateCountedMemory(SizeOf(_type_),SizeOf(_class::Header_Functions))
     
      Protected *header._class::Header_Functions = _type_#_ClassFunctions_ - SizeOf(_class::Header_Functions)
      InitializeStructure(*header, _class::Header_Functions)
      *header\parentFunctions = _extends_#_ClassFunctions_
      
      json = CreateJSON(#PB_Any)   
      InsertJSONStructure( JSONValue(json), _type_#_ClassFunctions_, _type_)
     
      FillMemory(_type_#_ClassFunctions_, SizeOf(_type_))
      CopyMemory(_extends_#_ClassFunctions_, _type_#_ClassFunctions_, SizeOf( _extends_ ) )
     
      _class::FillFunctions(_type_#_ClassFunctions_, SizeOf(_type_), json, _class::dquote#_type_#_class::dquote, #PB_Compiler_Module)
      FreeJSON(json)     
      
    EndProcedure
    _#_type_#_init ()
  EndMacro
   
EndDeclareModule
;-
DeclareModule Object
  Macro New(_type_,_para_=() )
    _type_#_new_ _para_
  EndMacro
  Declare Delete( *obj ) 
  
  Macro DimDelete(_name_)
    CompilerIf Not Defined(_class_object_dim_i_,#PB_Variable)
      CompilerIf #PB_Compiler_Procedure<>""
        Protected _class_object_dim_i_.l
      CompilerElse
        Define _class_object_dim_i_.l
      CompilerEndIf
    CompilerEndIf
   
    For _class_object_dim_i_=0 To ArraySize(_name_())
      Object::Delete(_name_(_class_object_dim_i_) )
    Next   
    
  EndMacro
 
  Macro DimNew(_name_,_type_,_para_=() )   
    CompilerIf Not Defined(_class_object_dim_i_,#PB_Variable)
      CompilerIf #PB_Compiler_Procedure<>""
        Protected _class_object_dim_i_.l
      CompilerElse
        Define _class_object_dim_i_.l
      CompilerEndIf
    CompilerEndIf
   
    For _class_object_dim_i_=0 To ArraySize(_name_())
      _name_(_class_object_dim_i_) = Object::New( _type_, _para_ )
    Next
   
  EndMacro
 
  
  
EndDeclareModule
;-
Module _class
  
  Procedure IsClass(*object,*functionlist)
    Protected *header._class::Header_Functions
     
    *header = PeekI( *object )
    While *header
      If *header = *functionlist
        ProcedureReturn #True
      EndIf
      *header - SizeOf( _class::Header_Functions )
      *header = *header\parentFunctions
    Wend
    ProcedureReturn #False
  EndProcedure    
      
  Procedure AllocateCountedMemory(Count,Offset)
    Protected.integer *ret, *mem.integer = AllocateMemory(count+Offset, #PB_Memory_NoClear)+Offset
    Protected i
    *ret=*mem
    While i<count
      *mem\i=i
      *mem + SizeOf(integer)
      i + SizeOf(integer)
    Wend
    ProcedureReturn *ret
  EndProcedure   
    
  Procedure FillFunctions (ClassFunctions, size, json, type.s, mod.s)
    Protected ObjectValue = JSONValue(json)
    Protected.i offset
    Protected *SetMem.integer 
    Protected *func
   
    If mod<>""
      mod+"::"
    EndIf
     
    If ExamineJSONMembers(ObjectValue)
      While NextJSONMember(ObjectValue)
        offset = GetJSONInteger(JSONMemberValue(ObjectValue))
        *SetMem= ClassFunctions + offset
        *func = GetRuntimeInteger( mod+ type + "_" + JSONMemberKey(ObjectValue) + "()" )  
        If *func = 0 And offset = 0
          *func= GetRuntimeInteger( mod+ type + "_" + type + "()" )            
        EndIf
      
        If *func
          *SetMem\i = *func
        EndIf
       
        CompilerIf #PB_Compiler_Debugger
          If *SetMem\i = 0
            Debug "[CLASS] missing member "+ mod+ type + "_" + JSONMemberKey(ObjectValue) + "()"
          EndIf
        CompilerEndIf       
        
      Wend
    EndIf
   
    CompilerIf #PB_Compiler_Debugger
      Protected i=size
      *SetMem = ClassFunctions
      While i>0
        If *SetMem\i=#Null
          Debug "MISSING FUNCTION! - class::Member?"
          CallDebugger
          End
        EndIf
        *SetMem+SizeOf(Integer)
        i - SizeOf(Integer)
      Wend
    CompilerEndIf        
      
  EndProcedure
EndModule

;-
 
Module Class
  
  Procedure.l base_base(*self.mBase)
    ProcedureReturn #True
  EndProcedure
  Procedure base__delete(*self.mBase)
  EndProcedure
 
  Procedure Init()
    base_ClassFunctions_ = AllocateMemory(SizeOf(class::Base)*2+ SizeOf(_class::Header_Functions)) + SizeOf(_class::Header_Functions)
    PokeI(base_ClassFunctions_ + OffsetOf( class::Base\_new() )   , @base_base() )
    PokeI(base_ClassFunctions_ + OffsetOf( class::Base\_delete() ), @base__delete() )
  EndProcedure
  init()
 
EndModule

;-

Module Object
  Procedure Delete(*obj.class::Base)
    Protected *header._class::Header_Functions
    Protected *cur.integer = *obj   
    If *obj = #Null
      ProcedureReturn
    EndIf
   
    Protected *delFunc, *delFuncOld
   
    *cur=*cur\i
    While *cur
      If *cur <> class::base_ClassFunctions_
        *delFunc = PeekI(*cur + OffsetOf( class::Base\_delete() ))
        If *delFunc And *delFunc <> *delFuncOld
          CallFunctionFast(*delFunc,*obj )
        EndIf
        *delFuncOld = *delFunc
      EndIf
      *header= *cur - SizeOf(_class::Header_Functions)
      *cur=*header\parentFunctions
    Wend
     
    PokeI(*obj,#Null)
    FreeStructure(*obj)
 
  EndProcedure
 
EndModule

;-

Macro class
  Runtime 
EndMacro
 
CompilerIf #PB_Compiler_IsMainFile
  OpenConsole()
 
  Interface dummy Extends class::base
    Testi()
  EndInterface
  Structure mDummy Extends Class::mBase
    value.i
  EndStructure
 
  class::Create(dummy,(a))
 
  class::Method Procedure.l dummy_dummy(*self.mDummy,a)
    *self\value=a
    Debug "Create"
    ProcedureReturn #True
  EndProcedure
 
  class::Method Procedure dummy__delete(*self.mDummy)
    Debug "Delete"
  EndProcedure
 
  class::Method Procedure dummy_Testi(*self.mDummy)
    Debug "Testi " + *self\value
  EndProcedure
 
  
  Define c1.dummy = Object::New( dummy, (10) )
 
  
  c1\Testi()
 
  Object::Delete(c1)
 
  DeclareModule ren
    Interface class Extends class::base
      aber()
    EndInterface
    Structure mClass Extends class::mBase
    EndStructure
    class::Announce(class)
  EndDeclareModule
  Module ren
    class::Create(class)
   
    class::Method Procedure class_class(*self.mClass)
      Debug "ren::class "+*self
     ProcedureReturn #True
    EndProcedure
   
    class::Method Procedure class__delete(*self.mClass)
      Debug "Remove Ren "+*self
    EndProcedure
   
    class::Method Procedure class_aber(*self.mClass)
      Debug "ABER!" 
    EndProcedure
   
    
  EndModule
 
  
  Define.ren::class c2=  Object::New(ren::class)
  c2\aber()
     
  Dim c3.dummy(10)
 
  object::DimNew(c3, dummy, (99) )
 
  object::DimDelete(c3)
 
  
  Interface ren2 Extends ren::class
    darum()
  EndInterface
  Structure mRen2 Extends ren::mClass
  EndStructure
  class::Create( ren2,(),ren::class)
 
  class Procedure ren2_darum(*self.mRen2)
    Debug "darum"
  EndProcedure
  class Procedure ren2__delete(*self.mRen2)
    Debug "Delete ren2 "+*self
  EndProcedure
  class Procedure ren2_ren2(*self.mRen2)
    Debug "New Ren2:"+*self
    ProcedureReturn #True
  EndProcedure
 
  
  Define.ren2 c4 = Object::New(ren2)
 
  c4\aber()
  c4\darum()
 
  Debug "==="
  Debug class::is(c4,ren2)
  Debug class::is(c4,ren::class)
  
  Debug class::is(c2,ren2)
  Debug class::is(c2,ren::class)
  
  Object::Delete(c4)
  
  
CompilerEndIf
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 247
; FirstLine = 181
; Folding = -f------
; EnableXP