Func loadEvent($selectedItem) ; load a selected item's IN, OUT and FILE from the event list
	If _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 0) = "▶" Then
		_GUICtrlListView_SetItemText($eventList, $currentPlayingEvent, $currentPlayingEventPos, 0) ; switch the current playing event # back to it's original state
	EndIf

	$currentFile = _GUICtrlListView_GetItemText($eventList, $selectedItem, 5)
	$fileToLoad = findFileExists($currentFile, $currentLooperFile) ; finds the path to the file, either in it's original dir, or relative to the looper file

	If $fileToLoad <> -1 Then
		$currentPlayingEventPos = _GUICtrlListView_GetItemText($eventList, $selectedItem, 0) ; get the current playing event # from the new event to load

		GUICtrlSetData($inTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 2))
		GUICtrlSetData($outTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 3))

		$currentName = _GUICtrlListView_GetItemText($eventList, $selectedItem, 1)

		If $fileToLoad <> $currentLoadedFile Then
			__MPC_send_message($ghnd_MPC_handle, $CMD_OPENFILE, $fileToLoad)

			While $isLoaded <> 2
				; wait until the file loads
			WEnd

			Sleep(150)

			$currentLoadedFile = $fileToLoad
		EndIf

		$currentPlayingEvent = $selectedItem
		updateEventOSDInfo($currentPlayingEvent + 1)
		_GUICtrlListView_EnsureVisible($eventList, $currentPlayingEvent, True)
		_GUICtrlListView_SetItemText($eventList, $currentPlayingEvent, "▶", 0) ; tell the event list that the new event is currently playing

		; CHECK THE SPEED SETTING FOR THIS EVENT AND SET IT IN MPC-HC
		$speedSetting = checkNameSpeedSetting($currentName)

		$loopRepeats[0] = checkNameRepeatSetting($currentName) ; the number of repeats for the current loop
		$loopRepeats[1] = 1 ; always set this to 1 (this is the first loop)

		__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - ($timeAdjustment * 0.5)) ; seeks to the current IN point

		setSpeed($speedSetting)

		If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "pausePlaybackOnLoadEvent", "0") = "1" Then
			__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC-HC to pause after loading and cueing the event
		Else
			__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; tells MPC-HC to play after loading and cueing the event
		EndIf
	Else ; the event is looking for a file that it can't find...
		__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause
		$findFile = MsgBox(4 + 48 + 262144, "Can't find media file for the event you loaded", "The media file for this event can not be found:" & @CRLF & @CRLF & $currentFile & @CRLF & @CRLF & "Would you like to try and locate it elsewhere?")

		If $findFile = 6 Then
			$currentFilePath = StringTrimLeft($currentFile, StringInStr($currentFile, "\", Default, -1)) ; the base name for the file we're looking for
			$currentExtension = StringTrimLeft($currentFilePath, StringInStr($currentFilePath, ".", Default, -1)) ; the base extension (to limit results)

			$filePath = FileOpenDialog("Find Missing Media File", @DesktopDir, "Matching (" & $currentFilePath & ")|" & $currentExtension & " files (*." & $currentExtension & ")", Default, $currentFilePath)

			If $filePath <> "" Then
				If $currentlySearching = 0 Then ; if we're not in search mode, then we don't have this set yet, so set it
					$completeEventList = _GUIListViewEx_ReturnArray($eventListIndex) ; get the entire events list as an array to check other positions for this event
				EndIf

				For $i = 0 to UBound($completeEventList) - 1 ; replace all the master list's filepaths with the new file
					$completeEventList[$i] = StringReplace($completeEventList[$i], $currentFile, $filePath) ; replace the old filename with the new one for every one that matches
				Next

				If $currentlySearching <> 0 Then ; if we're searching, then replace the current paths with the updated path
					For $i = 0 to UBound($searchResultsList) - 1
						$searchResultsList[$i] = StringReplace($searchResultsList[$i], $currentFile, $filePath) ; replace the old filename with the new one for every one that matches
					Next

					reloadList($searchResultsList) ; reload the events list again, with the search array (because we're in search mode)
				Else
					reloadList($completeEventList) ; reload the events list again, but with the master list (because we're NOT in search mode)
				EndIf

				loadEvent($selectedItem) ; load the event we originally asked for again...

				setModified()
			Else
				$currentPlayingEvent = $selectedItem ; if you didn't select a file, set $currentPlayingEvent to that item to skip it for the next pass
			EndIf
		Else
			$currentPlayingEvent = $selectedItem ; if you decided -=not to find the file=-, see the above comment...
		EndIf
	EndIf
EndFunc