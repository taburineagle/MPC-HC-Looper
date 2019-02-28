Func Uninitialize() ; close the MPC Looper window and quit, asking if you want to save
	If getItemCount() = 0 Then
		writeCurrentlyPlayingFile() ; If nothing has changed in the playlist, quit anyway
;~ 		Exit
	EndIf

	If $tryingToQuit = 0 Then
		$tryingToQuit = 1
		__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause
		loadHotKeys(0) ; disable hotkeys so they don't fotz up typing

		If $MPCInitialized <> 0 Then
			$isQuitting = MsgBox(262144 + 52, "Quitting?", "Do you want to quit Media Player Classic Looper?")
		Else
			$isQuitting = "6" ; don't ask, MPC-HC closed, so we're quitting, regardless...
		EndIf

		If $isQuitting = "6" Then
			If $isModified = 1 Then
				$saveState = askForSave("Do you want to save before quitting?")

				 ; If $saveState returned either a name (successful saving) or -1 (you chose not to save), then we're good to quit
				If ($saveState <> "") Or ($saveState = -1) Then
					writeCurrentlyPlayingFile()
				Else
					If $MPCInitialized <> 0 Then
						$saveState = MsgBox(262144 + 4, "You did not save", "You chose not to save a new .looper file - do you still want to quit?")
					Else
						$saveState = "6" ; You chose not to save, but MPC-HC is closed, so quit anyway
					EndIf
					If $saveState = "6" Then
						writeCurrentlyPlayingFile()
					Else ; You chose "No" to quitting, so re-initialize everything
						$tryingToQuit = 0
						loadHotKeys(1)
						If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
							__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to pause
						EndIf
					EndIf
				EndIf
			Else
				writeCurrentlyPlayingFile() ; If nothing has changed in the playlist, quit anyway, but save current loop just in case
			EndIf
		Else ; You chose not to quit, so re-initialize everything
			$tryingToQuit = 0
			loadHotKeys(1) ; re-enable hotkeys
			If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
				__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to pause
			EndIf
		EndIf
	EndIf
EndFunc