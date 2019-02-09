Func updateEventOSDInfo($eventToLoad)
	$numOfEvents = getItemCount()

	$currentEventIN = _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 2)
	$currentEventOUT = _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 3)

	If $currentEventIN = GUICtrlRead($inTF) And $currentEventOut = GUICtrlRead($outTF) Then
		If $eventToLoad <> 0 Then
			$currentEventName = _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 1)
			$currentEventDur = NumberToTimeString(getEventDur($eventToLoad))
			$currentEventCounter = "Playing event " & $eventToLoad & " out of " & $numOfEvents & " (" & $currentEventDur & ")"
		Else
			clearOSDInfo() ; if the event to load is 0 (which means a new file is open and didn't preload an event), show summary

			If _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 0) = "▶" Then
				_GUICtrlListView_SetItemText($eventList, $eventToLoad - 1, $currentPlayingEventPos, 0)
			EndIf
		EndIf
	Else
		clearOSDInfo() ; if the IN and OUT point don't match the currently playing event, show a summary instead

		If _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 0) = "▶" Then
			_GUICtrlListView_SetItemText($eventList, $eventToLoad - 1, $currentPlayingEventPos, 0)
		EndIf
	EndIf
EndFunc