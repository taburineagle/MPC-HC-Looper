Func checkNameSpeedSetting($theName)
	$speedSetting = 100

	$theOffset = StringInStr($theName, "<S:")

	If $theOffset <> 0 Then
		$speedSetting = StringTrimLeft($theName, $theOffset + 2)
		$endBracketOffset = StringInStr($speedSetting, ">")
		$speedSetting = StringLeft($speedSetting, $endBracketOffset - 1)
	EndIf

	If isAcceptableNumber($speedSetting) Then ; check to make sure the returned value of above is a valid number
		Return $speedSetting
	Else
		Return 100 ; return 100 (100%) for speeds that are invalidly set
	EndIf
EndFunc