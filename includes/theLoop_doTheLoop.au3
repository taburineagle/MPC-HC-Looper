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

		If GUICtrlRead($loopButton) = "Playlist Mode" Then
			_GUICtrlListView_SetItemSelected($eventList, -1, false, false) ; clears any selection to force Playlist mode to continue
		EndIf

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
						__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, (TimeStringToNumber($currentInPoint))) ; set it to the IN point, a.k.a. LOOP IT
					ElseIf GUICtrlRead($loopButton) = "Playlist Mode" Then
						If $loopRepeats[1] < $loopRepeats[0] Then
							__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, (TimeStringToNumber($currentInPoint))) ; set it to the IN point, a.k.a. LOOP IT

							If $loopRepeats[0] <> 0 Then
								$loopRepeats[1] = $loopRepeats[1] + 1
							EndIf
						Else
							loadPrevNextEvent(1) ; if the count of loops is over, then go to the next event
						EndIf
					ElseIf GUICtrlRead($loopButton) = "Shuffle Mode" Then
						If $loopRepeats[1] < $loopRepeats[0] Then
							__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, (TimeStringToNumber($currentInPoint))) ; set it to the IN point, a.k.a. LOOP IT

							If $loopRepeats[0] <> 0 Then
								$loopRepeats[1] = $loopRepeats[1] + 1
							EndIf
						Else
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
					EndIf

					$trimmingOut = 0 ; go back to playing normally (no longer trimming)
				EndIf
			EndIf
		EndIf
	Else ; LOOP is turned off
		; Don't do any looping
	EndIf
EndFunc