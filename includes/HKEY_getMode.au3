Func getMode()
	If GUICtrlRead($loopButton) = "Loop Mode" Or GUICtrlRead($loopButton) = "OFF" Then
		Return True
	Else
		Return False
	EndIf
EndFunc