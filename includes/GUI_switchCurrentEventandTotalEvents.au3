Func switchCurrentEventandTotalEvents()
	If $displayMessage = 0 Then
		$displayTimer = 1 ; set the display timer to 1 tick (to start it during the main loop ticking up to 100)
		$displayMessage = 1 ; set the type of display to 1 (this shows the total tally of events in the event list)
	Else
		$displayTimer = 0 ; set the display timer to 0 tick (to cancel the timer altogether)
		$displayMessage = 0 ; set the type of display to 0 (this goes back to the normal "Playing 1 of..." status text)
	EndIf
EndFunc