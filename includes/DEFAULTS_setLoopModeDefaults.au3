Func setLoopModeDefaults()
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
EndFunc