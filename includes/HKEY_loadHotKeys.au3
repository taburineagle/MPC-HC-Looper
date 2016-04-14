Func loadHotKeys($loadOrCancel) ; load or cancel the hotkeys
	For $i = 0 To (UBound($HotkeyList) - 1)
		If $loadOrCancel = 1 Then
			HotKeySet($HotkeyList[$i], "hotKeyPressed") ; load each hotkey into it's event handler
			$hotKeysActive = True

			If GUICtrlRead($HotKeyStatusTF) <> "HOTKEYS ON" Then
				GUICtrlSetData($HotKeyStatusTF, "HOTKEYS ON")
				GUICtrlSetColor($HotKeyStatusTF, $COLOR_GREEN)
			EndIf
		Else
			HotKeySet($HotkeyList[$i]) ; clear each hotkey from it's event handler (so it doesn't funk up typing)
			$hotKeysActive = False

			If GUICtrlRead($HotKeyStatusTF) <> "HOTKEYS OFF" Then
				GUICtrlSetData($HotKeyStatusTF, "HOTKEYS OFF")
				GUICtrlSetColor($HotKeyStatusTF, $COLOR_RED)
			EndIf
		EndIf
	Next
EndFunc