Func setLoopModeDefaults()
	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", 0) = 0 And $currentLooperFile <> "" Then
		switchToLoop()
	Else
		Switch IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "Loop Mode")
			Case "OFF"
				switchToOff()
			Case "Playlist Mode"
				switchToPlaylist()
			Case "Shuffle Mode"
				switchToShuffle()
			Case Else
				switchToLoop()
		EndSwitch
	EndIf
EndFunc