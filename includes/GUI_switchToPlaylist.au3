Func switchToPlaylist()
	If getItemCount() > 0 Then ; if there are items in the playlist to play one after another, then switch to Playlist mode
		GUICtrlSetData($loopButton, "Playlist Mode")
		GUICtrlSetBkColor($loopButton, 0xffa882)
		switchEditingControls($GUI_DISABLE)
		clearRandomization()
	Else
		displayError("Playlist Mode")
		switchToLoop() ; if the event list is empty, just switch to OFF mode
	EndIf
EndFunc