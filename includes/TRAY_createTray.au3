Opt("TrayMenuMode", 3) ; does not show default menu, and does not automatically set things as checked when clicking
Opt("TrayOnEventMode", 1) ; responds to direct calls to tray menu functions
TraySetState(1) ; show the tray icon
TraySetToolTip("MPC-HC Looper [02-11-19] RC by Zach Glenwright") ; set the system tray icon text

;~ --------------------------------------------------------------
;~ ===================== TRAY MENU ITEMS ========================
;~ --------------------------------------------------------------

$headlessModeTrayItem = TrayCreateItem("Operate Looper in Headless mode (for this session)");
TrayCreateItem("")
$prefsTrayItem = TrayCreateItem("Looper Preferences...");
$exitTrayItem = TrayCreateItem("Quit MPC-HC Looper");

TrayItemSetOnEvent($headlessModeTrayItem, "clickedTrayIcon")
TrayItemSetOnEvent($prefsTrayItem, "clickedTrayIcon")
TrayItemSetOnEvent($exitTrayItem, "clickedTrayIcon")

Func clickedTrayIcon()
	Switch @TRAY_ID
		Case $headlessModeTrayItem
			switchHeadlessMode() ; switch to and from Headless (GUI-less) mode
		Case $prefsTrayItem
			loadOptions() ; load the preferences dialog
		Case $exitTrayItem
			Uninitialize() ; quit out of Looper
	EndSwitch
EndFunc

Func switchHeadlessMode()
	If TrayItemGetState($headlessModeTrayItem) = 68 Then
		TrayItemSetState($headlessModeTrayItem, $TRAY_CHECKED)
		WinSetState($mainWindow, "", @SW_HIDE)
	ElseIf TrayItemGetState($headlessModeTrayItem) = 65 Then
		TrayItemSetState($headlessModeTrayItem, $TRAY_UNCHECKED)
		WinSetState($mainWindow, "", @SW_SHOW)
	EndIf
EndFunc