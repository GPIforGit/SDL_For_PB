UseSHA3Fingerprint()
UseBriefLZPacker()
EnableExplicit

CompilerIf #PB_Compiler_OS=#PB_OS_MacOS
  If Right(GetCurrentDirectory(),14)=".app/Contents/"
    SetCurrentDirectory("../..")
  EndIf
CompilerEndIf

Procedure StringToMem(str.s)
  Protected *mem.byte=AllocateMemory(Len(str)/2)
  Protected i
  For i=1 To Len(str)/2
    PokeA(*mem +i-1, Val("$"+Mid(str,(i-1)*2-1,2)) )
  Next
  ProcedureReturn *mem
EndProcedure

Global NewMap Wordbook.i()
Global NewMap WordbookId.s()

Procedure ClearWordbook()
  ClearMap( Wordbook() )
  ClearMap( WordbookId() )
EndProcedure

Procedure AddWordbookWord( word.s)
  Protected count
  If FindMapElement( Wordbook(),word)=0
    count=MapSize(Wordbook())+1
    Wordbook(word)=count
    WordbookId("#"+count)=word
  EndIf
EndProcedure
  
Procedure CreateWordbook( path.s )
  ClearWordbook()
  Protected in
  Protected line,*mem,*read.ascii,*start,word.s,oword.s
  
  Restore wordlist
  Repeat
    Read.s word
    If word=""
      Break
    EndIf
    AddWordbookWord( word )
  ForEver
  DataSection
    wordlist:
    Data.s "2020","2021","2022","https","lazyfoo","net","tutorials","index2","index","php","EnableExplicit","XIncludeFile","sdl2","pbi","Define","Debug","FF","EndIf","IDE","Options","PureBasic"
    Data.s "Windows","x64","CursorPosition","EnableXP","Declare","Global","Procedure","Protected","ProcedureReturn","EndProcedure","Wend","Enumeration","EndEnumeration"
    Data.s "Dim","ElseIf","EndSelect","SDL_Error","LoadTex","SetRect","_x_","_y_","_w_","_h_","Macro","EndMacro","_baseclass","Extends","Interface","Structure","00","Step"
    Data.s "Next","EndStructure","CreateClass","EndInterface","NewObject","DeleteObject","self"
    Data.s ""
  EndDataSection
          
    
  in=ReadFile(#PB_Any,path)
  
  
  If in
    *mem=AllocateMemory(Lof(in)+100)
    ReadData(in, *mem, Lof(in))    
    CloseFile(in)
    
    *read=*mem
    
    While *read\a<>0
      Select *read\a 
        Case 'a' To 'z', 'A' To 'Z', '0' To '9', '_'
          *start=*read
          While (*read\a>='A' And *read\a<='Z') Or (*read\a>='a' And *read\a<='z') Or (*read\a>='0' And *read\a<='9') Or *read\a = '_'
            *read+1
          Wend
          word= PeekS(*start,*read-*start,#PB_Ascii)
          oword=word
          
          AddWordbookWord( word )
          AddWordbookWord( LCase(word) )
          AddWordbookWord( UCase( word) )
          word=UCase(Left(word,1)) + LCase(Mid(word,2))
          AddWordbookWord( word )
          
          If Left(oword,4)="SDL_"
            word=Mid(oword,5)
            AddWordbookWord( word )
            AddWordbookWord( LCase(word) )
            AddWordbookWord( UCase(word) )
            word=UCase(Left(word,1)) + LCase(Mid(word,2))
            AddWordbookWord( word )
          EndIf
            
      EndSelect
            
      *read+1
    Wend
    
    FreeMemory(*mem)
  EndIf
EndProcedure

#cachesize=1024*1024*10
Global *unpatchmem=AllocateMemory(#cachesize)

Procedure unpatch(*mem.word)
  Protected *outmem.ascii = *unpatchmem,len
  
  If *mem\w <> $1234
    ProcedureReturn 0
  EndIf
  *mem+2
  
  While *mem\w<>0
    Select *mem \w
      Case 0
        Break
      Case 1 To 32767
        PokeS(*outmem, WordbookId("#" + *mem\w),-1,#PB_Ascii):*outmem + Len(WordbookId())
        *mem+2
      Case -255 To -1
        *outmem\a=- *mem\w: *outmem+1
        *mem+2
      Case -32768 To -256
        len=(- *mem\w) >>8
        *mem+2
        CopyMemory(*mem,*outmem,len):*outmem+len
        AddWordbookWord( PeekS(*mem,len,#PB_Ascii) )
        *mem+len
    EndSelect
  Wend
  *outmem\a=0
  ProcedureReturn *outmem - *unpatchmem       
EndProcedure

Global *memunpack=AllocateMemory(#cachesize)
Procedure decrypt(file.s,*mem,psize)
  Protected out
  Debug "do:"+file
  out=CreateFile(#PB_Any,file+".pb")
  If out
    
    Protected sha3.s = FileFingerprint(file+"/"+file+".cpp",#PB_Cipher_SHA3)
    If sha3="" And Len(sha3)<>32
      WriteStringN(out,";file not found:"+file+"/"+file+".cpp")
    Else
      Protected *memKey=StringToMem(sha3)
      Protected *memout=AllocateMemory(psize)
      Protected size
      
      CreateWordbook( file+"/"+file+".cpp" )
      
      If AESDecoder(*mem,*memout,psize,*memKey,256,0,#PB_Cipher_ECB)
        size= UncompressMemory(*memout,psize,*memunpack,psize*100, #PB_PackerPlugin_BriefLZ)
        If size>0
          size=unpatch(*memunpack)
          WriteData(out,*unpatchmem,size)
        Else
          WriteStringN(out,";modified - "+file+"/"+file+".cpp")
          Debug ";modified (unpack) - "+file+"/"+file+".cpp"
        EndIf        
      Else
        WriteStringN(out,";modified - "+file+"/"+file+".cpp")
        Debug ";modified (uncrypt) - "+file+"/"+file+".cpp"
      EndIf
      
      Debug file+" "+size+" "+psize
      FreeMemory(*memout)
      FreeMemory(*memKey)
    EndIf 
    CloseFile(out)
  EndIf
EndProcedure

Define file.s

Define *mem.long 
Define size

Define in

in=OpenFile(#PB_Any,"patch.dat")
If Not in
  MessageRequester("Error","Can't open patch.dat!")
  End
EndIf

size=Lof(in)
*mem = AllocateMemory( size )
ReadData(in, *mem, size )
CloseFile (in)


Repeat
  size=*mem\l:*mem+4
  If size=0
    Break
  EndIf
  file=PeekS(*mem,size,#PB_Ascii):*mem+size
  size=*mem\l:*mem+4    
  decrypt(file,*mem,size)  
  *mem+size
ForEver

MessageRequester("PatchTutorial","done")

End

; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 192
; FirstLine = 163
; Folding = --
; EnableXP
; Executable = PatchLazyFooTutorial.exe
; DisableDebugger