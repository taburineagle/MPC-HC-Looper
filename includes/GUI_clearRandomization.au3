Func clearRandomization()
	If UBound($randomPlayOrder) > 0 Then ; if the random playlist array has any items
		_ArrayDelete($randomPlayOrder, "0-" & UBound($randomPlayOrder) - 1) ; deletes every item in the random playlist array to save memory
	EndIf
EndFunc