Func returnColor()
	If GUICtrlRead($loopButton) = "Loop Mode" Then
		Return 0xb0f6b0 ; make the background color of the currently playing item the same color as the Loop Mode button
	ElseIf GUICtrlRead($loopButton) = "Playlist Mode" Then
		Return 0xffa882 ; "" Playlist mode button
	ElseIf GUICtrlRead($loopButton) = "Shuffle Mode" Then
		Return 0x85e7f0 ; "" Shuffle mode button
	Else
		Return 0xFFFFFF ; OFF is selected, so don't do anything colorish, just load the item
	EndIf
EndFunc

Func returnBGColor()
	If $currentlySearching = 0 Then
		Return 0xFFFFFF
	Else
		Return 0xe4ffef
	EndIf
EndFunc

Func highlightItem($selectedItem, $UNhighlight = 0)
	If $UNhighlight = 0 Then
		For $i = 0 to getItemCount() - 1
			If $i = $selectedItem Then ; set the background color and foreground font to make the currently playing item stand out
				ListViewColorsFonts_SetItemColors($eventList, $selectedItem, -1, returnColor())
				ListViewColorsFonts_SetItemFonts($eventList, $selectedItem, -1, "", $iFontStyleBold)
			Else ; reset all other items to the standard look
				ListViewColorsFonts_SetItemColors($eventList, $i, -1, returnBGColor())
				ListViewColorsFonts_SetItemFonts($eventList, $i, -1, "", $iFontStyleNormal)
			EndIf
		Next
	Else
		ListViewColorsFonts_SetItemColors($eventList, $selectedItem, -1, returnBGColor())
		ListViewColorsFonts_SetItemFonts($eventList, $selectedItem, -1, "", $iFontStyleNormal)
	EndIf

	ListViewColorsFonts_Redraw($eventList) ; redraw the events list with the above settings
EndFunc

Func loadEvent($selectedItem) ; load a selected item's IN, OUT and FILE from the event list
	$currentFile = _GUICtrlListView_GetItemText($eventList, $selectedItem, 5)
	$fileToLoad = findFileExists($currentFile, $currentLooperFile) ; finds the path to the file, either in it's original dir, or relative to the looper file

	If $fileToLoad <> -1 Then
		GUICtrlSetData($inTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 2))
		GUICtrlSetData($outTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 3))

		highlightItem($selectedItem)

		$currentName = _GUICtrlListView_GetItemText($eventList, $selectedItem, 1)

		If $fileToLoad <> $currentLoadedFile Then
			__MPC_send_message($ghnd_MPC_handle, $CMD_OPENFILE, $fileToLoad)
			While $isLoaded <> 2
				; wait until the file loads
			WEnd

			__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - 0.5)
			__MPC_send_message($ghnd_MPC_handle, $CMD_STOP, "")
			Sleep(200)

			$currentSpeed = 100 ; reset the current speed to 100, that way if the speed of the new event is slower, it forces it to re-slow...
			$currentLoadedFile = $fileToLoad
		EndIf

		__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - 0.5)

		$speedSetting = checkNameSpeedSetting($currentName)

		If $speedSetting <> 0 Then
			If $currentSpeed <> $speedSetting Then
				setSpeed($speedSetting)
			EndIf
		Else
			If $currentSpeed <> 100 Then
				setSpeed(100)
			EndIf
		EndIf

		If $hotKeysActive = true Then ; if either Looper or the main MPC-HC window are main and hotkeys are active, then...
			MakeMPCActive() ; make MPC-HC the active program (so it can respond to its own keyboard shortcuts)
		EndIf

		__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to pause

		$currentPlayingEvent = $selectedItem
		_GUICtrlListView_EnsureVisible($eventList, $currentPlayingEvent, True)

		updateEventOSDInfo($currentPlayingEvent + 1)
	Else
		MsgBox(262144 + 48, "Can't find media file for the event you loaded", "This event's media file can not be found:" & @CRLF & $currentFile & @CRLF & @CRLF & "Media files either need to be in the same directory as the .looper file:" & @CRLF & "          > [example: (path to current .looper file)\MediaFile.mp4] <" & @CRLF & "or in the original directory they were in:" & @CRLF & "         > [example: E:\Media\MediaFile.mp4] <" & @CRLF & "for MPC-HC Looper to be able find them to load them for playback.")
	EndIf
EndFunc
