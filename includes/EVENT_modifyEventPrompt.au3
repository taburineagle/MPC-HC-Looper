Func modifyEventPrompt() ; modify an event in the event list
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

		modifyEvent($currentPlayingEvent, $currentEvent, $currentName, $inPoint, $outPoint, $currentFile, $currentPlayingEvent, $currentPlayingEvent)
	EndIf

	initializeEventChange($GUI_ENABLE)
EndFunc