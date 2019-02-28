Func stripInfoFromName($eventName)
	$speedOffset = StringInStr($eventName, "<S:")

	If $speedOffset <> 0 Then ; if we have a speed setting on the event name (<S:30>), then take it off for the dialog
		$eventName = StringTrimLeft($eventName, $speedOffset)
		$endBracketOffset = StringInStr($eventName, ">")
		$eventName = StringTrimLeft($eventName, $endBracketOffset)
	EndIf

	$repeatOffset = StringInStr($eventName, "<L:")

	If $repeatOffset <> 0 Then ; if we have a repeat setting on the event name (<L:5>), then take it off for the dialog
		$eventName = StringTrimLeft($eventName, $repeatOffset)
		$endBracketOffset = StringInStr($eventName, ">")
		$eventName = StringTrimLeft($eventName, $endBracketOffset)
	EndIf

	Return $eventName
EndFunc