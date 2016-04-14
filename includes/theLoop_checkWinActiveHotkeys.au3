Func checkWinActiveHotkeys()
	If WinActive($mainWindow) Or WinActive(Hwnd($ghnd_MPC_handle)) Or WinActive("OSD Window") Then ; either the main GUI or MPC is active
		If $hotKeysActive = False Then
			$currentFocus = ControlGetFocus($mainWindow, "")

			If $currentFocus = "Edit3" Then ; if the text box is active, then
				loadHotKeys(0) ; turn hotkeys off
			Else
				loadHotKeys(1) ; so if the hotkeys aren't currently active, activate them
			EndIf
		EndIf
	Else
		If $hotKeysActive = True Then
			loadHotKeys(0) ; if the hotkeys are active, disable them (to fix typing issues)
		EndIf
	EndIf
EndFunc