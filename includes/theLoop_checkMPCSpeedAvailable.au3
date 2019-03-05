Func checkMPCSpeedAvailable() ; checks to see if MPC-HC has a file loaded, if it does, then Looper enables the speed control
	If WinGetTitle(HWnd($ghnd_MPC_handle)) = "Media Player Classic Home Cinema" Then
		If GUICtrlGetState($speedSlider) = 80 Then GUICtrlSetState($speedSlider, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_025X) = 80 Then GUICtrlSetState($__SPD_025X, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_05X) = 80 Then GUICtrlSetState($__SPD_05X, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_075X) = 80 Then GUICtrlSetState($__SPD_075X, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_1X) = 80 Then GUICtrlSetState($__SPD_1X, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_125X) = 80 Then GUICtrlSetState($__SPD_125X, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_15X) = 80 Then GUICtrlSetState($__SPD_15X, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_175X) = 80 Then GUICtrlSetState($__SPD_175X, $GUI_DISABLE)
		If GUICtrlGetState($__SPD_2X) = 80 Then GUICtrlSetState($__SPD_2X, $GUI_DISABLE)
	Else
		If GUICtrlGetState($speedSlider) = 144 Then GUICtrlSetState($speedSlider, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_025X) = 144 Then GUICtrlSetState($__SPD_025X, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_05X) = 144 Then GUICtrlSetState($__SPD_05X, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_075X) = 144 Then GUICtrlSetState($__SPD_075X, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_1X) = 144 Then GUICtrlSetState($__SPD_1X, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_125X) = 144 Then GUICtrlSetState($__SPD_125X, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_15X) = 144 Then GUICtrlSetState($__SPD_15X, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_175X) = 144 Then GUICtrlSetState($__SPD_175X, $GUI_ENABLE)
		If GUICtrlGetState($__SPD_2X) = 144 Then GUICtrlSetState($__SPD_2X, $GUI_ENABLE)

		If GUICtrlRead($speedSlider) <> $currentSpeed Then
			GUICtrlSetData($speedSlider, $currentSpeed)
		EndIf
	EndIf
EndFunc