Func clickOSDButton()
	Switch GUICtrlRead($OSDButton)
		Case "OSD Off"
			OSDWindow()

			GUICtrlSetData($OSDButton, "OSD On")
			GUICtrlSetBkColor($OSDButton, 0x49b9f3)
		Case "OSD On"
			$currentWndSize = WinGetPos($OSDWindow, "")
			$OSDWindowX = $currentWndSize[0]
			$OSDWindowY = $currentWndSize[1]
			GUIDelete($OSDWindow)

			GUICtrlSetData($OSDButton, "OSD Off")
			GUICtrlSetBkColor($OSDButton, 0xbfd1db)
	EndSwitch
EndFunc