Func reloadList($listToLoad)
	_GUIListViewEx_Close($eventListIndex)
	$eventListIndex = 0
	_GUICtrlListView_DeleteAllItems($eventList)

	_GUICtrlListView_BeginUpdate($eventList)

	For $i = 0 to UBound($listToLoad) - 1
		GUICtrlCreateListViewItem($listToLoad[$i], $eventList)
	Next

	_GUICtrlListView_EndUpdate($eventList)
	$eventListIndex = _GUIListViewEx_Init($eventList, $listToLoad, 0, 0, True, 1) ; for Dragging and Dropping items
EndFunc