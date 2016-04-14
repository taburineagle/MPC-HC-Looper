Func getEventDur($eventNumOrInPoint, $outPoint = 0)
	If $outPoint <> "0" Then
		$inPoint = TimeStringToNumber($eventNumOrInPoint)
		$outPoint = TimeStringToNumber($outPoint)
	Else
		$eventNumOrInPoint = $eventNumOrInPoint - 1 ; the event # is one higher than the playlist index

		$inPoint = TimeStringToNumber(_GUICtrlListView_GetItemText($eventList, $eventNumOrInPoint, 2))
		$outPoint = TimeStringToNumber(_GUICtrlListView_GetItemText($eventList, $eventNumOrInPoint, 3))
	EndIf

	$theDifference = $outPoint - $inPoint

	If $theDifference > 0 Then
		Return $theDifference
	Else
		Return 0
	EndIf
EndFunc