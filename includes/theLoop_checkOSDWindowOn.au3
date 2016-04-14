Func checkOSDWindowOn()
	If GUICtrlRead($OSDButton) = "OSD On" Then
		WinSetOnTop($OSDWindow, "", 1)
		updateOSD()
	EndIf
EndFunc