Func setAlwaysOnTop() ; whether or not the window should always be on top of other windows
	$currentState = GUICtrlRead($onTopButton)

	If $currentState = "Always on Top" Then
		WinSetOnTop($mainWindow, "", 0)

		GUICtrlSetData($onTopButton, "Not Topmost")
		GUICtrlSetBkColor($onTopButton, 0xd1d1d1)
	ElseIf $currentState = "Not Topmost" Then
		WinSetOnTop($mainWindow, "", 1)

		GUICtrlSetData($onTopButton, "Always on Top")
		GUICtrlSetBkColor($onTopButton, 0xb7baf3)
	EndIf
EndFunc