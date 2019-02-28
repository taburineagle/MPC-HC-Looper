Func switchToLoop()
	GUICtrlSetData($loopButton, "Loop Mode")
	GUICtrlSetBkColor($loopButton, 0xb0f6b0)
	switchEditingControls($GUI_ENABLE)
	clearRandomization() ; clear any randomized lists (if they exist)
	$loopRepeats[1] = 1 ; set this to 1 to reset the count of loops (if we switch from Playlist/Random to Loop Mode)
EndFunc