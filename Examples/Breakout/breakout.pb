
XIncludeFile "../../sdl2/SDL_mixer.pbi"
XIncludeFile "../../sdl2/SDL_image.pbi"

XIncludeFile "../../sdl2/SDL_ttf.pbi"
XIncludeFile "../../sdl2/SDL.pbi"
XIncludeFile "../renderer.pbi"
XIncludeFile "../Collision.pbi"

EnableExplicit

#title="Breakout-Demo"
#width=640*2
#height=400*2
#LogicalWidth=640
#LogicalHeight=400
#integerScale=#False
#sdl_flags = SDL::#INIT_EVENTS | SDL::#INIT_VIDEO
#sdl_img_flags = SDL::#IMG_INIT_PNG ; only png (&zip)
#sdl_mix_flags = SDL::#MIX_INIT_MP3 ; only MP3

#targetFrameMS = 1000.0/60.0 ; For Calculations

#minFPS = 1000/30 +1; Time for a slow frame. When a frame needs more time than this, the game should slowdown instead tooo big jumps

#ballspeed = 6.0 / #targetFrameMS

#angel0=45+25
#angel1=45
#angel2=45-25

#MaxPlayerSpeed = 32.0 / #targetFrameMS

Global MAXDISTANCE = Sqr(#LogicalHeight*#LogicalHeight + #LogicalWidth*#LogicalWidth)

Global.Renderer::Class Render 
Global.Renderer::texture *TexBlock
Global.Renderer::texture *TexBall
Global.Renderer::texture *TexRacket
Global.Renderer::texture *TexPause
Global.SDL::Mix_Music *MusBack
Global.sdl::Mix_Chunk *SndBlock
Global.SDL::Mix_Chunk *SndReflect
Global.sdl::Mix_Chunk *SndPause

Procedure.l SDL_init()
  
  If SDL::init(#sdl_flags) 
    ProcedureReturn #False
  EndIf
  If SDL::IMG_Init(#sdl_img_flags) & #sdl_img_flags <> #sdl_img_flags
    ProcedureReturn #False
  EndIf
  If SDL::TTF_Init()
    ProcedureReturn #False
  EndIf
  If SDL::MIX_Init(#sdl_mix_flags) & #sdl_mix_flags <> #sdl_mix_flags
    ProcedureReturn #False
  EndIf
  
  render=renderer::New(#title, sdl::#WINDOWPOS_CENTERED, sdl::#WINDOWPOS_CENTERED, #width, #height, 
                     sdl::#WINDOW_ALLOW_HIGHDPI | sdl::#WINDOW_RESIZABLE, 
                     SDL::#RENDERER_ACCELERATED |  SDL::#RENDERER_TARGETTEXTURE | SDL::#RENDERER_PRESENTVSYNC)
  
  
  If render = #Null
    ProcedureReturn #False
  EndIf
  
  ;render\SetFrameRate(40)
  
  render\winSetBound(#LogicalWidth,#LogicalHeight)
  
  render\SetLogicalSize(#LogicalWidth,#LogicalHeight,0)
  render\SetIntegerScale(#integerScale)
  
  
  *TexBall=render\LoadTexture("ball.png",RGB(255,0,255))
  If *TexBall=#Null    
    ProcedureReturn #False
  EndIf
  
  *TexBlock=render\LoadTexture("blocks.png")
  If *TexBlock=#Null
    ProcedureReturn #False
  EndIf
  
  *TexRacket=render\LoadTexture("racket.png",RGB(255,0,255))
  If *TexRacket=#Null    
    ProcedureReturn #False
  EndIf
  
  Protected.sdl::TTF_Font *font = sdl::TTF_OpenFont("crash-a-like.ttf",48)
  If *font = #Null
    ProcedureReturn #False
  EndIf
  
  Protected.sdl::Color color
  color\a=255:color\r=255:color\g=255:color\b=0
  
  *TexPause = render\RenderText( *font, "Pause", color)
  
  sdl::TTF_CloseFont(*font)
  
  If *TexPause = #Null
    ProcedureReturn #False
  EndIf
  
  If SDL::Mix_OpenAudio(44100 , sdl::#MIX_DEFAULT_FORMAT, sdl::#MIX_DEFAULT_CHANNELS, 1024)
    ProcedureReturn #False
  EndIf
  
  *MusBack = SDL::Mix_LoadMus("Arkanoid_Navel_Lint_Dub_OC_ReMix.mp3")
  If *MusBack = #Null
    ProcedureReturn #False
  EndIf
  
  *SndBlock = SDL::Mix_LoadWAV("pop.wav")
  If *SndBlock = #Null
    ProcedureReturn #False
  EndIf
  
  *SndPause = SDL::Mix_LoadWAV("shoot.wav")
  If *SndPause = #Null
    ProcedureReturn #False
  EndIf
  
  *SndReflect = SDL::Mix_LoadWAV("reflect.wav")
  If *SndReflect = #Null
    ProcedureReturn #False
  EndIf
  
  ProcedureReturn #True
EndProcedure

Procedure SDL_quit()
  Object::Delete(*TexBall)
  Object::Delete(*TexBlock)
  Object::Delete(*TexRacket)
  Object::Delete(*TexPause)
  Object::Delete(render)
  
  SDL::Mix_CloseAudio()
  
  If *MusBack
    SDL::Mix_FreeMusic(*MusBack)
    *MusBack=#Null
  EndIf
  If *SndBlock
    sdl::Mix_FreeChunk(*SndBlock)
    *SndBlock=#Null
  EndIf
  If *SndPause
    sdl::Mix_FreeChunk(*SndPause)
    *SndPause=#Null
  EndIf
  If *SndReflect
    sdl::Mix_FreeChunk(*SndReflect)
    *SndReflect=#Null
  EndIf 
  
  SDL::Mix_Quit()
  If SDL::TTF_WasInit()
    SDL::TTF_Quit()
  EndIf
  SDL::IMG_Quit()
  SDL::Quit()
EndProcedure

Structure sBlocks
  color.l
  rect.sdl::rect
EndStructure


Structure sEffects
  *chunk.sdl::Mix_Chunk
  distance.l
  angle.l
EndStructure

Procedure FillEffectPosition(*effect.sEffects,*snd,x1.l,y1.l,x2.l,y2.l)
  Protected.l x=x1-x2
  Protected.l y=y1-y2
  Protected angle.l
  angle= Degree(ATan2(x,y)) -90
  If angle<0
    angle + 360
  EndIf
  
  *effect\distance = Sqr(x*x + y*y)/MAXDISTANCE * 255
  *effect\chunk = *snd
  *effect\angle = angle
  
EndProcedure


Procedure main()  
  
  If  Not SDL_init()
    MessageRequester(#title,"SDL Error" + #LF$ + SDL::GetError())
    SDL_quit()
    ProcedureReturn
  EndIf
  
  NewList Effects.sEffects()
  
  Protected WinEvent
  Protected.sdl::Event e
  Protected.l quit
  Protected.l relX,relY
  Protected.l mouseX,mouseY,MouseButton
  Protected.l w,h,x,y
  Protected.l test,ok
  
  Protected.sdl::rect PlayerRect
  Protected.SDL::FPoint BallPos, oldBall
  Protected.sdl::Fpoint BallDelta
  Protected.sCircle testBall
  Protected.l lastFPS
  Protected.l pause, oldPause
  Protected.q delay,wasted
  Protected.q FrameCount,FrameTimer
  
  Protected.l Volume=128
  
  Protected.f frameRate
  
  Protected.sdl::FPoint Angel0, Angel1, Angel2
  
  angel0\x = Cos(Radian(#angel0)) * #ballspeed
  angel0\y = Sin(Radian(#angel0)) * #ballspeed
  
  angel1\x = Cos(Radian(#angel1)) * #ballspeed
  angel1\y = Sin(Radian(#angel1)) * #ballspeed
  
  angel2\x = Cos(Radian(#angel2)) * #ballspeed
  angel2\y = Sin(Radian(#angel2)) * #ballspeed
  
  
  PlayerRect\w=*TexRacket\GetWidth()
  PlayerRect\h=*TexRacket\GetHeight()
  PlayerRect\x = (#LogicalWidth - PlayerRect\w)/2
  PlayerRect\y = #LogicalHeight - PlayerRect\h * 3
  
  
  testBall\r = Int( *TexBall\GetWidth() /2 )
  
  BallPos\x = #LogicalWidth / 2.0 - testBall\r 
  BallPos\y = PlayerRect\y - testBall\r * 2.0
  
  
  
  BallDelta\x = angel1\x
  BallDelta\y = -angel1\y
  
  NewList blocks.sBlocks()
  NewList *collBlocks.sblocks()
  
  w = #LogicalWidth - (#LogicalWidth % 34) -1
  For x=0 To w  Step 32+2
    For y=2 To #LogicalHeight/4 -2 Step 16+2
      AddElement(blocks())
      With blocks()
        \color=Random(4,0)
        \rect\x=x+ (#LogicalWidth-w)/2
        \rect\y=y
        \rect\w=32
        \rect\h=16
      EndWith
    Next
  Next   
  
  render\MouseSetRelative(#True)
  
  lastFPS=1
  
  sdl::Mix_PlayMusic(*MusBack,-1)
  
  FrameTimer=ElapsedMilliseconds()
  
  render\SetDrawColor(0,0,0,255)
  render\Clear()
  Render\Show()
  render\Clear()
  render\Show()

  While Not quit
    
   
    
    delay= ElapsedMilliseconds()-FrameTimer
    If delay>200
      frameRate = FrameCount/delay*1000.0
      FrameCount=0
      FrameTimer=ElapsedMilliseconds()
    EndIf
    
    render\winSetTitle(#title +" - "+ lastFPS+"ms"+" "+StrF(frameRate,2)+" Volume:"+Volume )
     
    
    If lastFPS > #minFPS
      lastFPS = #minFPS ; ok, better slowdown as too big jumps!
    ElseIf lastFps<1
      lastFPS=1
    EndIf
    
    relx=0
    rely=0
    
    While SDL::PollEvent( e ) 
      render\doEvents(e);allways first!      
      
      Select e\type
        Case sdl::#quit
          quit=#True
          
        Case sdl::#MOUSEMOTION
          relx + e\motion\xrel
          rely + e\motion\yrel
          
          
        Case sdl::#KEYDOWN
          If e\key\windowID = Render\winGetId()
            Select e\key\keysym\sym
              Case sdl::#K_MINUS, sdl::#K_KP_MINUS
                volume - 10
                If Volume<0
                  volume = 0
                EndIf
                sdl::Mix_Volume(-1,Volume)
                sdl::Mix_VolumeMusic(Volume)
                
                
              Case sdl::#K_PLUS, sdl::#K_KP_PLUS
                volume + 10
                If Volume > sdl::#MIX_MAXVOLUME
                  Volume= sdl::#MIX_MAXVOLUME
                EndIf
                
                sdl::Mix_Volume(-1,Volume)
                sdl::Mix_VolumeMusic(Volume)
                
            EndSelect
            
            Select e\key\keysym\scancode
                
              Case sdl::#SCANCODE_ESCAPE
                
                If render\MouseIsRelative()
                  render\MouseSetRelative(#False)
                  pause=#True
                Else
                  render\MouseSetRelative(#True)
                  pause=#False
                EndIf
                
            EndSelect            
          EndIf
          
      EndSelect
      
    Wend
        
    If Not render\winHasKeyboard() And Not pause
      render\MouseSetRelative(#False)
      pause=#True
    EndIf
    
    If Not pause
      
      ; limit mouse movement      
      If relX<- #MaxPlayerSpeed * lastFPS
        relx=-#MaxPlayerSpeed * lastFPS
      ElseIf relX>#MaxPlayerSpeed * lastFPS
        relx=#MaxPlayerSpeed * lastFPS
      EndIf
      
      ; move player
      PlayerRect\x + relX
      If PlayerRect\x < 0
        PlayerRect\x = 0
      ElseIf PlayerRect\x > #LogicalWidth - PlayerRect\w
        PlayerRect\x = #LogicalWidth - PlayerRect\w
      EndIf
      
      ;move ball
      ok = #False
      oldBall = BallPos
      
      BallPos\x + BallDelta\x * lastFPS
      BallPos\y + BallDelta\y * lastFPS
      
      If BallPos\x < testBall\r
        BallPos\x = testBall\r + (testBall\r - BallPos\x)
        If BallDelta\x < 0 
          BallDelta\x = - BallDelta\x
          ok = #True
        EndIf
      ElseIf BallPos\x > #LogicalWidth - testBall\r
        BallPos\x = (#LogicalWidth - testBall\r) - (BallPos\x - (#LogicalWidth - testBall\r) )
        If BallDelta\x > 0
          BallDelta\x = - BallDelta\x
          ok = #True
        EndIf
      EndIf
      If BallPos\y < testBall\r
        BallPos\y = testBall\r - (testBall\r - BallPos\y)
        If BallDelta\y < 0 
          BallDelta\y = - BallDelta\y
          ok = #True
        EndIf
      ElseIf BallPos\y > #LogicalHeight - testBall\r
        BallPos\y = (#LogicalHeight - testBall\r) - (BallPos\y - (#LogicalHeight - testBall\r) )
        If BallDelta\y > 0
          BallDelta\y = - BallDelta\y
          ok = #True
        EndIf
      EndIf
      
      If ok
        AddElement(Effects())
        FillEffectPosition(Effects(), *SndReflect, PlayerRect\x+PlayerRect\w/2, PlayerRect\y+PlayerRect\h/2, ballpos\x, BallPos\y)
      EndIf    
      
      ;check collision
      ClearList( *collBlocks() )
      testBall\x = (BallPos\x)
      testBall\y = (BallPos\y)
      ForEach blocks()
        If RectWHOnCircle( blocks()\rect, testBall)
          AddElement (*collBlocks())
          *collBlocks() = @blocks()
        EndIf
      Next
      
      ;check reflection
      If ListSize( *collBlocks() ) >0
        ok=#False
        
        ;check x
        testBall\x = (BallPos\x)
        testBall\y = (oldBall\y)
        ForEach *collBlocks()
          If RectWHOnCircle( *collBlocks()\rect, testBall)
            BallDelta\x = - BallDelta\x
            ok=#True
            BallPos\x = oldBall\x
            Break
          EndIf
        Next
        
        ;check y
        testBall\x = (oldBall\x)
        testBall\y = (BallPos\y)
        ForEach *collBlocks()
          If RectWHOnCircle( *collBlocks()\rect, testBall)
            BallDelta\y = - BallDelta\y
            ok=#True
            BallPos\y = oldBall\y
            Break
          EndIf
        Next
        
        ;both!
        If Not ok
          BallDelta\x = - BallDelta\x
          BallDelta\y = - BallDelta\y
          BallPos=oldBall
        EndIf
        
        ;remove block    
        ForEach *collBlocks()
          ChangeCurrentElement( blocks(), *collBlocks() )
          
          AddElement(Effects())
          FillEffectPosition(Effects(), *SndBlock, PlayerRect\x+PlayerRect\w/2, PlayerRect\y+PlayerRect\h/2, blocks()\rect\x+blocks()\rect\w/2, blocks()\rect\y+blocks()\rect\h/2)
          
          DeleteElement(blocks())                
        Next
        
      EndIf
      
      ;check ball and player
      If BallDelta\y >0       
        testBall\x = (BallPos\x)
        testBall\y = (BallPos\y)
        If RectWHOnCircle( PlayerRect, testBall )
          test= ((PlayerRect\x + PlayerRect\w/2) - ballpos\x ) / (PlayerRect\w/5)
          If test<=-2
            BallDelta\x= angel2\x
            BallDelta\y= -angel2\y
          ElseIf test=-1
            BallDelta\x= angel1\x
            BallDelta\y= -angel1\y
          ElseIf test=0
            BallDelta\x= angel0\x * Sign(BallDelta\x)
            balldelta\y= -angel0\y
          ElseIf test=1
            BallDelta\x= -angel1\x
            BallDelta\y= -angel1\y
          ElseIf test>=2
            BallDelta\x= -angel2\x
            BallDelta\y= -angel2\y
          EndIf
          
          AddElement(Effects())
          FillEffectPosition(Effects(), *SndReflect, PlayerRect\x+PlayerRect\w/2, PlayerRect\y+PlayerRect\h/2, ballpos\x, BallPos\y)
          
        EndIf
      EndIf
      
    EndIf
    
    ;complete Screen red
    render\SetDrawColor(128,0,0,255)
    render\Clear()
    
    ;drawing on logical!
    render\StartDrawing()
    ;background black
    render\SetDrawColor(0,0,0,255)
    render\Clear()
    
    ;Draw blocks()
    ForEach blocks()
      With blocks()
        *TexBlock\SetClip( \color * 32,0,32,16)
        *TexBlock\Draw( \rect\x, \rect\y )
      EndWith
    Next    
    
    ;draw player
    *TexRacket\Draw( PlayerRect\x, PlayerRect\y)
    
    ;draw ball
    testBall\x = (BallPos\x)
    testBall\y = (BallPos\y)
    *TexBall\Draw( testBall\x - testBall\r, testBall\y - testBall\r)
    
    
    If pause
      *TexPause\Center( #LogicalWidth/2, #LogicalHeight/2)
    EndIf
    
    
    If pause<>oldPause
      If pause
        AddElement(Effects())
        FillEffectPosition(Effects(), *SndPause, PlayerRect\x+PlayerRect\w/2, PlayerRect\y+PlayerRect\h/2, #LogicalWidth/2, #LogicalHeight/2)
        
        If sdl::Mix_PlayingMusic() And Not sdl::Mix_PausedMusic()
          sdl::Mix_PauseMusic()
        EndIf
      Else
        If sdl::Mix_PlayingMusic() And sdl::Mix_PausedMusic()
          sdl::Mix_ResumeMusic()
        EndIf
      EndIf
      oldPause=pause
    EndIf
    
    ;finish logical
    Render\EndDrawing()
    
    lastFPS = Render\Show() 
    FrameCount+1
    
    Protected.l channel
    ForEach Effects()
      channel=SDL::Mix_PlayChannel(-1,Effects()\chunk,0)
      If channel>=0
        SDL::Mix_SetPosition(channel, effects()\angle, Effects()\distance )
      EndIf
    Next
    ClearList( Effects() )
    
    
    
    
    
  Wend
  
  If sdl::Mix_PlayingMusic()
    sdl::Mix_HaltMusic()
  EndIf
  
  
  SDL_QUIT()
  
  
  
EndProcedure

main()

; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 140
; FirstLine = 127
; Folding = --
; EnableXP
; DPIAware