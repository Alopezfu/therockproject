#SingleInstance FORCE
#Persistent
SetTimer, SendHotkey, 300
return

SendHotkey:
If !WinExist("ahk_exe csgo.exe")
	return  ; do nothing
    ; otherwise:
SetTimer, SendHotkey, off
WinActivate, ahk_exe csgo.exe
WinWaitActive, ahk_exe csgo.exe
SoundBeep, 800, 200
Run, "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OBS Studio\OBS Studio (64bit)" --startreplaybuffer --scene "csgo_flash_rec" --multi, -m,,OutputVarPID
WinWait, ahk_pid %OutputVarPID%
WinMinimize
WinWaitClose, ahk_exe csgo.exe
SoundBeep, 400, 700
Process, Close, %OutputVarPID%
SetTimer, SendHotkey, on ; repeat the action next time the program starts
return

!F10::
Loop 2 	
{
SoundBeep, 800, 100
}

;Falta una manera de cerrar el obs mas amigable y dejando de grabar antes de cerrar.