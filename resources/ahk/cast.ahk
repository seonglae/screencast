; cast.ahk
; Shows pushed down keys and buttons
; Seonglae @2021

#SingleInstance,Force
CoordMode,Mouse,Screen

applicationname=cast

Gosub,TRAYMENU
Gosub,READINI

shiftkeys=
keys=

; gui init
frombottom := A_ScreenHeight - statusheight* 2
width := statuswidth
statusx := (A_ScreenWidth - statuswidth) / 2
top := (statusheight - fontsize * 1.5) / 2
Gui,+Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui,Margin,0,%top%
Gui,Color,%backcolor%
Gui,Font,C%fontcolor% S%fontsize% W%boldness%,%font%
Gui,Show,X%statusx% Y%frombottom% W%width% H%statusheight% NoActivate,%applicationname%
Gui,Add,Text,Center Vtext w%width% h%statusheight%,
GuiControl,,text,
WinSet,Transparent,%transparency%,%applicationname%

Loop
{
  oldkeys=%keys%
  keys=
  Loop,%keyarray0%
  {
    key:=keyarray%A_Index%
    StringTrimRight,key,key,1
    GetKeyState,state,%key%,P
    If state=D
      keys=%keys% %key%
  }
  StringTrimRight,keys,keys,0
  If keys=%oldkeys%
    Continue

  oldshiftkeys=%shiftkeys%
  shiftkeys=%keys%
  StringReplace,shiftkeys,shiftkeys,LWin
  StringReplace,shiftkeys,shiftkeys,RWin
  StringReplace,shiftkeys,shiftkeys,LCtrl
  StringReplace,shiftkeys,shiftkeys,RCtrl
  StringReplace,shiftkeys,shiftkeys,LShift
  StringReplace,shiftkeys,shiftkeys,RShift
  StringReplace,shiftkeys,shiftkeys,LAlt
  StringReplace,shiftkeys,shiftkeys,RAlt
  StringReplace,shiftkeys,shiftkeys,AltGr
  StringReplace,shiftkeys,shiftkeys,%A_SPACE%,,All
  If shiftkeys=
    If oldshiftkeys<>
    Continue

  If keys<>
  {
    GuiControl,,text,%keys%
    SetTimer,STATUSOFF,%timetoshow%
  }

  GetKeyState,mstate,LButton,P
  If mstate=D
  {
    MouseGetPos,mx1,my1,mid
    WinGetTitle,stitle,ahk_id %mid%
    If stitle=%applicationname%
    {
      Loop
      {
        MouseGetPos,mx2,my2
        WinGetPos,sx,sy,,,ahk_id %mid%
        sx:=sx-mx1+mx2
        sy:=sy-my1+my2
        WinMove,ahk_id %mid%,,%sx%,%sy% 
        mx1:=mx2
        my1:=my2
        GetKeyState,mstate,LButton,P
        If mstate=U
          Break
      } 
    }
  }
}

STATUSOFF:
  GuiControl,,text,
  SetTimer,STATUSOFF,Off
Return

