Func modifyEventPrompt() ; modify an event in the event list
	If GUICtrlRead($listModifyButton) = "Modify Event" Then
		If $currentlySearching = 2 Then
			$currentItem = $searchResultsList[$currentPlayingEvent]
			$currentPlayingEvent = Int(StringLeft($currentItem, StringInStr($currentItem, "|"))) - 1
		EndIf

		searchEventListRestore()
		initializeEventChange($GUI_DISABLE)

		$currentEvent = _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 0) ; the current position of this event in the list
		$currentName = _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 1) ; the current name of this event in the list
		$currentName = eventNamePrompt($currentName)

		If $currentName <> "" Then
			$inPoint = GUICtrlRead($inTF)
			$outPoint = GUICtrlRead($outTF)

			$currentFile = $nowPlayingInfo[Ubound($nowPlayingInfo) - 2]

			modifyEvent($currentPlayingEvent, $currentEvent, $currentName, $inPoint, $outPoint, $currentFile, $currentPlayingEvent, $currentPlayingEvent)
		EndIf

		initializeEventChange($GUI_ENABLE)
	Else
		$currentlySelected = _GUICtrlListView_GetSelectedIndices($eventList, 1)

		If $currentlySelected[0] <> 0 Then
			$newINPoint =  _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 2)
			$newOUTPoint = _GUICtrlListView_GetItemText($eventList, $currentlySelected[UBound($currentlySelected) - 1], 3)

			$goodToCombine = 0 ; checks to see if the items you want to combine are correct - if less than 3, then we can't combine
			$errorString = "" ; error string to output related to errors happening below...

			If $currentlySelected[UBound($currentlySelected) - 1] - ($currentlySelected[0] - 1) = $currentlySelected[1] Then
				$goodToCombine = $goodToCombine + 1
			Else
				$errorString = $errorString & "You can't merge staggered events from the events list - to merge events, they all need to come from the same series (for example, 1 through 3 would work, as would 5 through 8 - but not 1-3, then 5 and 8 individually)."
			EndIf

			If getEventDur($newINPoint, $newOUTPoint) <> 0 Then ; something went wrong with the duration (IN is later than OUT)
				$goodToCombine = $goodToCombine + 1
			Else
				If $errorString <> "" Then
					$errorString = $errorString & @CRLF & @CRLF & "Also, "; if the error string is not blank (we have errors above), we need to add a break to it
				EndIf

				$errorString = $errorString & "The IN Point of the first event (" & $newINPoint & ") is later than the last event's OUT point (" & $newOUTPoint & ").  You can't combine events that have an IN point set later than the OUT point."
			EndIf

			; FILE CHECK PROCEDURE GOES HERE, FOR THE 3rd $goodToCombine CHECK SERIES
			$goodToCombine = $goodToCombine + 1 ; for now, we're just going to set it to successful

			If $goodToCombine = 3 Then
				$newName = "[Events " ; Beginning...

				If _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 0) = "▶" Then
					$newName = $newName & $currentPlayingEventPos ; if the first item is in the currently playing selection, get the original # of it in the list
				Else
					$newName = $newName &  _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 0)
				EndIf

				$newName = $newName & "-" ; ...middle, and...

				If _GUICtrlListView_GetItemText($eventList, $currentlySelected[UBound($currentlySelected) - 1], 0) = "▶" Then
					$newName = $newName & $currentPlayingEventPos ; if the last item is in the currently playing selection, get the original # of it in the list
				Else
					$newName = $newName & _GUICtrlListView_GetItemText($eventList, $currentlySelected[UBound($currentlySelected) - 1], 0)
				EndIf

				$newName = $newName & "]" ; ...end

				$newDur = NumberToTimeString(getEventDur($newINPoint, $newOUTPoint))
				$currentFile = _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 5)

				; It IS possible to get an OUT that's earlier than an IN - error code here should handle this
				; possibly check $newDur (because if this is the case, the duration would be 0)

				; If $newDur = "0:00.00" Then

				; as well as a detection that EVERY item in the selection is the same file - otherwise, DANGER AHEAD!

				$combineEvents = MsgBox(4, "Merge events?", "Are you sure you want to merge these " & $currentlySelected[0] & " events into one event?" & @CRLF & @CRLF & _
				"New Name: " & $newName & @CRLF & @CRLF & _
				"New IN Point: " & $newINPoint & @CRLF & _
				"New OUT Point: " & $newOUTPoint & @CRLF & @CRLF & _
				"New Duration: " & $newDur)

				If $combineEvents = 6 Then ; you clicked on "Yes" to combining files
					;          The current event's ID  The event's proper order in the event list (the leftmost column)    Name      IN Point     Out Point     Filename      Event to start delete  Event to stop delete (the last item of the array)
					modifyEvent($currentlySelected[1], _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 0), $newName, $newINPoint, $newOUTPoint, $currentFile, $currentlySelected[1], $currentlySelected[UBound($currentlySelected) -1])
					GUICtrlSetData($listModifyButton, "Modify Event")
				EndIf
			Else
				__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause

				MsgBox(262144 + 16, "Merging Error!", $errorString)

				If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
					__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to play
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc