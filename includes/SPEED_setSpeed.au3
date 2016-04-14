Func setSpeed025()
	setSpeed(25)
EndFunc

Func setSpeed05()
	setSpeed(50)
EndFunc

Func setSpeed075()
	setSpeed(75)
EndFunc

Func setSpeed1()
	setSpeed(100)
EndFunc

Func setSpeed125()
	setSpeed(125)
EndFunc

Func setSpeed15()
	setSpeed(150)
EndFunc

Func setSpeed175()
	setSpeed(175)
EndFunc

Func setSpeed2()
	setSpeed(200)
EndFunc

Func setSpeed($theSpeed)
		displayStatusMsg("Setting speed to " & $theSpeed & " percent")
		__MPC_send_message($ghnd_MPC_handle, $CMD_SETSPEED, Number($theSpeed) / 100)
		GUICtrlSetData($speedSlider, $theSpeed)
		$currentSpeed = $theSpeed
EndFunc