Func deleteEvent() ; delete an event in the event list
	If getItemCount() > 0 Then
		initializeEventChange($GUI_DISABLE)
		GUICtrlSetState($eventList, $GUI_DISABLE)

		$deleteFiles = 0 ; initialize the $deleteFiles value so you don't need to set it every time
		$selectedItems = _GUICtrlListView_GetSelectedIndices($eventList, True)

		If $selectedItems[0] = getItemCount() Then ; if you chose to delete ERRYTHIN'
			If $currentlySearching = 0 Then ; if you're not in search mode
				$deleteFiles = MsgBox(262144 + 36, "Delete", "You chose to delete all of the events (" & $selectedItems[0] & " of " & getItemCount() & ") in the event list" & @CRLF & @CRLF & 'Deleting all the events will unload the current .looper file and clear the event list, creating a new session (the same as hitting the "Clear List" button) - are you sure you want to do that?')

				If $deleteFiles = "6" Then
					clearEvents()
				EndIf
			Else ; if you ARE in search mode
				$deleteFiles = MsgBox(262144 + 36, "Delete - Search Mode", "Deleting an event in Search Mode also deletes it in the main playlist -" & @CRLF & @CRLF & "Do you want to delete all of the search mode events from the main playlist?" & @CRLF & @CRLF & "HINT - if you just want to exit Search Mode and not delete the events, just click on the " & '"Clear"' & "button to the right of the Search area.")

				If $deleteFiles = 6 Then
					$deleteFiles = 1
				EndIf
			EndIf
		Else
			If $selectedItems[0] = 1 Then ; if you chose to delete only one event
				If $currentlySearching = 0 Then ; if you're not in search mode
					$deleteFiles = MsgBox(262144 + 36, "Delete", "Are you sure you want to delete" & @CRLF & @CRLF & '"' & _GUICtrlListView_GetItemText($eventList, Number($selectedItems[1]), 1) & '"' & @CRLF & @CRLF & "From the main events playlist?")

					If $deleteFiles = 6 Then
						$deleteFiles = 1
					EndIf
				Else ; if you ARE in search mode
					$deleteFiles = MsgBox(262144 + 36, "Delete - Search Mode", "Deleting an event in Search Mode also deletes it in the main playlist - " & @CRLF & @CRLF & "Do you want to delete " & @CRLF & '"' & _GUICtrlListView_GetItemText($eventList, Number($selectedItems[1]), 1) & '"' & @CRLF & "From the main events playlist also?")

					If $deleteFiles = 6 Then
						$deleteFiles = 1
					EndIf
				EndIf
			Else ; if you have multiple events to delete
				If $currentlySearching = 0 Then ; if you're not in search mode
					$deleteFiles = MsgBox(262144 + 36, "Delete", "Are you sure you want to delete these " & $selectedItems[0] & " events from the main events playlist?")

					If $deleteFiles = 6 Then
						$deleteFiles = 1
					EndIf
				Else ; if you ARE in search mode
					$deleteFiles = MsgBox(262144 + 36, "Delete - Search Mode", "Deleting an event in Search Mode also deletes it in the main playlist - " & @CRLF & @CRLF & "Do you want to delete these " & $selectedItems[0] & " events?")

					If $deleteFiles = 6 Then
						$deleteFiles = 1 ; also go to the routine to delete the files from the MAIN event playlist as well
					EndIf
				EndIf
			EndIf
		EndIf

		If $deleteFiles = 1 Then
			_ArrayDelete($selectedItems, 0)
			Local $deleteArray[UBound($selectedItems)]

			If $currentlySearching = 0 Then
				$completeEventList = _GUIListViewEx_ReturnArray($eventListIndex)
			EndIf

			For $i = 0 to UBound($selectedItems) - 1
				If $currentlySearching = 0 Then
					$currentItem = $completeEventList[$selectedItems[$i]]
				Else
					$currentItem = $searchResultsList[$selectedItems[$i]]
				EndIf

				$deleteArray[$i] = Int(StringLeft($currentItem, StringInStr($currentItem, "|") - 1))
			Next

			_ArraySort($deleteArray, 1)

			If $currentlySearching <> 0 Then
				$searchResultsList = reorderArray($searchResultsList, $deleteArray)
			EndIf

			$completeEventList = reorderArray($completeEventList, $deleteArray)

			If $currentlySearching <> 0 Then
				If UBound($searchResultsList) > 0 Then
					reloadList($searchResultsList)
				Else
					searchEventListRestore()
				EndIf
			Else
				reloadList($completeEventList)
			EndIf

			setModified()

			If $currentPlayingEvent = getItemCount() Then ; if we're playing the last event in the list currently
				loadEvent($currentPlayingEvent - 1) ; load the penultimate event
			Else
				loadEvent($currentPlayingEvent) ; if we're not, then just play the event after the one you deleted
			EndIf

			_GUICtrlListView_SetItemSelected($eventList, $currentPlayingEvent, true, true)
		EndIf
	EndIf

	initializeEventChange($GUI_ENABLE)
	GUICtrlSetState($eventList, $GUI_ENABLE)
EndFunc

Func reorderArray($arrayToSort, $deleteArray)
	Local $arrayToWorkWith[UBound($arrayToSort)][3]

	For $i = 0 to UBound($arrayToSort) - 1
		$currentItem = $arrayToSort[$i]
		$currentItemDelim = StringInStr($currentItem, "|") - 1

		$arrayToWorkWith[$i][0] = $currentItem ; the current item in the list
		$arrayToWorkWith[$i][1] = $i ; the current item's position in the list
		$arrayToWorkWith[$i][2] = Int(StringLeft($currentItem, $currentItemDelim)) ; the current item's position in the global list
	Next

	_ArraySort($arrayToWorkWith, 1, -1, -1, 2)

	$deleteOffset = 0

	For $a = 0 to UBound($arrayToWorkWith) - 1
		If $arrayToWorkWith[$a][2] > $deleteArray[$deleteOffset] Then
			$arrayToWorkWith[$a][2] = $arrayToWorkWith[$a][2] - (UBound($deleteArray) - $deleteOffset)
		ElseIf $arrayToWorkWith[$a][2] = $deleteArray[$deleteOffset] Then
			$arrayToWorkWith[$a][2] = "XX"

			If $deleteOffset <> UBound($deleteArray) - 1 Then
				$deleteOffset = $deleteOffset + 1
			EndIf
		Else

		EndIf
	Next

	_ArraySort($arrayToWorkWith, 0, -1, -1, 1)
	Redim $arrayToSort[0]

	For $b  = 0 to UBound($arrayToWorkWith) - 1
		If $arrayToWorkWith[$b][2] <> "XX" Then
			Redim $arrayToSort[UBound($arrayToSort) + 1]

			$currentItem = $arrayToWorkWith[$b][0]
			$currentItemDelim = StringInStr($currentItem, "|") - 1

			$arrayToSort[UBound($arrayToSort) - 1] = $arrayToWorkWith[$b][2] & StringTrimLeft($currentItem, $currentItemDelim)
		EndIf
	Next

	Return $arrayToSort
EndFunc

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