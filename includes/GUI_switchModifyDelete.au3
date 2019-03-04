Func switchModifyDelete()
	$iCount = _GUICtrlListView_GetSelectedCount($eventList) ; Are any items selected

	If $iCount Then
		If $currentPlayingEvent <> -1 Then
			GUICtrlSetState($listDeleteButton, $GUI_ENABLE)
			GUICtrlSetState($listModifyButton, $GUI_ENABLE)

			If $iCount > 1 And $currentlySearching = 0 Then ; If we're in search mode, don't allow combining
				If getMode() And GUICtrlRead($listModifyButton) = "Modify Event" Then
					GUICtrlSetData($listModifyButton, "Merge Events")
				EndIf
			Else
				If GUICtrlRead($listModifyButton) = "Merge Events" Then
					GUICtrlSetData($listModifyButton, "Modify Event")
				EndIf
			EndIf
		Else
			GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
			GUICtrlSetState($listModifyButton, $GUI_DISABLE)
		EndIf
	Else
		GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
		GUICtrlSetState($listModifyButton, $GUI_DISABLE)
	EndIf
EndFunc