Func clearEvents() ; delete all of the events in the event list
	_GUIListViewEx_Close($eventListIndex)
	$eventListIndex = 0
	_GUICtrlListView_DeleteAllItems($eventList)

	GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
	GUICtrlSetState($listModifyButton, $GUI_DISABLE)

	If $currentlySearching = 0 Then
		If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", 0) = 0 Then
			switchToLoop()
		EndIf

		$currentLooperFile = "" ; if we're not currently searching, delete the current file variable
		setModified(0)
	Else
		switchToLoop()
	EndIf

	clearOSDInfo()
EndFunc