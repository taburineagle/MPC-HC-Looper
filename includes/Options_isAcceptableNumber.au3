Func isAcceptableNumber($theNumber)
	If StringIsDigit($theNumber) or StringIsFloat($theNumber) Then
		return 1
	Else
		return 0
	EndIf
EndFunc