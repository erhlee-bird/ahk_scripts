;; Recreation of a few convenient window management functions from xmonad.
;; erhlee-bird

#NoEnv
#SingleInstance performance
SendMode Input

State=0

#q::
State := !State
If State
{
  MsgBox "winmove shortcuts enabled"
  Hotkey, #w, On
  Hotkey, #e, On
  Hotkey, #r, On
}
Else
{
  MsgBox "winmove shortcuts disabled"
  Hotkey, #w, Off
  Hotkey, #e, Off
  Hotkey, #r, Off
}
Return

;; My default shortcuts.

#w::
MoveMouseTo(1)
Return

#+w::
MoveWinTo(1)
Return

#e::
MoveMouseTo(2)
Return

#+e::
MoveWinTo(2)
Return

#r::
MoveMouseTo(3)
Return

#+r::
MoveWinTo(3)
Return

;; Utility Functions

MonitorCheck(num, byref TargetWidth, byref TargetHeight, byref TargetX, byref TargetY)
{
  SysGet, monNum, MonitorCount
  if num > %monNum%
  {
    ; Don't move to a monitor that doesn't exist.
    Exit
  }

  SysGet, Target, Monitor, %num%
  TargetWidth := (TargetRight - TargetLeft) * 0.5
  TargetHeight := (TargetBottom - TargetTop) * 0.5
  TargetX := TargetLeft + (TargetWidth / 2)
  TargetY := TargetTop + (TargetHeight / 2)
}

MoveMouseTo(num)
{
  MonitorCheck(num, TargetWidth, TargetHeight, TargetX, TargetY)
  CoordMode, Mouse, Screen
  MouseMove, %TargetX%, %TargetY%, 0
}

MoveWinTo(num)
{
  MonitorCheck(num, TargetWidth, TargetHeight, TargetX, TargetY)
  WinRestore, A
  WinMove, A, , %TargetX%, %TargetY%, %TargetWidth%, %TargetHeight%
  WinMaximize, A
}
