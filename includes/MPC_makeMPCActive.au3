Func makeMPCActive()
	If WinActive(HWnd($ghnd_MPC_handle)) = 0 Then
		WinActivate(HWnd($ghnd_MPC_handle))
	EndIf
EndFunc