READINI:
  IfNotExist,%applicationname%.ini
  {
    inifile=;%applicationname%.ini
    inifile=%inifile%`n`;[Settings]
    inifile=%inifile%`n`;backcolor    000000-FFFFFF 
    inifile=%inifile%`n`;fontcolor    000000-FFFFFF
    inifile=%inifile%`n`;fontsize
    inifile=%inifile%`n`;boldness     1-1000   `;400=normal 700=bold
    inifile=%inifile%`n`;font
    inifile=%inifile%`n`;statusheight
    inifile=%inifile%`n`;statuswidth
    inifile=%inifile%`n`;transparency 0-255,Off
    inifile=%inifile%`n`;timetohide             `;time in ms
    inifile=%inifile%`n
    inifile=%inifile%`n[Settings]
    inifile=%inifile%`nbackcolor=424242
    inifile=%inifile%`nfontcolor=ffffff
    inifile=%inifile%`nfontsize=60
    inifile=%inifile%`nboldness=200
    inifile=%inifile%`nfont=Arial
    inifile=%inifile%`nstatusheight=200
    inifile=%inifile%`nstatuswidth=1000
    inifile=%inifile%`ntransparency=150
    inifile=%inifile%`ntimetoshow=1000
    inifile=%inifile%`n
    inifile=%inifile%`nAppsKey`nLWin`nRWin`nLCtrl`nRCtrl`nLShift`nRShift`nLAlt`nRAlt`nAltGr
    inifile=%inifile%`nPrintScreen`nCtrlBreak`nPause`nBreak`nHelp`nBrowser_Back`nBrowser_Forward`nBrowser_Refresh`nBrowser_Stop`nBrowser_Search`nBrowser_Favorites`nBrowser_Home`nVolume_Mute`nVolume_Down`nVolume_Up`nMedia_Next`nMedia_Prev`nMedia_Stop`nMedia_Play_Pause`nLaunch_Mail`nLaunch_Media`nLaunch_App1`nLaunch_App2
    inifile=%inifile%`nF1`nF2`nF3`nF4`nF5`nF6`nF7`nF8`nF9`nF10`nF11`nF12`nF13`nF14`nF15`nF16`nF17`nF18`nF19`nF20`nF21`nF22`nF23`nF24
    inifile=%inifile%`nJoy1`nJoy2`nJoy3`nJoy4`nJoy5`nJoy6`nJoy7`nJoy8`nJoy9`nJoy10`nJoy11`nJoy12`nJoy13`nJoy14`nJoy15`nJoy16`nJoy17`nJoy18`nJoy19`nJoy20`nJoy21`nJoy22`nJoy23`nJoy24`nJoy25`nJoy26`nJoy27`nJoy28`nJoy29`nJoy30`nJoy31`nJoy32`nJoyX`nJoyY`nJoyZ`nJoyR`nJoyU`nJoyV`nJoyPOV
    inifile=%inifile%`nSpace`nTab`nEnter`nEscape`nBackspace`nDelete`nInsert`nHome`nEnd`nPgUp`nPgDn`nUp`nDown`nLeft`nRight`nScrollLock`nCapsLock
    inifile=%inifile%`nNumLock`nNumpadDiv`nNumpadMult`nNumpadAdd`nNumpadSub`nNumpadEnter`nNumpadDel`nNumpadIns`nNumpadClear`nNumpadDot`nNumpad0`nNumpad1`nNumpad2`nNumpad3`nNumpad4`nNumpad5`nNumpad6`nNumpad7`nNumpad8`nNumpad9
    inifile=%inifile%`nA`nB`nC`nD`nE`nF`nG`nH`nI`nJ`nK`nL`nM`nN`nO`nP`nQ`nR`nS`nT`nU`nV`nW`nX`nY`nZ`n�`n�`n�`n1`n2`n3`n4`n5`n6`n7`n8`n9`n0`n```n`,`n`%`n+`n-`n*`n\`n/`n|`n_`n<`n^`n>`n!`n"`n#`n�`n&`n(`n)`n=`n?`n�`n'`n�`n~`n;`n:`n.`n@`n�`n$`n�`n�`n�
    inifile=%inifile%`nLButton`nRButton`nMButton`nWheelDown`nWheelUp`nXButton1`nXButton2`n
    FileAppend,%inifile%,%applicationname%.ini
  }

  IniRead,backcolor,%applicationname%.ini,Settings,backcolor
  IniRead,fontcolor,%applicationname%.ini,Settings,fontcolor
  IniRead,fontsize,%applicationname%.ini,Settings,fontsize
  IniRead,boldness,%applicationname%.ini,Settings,boldness
  IniRead,font,%applicationname%.ini,Settings,font
  IniRead,statusheight,%applicationname%.ini,Settings,statusheight
  IniRead,statuswidth,%applicationname%.ini,Settings,statuswidth
  IniRead,transparency,%applicationname%.ini,Settings,transparency
  IniRead,timetoshow,%applicationname%.ini,Settings,timetoshow
  FileRead,inifile,%applicationname%.ini
  StringSplit,keyarray,inifile,`n
  inifile=
Return

TRAYMENU:
  Menu, Tray, Icon, img\logo.ico
  Menu,Tray,NoStandard
  Menu,Tray,Add,%applicationname%,SETTINGS
  Menu,Tray,Add,
  Menu,Tray,Add,&Settings...,SETTINGS
  Menu,Tray,Add,&About...,ABOUT
  Menu,Tray,Add,E&xit,EXIT
  Menu,Tray,Default,%applicationname%
  Menu,Tray,Tip,%applicationname%
Return

SETTINGS:
  Gosub,READINI
  Run,%applicationname%.ini
Return

EXIT:
GuiClose:
ExitApp

ABOUT:
  Gui,99:Destroy
  Gui,99:Margin,20,20
  Gui,99:Font,Bold
  Gui,99:Add,Text,x+10 yp+10,%applicationname%

  Gui,99:Add,Picture,xm y+20 Icon5,img\logo.ico
  Gui,99:Font,Bold
  Gui,99:Add,Text,x+10 yp+10, Made by Seonglae
  Gui,99:Font
  Gui,99:Add,Text,y+10,Seonglae trying to make kind program
  Gui,99:Font,CBlue Underline
  Gui,99:Add,Text,y+5 G1HOURSOFTWARE,www.seonglae.com
  Gui,99:Font

  Gui,99:Add,Picture,xm y+20 Icon5,img\logo.ico
  Gui,99:Font,Bold
  Gui,99:Add,Text,x+10 yp+10,Impressed by Skrommel
  Gui,99:Font
  Gui,99:Add,Text,y+10,For more tools from him, information and donations, please visit 
  Gui,99:Font,CBlue Underline
  Gui,99:Add,Text,y+5 G1HOURSOFTWARE,www.1HourSoftware.com
  Gui,99:Font

  Gui,99:Show,,%applicationname% About
  hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
  OnMessage(0x200,"WM_MOUSEMOVE") 
Return

1HOURSOFTWARE:
  Run,http://www.1hoursoftware.com,,UseErrorLevel
Return

99GuiClose:
  Gui,99:Destroy
  OnMessage(0x200,"")
  DllCall("DestroyCursor","Uint",hCur)
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static9,Static13,Static17
    DllCall("SetCursor","UInt",hCurs)
Return
}
Return

Lalt & r::
  if (!GetKeyState("shift") && !GetKeyState("ctrl") && !GetKeyState("lwin")){
    MsgBox ,,AHK, Reload Start
    Reload
  }
return