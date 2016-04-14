Func isAcceptable($theNumber)
	If StringIsDigit($theNumber) or StringIsFloat($theNumber) Then
		return 1
	Else
		MsgBox(262144 + 16, "Error!", "Please only use numbers in the Current Delay and Slip Time fields.")
		return 0
	EndIf
EndFunc