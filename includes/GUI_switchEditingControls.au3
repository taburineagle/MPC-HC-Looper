Func switchEditingControls($onOrOff)
	GUICtrlSetState($inButton, $onOrOff)
	GUICtrlSetState($outButton, $onOrOff)
	GUICtrlSetState($clearInButton, $onOrOff)
	GUICtrlSetState($clearOutButton, $onOrOff)
	GUICtrlSetState($clearAllButton, $onOrOff)
	GUICtrlSetState($inDecButton, $onOrOff)
	GUICtrlSetState($inIncButton, $onOrOff)
	GUICtrlSetState($outDecButton, $onOrOff)
	GUICtrlSetState($outIncButton, $onOrOff)
	GUICtrlSetState($listAddButton, $onOrOff)

	If $onOrOff = 64 Then
		switchModifyDelete() ; check to see if there is any reason to enable Modify or Delete buttons
	Else
		GUICtrlSetState($listModifyButton, $onOrOff)
		GUICtrlSetState($listDeleteButton, $onOrOff)
	EndIf

	GUICtrlSetState($listClearButton, $onOrOff)
EndFunc