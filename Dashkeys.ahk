#UseHook

Menu, TRAY, Icon, keyboard.ico
Menu, TRAY, Tip, Dashkeys:  Custom hotkeys defined by Dash
 
#e::Run explorer.exe Libraries\Documents
#n::SetNumLockState, Off

^#r::Run powershell -Command "Start-Process PowerShell -Verb RunAs"

F9::^#Right 
F10::^#Left 

^SPACE::  Winset, Alwaysontop, , A

; source http://www.dcmembers.com/skrommel/download/noclose/

#c::
  WinGet, Id, Id, A
  DISABLE(id)
  Return

#v::
  WinGet, Id, Id, A
  ENABLE(id)
  Return

DISABLE(id) ;By RealityRipple at http://www.xtremevbtalk.com/archive/index.php/t-258725.html
{
  menu:=DllCall("user32\GetSystemMenu","UInt",id,"UInt",0)
  DllCall("user32\DeleteMenu","UInt",menu,"UInt",0xF060,"UInt",0x0)
  WinGetPos,x,y,w,h,ahk_id %id%
  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h-1
  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h+1
}

ENABLE(id) ;By Mosaic1 at http://www.xtremevbtalk.com/archive/index.php/t-258725.html
{
  menu:=DllCall("user32\GetSystemMenu","UInt",id,"UInt",1)
  DllCall("user32\DrawMenuBar","UInt",id)
}