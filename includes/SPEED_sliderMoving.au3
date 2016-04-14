Func sliderMoving($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam

	If $lParam = GUICtrlGetHandle($speedSlider) Then
		setSpeed(GUICtrlRead($speedSlider))
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc