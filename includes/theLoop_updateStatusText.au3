Func updateStatusText()
	If $displayTimer <> "" Then
		If Mod($displayTimer, 100) = 0 Then
			If $displayMessage = 2 Then ToolTip("")

			$displayMessage = 0
			$displayTimer = 0
		Else
			$displayTimer = $displayTimer + 1
		EndIf
	EndIf

	If $displayMessage = 0 Then
		If getItemCount() > 0 Then
			updateEventOSDInfo($currentPlayingEvent + 1)
		Else
			clearOSDInfo(0)
		EndIf
	ElseIf $displayMessage = 1 Then
		clearOSDInfo(0)
	Else
		;
	EndIf

	If GUICtrlRead($currentEventStatusTF) <> $currentEventCounter Then
		GUICtrlSetData($currentEventStatusTF, $currentEventCounter)
	EndIf
EndFunc