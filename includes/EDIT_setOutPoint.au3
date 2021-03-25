Func setOutPoint() ; set the OUT point
	GUICtrlSetBkColor($outButton, 0xb9b9b9)
	__MPC_send_message($ghnd_MPC_handle, $CMD_GETCURRENTPOSITION, "")
	GUICtrlSetData($outTF, NumberToTimeString($currentPosition + ($timeAdjustment * 0.5)))
	clearOSDInfo()
	Sleep(50)
	GUICtrlSetBkColor($outButton, 0xFF000000)
EndFunc