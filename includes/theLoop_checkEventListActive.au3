Func checkEventListActive()
	If getItemCount() > 0 Then
		If GUICtrlRead($loopButton) <> "Playlist Mode" Then
			If GUICtrlGetState($listClearButton) = 144 Then GUICtrlSetState($listClearButton, $GUI_ENABLE) ; Enables the Clear List button when there are items IN the list
		EndIf

		If GUICtrlGetState($previousEventButton) = 144 Then GUICtrlSetState($previousEventButton, $GUI_ENABLE) ; Enables the Previous Event button when there are items IN the list
		If GUICtrlGetState($nextEventButton) = 144 Then GUICtrlSetState($nextEventButton, $GUI_ENABLE)
	Else
		If GUICtrlRead($loopButton) <> "Playlist Mode" Then
			If GUICtrlGetState($listClearButton) = 80 Then GUICtrlSetState($listClearButton, $GUI_DISABLE) ; Disables the Clear List button when there is NOTHING in the list
		EndIf

		If GUICtrlGetState($previousEventButton) = 80 Then GUICtrlSetState($previousEventButton, $GUI_DISABLE) ; Disables the Previous Event button when there is NOTHING in the list
		If GUICtrlGetState($nextEventButton) = 80 Then GUICtrlSetState($nextEventButton, $GUI_DISABLE) ; Disables the Next Event button when there is NOTHING in the list
	EndIf
EndFunc