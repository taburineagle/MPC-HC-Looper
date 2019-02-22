Func searchEventListRestore()
	If $currentlySearching <> 0 Then
		GUICtrlSetData($searchEventTF, "")
		clearEvents()

		Redim $searchResultsList[0]
		$currentlySearching = 0 ; put this after the clearEvents(), so it wouldn't delete the filename stored

		_GUICtrlListView_BeginUpdate($eventList)

		GUICtrlSetBkColor($searchEventTF, $COLOR_WHITE)
		GUICtrlSetBkColor($eventList, $COLOR_WHITE)
		GUICtrlSetFont($eventList, 9, 400, 0, "Segoe UI")

		For $i = 0 to UBound($completeEventList) - 1
			GUICtrlCreateListViewItem($completeEventList[$i], $eventList)
		Next

		_GUICtrlListView_EndUpdate($eventList)

		$eventListIndex = _GUIListViewEx_Init($eventList, $completeEventList, 0, 0, True, 1) ; for Dragging and Dropping items
		_GUICtrlListView_SetItemSelected($eventList, -1, False, False) ; for Dragging and Dropping items

		If GUICtrlRead($loopButton) = "Shuffle Mode" Then ; if we're in shuffle mode, special consideration needs to be taken...
			clearRandomization() ; ... to clear the old randomized list before starting the new one, and...
			createRandomList() ; ... to make a new one before starting playback
		EndIf

		GUICtrlSetState($searchClearButton, $GUI_DISABLE)
		GUICtrlSetState($listClearButton, $GUI_SHOW) ; shows the "Clear All" button again
	EndIf
EndFunc