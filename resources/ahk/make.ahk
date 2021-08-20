; Administrator and Set Options
#NoTrayIcon
#SingleInstance Force

SetWorkingDir %A_ScriptDir%

if not A_IsAdmin
    Run *RunAs "%A_ScriptFullPath%"

Run *Runas cmd.exe /c ""exe\ahk\AutoHotkey.exe" "cast.ahk"",,hide