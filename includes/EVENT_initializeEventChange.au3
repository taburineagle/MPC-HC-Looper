Func initializeEventChange($onOrOff)
	If $onOrOff = $GUI_DISABLE Then
		loadHotKeys(0) ; disable hotkeys so they don't fotz up typing
		__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause
	Else
		If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
			__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to pause
		EndIf

		makeMPCActive()
		Sleep(200)
		loadHotKeys(1) ;reload hotkeys
	EndIf

	If getItemCount() > 0 Then
		GUICtrlSetState($listSaveButton, $onOrOff)
		GUICtrlSetState($listClearButton, $onOrOff)
	EndIf

	If $onOrOff = 64 Then
		switchModifyDelete() ; check to see if there is any reason to enable Modify or Delete buttons
	Else
		GUICtrlSetState($listModifyButton, $onOrOff)
		GUICtrlSetState($listDeleteButton, $onOrOff)
	EndIf

	GUICtrlSetState($listLoadButton, $onOrOff)
	GUICtrlSetState($listAddButton, $onOrOff)
EndFunc