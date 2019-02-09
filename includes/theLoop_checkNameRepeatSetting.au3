Func checkNameRepeatSetting($theName)
	$repeatSetting = "---"

	$theOffset = StringInStr($theName, "<L:")

	If $theOffset <> 0 Then
		$repeatSetting = StringTrimLeft($theName, $theOffset + 2)
		$endBracketOffset = StringInStr($repeatSetting, ">")
		$repeatSetting = StringLeft($repeatSetting, $endBracketOffset - 1)
	EndIf

	Return $repeatSetting
EndFunc