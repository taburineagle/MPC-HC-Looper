Func clickLeftDockingButton()
	If GUICtrlRead($dockLeftButton) <> " " Then ; if docking isn't already on that side
		GUICtrlSetData($dockLeftButton, " ")
		GUICtrlSetData($dockRightButton, "")
		GUICtrlSetBkColor($dockLeftButton, 0x3daf05)
		GUICtrlSetBkColor($dockRightButton, 0xffffff)
		WinMove($mainWindow, "", 11, 11) ; move the windows to the left of the screen
	Else ; if docking is already on that side, then just cancel docking altogether
		clickDockingButton()
	EndIf
EndFunc

Func clickDockingButton()
	GUICtrlSetData($dockLeftButton, "")
	GUICtrlSetData($dockRightButton, "")
	GUICtrlSetBkColor($dockLeftButton, 0xffffff)
	GUICtrlSetBkColor($dockRightButton, 0xffffff)
EndFunc

Func clickRightDockingButton()
	If GUICtrlRead($dockRightButton) <> " " Then ; if docking isn't already on that side
		GUICtrlSetData($dockLeftButton, "")
		GUICtrlSetData($dockRightButton, " ")
		GUICtrlSetBkColor($dockLeftButton, 0xffffff)
		GUICtrlSetBkColor($dockRightButton, 0x3daf05)
		WinMove($mainWindow, "", (@DesktopWidth - (429 + 30)), 11) ; move the windows to the right of the screen
	Else ; if docking is already on that side, then just cancel docking altogether
		clickDockingButton()
	EndIf
EndFunc