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