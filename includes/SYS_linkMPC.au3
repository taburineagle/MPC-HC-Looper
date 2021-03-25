Func linkMPC()
	$MPCInitialized = 0

	$s_formHandle = Dec(StringMid(String($mainWindow), 3))

	$PathtoMPC = IniRead(@ScriptDir & "\MPCLooper.ini", "System", "MPCEXE", "")

	If Not FileExists($PathtoMPC) Then ; if the path to MPC-HC doesn't exist, then ask where the executable is
		$PathtoMPC = ""
	EndIf

	While $MPCInitialized = 0
		If $PathtoMPC = "" Then
			$PathtoMPC = FileOpenDialog("Where is MPC-HC's executable?", "", "MPC-HC Execuatables (mpc*.exe)", 1)

			If $PathtoMPC <> "" Then
				IniWrite(@ScriptDir & "\MPCLooper.ini", "System", "MPCEXE", $PathtoMPC)
			EndIf
		EndIf

		$pid_MPC = Run($PathtoMPC & " /slave " & $s_formHandle)

		If $pid_MPC = 0 Then ; Media Player Classic could not be found or loaded
			$tryAgain = MsgBox(262144 + 5, "Error - Could not run Media Player Classic", "Could not launch the Media Player Classic .exe file - this happens if you cancel the dialog asking you to find MPC-HC's .exe file, or you choose the wrong .exe file to launch.  Do you want to try to find the file again?")

			If $tryAgain = 2 Then
				Exit
			EndIf
		Else ; (or it loaded, make it frontmost)
			; Determine whether or not to use the old offset time display or the "updated" time
			If StringInStr($PathToMPC, "mpc-hc") Then ; we're using MPC-HC, so check the version
				While $timeAdjustment = -1 ; wait for MPC-HC to report the version information
					__MPC_send_message($ghnd_MPC_handle, $CMD_GETVERSION, "") ; get the current version of MPC-HC
					Sleep(200) ; wait a small amount to see if MPC-HC has reported the version
				Wend

				$versionCompare = StringSplit($timeAdjustment, ".") ; split the version reported into individual components to compare them individually

				If Int($versionCompare[1]) > 1 Then ; if we're running an MPC-HC with a version newer than 2.x.x, then turn off time adjustment automatically
					$timeAdjustment = 0
				Else ; we're still on 1.x.x.x (which is *all versions* at the moment)
					If Int($versionCompare[2]) > 7 Then ; if we're running an MPC-HC with a version newer than 1.7.x, then turn off time adjustment
						$timeAdjustment = 0
					Else ; we're running an old verison of MPC-HC, so adjust the times
						$timeAdjustment = 1
					EndIf
				EndIf
			Else ; if we're using MPC-BE, we're automatically (as of 3-24-21) using the "outdated" time information, so no need to check the version
				$timeAdjustment = 1
			EndIf

			$MPCInitialized = 1
		EndIf
	WEnd
EndFunc