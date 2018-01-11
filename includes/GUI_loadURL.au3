Func loadURL()
	$loadWebsite = MsgBox(262144 + 32 + 4, "Go to MPC-HC Looper Website?", "Would you like to visit the MPC-HC Looper Homepage?  If you click Yes, a browser window will open, taking you to the URL:" & @CRLF & @CRLF & "< http://www.gullswingmedia.com/mpc-hc-looper.html >")

	If $loadWebsite = "6" Then
		ShellExecute("http://www.gullswingmedia.com/mpc-hc-looper.html")
	EndIf
EndFunc
