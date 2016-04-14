Func hotKeyPressed() ; when you press a hotkey
	Switch @HotKeyPressed
		Case "i"
			If getMode() Then setInPoint()
		Case "o"
			If getMode() Then setOutPoint()
		Case "^i"
			If getMode() Then clearInPoint()
		Case "^o"
			If getMode() Then clearOutPoint()
		Case "^x"
			If getMode() Then clearInOutPoint()
		Case "["
			If getMode() Then trimInPointDec()
		Case "]"
			If getMode() Then trimInPointInc()
		Case ";"
			If getMode() Then trimOutPointDec()
		Case "'"
			If getMode() Then trimOutPointInc()
		Case "^n"
			If getMode() Then addEvent()
		Case "{DEL}"
			If GUICtrlGetState($listDeleteButton) = 80 Then deleteEvent()
		Case "^l"
			loadList()
		Case "^s"
			saveList()
		Case "+l"
			clickLoopButton()
		Case "^t"
			setAlwaysOnTop()
		Case "+o"
			clickOSDButton()
		Case "^q"
			Uninitialize()
		Case "^,"
			loadOptions()
		Case "!^{BS}"
			openPathtoFile()
		Case "{SPACE}"
			__MPC_send_message($ghnd_MPC_handle, $CMD_PLAYPAUSE, "")
			makeMPCActive()
		Case "!{ENTER}"
			makeMPCActive()
			__MPC_send_message($ghnd_MPC_handle, $CMD_TOGGLEFULLSCREEN, "")
		Case "^{PGUP}"
			If getItemCount() > 0 Then loadPrevNextEvent(-1)
		Case "^{PGDN}"
			If getItemCount() > 0 Then loadPrevNextEvent(1)
		Case "^{UP}"
			setspeed($currentSpeed + 10)
		Case "^{DOWN}"
			setspeed($currentSpeed - 10)
		Case "^r"
			setSpeed(100)
		Case "^1"
			switchToOff()
		Case "^2"
			switchToLoop()
		Case "^3"
			switchToPlaylist()
		Case "^4"
			switchToShuffle()
	EndSwitch
EndFunc