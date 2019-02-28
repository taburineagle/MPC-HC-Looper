Func displayError($errorMode)
	If $errorMode = "Playlist Mode" Then
		$errorTitle = "Can't switch to Playlist Mode (CTRL-3)... yet"
		$errorMsg = "You can't switch to Playlist Mode unless you have at least one" & @CRLF & "event in the events list."
	ElseIf $errorMode = "Shuffle Mode" Then
		$errorTitle = "Can't switch to Shuffle Mode (CTRL-4)... yet"
		$errorMsg = "You can't switch to Shuffle Mode unless you have 2 or more events" & @CRLF & "in the events list." & @CRLF & @CRLF & "Looper automatically switches back to Loop Mode if you have" & @CRLF & "only one event in the events list, or if the events list is empty." & @CRLF & @CRLF & "NOTE!  If you don't force Loop mode on opening .looper files," & @CRLF & "and you loaded a new file with only one event, Looper will jump" & @CRLF & "back to Loop Mode because you have less than two events" & @CRLF & "in the events list."
	EndIf

	Local $mWCoords = WinGetPos($mainWindow)
	Local $coords = ControlGetPos($mainWindow, "", $loopButton)

	For $p = 0 to 1
		$coords[$p] = (Int($mWCoords[$p]) + Int($coords[$p])) + 25
	Next

	$coords[1] = Int($coords[1]) + (Int($coords[3]) / 2)

	ToolTip($errorMsg, $coords[0], $coords[1], $errorTitle, 2, 1)

	$displayTimer = 1
	$displayMessage = 2
EndFunc