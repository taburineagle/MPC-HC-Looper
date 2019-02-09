Func loadEvent($selectedItem) ; load a selected item's IN, OUT and FILE from the event list
	$currentFile = _GUICtrlListView_GetItemText($eventList, $selectedItem, 5)
	$fileToLoad = findFileExists($currentFile, $currentLooperFile) ; finds the path to the file, either in it's original dir, or relative to the looper file

	If $fileToLoad <> -1 Then
		_GUICtrlListView_SetItemText($eventList, $currentPlayingEvent, $currentPlayingEventPos, 0) ; switch the current playing event # back to it's original state
		$currentPlayingEventPos = _GUICtrlListView_GetItemText($eventList, $selectedItem, 0) ; get the current playing event # from the new event to load

		GUICtrlSetData($inTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 2))
		GUICtrlSetData($outTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 3))

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

		__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to pause

		$currentPlayingEvent = $selectedItem
		_GUICtrlListView_EnsureVisible($eventList, $currentPlayingEvent, True)

		updateEventOSDInfo($currentPlayingEvent + 1)
		_GUICtrlListView_SetItemText($eventList, $currentPlayingEvent, "▶", 0) ; tell the event list that the new event is currently playing
	Else
		MsgBox(262144 + 48, "Can't find media file for the event you loaded", "This event's media file can not be found:" & @CRLF & $currentFile & @CRLF & @CRLF & "Media files either need to be in the same directory as the .looper file:" & @CRLF & "          > [example: (path to current .looper file)\MediaFile.mp4] <" & @CRLF & "or in the original directory they were in:" & @CRLF & "         > [example: E:\Media\MediaFile.mp4] <" & @CRLF & "for MPC-HC Looper to be able find them to load them for playback.")
	EndIf
EndFunc