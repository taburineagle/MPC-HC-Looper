Opt("TrayMenuMode", 1) ; does not show default menu
Opt("TrayOnEventMode", 1) ; responds to direct calls to tray menu functions
TraySetState(1) ; show the tray icon
TraySetToolTip("MPC-HC Looper [02-01-18] by Zach Glenwright") ; set the system tray icon text

;~ --------------------------------------------------------------
;~ ===================== TRAY MENU ITEMS ========================
;~ --------------------------------------------------------------

$headlessModeTrayItem = TrayCreateItem("Operate Looper in headless mode");

TrayItemSetOnEvent($headlessModeTrayItem, "clickedTrayIcon")

Func clickedTrayIcon()
	Switch @TRAY_ID
		Case $headlessModeTrayItem
			switchHeadlessMode()
	EndSwitch
EndFunc

Func switchHeadlessMode()
	If WinGetState($mainWindow) = 2 Then
		WinSetState($mainWindow, "", @SW_HIDE)
	Else
		WinSetState($mainWindow, "", @SW_SHOW)
	EndIf
EndFunc