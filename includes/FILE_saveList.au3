Func saveList() ; save the current events list to a .looper file
	$numOfEvents = getItemCount() ; how many events are in the event list, used to make sure there are some there (you can't save if there aren't any events)

	If $numOfEvents > 0 Then
		If $isModified = 1 Then
			__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause

			loadHotKeys(0) ; disable hotkeys so they don't fotz up typing

			$currentSaveFile = ""

			If $currentlySearching <> 0 Then
				$savePartial = MsgBox(262144 + 4, "Save file - Save partial list?", "You are currently in search mode - in search mode, you can save a partial list of events (the events listed in the search), or you can choose to save the entire list of events (including those outside of the current search)..." & @CRLF & @CRLF & "To save just the partial list (the events currently shown in the search), choose YES" & @CRLF & "To clear the search results and save the entire events list, choose NO")

				If $savePartial = "6" Then
					; don't do anything
				Else
					searchEventListRestore() ; restore the list and set $currentlySearching to 0, so it'll be seen in the next step
					Sleep(1000)
				EndIf
			EndIf

			If $currentlySearching = 0 Then
				If $currentLooperFile <> "" Then
					$saveOldFile = MsgBox(262144 + 4, "Overwrite file", "Do you want to overwrite the current .looper file?")

					If $saveOldFile = "6" Then
						$currentSaveFile = $currentLooperFile
					EndIf
				EndIf
			EndIf

			If $currentSaveFile = "" Then
				If $currentlySearching = 0 Then
					$currentSaveFile = FileSaveDialog("Where do you want to save the loop events file?", @DesktopDir, "MPC-HC Looper Events File (*.looper)", 16, ".looper")
				Else
					$currentSaveFile = FileSaveDialog("Where do you want to save the partial loop events file?", @DesktopDir, "MPC-HC Looper Events File (*.looper)", 16, ".looper")
				EndIf

				If $currentSaveFile <> "" Then ; if the filename STILL hasn't been chosen, then...
					If StringLen($currentSaveFile) > 7 Then
						$isLooper = StringTrimLeft($currentSaveFile, StringLen($currentSaveFile) - 7)
					Else
						$isLooper = ""
					EndIf

					If $isLooper <> ".looper" Then
						$currentSaveFile = $currentSaveFile & ".looper"
					Else
						; file is already a .looper file, so don't change the name
					EndIf
				EndIf
			EndIf

			If $currentSaveFile <> "" Then ; you didn't cancel the saving process
				$writingFile = FileOpen($currentSaveFile, 34)

				$numOfEvents = getItemCount() ; once again get the count of items in the list, this time for actual saving purposes

				For $i = 0 To $numOfEvents - 1
					$writingLine = _GUICtrlListView_GetItemText($eventList, $i, 1) & "|"
					$writingLine = $writingLine & _GUICtrlListView_GetItemText($eventList, $i, 2) & "|"
					$writingLine = $writingLine & _GUICtrlListView_GetItemText($eventList, $i, 3) & "|"
					$writingLine = $writingLine & _GUICtrlListView_GetItemText($eventList, $i, 5)

					FileWriteLine($writingFile, $writingLine)
				Next

				FileClose($writingFile)

				setModified(0)
				$currentLooperFile = $currentSaveFile
			EndIf

			loadHotKeys(1) ; re-enable hotkeys

			If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
				__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to pause
			EndIf

			Return $currentSaveFile
		EndIf
	EndIf
EndFunc