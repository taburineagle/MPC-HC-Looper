Func maximizeWindow() ; maximize the window to 3 defined sizes
	$windowDim = WinGetPos($mainWindow)

	If $windowDim[3] = $minHeight Then
		WinMove($mainWindow, "", Default, Default, Default, (@DesktopHeight / 2))
	ElseIf $windowDim[3] = $maxHeight Then
		WinMove($mainWindow, "", Default, Default, Default, $minHeight)
	Else
		WinMove($mainWindow, "", Default, Default, Default, $maxHeight)
	EndIf
EndFunc