Func setDockingModeDefaults()
	WinActivate($mainWindow, "") ; activate the main window to help with docking

	Switch IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "OFF")
		Case "Left"
			clickLeftDockingButton()
		Case "Right"
			clickRightDockingButton()
		Case "OFF"
			; should be already set
	EndSwitch
EndFunc

Func loadWindowSizeDefaults()
	$startPositionW = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionW", "404") ; initial width - 404 for total size (+14)
	$startPositionH = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionH", "552") ; initial height ; 540 for total size (+14)
	$startPositionL = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", (@DesktopWidth - (429 + 30))) ; initial left value (position on screen)
	$startPositionT = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionT", "11") ; initial top value (position on screen)

	WinMove($mainWindow, "", $startPositionL, $startPositionT, $startPositionW, $startPositionH)
EndFunc

Func setAlwaysOnTopDefaults()
	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", 1) = 0 Then
		setAlwaysOnTop() ; if Always on Top is set to default to not, then turn it off here
	EndIf
EndFunc

Func setLoopModeDefaults()
	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "Loop Mode") = "OFF" Then
		switchToOff()
	Else
		switchToLoop()
	EndIf
EndFunc