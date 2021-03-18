Func openPathtoFile()
	If IsArray($nowPlayingInfo) = 1 Then
		If $nowPlayingInfo[Ubound($nowPlayingInfo) - 2] <> "" Then
			Run("explorer.exe /n,/e,/select," & $nowPlayingInfo[Ubound($nowPlayingInfo) - 2])
		EndIf
	EndIf
EndFunc