Func loadHotKeys($loadOrCancel) ; load or cancel the hotkeys
	If $loadOrCancel = 1 Then
		For $i = 0 To (UBound($HotkeyList) - 1)
			HotKeySet($HotkeyList[$i], "hotKeyPressed") ; load each hotkey into it's event handler
		Next

		$hotKeysActive = True

		If GUICtrlRead($HotKeyStatusTF) <> "HOTKEYS ON" Then
			GUICtrlSetData($HotKeyStatusTF, "HOTKEYS ON")
			GUICtrlSetColor($HotKeyStatusTF, $COLOR_GREEN)
		EndIf
	Else
		For $i = 0 To (UBound($HotkeyList) - 1)
			HotKeySet($HotkeyList[$i]) ; clear each hotkey from it's event handler (so it doesn't funk up typing)
		Next

		If _WinAPI_GetFocus() = GUICtrlGetHandle($searchEventTF) Then
			HotKeySet("{Enter}", "searchEventList") ; make ENTER the hotkey to send a command from the search bar
			$inSearchMode = 1 ; turn search mode on
		EndIf

		$hotKeysActive = False

		If GUICtrlRead($HotKeyStatusTF) <> "HOTKEYS OFF" Then
			GUICtrlSetData($HotKeyStatusTF, "HOTKEYS OFF")
			GUICtrlSetColor($HotKeyStatusTF, $COLOR_RED)
		EndIf
	EndIf
EndFunc