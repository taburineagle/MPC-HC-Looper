Func trimInPointInc_Button()
	trimInPointInc()
EndFunc

Func trimInPointInc($trimAmount = 0) ; trim the IN point forward
	GUICtrlSetBkColor($inIncButton, 0xb9b9b9)
	Local $hDLL = DllOpen("user32.dll")

	$isDone = False
	$firstRun = True

	If $trimAmount = 0 Then
		$trimAmount = $loopSlipLength
	EndIf

	While $isDone = False
		$newInPoint = NumberToTimeString(TimeStringToNumber(GUICtrlRead($inTF)) + $trimAmount)
		GUICtrlSetData($inTF, $newInPoint)

		clearOSDInfo()
		__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - ($timeAdjustment * 0.5))

		If $firstRun = True Then
			Sleep(250) ; if this is the first time you clicked the button, give it some time to rest (to show it's waiting)
			$firstRun = False
		EndIf

		If _IsPressed("01", $hDLL) Then
			$isDone = False
			Sleep(60)
		Else
			$isDone = True
		EndIf
	WEnd

	DllClose($hDLL)
	GUICtrlSetBkColor($inIncButton, 0xFF000000)
EndFunc