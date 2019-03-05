Func switchToShuffle()
	If getItemCount() > 1 Then ; if there are items in the playlist to shuffle
		If GUICtrlRead($loopButton) <> "Shuffle Mode" Then ; switch to shuffle mode
			HotKeySet("^4", "dummyAction") ; disable CTRL-4 until Shuffle mode is actually set
			GUICtrlSetData($loopButton, "Shuffle Mode")
			GUICtrlSetBkColor($loopButton, 0x85e7f0)
			switchEditingControls($GUI_DISABLE)
			createRandomList()

			If GUICtrlRead($listModifyButton) = "Merge Events" Then
				GUICtrlSetData($listModifyButton, "Modify Event")
			EndIf

			Sleep(75) ; wait a little bit of time before allowing hotkeys for CTRL-4
			HotKeySet("^4", "hotKeyPressed") ; allow the hotkey for the above
		Else
			switchToLoop() ; if the button already says "Shuffle Mode", then just switch to Loop mode on the current loop item
		EndIf
	Else
		switchToLoop()
		displayError("Shuffle Mode")
	EndIf
EndFunc