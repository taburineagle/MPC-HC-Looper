Func checkPlayingNewFile()
	If IsArray($nowPlayingInfo) = 1 Then
		If $currentLoadedFile = "" Or $currentLoadedFile <> $nowPlayingInfo[4] Then
			clearInOutPoint()
			setSpeed(100)
			$currentLoadedFile = $nowPlayingInfo[4]
		EndIf
	EndIf
EndFunc