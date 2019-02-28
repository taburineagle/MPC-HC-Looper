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