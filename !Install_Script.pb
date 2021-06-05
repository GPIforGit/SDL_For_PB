Procedure BreakPrint(str.s)
  Static pos.l
  
  If str=""
    PrintN("")
    pos = 0
    ProcedureReturn
  EndIf
  
  Protected.l i = 1,start,len
  Repeat
    start = i
    i = FindString(str," ",start+1)
    If i=0 : i = Len (str)+1 : EndIf
    len = i - start 
    If pos + len > 80
      PrintN("")
      pos = 0
      If Mid(str,start,1)=" "
        start +1
        len -1
      EndIf     
    EndIf
    pos + len
    Print( Mid( str, start, len) )
  Until i >= Len(str) 
EndProcedure

Procedure.s GetKey()
  Protected.s key 
  Repeat
    key = Inkey()
    Delay(0)
  Until key <> ""
  ProcedureReturn key
EndProcedure

;find folders and dlls
NewList folder.s()
NewList dll.s()

SetCurrentDirectory( #PB_Compiler_FilePath )

Define dir=ExamineDirectory(#PB_Any, "./","*.*")
If dir
  While NextDirectoryEntry(dir)
    Define.s name = DirectoryEntryName(dir)
    If DirectoryEntryType(dir) = #PB_DirectoryEntry_Directory
      If name <> "." And name <> ".."
        AddElement(folder())
        folder() = name
      EndIf
      
    ElseIf LCase( GetExtensionPart( name ) ) = "dll"
      AddElement(dll())
      dll() = name
    EndIf  
  Wend
  FinishDirectory(dir)
EndIf

OpenConsole("install script")
BreakPrint("This script copies the include-folders to " )
BreakPrint("")
BreakPrint("")
PrintN("     "+ #PB_Compiler_Home + "Include"  )
BreakPrint("")
BreakPrint("Of course you can simple copy the folders to every project and use a invidual XIncludeFile in your source code. " + 
           "But when it is in your compiler-home, you can simple write to any source file a simple")
BreakPrint("")
BreakPrint("")
PrintN(~"   XIncludeFile #PB_Compiler_Home + \"Include/sdl/SDL2.pbi\"")
BreakPrint("")
BreakPrint("to add the sdl-sdk for example. Also all of my examples, tutorials and so one expect the files in the compiler home directory.")
BreakPrint("")
BreakPrint("")

ForEach folder()
  Print ("Copy " + folder() + "? [Y/N] ")
  
  Define.s key = GetKey()
  
  If key="y" Or key="Y" Or key="j" Or key="J"
    Print("Yes ")
    CreateDirectory( #PB_Compiler_Home + "Include")
    If CopyDirectory( "./" + folder(), #PB_Compiler_Home + "Include/" + folder(), "*.*", #PB_FileSystem_Recursive | #PB_FileSystem_Force)
      PrintN("done")
    Else
      PrintN("FAIL")
    EndIf
  Else
    PrintN("No")
  EndIf  
Next

CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  If ListSize(dll()) > 0
    BreakPrint("")
    BreakPrint("The include-files needs some DLLs to work. Windows will search this dll in the directory of the executeable, the current directory or " +
               "in the %PATH% enviroment variable. The pure basic ide set the %path% variabel to")
    BreakPrint("")
    BreakPrint("")
    PrintN("     "+ #PB_Compiler_Home + "Compilers")
    BreakPrint("")
    BreakPrint("This script can copy all the dlls to this directory and " + #DQUOTE$ + "Compile/Run" + #DQUOTE$ +" will work without extra manual copies of the dlls.")
    BreakPrint("")
    BreakPrint("")
    Print("Copy all DLLs to "+#PB_Compiler_Home + "Compilers"+" ? [Y/N] ")
    
    Key = GetKey()
    
    If key="y" Or key="Y" Or key="j" Or key="J"
      PrintN("Yes")
      ForEach dll()
        Print("  "+dll())
        If CopyFile( dll(), #PB_Compiler_Home + "Compilers/" + dll() )
          PrintN(" done")
        Else
          PrintN(" FAIL")
        EndIf
      Next
    Else
      PrintN("No")
    EndIf
  EndIf
CompilerEndIf

BreakPrint("")
BreakPrint("Press [any] to quit.")
key = GetKey()

CloseConsole()
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; ExecutableFormat = Console
; CursorPosition = 35
; FirstLine = 19
; Folding = -
; EnableXP
; EnableAdmin
; Debugger = IDE