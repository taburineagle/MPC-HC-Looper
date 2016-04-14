Func refreshMPCInfo()
	__MPC_send_message($ghnd_MPC_handle, $CMD_GETNOWPLAYING, "") ; returns a bunch of things, but we're only looking for the current filename
EndFunc