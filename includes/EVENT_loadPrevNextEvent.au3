Func loadPrevEventButton()
		loadPrevNextEvent(-1)
EndFunc

Func loadNextEventButton()
		loadPrevNextEvent(1)
EndFunc

Func loadPrevNextEvent($nextOrPrev)
	$numOfEvents = getItemCount()
	$currentPlayingEvent = $currentPlayingEvent + $nextOrPrev

	If $currentPlayingEvent = -1 Then
		$currentPlayingEvent = $numOfEvents - 1
	ElseIf $currentPlayingEvent = $numOfEvents Then
		$currentPlayingEvent = 0
	EndIf

	If GUICtrlRead($loopButton) = "Playlist Mode" Then
		$selectedItems = _GUICtrlListView_GetSelectedIndices($eventList, True)

		If $selectedItems[0] <> 0 Then
			While _ArraySearch($selectedItems, $currentPlayingEvent, 1) = -1
				$currentPlayingEvent = $currentPlayingEvent + $nextOrPrev

				If $currentPlayingEvent = -1 Then
					$currentPlayingEvent = $numOfEvents
				ElseIf $currentPlayingEvent > $numOfEvents Then
					$currentPlayingEvent = 0
				EndIf
			WEnd
		EndIf
	EndIf

	loadEvent($currentPlayingEvent)
EndFunc