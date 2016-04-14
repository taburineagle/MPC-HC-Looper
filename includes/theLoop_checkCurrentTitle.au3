Func checkCurrentTitle()
	If $currentLooperFile <> "" Then ; adjust the window title if there's a file loaded, or if it's been changed
		If $isModified = 0 Then
			If WinGetTitle($mainWindow) <> $windowTitle & " - " & looperTitle() Then
				WinSetTitle($mainWindow, "", $windowTitle & " - " & looperTitle())
			EndIf
		Else ; file has been modified, so add (*) to the title to let you know that
			If WinGetTitle($mainWindow) <> $windowTitle & " - " & looperTitle() & " (*)" Then
				WinSetTitle($mainWindow, "", $windowTitle & " - " & looperTitle() & " (*)")
			EndIf
		EndIf
	Else
		If $isModified = 0 Then
			If WinGetTitle($mainWindow) <> $windowTitle & " - Untitled" Then
				WinSetTitle($mainWindow, "", $windowTitle & " - Untitled")
			EndIf
		Else ; file has been modified, so add (*) to the title to let you know that
			If WinGetTitle($mainWindow) <> $windowTitle & " - Untitled (*)" Then
				WinSetTitle($mainWindow, "", $windowTitle & " - Untitled (*)")
			EndIf
		EndIf
	EndIf
EndFunc