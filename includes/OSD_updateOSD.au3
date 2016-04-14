Func updateOSD()
	If GUICtrlRead($OSDButton) = "OSD On" Then
		If GUICtrlRead($OSDmodeTF) <> GUICtrlRead($loopButton) Then
			GUICtrlSetData($OSDmodeTF, GUICtrlRead($loopButton)) ; $OSDmodeTF
		EndIf

		If GUICtrlRead($OSDeventNameTF) <> $currentEventName Then
			GUICtrlSetData($OSDeventNameTF, $currentEventName) ; $OSDeventNameTF
		EndIf

		If GUICtrlRead($OSDeventCounterTF) <> $currentEventCounter Then
			GUICtrlSetData($OSDeventCounterTF, $currentEventCounter) ; $OSDeventCounterTF
		EndIf

		If GUICtrlRead($OSDcurrentPositionTF) <> GUICtrlRead($timeTF) Then
			GUICtrlSetData($OSDcurrentPositionTF, GUICtrlRead($timeTF)) ; $OSDcurrentPositionTF
		EndIf

		If GUICtrlRead($OSDinPositionTF) <> GUICtrlRead($inTF) Then
			GUICtrlSetData($OSDinPositionTF, GUICtrlRead($inTF)) ; $OSDinPositionTF
		EndIf

		If GUICtrlRead($OSDoutPositionTF) <> GUICtrlRead($outTF) Then
			GUICtrlSetData($OSDoutPositionTF, GUICtrlRead($outTF)) ; OSDoutPositionTF
		EndIf

		If $currentOrRemaining = 1 Then
			If GUICtrlRead($OSDCurrentRemainTF) <> "  REMAIN" Then
				GUICtrlSetData($OSDCurrentRemainTF, "  REMAIN") ; $OSDCurrentRemainTF
			EndIf
		Else
			If GUICtrlRead($OSDCurrentRemainTF) <> "CURRENT" Then
				GUICtrlSetData($OSDCurrentRemainTF, "CURRENT") ; $OSDCurrentRemainTF
			EndIf
		EndIf
	EndIf
EndFunc