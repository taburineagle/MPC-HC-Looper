Func loadPrevEventButton()
		loadPrevNextEvent(-1)
EndFunc

Func loadNextEventButton()
		loadPrevNextEvent(1)
EndFunc

Func loadPrevNextEvent($nextOrPrev)
	$numOfEvents = getItemCount()
	$nextEventToPlay = $currentPlayingEvent + $nextOrPrev

	If $nextEventToPlay = -1 Then
		$nextEventToPlay = $numOfEvents - 1
	ElseIf $nextEventToPlay = $numOfEvents Then
		$nextEventToPlay = 0
	EndIf

	If GUICtrlRead($loopButton) = "Playlist Mode" Then
		$selectedItems = _GUICtrlListView_GetSelectedIndices($eventList, True)

		If $selectedItems[0] = 1 Then
			_GUICtrlListView_SetItemSelected($eventList, -1, false, false) ; clears any selection to force Playlist mode to continue
		ElseIf $selectedItems[0] > 1 Then
			For $i = 1 to $selectedItems[0]
				While _ArraySearch($selectedItems, $nextEventToPlay) = -1 ; if $nextEventToPlay is not part of the current array, find the closest event...
					If $nextEventToPlay < $selectedItems[1]  Or $nextEventToPlay > $selectedItems[$selectedItems[0]] Then ; we're out of bounds
						If $nextOrPrev = 1 Then ; if we're advancing to the next event
							$nextEventToPlay = $selectedItems[1] ; jump back to the beginning of the selected items
						ElseIf $nextOrPrev = -1 Then ; if we're going to the PREVIOUS event
							$nextEventToPlay = $selectedItems[$selectedItems[0]] ; jump to the END of the selected items
						EndIf
					Else ; if we're in bounds, but the current event isn't in the selected list, go to the next one and try to find it
						If $nextOrPrev = 1 Then
							$nextEventToPlay = $nextEventToPlay + 1
						ElseIf $nextOrPrev = -1 Then
							$nextEventToPlay = $nextEventToPlay - 1
						EndIf
					EndIf
				WEnd
			Next
		EndIf
	EndIf

	loadEvent($nextEventToPlay)
EndFunc