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
			$MPCInitialized = 1
		EndIf
	WEnd
EndFunc