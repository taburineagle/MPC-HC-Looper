Func modifyEvent() ; modify an event in the event list
	If $currentlySearching = 2 Then
		$currentItem = $searchResultsList[$currentPlayingEvent]
		$currentPlayingEvent = Int(StringLeft($currentItem, StringInStr($currentItem, "|"))) - 1
	EndIf

	searchEventListRestore()
	initializeEventChange($GUI_DISABLE)

	$currentEvent = _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 0) ; the current position of this event in the list
	$currentName = _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 1) ; the current name of this event in the list
	$currentName = eventNamePrompt($currentName)

	If $currentName <> "" Then
		$inPoint = GUICtrlRead($inTF)
		$outPoint = GUICtrlRead($outTF)

		refreshMPCInfo()
		$currentFile = $nowPlayingInfo[4]

		_GUICtrlListView_SetItemSelected($eventList, -1, false, false) ; for Dragging and Dropping items
		_GUICtrlListView_SetItemSelected($eventList, $currentPlayingEvent, True, True) ; for Dragging and Dropping items

		_GUIListViewEx_Delete() ; delete the currently selected event item, for Dragging and Dropping items
		_GUIListViewEx_Insert($currentEvent & "|" & $currentName & "|" & $inPoint & "|" & $outPoint & "|" & NumberToTimeString(getEventDur($inPoint, $outPoint)) & "|" & $currentFile) ; replace the entry with the new information, for Dragging and Dropping items

		If $currentPlayingEvent = 0 Then
			_GUIListViewEx_Up()
		EndIf

		GUICtrlSetData($currentEventStatusTF, "Please wait, saving event data...")
;~ 		loadEvent($currentPlayingEvent)
	EndIf

	initializeEventChange($GUI_ENABLE)
EndFunc

#cs
modify event function - need
	- position in list
	- name of new event
	- IN and OUT point of new event
	- figure out duration based on that information
	- and event(s) to delete, more if you're combining events
	- then the move up thing (If $currentPlayingEvent =) stuff
#ce