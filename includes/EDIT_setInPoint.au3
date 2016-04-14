Func setInPoint() ; set the IN point
	GUICtrlSetBkColor($inButton, 0xb9b9b9)
	__MPC_send_message($ghnd_MPC_handle, $CMD_GETCURRENTPOSITION, "")
	GUICtrlSetData($inTF, NumberToTimeString($currentPosition + 0.5 - 0.15))
	clearOSDInfo()
	checkOutPoint()
	Sleep(50)
	GUICtrlSetBkColor($inButton, 0xFF000000)
EndFunc

Func checkOutPoint()
	$currentInPoint = TimeStringToNumber(GUICtrlRead($inTF))
	$currentOutPoint = TimeStringToNumber(GUICtrlRead($outTF))

	If $currentOutPoint < $currentInPoint Then
		clearOutPoint()
	EndIf
EndFunc