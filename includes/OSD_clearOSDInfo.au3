Func clearOSDInfo($changeName = 1)
	If $changeName = 1 Then
		$currentEventName = ""
	EndIf

	$numOfEvents = getItemCount() ; how many events are in the event list

	If $numOfEvents > 1 Or $numOfEvents = 0 Then
		$currentEventCounter = $numOfEvents & " events in playlist"
	Else
		$currentEventCounter = "1 event in playlist"
	EndIf

	$totalTimeTally = getTotalPlaylistDur()
	$currentEventCounter = $currentEventCounter & " (" & NumberToTimeString($totalTimeTally) & " in entire playlist)"
EndFunc