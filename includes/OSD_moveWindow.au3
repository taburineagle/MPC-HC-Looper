Func moveWindow()
	_SendMessage($OSDWindow, $WM_SYSCOMMAND, 0xF012, 0)
EndFunc