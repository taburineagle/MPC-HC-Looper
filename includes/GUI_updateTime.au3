Func updateTime()
	If $currentOrRemaining = 0 Then
		GUICtrlSetData($timeTF, NumberToTimeString($currentPosition + ($timeAdjustment * 0.5))) ; Show the current time (not the remaining)
	Else
		$remainingTime = Round(TimeStringToNumber(GUICtrlRead($outTF)) - ($timeAdjustment * 0.5) - $currentPosition, 4)
		If $remainingTime > 0 Then
			GUICtrlSetData($timeTF, "-" & NumberToTimeString($remainingTime))
		Else
			GUICtrlSetData($timeTF, "<--------->")
		EndIf
	EndIf

	$pastPosition = $currentPosition
EndFunc