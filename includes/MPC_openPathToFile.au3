Func openPathtoFile()
	If IsArray($nowPlayingInfo) = 1 Then
		If $nowPlayingInfo[4] <> "" Then
			Run("explorer.exe /n,/e,/select," & $nowPlayingInfo[4])
		EndIf
	EndIf
EndFunc