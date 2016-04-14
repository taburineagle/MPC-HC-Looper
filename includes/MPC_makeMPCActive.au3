Func makeMPCActive()
	If WinActive("[CLASS:MediaPlayerClassicW]") = 0 Then
		WinActivate("[CLASS:MediaPlayerClassicW]")
	EndIf
EndFunc