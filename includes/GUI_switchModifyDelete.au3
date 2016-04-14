Func switchModifyDelete()
	$iCount = _GUICtrlListView_GetSelectedCount($eventList) ; Are any items selected

	If $iCount Then
		If $currentPlayingEvent <> -1 Then
			GUICtrlSetState($listDeleteButton, $GUI_ENABLE)
			GUICtrlSetState($listModifyButton, $GUI_ENABLE)
		Else
			GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
			GUICtrlSetState($listModifyButton, $GUI_DISABLE)
		EndIf
	Else
		GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
		GUICtrlSetState($listModifyButton, $GUI_DISABLE)
	EndIf
EndFunc