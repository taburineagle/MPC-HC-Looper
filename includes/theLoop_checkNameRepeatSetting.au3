Func checkNameRepeatSetting($theName)
	$repeatSetting = 0

	$theOffset = StringInStr($theName, "<L:")

	If $theOffset <> 0 Then
		$repeatSetting = StringTrimLeft($theName, $theOffset + 2)
		$endBracketOffset = StringInStr($repeatSetting, ">")
		$repeatSetting = StringLeft($repeatSetting, $endBracketOffset - 1)
	EndIf

	If isAcceptable($repeatSetting) Then ; check to make sure the returned value of above is a valid number
		Return $repeatSetting
	Else
		Return 0 ; return 0 (0 repeats, or endless loop) for repeats that are invalidly set
	EndIf
EndFunc