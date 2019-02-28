Func checkOutPoint()
	$currentInPoint = TimeStringToNumber(GUICtrlRead($inTF))
	$currentOutPoint = TimeStringToNumber(GUICtrlRead($outTF))

	If $currentOutPoint < $currentInPoint Then
		clearOutPoint()
	EndIf
EndFunc