Func switchToOff()
	GUICtrlSetData($loopButton, "OFF")
	GUICtrlSetBkColor($loopButton, 0xFFFFE1)
	switchEditingControls($GUI_ENABLE)
	clearRandomization()
EndFunc