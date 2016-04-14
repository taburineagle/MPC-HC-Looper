Func clearInPoint() ; clear the IN point
	GUICtrlSetBkColor($clearInButton, 0xb9b9b9)
	GUICtrlSetData($inTF, "0:00")
	clearOSDInfo()
	Sleep(30)
	GUICtrlSetBkColor($clearInButton, 0xFF000000)
EndFunc