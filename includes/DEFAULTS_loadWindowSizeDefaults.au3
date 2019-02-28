Func loadWindowSizeDefaults()
	$startPositionW = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionW", "404") ; initial width - 404 for total size (+14)
	$startPositionH = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionH", "552") ; initial height ; 540 for total size (+14)
	$startPositionL = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", (@DesktopWidth - (429 + 30))) ; initial left value (position on screen)
	$startPositionT = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionT", "11") ; initial top value (position on screen)

	WinMove($mainWindow, "", $startPositionL, $startPositionT, $startPositionW, $startPositionH)
EndFunc