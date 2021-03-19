Func clickLeftDockingButton()
	If GUICtrlRead($dockLeftButton) <> " " Then ; if docking isn't already on that side
		GUICtrlSetData($dockLeftButton, " ")
		GUICtrlSetData($dockRightButton, "")
		GUICtrlSetBkColor($dockLeftButton, 0x3daf05)
		GUICtrlSetBkColor($dockRightButton, 0xffffff)

		$TBOffsets = checkTaskbarPosition("Left")
		WinMove($mainWindow, "", 11 + $TBOffsets[0], 11 + $TBOffsets[1]) ; move the windows to the left of the screen
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

		$TBOffsets = checkTaskbarPosition("Right")
		WinMove($mainWindow, "", (@DesktopWidth - (429 + 30)) - $TBOffsets[0], 11 + $TBOffsets[1]) ; move the windows to the right of the screen
	Else ; if docking is already on that side, then just cancel docking altogether
		clickDockingButton()
	EndIf
EndFunc

Func checkTaskbarPosition($dockPosition)
	$TBPos = WinGetPos("[CLASS:Shell_TrayWnd]")
	Dim $offsetsArray[2] = [0, 0] ; the array of offsetting the docked windows relative to the taskbar position

	If $TBPos[0] = 0 And $TBPos[1] = 0 And $TBPos[2] = @DesktopWidth Then ; the taskbar is on the top of the screen
		$offsetsArray[1] = $TBPos[3]
	EndIf

	If $dockPosition = "Left" Then
		If $TBPos[0] = 0 And $TBPos[1] = 0 And $TBPos[3] = @DesktopHeight Then ; the taskbar is on the left of the screen
			$offsetsArray[0] = $TBPos[2]
		EndIf
	ElseIf $dockPosition = "Right" Then
		If $TBPos[0] > 0 And $TBPos[1] = 0 And $TBPos[3] = @DesktopHeight Then ; the taskbar is on the right of the screen
			$offsetsArray[0] = $TBPos[2]
		EndIf
	EndIf

	Return $offsetsArray
EndFunc