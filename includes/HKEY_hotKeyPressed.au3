Func dummyAction()

EndFunc

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
			If getMode() Then trimInPointDec() ; if you hold down [ without SHIFT
		Case "]"
			If getMode() Then trimInPointInc() ; if you hold down ] without SHIFT
		Case ";"
			If getMode() Then trimOutPointDec() ; if you hold down ; without SHIFT
		Case "'"
			If getMode() Then trimOutPointInc() ; if you hold down ' without SHIFT

		Case "+["
			If getMode() Then trimInPointDec(0.050) ; if you hold down [ WITH SHIFT
		Case "+]"
			If getMode() Then trimInPointInc(0.050) ; if you hold down ] WITH SHIFT
		Case "+;"
			If getMode() Then trimOutPointDec(0.050) ; if you hold down ; WITH SHIFT
		Case "+'"
			If getMode() Then trimOutPointInc(0.050) ; if you hold down ' WITH SHIFT

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
			HotKeySet("^{PGUP}", "dummyAction") ; block the PG UP hotkey to delay the next event switch (slow it down a bit)
			If getItemCount() > 0 Then loadPrevNextEvent(-1)
			Sleep(75)
			HotKeySet("^{PGUP}", "hotKeyPressed")
		Case "^{PGDN}"
			HotKeySet("^{PGDN}", "dummyAction") ; block the PG DN hotkey to delay the next event switch (slow it down a bit)
			If getItemCount() > 0 Then loadPrevNextEvent(1)
			Sleep(75)
			HotKeySet("^{PGDN}", "hotKeyPressed")
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