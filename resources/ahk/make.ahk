; Administrator and Set Options
#NoTrayIcon
#SingleInstance Force

SetWorkingDir %A_ScriptDir%

if not A_IsAdmin
    Run *RunAs "%A_ScriptFullPath%"

; meta - kill process
Run, %comspec% /c taskkill /im cast.exe, , Hide
Process, WaitClose, cast.exe

; meta - check previous file and remove
if FileExist("cast.exe"){
    FileDelete, cast.exe
    while (FileExist("cast.exe"))
        sleep 1
}

; meta - Make EXE
Run *Runas cmd.exe /c ""exe\ahk\Ahk2Exe.exe" /in "cast.ahk" /icon "img\logo.ico" /out cast.exe",,hide

; meta - if made then run
while(true){`
    if FileExist("cast.exe"){
        run "cast.exe"
        sleep 1
        break
    }
}

Exitapp
