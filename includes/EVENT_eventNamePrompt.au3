Func eventNamePrompt($textToInsert = "")
	Opt("GUIOnEventMode",0)

	$eventDialogWindow = GUICreate("Loop event name", 338, 91, -1, -1)

	If $textToInsert = "" Then
		$eventHappenedLabel = GUICtrlCreateLabel("What do you want to name this event?", 8, 4, 323, 21, $SS_CENTER)
		If $currentSpeed <> 100 Then
			$eventNameTF = GUICtrlCreateEdit("<S:" & $currentSpeed & ">", 8, 26, 321, 22, $ES_AUTOVSCROLL)
		Else
			$eventNameTF = GUICtrlCreateEdit("", 8, 26, 321, 22, $ES_AUTOVSCROLL)
		EndIf
	Else
		$eventHappenedLabel = GUICtrlCreateLabel("What do you want to re-name this event?", 8, 4, 323, 21, $SS_CENTER)

		$speedSetting = checkNameSpeedSetting($textToInsert)

		If $speedSetting <> 0 Then
			$theOffset = StringInStr($textToInsert, ">")
			$textToInsert = StringTrimLeft($textToInsert, $theOffset)
		EndIf

		If $currentSpeed <> 100 Then
			$eventNameTF = GUICtrlCreateEdit("<S:" & $currentSpeed & ">" & $textToInsert, 8, 26, 321, 22, $ES_AUTOVSCROLL)
		Else
			$eventNameTF = GUICtrlCreateEdit($textToInsert, 8, 26, 321, 22, $ES_AUTOVSCROLL)
		EndIf
	EndIf

	GUICtrlSetFont($eventHappenedLabel, 10, 400, 0, "Segoe UI")
	GUICtrlSetFont($eventNameTF, 10, 400, 0, "Segoe UI")

	$eventDialogOKButton = GUICtrlCreateButton("OK", 8, 56, 158, 25)
	GUICtrlSetFont(-1, 10, 800, 0, "Segoe UI")
	$eventDialogCancelButton = GUICtrlCreateButton("Cancel", 172, 56, 158, 25)
	GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")

	Dim $eventDialogWindow_AccelTable[2][2] = [["{ENTER}", $eventDialogOKButton],["{ESC}", $eventDialogCancelButton]]
	GUISetAccelerators($eventDialogWindow_AccelTable)

	GUISetState(@SW_SHOW)

	_WinAPI_SetFocus(ControlGetHandle($eventDialogWindow, "", $eventNameTF))
	WinSetOnTop($eventDialogWindow, "", 1)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $eventDialogCancelButton
				$textReturned = ""
				GUIDelete($eventDialogWindow)
				ExitLoop
			Case $eventDialogOKButton
				If GUICtrlRead($eventNameTF) = "" Then
					$textReturned = "New Loop Event"
				ElseIf GUICtrlRead($eventNameTF) = "<S:" & $currentSpeed & ">" Then
					$textReturned = "<S:" & $currentSpeed & ">" & "New Loop Event"
				Else
					$textReturned = GUICtrlRead($eventNameTF)
				EndIf

				GUIDelete($eventDialogWindow)
				ExitLoop
		EndSwitch
	WEnd

	Opt("GUIOnEventMode",1)
	Return $textReturned
EndFunc