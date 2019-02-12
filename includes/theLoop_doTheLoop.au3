Func doTheLoop()
	$currentFocus = ControlGetFocus($mainWindow, "")

	If $currentFocus = "Edit3" Then
		loadHotKeys(0) ; if we have the search text field enabled, then disable the hotkeys
	EndIf

	If $isClicked = 1 Then
		switchModifyDelete()
		$isClicked = 0
	ElseIf $isClicked = 2 Then
		$selectedItem = _GUICtrlListView_GetSelectedIndices($eventList, False) ; Get which item is selected
		loadEvent(Number($selectedItem))
		switchModifyDelete()

		If $currentlySearching = 1 Then
			$currentlySearching = 2
		EndIf

		$isClicked = 0
	EndIf

	__MPC_send_message($ghnd_MPC_handle, $CMD_GETCURRENTPOSITION, "") ; gets the current position for this iteration

	If $pastPosition <> $currentPosition Then
		updateTime()
	EndIf

	If GUICtrlRead($loopButton) = "Loop Mode" Or GUICtrlRead($loopButton) = "Playlist Mode" Or _
	GUICtrlRead($loopButton) = "Shuffle Mode" Then ; we have LOOP turned on
		$currentInPoint = TimeStringToNumber(GUICtrlRead($inTF)) - 0.5
		$currentOutPoint = TimeStringToNumber(GUICtrlRead($outTF)) - 0.5

		If $trimmingOut = 1 Then
			$currentOutPoint = $currentOutPoint + ($loopPreviewLength / 4)
		EndIf

		If $currentOutPoint <> "" Then ; there is an OUT point set
			If $currentOutPoint < $currentPosition Then ; the current position is past the OUT point, so...
				If GUICtrlRead($inTF) <> "" Then
					If GUICtrlRead($loopButton) = "Loop Mode" Then
						If $loopRepeats[0] = 0 Or $loopRepeats[1] < $loopRepeats[0] Then
							__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, (TimeStringToNumber($currentInPoint))) ; set it to the IN point, a.k.a. LOOP IT

							If $loopRepeats[0] <> 0 Then
								$loopRepeats[1] = $loopRepeats[1] + 1
							EndIf
						Else
							__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause (if we've reached the amount of loops set in the <L:> setting
						EndIf
					ElseIf GUICtrlRead($loopButton) = "Playlist Mode" Then
						If $loopRepeats[0] = 0 Or $loopRepeats[1] < $loopRepeats[0] Then
							__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, (TimeStringToNumber($currentInPoint))) ; set it to the IN point, a.k.a. LOOP IT

							If $loopRepeats[0] <> 0 Then
								$loopRepeats[1] = $loopRepeats[1] + 1
							EndIf
						Else
							$loopRepeats[0] = 2 ; just here for testing, next loop has 2 repeats
							$loopRepeats[1] = 1 ; also just here for testing, and we're on the first one

							; the above code (setting $loopRepeats) should be done on loadEvent(), not here - once again, just for testing...

							; just a note, move the first part of the loop repeat code outside of the mode conditions (the recue part) so
							; we don't write that piece of code multiple times (that's just wasteful! - and kind of pointless to boot!)
							; and then use the mode conditions for the Else statement (so if it's not a "repeating" event, you can just do
							; the normal behavior, but if it is a "repeating" event, make sure to play the loop for n times, THEN do the
							; normal behavior...)  Also, when skipping from one mode to another, should we reset the count of iterations to 1
							; again (3 plays in Loop mode for a 4-repeat loop, then switch to Playlist mode - should we then say we're in
							; play 4 of that loop, or jump back to 1 for the new mode... I'm thinking one...)

							; ...also, lemur.  Definitely, lemur :)

							loadPrevNextEvent(1) ; if the count of loops is over, then go to the next event
						EndIf
					ElseIf GUICtrlRead($loopButton) = "Shuffle Mode" Then
						$nextEvent = $randomPlayOrder[$randomPlayOrder[UBound($randomPlayOrder) - 1]]
						loadEvent($nextEvent)

						Sleep(200)

						If UBound($randomPlayOrder) <> 0 Then
							If $randomPlayOrder[UBound($randomPlayOrder) - 1] = (getItemCount() - 1) Then
								$randomPlayOrder[UBound($randomPlayOrder) - 1] = 0
							Else
								$randomPlayOrder[UBound($randomPlayOrder) - 1] += 1
							EndIf
						Else
							; the array has been deleted (in another step), so gracefully bow out of that loop
						EndIf
					EndIf

					$trimmingOut = 0 ; go back to playing normally (no longer trimming)
				EndIf
			EndIf
		EndIf
	Else ; LOOP is turned off
		; Don't do any looping
	EndIf
EndFunc