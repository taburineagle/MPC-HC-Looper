Func checkEventListActive() ; checks to see if the events list is active, if it is, it activates the << and >> buttons
	If getItemCount() > 0 Then
		If GUICtrlGetState($previousEventButton) = 144 Then GUICtrlSetState($previousEventButton, $GUI_ENABLE) ; Enables the Previous Event button when there are items IN the list
		If GUICtrlGetState($nextEventButton) = 144 Then GUICtrlSetState($nextEventButton, $GUI_ENABLE)
	Else
		If GUICtrlGetState($previousEventButton) = 80 Then GUICtrlSetState($previousEventButton, $GUI_DISABLE) ; Disables the Previous Event button when there is NOTHING in the list
		If GUICtrlGetState($nextEventButton) = 80 Then GUICtrlSetState($nextEventButton, $GUI_DISABLE) ; Disables the Next Event button when there is NOTHING in the list
	EndIf
EndFunc