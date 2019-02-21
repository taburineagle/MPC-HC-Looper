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

		$loopRepeats[0] = checkNameRepeatSetting($currentName) ; the number of repeats for the current loop
		$loopRepeats[1] = 1 ; always set this to 1 (this is the first loop)

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
	Else ; the event is looking for a file that it can't find...
		$findFile = MsgBox(4 + 48, "Can't find media file for the event you loaded", "The media file for this event can not be found:" & @CRLF & @CRLF & $currentFile & @CRLF & @CRLF & "Would you like to try and locate it elsewhere?")

		If $findFile = 6 Then
			$currentFilePath = StringTrimLeft($currentFile, StringInStr($currentFile, "\", Default, -1)) ; the base name for the file we're looking for
			$currentExtension = StringTrimLeft($currentFilePath, StringInStr($currentFilePath, ".", Default, -1)) ; the base extension (to limit results)

			$filePath = FileOpenDialog("Find Missing Media File", @DesktopDir, "Matching (" & $currentFilePath & ")|" & $currentExtension & " files (*." & $currentExtension & ")", Default, $currentFilePath)

			; OK, this is getting a bit complicated - we need to do this:
			;	- Return the entire array from the events list
			;	- Check the filename parameter in every event to see if that file (the one that can't be found) is anywhere else in the list
			;	- Ask (if there are any extra copies of that filename in any other event) if you want to replace them too
			;	- If we replace them, then we have to:
			;		- Regenerate the array using the new (found) path instead of the old one
			;		- Delete the old array (uninitialize it from _GUIListViewEx
			;		- Reinitialize the array (check the search functions to see how to do this) to _GUIListViewEx
			;		- Re-display the events list with the new filename in place
			;		- Re-open that event one more time, this time with the (found) file

			; Also, this should be an option whether or not you want to find other copies of that file in the list:
			; 	- Ask if you want to save the "updated" .looper file with the new pathname(s) over the original (broken link) version

			$completeEventList = _GUIListViewEx_ReturnArray($eventListIndex) ; get the entire events list as an array to check other positions for this event

			For $i = 0 to UBound($completeEventList)
				$currentItem = StringSplit($completeEventList[$i], "|")
				_ArrayDisplay($currentItem)
			Next

			; $multipleEvents = _ArraySearch($completeEventList, $currentFile, Default, Default, Default, Default, Default, 5)

			; _ArrayDisplay($completeEventList)
			; _ArrayDisplay($multipleEvents)
		EndIf
	EndIf
EndFunc