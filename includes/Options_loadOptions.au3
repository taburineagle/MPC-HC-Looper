Func loadOptions() ; load or hide the options pane
	Opt("GUIOnEventMode",0)
	loadHotKeys(0) ; disable hotkeys so they don't fotz up typing
	__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "") ; forces MPC to pause

	$optionsWindow = GUICreate("MPC-HC Looper Options", 411, 528, Default, Default)

	$_NOTE1 = GUICtrlCreateLabel("Preview Time (in seconds)", 8, 8, 166, 21)
	$_NOTE2 = GUICtrlCreateLabel("Slip Amount (in seconds)", 208, 8, 160, 21)
	$prevDelayTF = GUICtrlCreateInput($loopPreviewLength, 8, 32, 193, 25)
	$slipTF = GUICtrlCreateInput($loopSlipLength, 208, 32, 185, 25)

	$_NOTE3 = GUICtrlCreateLabel("Default Settings for new Looper sessions", 8, 64, 257, 21)
	$_DESC1 = GUICtrlCreateLabel("NOTE: To restore any setting below to its default, un-check any of", 8, 88, 372, 21)
	$_DESC2 = GUICtrlCreateLabel("the preference(s) you want to restore below and click Save Prefs", 8, 106, 357, 21)

	$currentDelayCheck = GUICtrlCreateCheckbox(" Save Preview Time as default", 8, 132, 193, 25)
	$currentSlipCheck = GUICtrlCreateCheckbox("Save Slip Amount as default", 208, 132, 177, 25)
	$savePosCheck = GUICtrlCreateCheckbox(" Save current Looper window positions and sizes as default", 8, 160, 361, 17)
	$saveLoopCheck = GUICtrlCreateCheckbox(" Save current Loop Mode button setting as default", 8, 184, 361, 17)
	$saveAOTCheck = GUICtrlCreateCheckbox(" Save current Always on Top button setting as default", 8, 208, 361, 17)
	$saveDockCheck = GUICtrlCreateCheckbox(" Save current Window Docking setting as default", 8, 232, 361, 17)

	$_NOTE4 = GUICtrlCreateLabel("Extra System Options", 8, 256, 136, 21)

	$dontForceLooperModeonOpen = GUICtrlCreateCheckbox(" Keep the current mode setting when opening new files", 8, 281, 361, 17)
	$disableToolTips = GUICtrlCreateCheckbox(" Disable tool tips on the main Looper panel", 8, 305, 361, 17)
	$autoloadCheck = GUICtrlCreateCheckbox(" Auto-load the last open .looper file on Looper launch", 8, 329, 361, 17)
	$allowMICheck = GUICtrlCreateCheckbox(" Allow multiple instances of Looper if MPC-HC allows more", 8, 353, 369, 17)
	$MI_desc_2 = GUICtrlCreateLabel("than one instance (settable in MPC-HC Options)", 32, 370, 281, 21)
	$autoPlayDialogsCheck = GUICtrlCreateCheckbox(" Disable auto-playing after exiting Looper dialogs", 8, 394, 305, 17)
	$autoPlayCheck = GUICtrlCreateCheckbox(" Disable auto-playing first event when opening new .looper file", 8, 418, 393, 17)
	$pauseOnEventCheck = GUICtrlCreateCheckbox(" Force MPC-HC to pause when loading events", 8, 442, 393, 17)
	$askConfCheck = GUICtrlCreateCheckbox(" Disable re-open confirmation when closing MPC-HC on its own", 8, 466, 393, 17)

	$looperAssociateButton = GUICtrlCreateButton("Associate .looper files", 8, 492, 175, 25)
	$optionsCancelButton = GUICtrlCreateButton("Cancel", 192, 492, 91, 25)
	$optionsSaveButton = GUICtrlCreateButton("Save Prefs", 288, 492, 107, 25)

	Dim $optionsWindow_AccelTable[2][2] = [["{ENTER}", $optionsSaveButton],["{ESC}", $optionsCancelButton]]
	GUISetAccelerators($optionsWindow_AccelTable)

	#include 'custom\OptionFonts.au3' ; Sets font styles for the options pane
	#include 'custom\Option-tooltips.au3' ; Adds tooltips to each of the buttons in the option pane of MPC-HC Looper

	Local $entrySettings[14]
	$entrySettings[0] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "")
	$entrySettings[1] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "")
	$entrySettings[2] = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", "")
	$entrySettings[3] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "")
	$entrySettings[4] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", "")
	$entrySettings[5] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "")
	$entrySettings[6] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "")
	$entrySettings[7] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "")
	$entrySettings[8] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", "")
	$entrySettings[9] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "")
	$entrySettings[10] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "")
	$entrySettings[11] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "")
	$entrySettings[12] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", "")
	$entrySettings[13] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "pausePlaybackOnLoadEvent", "")

	If $entrySettings[0] <> "" Then GUICtrlSetState($currentDelayCheck, $GUI_CHECKED)
	If $entrySettings[1] <> "" Then GUICtrlSetState($currentSlipCheck, $GUI_CHECKED)
	If $entrySettings[2] <> "" Then GUICtrlSetState($savePosCheck, $GUI_CHECKED)
	If $entrySettings[3] <> "" Then GUICtrlSetState($saveLoopCheck, $GUI_CHECKED)
	If $entrySettings[4] <> "" Then GUICtrlSetState($saveAOTCheck, $GUI_CHECKED)
	If $entrySettings[5] <> "" Then GUICtrlSetState($saveDockCheck, $GUI_CHECKED)
	If $entrySettings[6] <> "" Then GUICtrlSetState($autoloadCheck, $GUI_CHECKED)
	If $entrySettings[7] <> "" Then GUICtrlSetState($autoPlayCheck, $GUI_CHECKED)
	If $entrySettings[8] <> "" Then GUICtrlSetState($allowMICheck, $GUI_CHECKED)
	If $entrySettings[9] <> "" Then GUICtrlSetState($autoPlayDialogsCheck, $GUI_CHECKED)
	If $entrySettings[10] <> "" Then GUICtrlSetState($askConfCheck, $GUI_CHECKED)
	If $entrySettings[11] <> "" Then GUICtrlSetState($disableToolTips, $GUI_CHECKED)
	If $entrySettings[12] <> "" Then GUICtrlSetState($dontForceLooperModeonOpen, $GUI_CHECKED)
	If $entrySettings[13] <> "" Then GUICtrlSetState($pauseOnEventCheck, $GUI_CHECKED)

	GUISetState(@SW_SHOW)
	WinSetOnTop($optionsWindow, "", 1)
	WinActivate($optionsWindow)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $optionsCancelButton
				GUIDelete($optionsWindow)
				ExitLoop
			Case $optionsSaveButton
				$currentSavedDialog = ""

				If isAcceptableNumber(GUICtrlRead($prevDelayTF)) and isAcceptableNumber(GUICtrlRead($slipTF)) Then
					If $loopPreviewLength <> Number(GUICtrlRead($prevDelayTF)) Or $loopSlipLength <> Number(GUICtrlRead($slipTF)) Then
						$currentSavedDialog = $currentSavedDialog & "You've made the following changes to the current Looper session:"  & @CRLF

						If $loopPreviewLength <> Number(GUICtrlRead($prevDelayTF)) Then
							$currentSavedDialog = $currentSavedDialog & "- You changed the Preview Time from " & $loopPreviewLength & " to " & Number(GUICtrlRead($prevDelayTF)) & @CRLF
							$loopPreviewLength = Number(GUICtrlRead($prevDelayTF))
						EndIf

						If $loopSlipLength <> Number(GUICtrlRead($slipTF)) Then
							$currentSavedDialog = $currentSavedDialog & "- You changed the Slip Time from " & $loopSlipLength & " to " & Number(GUICtrlRead($slipTF)) & @CRLF
							$loopSlipLength = Number(GUICtrlRead($slipTF))
						EndIf

						$currentSavedDialog = $currentSavedDialog & @CRLF
					EndIf
				Else ; if we get invalid values for either of the top 2 fields, show an error...
					$errorString = "Invalid values entered for these fields:" & @CRLF & @CRLF

					If Not isAcceptableNumber(GUICtrlRead($prevDelayTF)) Then
						$errorString = $errorString & " - Preview Time (in Seconds)" & @CRLF
					EndIf

					If Not isAcceptableNumber(GUICtrlRead($slipTF)) Then
						$errorString = $errorString & " - Slip Amount (in Seconds)" & @CRLF
					EndIf

					$errorString = $errorString & @CRLF & "Please only enter valid numbers in the Preview Time and Slip Amount fields (at the top of the Options panel), or the new values won't be saved."
					MsgBox(262144 + 16, "Invalid Number Error!", $errorString)
				EndIf

				$currentSavedDialog = $currentSavedDialog & "You've made the following changes to the default settings:" & @CRLF

				If GUICtrlRead($currentDelayCheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", $loopPreviewLength)

					If $entrySettings[0] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Current Preview Time" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength")

					If $entrySettings[0] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Preview Time" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($currentSlipCheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", $loopSlipLength)

					If $entrySettings[1] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Current Slip Time" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength")

					If $entrySettings[1] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Slip Time" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($savePosCheck) = 1 Then
					$currentWndSize = WinGetPos($mainWindow, "")
					IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", $currentWndSize[0])
					IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionT", $currentWndSize[1])
					IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionW", $currentWndSize[2])
					IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionH", $currentWndSize[3])

					If $entrySettings[2] <> IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Current Looper window positions and size" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "StartPos")

					If $entrySettings[2] <> IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Looper window positions and size" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($saveLoopCheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", GUICtrlRead($loopButton))

					If $entrySettings[3] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Current Loop Mode button setting" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode")

					If $entrySettings[3] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Loop Mode button setting" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($saveAOTCheck) = 1 Then
					If GUICtrlRead($onTopButton) = "Always on Top" Then
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", 1)
					Else
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", 0)
					EndIf

					If $entrySettings[4] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Current Always on Top button setting" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop")

					If $entrySettings[4] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Always on Top button setting" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($saveDockCheck) = 1 Then
					If GUICtrlRead($dockLeftButton) = " " Then
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "Left")
					ElseIf GUICtrlRead($dockRightButton) = " " Then
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "Right")
					Else
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "OFF")
					EndIf

					If $entrySettings[5] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Current Window Docking setting" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode")

					If $entrySettings[5] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Window Docking setting" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($dontForceLooperModeonOpen) = 1 Then
					If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", "") <> 1 Then
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", 1) ; if its nothing, then set the pref
					EndIf

					If $entrySettings[12] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Keep the current mode setting (don't force Loop Mode) when opening new files" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen")

					If $entrySettings[12] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dontForceLooperModeonOpen", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Keep the current mode setting (don't force Loop Mode) when opening new files" & @CRLF
					EndIf
				EndIf


				If GUICtrlRead($disableToolTips) = 1 Then
					If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "") <> 1 Then
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", 1) ; if its nothing, then set the pref
					EndIf

					If $entrySettings[11] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Disable tool tips on the main Looper panel" & @CRLF
					EndIf

					loadToolTips(0)
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips") ; delete the tool tips pref

					If $entrySettings[11] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable tool tips on the main Looper panel" & @CRLF
					EndIf

					loadToolTips(1)
				EndIf

				If GUICtrlRead($autoloadCheck) = 1 Then
					If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "") = "" Then
						IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", 1) ; if its nothing, then set the pref
					EndIf

					If $entrySettings[6] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Auto-load the last open .looper file when launching" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper")

					If $entrySettings[6] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Auto-load the last open .looper file when launching" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($allowMICheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", 1)

					If $entrySettings[8] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Allowing/Denying Multiple instances" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances")

					If $entrySettings[8] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Allowing/Denying Multiple instances" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($autoPlayDialogsCheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", 1)

					If $entrySettings[9] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Disable auto-play after exiting Looper dialogs" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs")

					If $entrySettings[9] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable auto-play after exiting Looper dialogs" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($autoPlayCheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", 1)

					If $entrySettings[7] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Disable auto-playing first event when opening new .looper file" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent")

					If $entrySettings[7] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable auto-playing first event when opening new .looper file" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($pauseOnEventCheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "pausePlaybackOnLoadEvent", 1)

					If $entrySettings[13] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "pausePlaybackOnLoadEvent", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Force MPC-HC to pause when loading events" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "pausePlaybackOnLoadEvent")

					If $entrySettings[13] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "pausePlaybackOnLoadEvent", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Force MPC-HC to pause when loading events" & @CRLF
					EndIf
				EndIf

				If GUICtrlRead($askConfCheck) = 1 Then
					IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", 1)

					If $entrySettings[10] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "") Then
						$currentSavedDialog = $currentSavedDialog & "SAVED - Disable re-open confirmation when closing MPC-HC on its own" & @CRLF
					EndIf
				Else
					IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm")

					If $entrySettings[10] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "") Then
						$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable re-open confirmation when closing MPC-HC on its own" & @CRLF
					EndIf
				EndIf

				WinSetOnTop($optionsWindow, "", 0)

				If $currentSavedDialog = "You've made the following changes to the default settings:" & @CRLF Then
					MsgBox(0, "Heads-up!", "You haven't made any changes to any of the settings...")
				Else
					MsgBox(0, "Saved settings!", $currentSavedDialog)
				EndIf

				GUIDelete($optionsWindow)
				ExitLoop
			Case $looperAssociateButton
				$associateFiles = MsgBox(262144 + 36, "Associate file extensions?", "Do you want to associate (or re-associate, if already associated before) .looper files with MPC-HC Looper?" & @CRLF & @CRLF & "(this lets you double click on .looper files to open them with MPC-HC Looper)")

				If $associateFiles = "6" Then
					_ShellFile_Install('MPC-HC Looper Events File', 'looper', Default, Default, Default, -201) ; Add the running EXE to the Shell ContextMenu.

					If @error Then
						MsgBox(262144 + 0, "Error!", ".looper files not successfully associated with Windows Explorer")
					Else
						MsgBox(262144 + 0, "Success!", ".looper files are successfully associated with Windows Explorer")
					EndIf
				EndIf
		EndSwitch
	WEnd

	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
		__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "") ; forces MPC to play
	EndIf

	loadHotKeys(1) ; re-enable hotkeys
	Opt("GUIOnEventMode", 1)
EndFunc