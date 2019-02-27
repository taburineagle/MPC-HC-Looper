Func checkPlayingNewFile()
	If IsArray($nowPlayingInfo) = 1 Then
		If $currentLoadedFile = "" Or $currentLoadedFile <> $nowPlayingInfo[4] Then
			clearInOutPoint()
			switchToLoop()
			setSpeed(100)
			$currentLoadedFile = $nowPlayingInfo[4]
		EndIf
	EndIf
EndFunc