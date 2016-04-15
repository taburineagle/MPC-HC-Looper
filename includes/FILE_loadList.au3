Func loadList($fileToOpen = "") ; load a .looper file into the program
	searchEventListRestore()

	loadHotKeys(0) ; disable hotkeys so they don't fotz up typing
	askForSave("Do you want to save before loading a new .looper file?")

	If $fileToOpen = "" Then
		__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause
		$fileToOpen = FileOpenDialog("Where is the loop events file you want to load?", @DesktopDir, "MPC-HC Looper Events File (*.looper)")
	EndIf

	If $fileToOpen <> "" Then ; you didn't cancel the opening process
		clearEvents()

		$eventCount = _FileCountLines($fileToOpen) ; see how many lines (events) there are in the file
		$readingFile = FileOpen($fileToOpen, FileGetEncoding($fileToOpen))

		Local $eventArray[$eventCount]

		For $i = 0 to ($eventCount - 1)
			$currentItem = FileReadLine($readingFile, ($i + 1))
			$currentItemArray = StringSplit($currentItem, "|", 2)

			$newItem = ($i + 1) & "|"
			$newItem = $newItem & $currentItemArray[0] & "|"
			$newItem = $newItem & $currentItemArray[1] & "|"
			$newItem = $newItem & $currentItemArray[2] & "|"
			$newItem = $newItem & NumberToTimeString(getEventDur($currentItemArray[1], $currentItemArray[2])) & "|"
			$newItem = $newItem & $currentItemArray[3]

			$eventArray[$i] = $newItem
		Next

		FileClose($readingFile)

		_GUICtrlListView_BeginUpdate($eventList)

		For $i = 0 to UBound($eventArray) - 1
			GUICtrlCreateListViewItem($eventArray[$i], $eventList)
		Next

		_GUICtrlListView_EndUpdate($eventList)

		$eventListIndex = _GUIListViewEx_Init($eventList, $eventArray, 0, 0, True, 1) ; for Dragging and Dropping items

		_GUICtrlListView_SetItemSelected($eventList, -1, False, False) ; for Dragging and Dropping items

		$currentLooperFile = $fileToOpen
		setModified(0)

		If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") <> 1 Then
			$isClicked = 1
			loadEvent(0) ; if you're supposed to autoplay, then load that event, otherwise do nothing...
		Else
			$currentPlayingEvent = -1 ; if we load the list, but don't autoplay the first event, set the current event to -1
		EndIf
	EndIf

	loadHotKeys(1) ; re-enable hotkeys

	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
		__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to pause
	EndIf
EndFunc