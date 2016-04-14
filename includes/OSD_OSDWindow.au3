Func OSDWindow()
	$OSDWindow = GUICreate("OSD Window", 524, 89, $OSDWindowX, $OSDWindowY, $WS_POPUP)

	$OSDmodeTF = GUICtrlCreateLabel("", 8, 1, 97, 25)
	$OSDeventNameTF = GUICtrlCreateLabel($currentEventName, 5, 30, 511, 29, $SS_RIGHT)
	$OSDeventCounterTF = GUICtrlCreateLabel($currentEventCounter, 164, 1, 352, 25, $SS_RIGHT)
	$OSDcurrentPositionTF = GUICtrlCreateLabel("", 400, 58, 120, 29)
	$OSDinPositionTF = GUICtrlCreateLabel("", 28, 58, 120, 29)
	$OSDoutPositionTF = GUICtrlCreateLabel("", 200, 58, 120, 29)
	$OSDCurrentRemainTF = GUICtrlCreateLabel("CURRENT", 336, 64, 62, 21)

	$_SEPERATOR = GUICtrlCreateGraphic(8, 26, 513, 1)
	$_IN = GUICtrlCreateLabel("IN", 8, 64, 18, 21)
	$_OUT = GUICtrlCreateLabel("OUT", 168, 64, 31, 21)

	#include 'custom\OSDWindowFonts.au3' ; Sets up the fonts and graphic elements in the OSD Window

	GUISetState(@SW_SHOWNOACTIVATE)

	GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, "moveWindow")
	GUICtrlSetOnEvent($OSDcurrentPositionTF, "switchCurrentandRemaining")
	GUICtrlSetOnEvent($OSDeventCounterTF, "switchCurrentEventandTotalEvents")

	WinSetTrans($OSDWindow, "", 188)
	WinSetOnTop($OSDWindow, "", 1)
EndFunc