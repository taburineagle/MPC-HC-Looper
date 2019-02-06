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

	loadEvent($currentPlayingEvent)
EndFunc