Func addEvent() ; add an event to the event list
	searchEventListRestore() ; if we're adding a new event, take the program out of search mode first

	initializeEventChange($GUI_DISABLE)
	$currentName = eventNamePrompt()

	If $currentName <> "" Then
		$inPoint = GUICtrlRead($inTF)
		$outPoint = GUICtrlRead($outTF)

		If GUICtrlRead($loopButton) = "OFF" Or GUICtrlRead($loopButton) = "Loop Mode" Then ; if you're in Loop Mode or OFF mode
			HotKeySet("^x", hotKeyPressed) ; initializes only CTRL-X to clear the selection as the event is being added
		EndIf

		If IsArray($nowPlayingInfo) = 1 Then
			$currentFile = $nowPlayingInfo[4]
		Else
			$currentFile = ""
		EndIf

		$newItem = (getItemCount() + 1) & "|" & $currentName & "|" & $inPoint & "|" & $outPoint & "|" & NumberToTimeString(getEventDur($inPoint, $outPoint)) & "|" & $currentFile

		If $eventListIndex = 0 Then
			$eventListIndex = _GUIListViewEx_Init($eventList, "", 0, 0, True, 1) ; for Dragging and Dropping items
		EndIf

		_GUICtrlListView_SetItemSelected($eventList, -1, false, false) ; erases the current selection to make sure the new item appears at the end
		_GUIListViewEx_Insert($newItem)  ; put the new event into the event list

		GUICtrlSetData($currentEventStatusTF, "Please wait, adding event to list...")

		$currentPlayingEvent = getItemCount() - 1 ; set the current playing event to this new event
		$currentPlayingEventPos = $currentPlayingEvent + 1
		_GUICtrlListView_SetItemText($eventList, $currentPlayingEvent, "▶", 0)
	EndIf

	initializeEventChange($GUI_ENABLE)
EndFunc