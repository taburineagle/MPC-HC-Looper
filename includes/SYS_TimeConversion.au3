Func NumberToTimeString($number)
	$timeString = StringSplit($number, ":")

	If $timeString[0] = 1 Then
		$timeString = ""
		$hours = Int($number / 3600)
		$minutes = Int(($number - ($hours * 3600)) / 60)
		$seconds = Round($number - ($hours * 3600) - ($minutes * 60), 3)

		If $seconds = 60 Then
			$seconds = 0
			$minutes = $minutes + 1
		EndIf

		If $hours > 0 Then
			$timeString = $hours & ":"
			If $minutes < 10 Then $timeString = $timeString & "0"
		EndIf

		If $minutes >= 0 Then
			$timeString = $timeString & $minutes & ":"
			If $seconds < 10 Then $timeString = $timeString & "0"
		EndIf

		$timeString = $timeString & StringFormat("%.3f", $seconds)
	Else
		$timeString = $number
	EndIf

	Return $timeString
EndFunc   ;==>NumberToTimeString

Func TimeStringToNumber($timeString)
	$timeString = StringSplit($timeString, ":")

	If $timeString[0] = 1 Then
		Return Number($timeString[1])
	ElseIf $timeString[0] = 2 Then
		Return Number(($timeString[1] * 60) + $timeString[2])
	ElseIf $timeString[0] = 3 Then
		Return Number(($timeString[1] * 3600) + ($timeString[2] * 60) + $timeString[3])
	EndIf
EndFunc   ;==>TimeStringToNumber