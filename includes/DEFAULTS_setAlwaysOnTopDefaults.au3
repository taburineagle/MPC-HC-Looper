Func setAlwaysOnTopDefaults()
	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", 1) = 0 Then
		setAlwaysOnTop() ; if Always on Top is set to default to not, then turn it off here
	EndIf
EndFunc