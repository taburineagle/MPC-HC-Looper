Func clearEvents() ; delete all of the events in the event list
	_GUIListViewEx_Close($eventListIndex)
	$eventListIndex = 0
	_GUICtrlListView_DeleteAllItems($eventList)

	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", 0) = 0 Then
		switchToLoop()
	EndIf

	GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
	GUICtrlSetState($listModifyButton, $GUI_DISABLE)

	If $currentlySearching <> 1 Then
		$currentLooperFile = "" ; if we're not currently searching, delete the current file variable
		setModified(0)
	EndIf

	clearOSDInfo()
EndFunc