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

			If GUICtrlRead($loopButton) = "Shuffle Mode" Then ; if we're in Shuffle mode, we need to re-randomize the playlist order
				clearRandomization() ; ... to clear the old randomized list before starting the new one, and...
				createRandomList() ; ... to make a new one before starting playback
			Else ; if we're not in Shuffle mode, just re-load the last available event for playback
				If $currentPlayingEvent = getItemCount() Then ; if we're playing the last event in the list currently
					loadEvent($currentPlayingEvent - 1) ; load the penultimate event
				Else
					loadEvent($currentPlayingEvent) ; if we're not, then just play the event after the one you deleted
				EndIf
			EndIf

			_GUICtrlListView_SetItemSelected($eventList, $currentPlayingEvent, true, true)
		EndIf
	EndIf

	If GUICtrlRead($loopButton) = "Loop Mode" Or GUICtrlRead($loopButton) = "OFF" Then
		initializeEventChange($GUI_ENABLE)
	EndIf

	GUICtrlSetState($eventList, $GUI_ENABLE)
EndFunc