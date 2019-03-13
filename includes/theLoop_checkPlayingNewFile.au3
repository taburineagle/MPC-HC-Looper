Func checkPlayingNewFile()
	If IsArray($nowPlayingInfo) = 1 Then
		If $currentLoadedFile = "" Or $currentLoadedFile <> $nowPlayingInfo[4] Then
			clearInOutPoint()

			If GUICtrlRead($loopButton) = "Playlist Mode" Or GUICtrlRead($loopButton) = "Shuffle Mode" Then
				switchToLoop() ; if we're in Playlist or Shuffle modes, switch Looper back to Loop Mode if we load a new file
			EndIf

			setSpeed(100)
			$currentLoadedFile = $nowPlayingInfo[4]
		EndIf
	EndIf
EndFunc