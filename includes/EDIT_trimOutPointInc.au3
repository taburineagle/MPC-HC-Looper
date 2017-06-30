Func trimOutPointInc_Button()
	trimOutPointInc()
EndFunc

Func trimOutPointInc($trimAmount = 0) ; trim the OUT point forward
	GUICtrlSetBkColor($outIncButton, 0xb9b9b9)
	Local $hDLL = DllOpen("user32.dll")

	$isDone = False
	$firstRun = True

	If $trimAmount = 0 Then
		$trimAmount = $loopSlipLength
	EndIf

	While $isDone = False
		$newOutPoint = NumberToTimeString(TimeStringToNumber(GUICtrlRead($outTF)) + $trimAmount)
		GUICtrlSetData($outTF, $newOutPoint)

		$trimmingOut = 1
		clearOSDInfo()
		__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, (TimeStringToNumber(GUICtrlRead($outTF)) - 0.5 - ($loopPreviewLength / 2)))

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
	GUICtrlSetBkColor($outIncButton, 0xFF000000)
EndFunc