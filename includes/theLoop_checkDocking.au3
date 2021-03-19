Func checkDocking()
	If GUICtrlRead($dockLeftButton) = " " Or GUICtrlRead($dockRightButton) = " " Then
		$currentMPCPos = WinGetPos(HWnd($ghnd_MPC_handle))
		$currentLooperPos = WinGetPos($mainWindow)

		If WinActive(HWnd($ghnd_MPC_handle)) Then
			If GUICtrlRead($dockLeftButton) = " " Then
				If $currentMPCPos[0] <> ($currentLooperPos[0] + $currentLooperPos[2]) Then
					Local $hDLL = DllOpen("user32.dll")

					If _IsPressed("01", $hDLL) Then
						WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 1)

						While _IsPressed("01", $hDLL)
							; Don't do anything
						WEnd
					EndIf

					DllClose($hDLL)

					WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 0)
					WinMove($mainWindow, "", ($currentMPCPos[0] - $currentLooperPos[2]) + 11, $currentMPCPos[1])
				EndIf
			ElseIf GUICtrlRead($dockRightButton) = " " Then
				If $currentMPCPos[0] <> ($currentLooperPos[0] - $currentLooperPos[2]) Then
					Local $hDLL = DllOpen("user32.dll")

					If _IsPressed("01", $hDLL) Then
						WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 1)

						While _IsPressed("01", $hDLL)
							; Don't do anything
						WEnd
					EndIf

					DllClose($hDLL)

					WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 0)
					WinMove($mainWindow, "", ($currentMPCPos[0] + $currentMPCPos[2]) - 11, $currentMPCPos[1])
				EndIf
			EndIf
		ElseIf WinActive($mainWindow) Then
			If GUICtrlRead($dockLeftButton) = " " Then
				If $currentLooperPos[0] <> ($currentMPCPos[0] - $currentLooperPos[2]) Then
					WinMove(Hwnd($ghnd_MPC_handle), "", ($currentLooperPos[0] + $currentLooperPos[2]) - 11, $currentLooperPos[1])
				EndIf
			ElseIf GUICtrlRead($dockRightButton) = " " Then
				If $currentLooperPos[0] <> ($currentMPCPos[0] + $currentMPCPos[2]) Then
					WinMove(Hwnd($ghnd_MPC_handle), "", ($currentLooperPos[0] - $currentMPCPos[2]) + 11, $currentLooperPos[1])
				EndIf
			EndIf
		EndIf
	Else
		; don't do anything additional
	EndIf
EndFunc

