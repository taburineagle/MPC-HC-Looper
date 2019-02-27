Func clickLoopButton() ; change the button behavior when you click on the Loop/Playlist Mode button
	loadHotkeys(0)

	Local $hDLL = DllOpen("user32.dll")

	If _IsPressed("02", $hDLL) Then ; if you have the right and left buttons clicked
		switchToShuffle() ; switch to/from shuffle mode
	Else
		Switch GUICtrlRead($loopButton)
			Case "Loop Mode"
				If getItemCount() > 0 Then
					switchToPlaylist()
				Else
					switchToOff()
				EndIf
			Case "Playlist Mode"
				switchToOff()
			Case "Shuffle Mode"
				switchToLoop()
			Case "OFF"
				switchToLoop()
		EndSwitch
	EndIf

	DllClose($hDLL) ; close the DLL that checks if both of the mouse buttons are clicked

	Sleep(200)
	loadHotkeys(1)
EndFunc

Func switchToLoop()
	GUICtrlSetData($loopButton, "Loop Mode")
	GUICtrlSetBkColor($loopButton, 0xb0f6b0)
	switchEditingControls($GUI_ENABLE)
	clearRandomization() ; clear any randomized lists (if they exist)
	$loopRepeats[1] = 1 ; set this to 1 to reset the count of loops (if we switch from Playlist/Random to Loop Mode)
EndFunc

Func switchToPlaylist()
	If getItemCount() > 0 Then ; if there are items in the playlist to play one after another, then switch to Playlist mode
		GUICtrlSetData($loopButton, "Playlist Mode")
		GUICtrlSetBkColor($loopButton, 0xffa882)
		switchEditingControls($GUI_DISABLE)
		clearRandomization()
	Else
		displayError("Playlist Mode")
		switchToLoop() ; if the event list is empty, just switch to OFF mode
	EndIf
EndFunc

Func switchToShuffle()
	If getItemCount() > 1 Then ; if there are items in the playlist to shuffle
		If GUICtrlRead($loopButton) <> "Shuffle Mode" Then ; switch to shuffle mode
			GUICtrlSetData($loopButton, "Shuffle Mode")
			GUICtrlSetBkColor($loopButton, 0x85e7f0)
			switchEditingControls($GUI_DISABLE)
			createRandomList()
		Else
			switchToLoop() ; if the button already says "Shuffle Mode", then just switch to Loop mode on the current loop item
		EndIf
	Else
		switchToLoop()
		displayError("Shuffle Mode")
	EndIf
EndFunc

Func switchToOff()
	GUICtrlSetData($loopButton, "OFF")
	GUICtrlSetBkColor($loopButton, 0xFFFFE1)
	switchEditingControls($GUI_ENABLE)
	clearRandomization()
EndFunc

Func clearRandomization()
	If UBound($randomPlayOrder) > 0 Then ; if the random playlist array has any items
		_ArrayDelete($randomPlayOrder, "0-" & UBound($randomPlayOrder) - 1) ; deletes every item in the random playlist array to save memory
	EndIf
EndFunc

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