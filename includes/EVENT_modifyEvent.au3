Func modifyEvent($eventLocation, $newPosition, $newName, $newINPoint, $newOUTPoint, $newFile, $deleteFrom, $deleteTo)
	#cs
	Parameters -
		0 - the current location of the event, it's events list ID# ($eventLocation)
		1 - the new position of the event you're modifying for reordering ($newPosition)
		2 - the modified name of the event to modify ($newName)
		3 - the current IN point of the event to modify ($newINPoint)
		4 - the current OUT point of the event to modify ($newOUTPoint)
		5 - the current file path of the event to modify ($newFile)
		6 - the event (or the start of a group of events) to start deleting from the events list ($deleteFrom)
		7 - the end of a group of events (or if the same as #5, the only event) to delete from the events list ($deleteTo)
	#ce

	_GUICtrlListView_SetItemSelected($eventList, -1, false, false) ; clears any selection that might exist

	For $i = $deleteFrom to $deleteTo
		_GUICtrlListView_SetItemSelected($eventList, $i, True, True) ; select an item in the events list (multiple if you have a range)
	Next

	_GUIListViewEx_Delete() ; delete the currently selected event item(s)

	If $newPosition = "▶" Then
		$newPosition = $currentPlayingEventPos
	EndIf

	_GUIListViewEx_Insert($newPosition & "|" & _
	$newName & "|" & _
	$newINPoint & "|" & _
	$newOUTPoint & "|" & _
	NumberToTimeString(getEventDur($newINPoint, $newOUTPoint)) & "|" & _
	$newFile)

	If $eventLocation = 0 Then
		_GUIListViewEx_Up() ; if the event is the first in the list, it will re-create on the 2nd spot, so move it up!
	EndIf

	GUICtrlSetData($currentEventStatusTF, "Please wait, saving event data...")

	loadEvent($eventLocation) ; re-load the event once you're done modifying it
	_GUICtrlListView_SetItemSelected($eventList, -1, false, false) ; clears any selection (again) to force Playlist mode to continue
EndFunc