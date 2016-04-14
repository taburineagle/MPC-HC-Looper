Func getTotalPlaylistDur()
	$numOfEvents = getItemCount() ; how many events are in the event list
	$totalTimeTally = 0

	For $p = 1 to $numOfEvents
		$currentItemDur = getEventDur($p)
		$totalTimeTally = $totalTimeTally + $currentItemDur
	Next

	Return $totalTimeTally
EndFunc