Func switchToShuffle()
	If getItemCount() > 1 Then ; if there are items in the playlist to shuffle
		If GUICtrlRead($loopButton) <> "Shuffle Mode" Then ; switch to shuffle mode
			GUICtrlSetData($loopButton, "Shuffle Mode")
			GUICtrlSetBkColor($loopButton, 0x85e7f0)
			switchEditingControls($GUI_DISABLE)
			createRandomList()

			If GUICtrlRead($listModifyButton) = "Merge Events" Then
				GUICtrlSetData($listModifyButton, "Modify Event")
			EndIf
		Else
			switchToLoop() ; if the button already says "Shuffle Mode", then just switch to Loop mode on the current loop item
		EndIf
	Else
		switchToLoop()
		displayError("Shuffle Mode")
	EndIf
EndFunc