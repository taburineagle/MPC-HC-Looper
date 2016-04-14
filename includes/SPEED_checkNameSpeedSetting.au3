Func checkNameSpeedSetting($theName)
	$speedSetting = 0

	If StringInStr($theName, "<S:") = 1 Then
		$theOffset = StringInStr($theName, ">")
		$speedSetting = StringLeft($theName, $theOffset - 1)
		$speedSetting = StringRight($speedSetting, StringLen($speedSetting) - 3)
	EndIf

	Return $speedSetting
EndFunc