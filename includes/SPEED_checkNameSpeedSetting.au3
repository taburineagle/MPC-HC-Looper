Func checkNameSpeedSetting($theName)
	$speedSetting = 100

	$theOffset = StringInStr($theName, "<S:")

	If $theOffset <> 0 Then
		$speedSetting = StringTrimLeft($theName, $theOffset + 2)
		$endBracketOffset = StringInStr($speedSetting, ">")
		$speedSetting = StringLeft($speedSetting, $endBracketOffset - 1)
	EndIf

	Return $speedSetting
EndFunc