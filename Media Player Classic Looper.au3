#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=MPC Icons.ico
#AutoIt3Wrapper_Outfile=F:\lelelelel\Programs\0A - AutoIt Programming Workfolder\MPC-HC Looper\Media Player Classic Looper.exe
#AutoIt3Wrapper_Res_Comment=MPC-HC/MPC-BE Looper lets you create multiple sets of A/B points, giving MPC-HC the ability to A/B loop.
#AutoIt3Wrapper_Res_Description=MPC-HC/MPC-BE Looper by Zach Glenwright
#AutoIt3Wrapper_Res_Fileversion=2020.4.27.7
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=© 2014-2020 Zach Glenwright
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_Icon_Add=F:\lelelelel\Programs\0A - AutoIt Programming Workfolder\MPC-HC Looper\MPCD.ico
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; **************************************************************************
; ******* Media Player Classic Looper! *************************************
; ******* (C) 2014-20 Zach Glenwright **************************************
; **************************************************************************
; ******* http://www.gullswingmedia.com ************************************
; **************************************************************************

; **************************************************************************
; ******* AutoIt SYSTEM OPTIONS AND INCLUDES *******************************
; **************************************************************************

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ColorConstants.au3>
#include <ListViewConstants.au3>
#include <GuiListView.au3>
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <File.au3>
#include <SliderConstants.au3>

#include <Misc.au3> ; To use the Singleton function and launch only one instance of the program
#include 'includes\SYS_MPC-HC-API.au3' ; All of the API ties to Media Player Classic (modularized because I shouldn't have to change it)
#include 'includes\SYS_ShellFile.au3' ; Associating the filetype with MPC-HC Looper

; **************************************************************************
; ******* GLOBAL DECLARATIONS **********************************************
; **************************************************************************

Opt("GUIEventOptions", 1) ; don't do the Windows maximize thing, do the custom one
Opt("GUIOnEventMode", 1) ; Change to OnEvent mode
Opt("GUICloseOnESC", 0) ; Don't close the GUI by hitting the ESC button

Const $windowTitle = "MPC-HC Looper!" ; the main title in the program

Global $isModified = 0 ; whether or not the current event list has been changed
Global $currentLooperFile ; the name of the current .looper file loaded

Global $loopRepeats[2] = [0, 1] ; $loopRepeats[0] = the number of repeats, $loopRepeats[1] = the current iteration of the repeat

Global $currentPlayingEvent = -1 ; The event that's currently playing
Global $currentPlayingEventPos = 0 ; The current playing event's position in the events list

Global $isLoaded = 0 ; whether the file is open in MPC or not yet
Global $currentLoadedFile = "" ; Which file is currently open in MPC
Global $nowPlayingInfo ; current info retrieved from MPC with a lot of info

Global $currentOrRemaining = 0 ; are we looking at current time, or remaining time in the loop?
Global $pastPosition, $currentPosition ; the previous position and the current position

Global $trimmingOut = 0 ; if you're currently trimming the out point or not (it plays slightly past the out point)
Global $loopPreviewLength = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "0.25") ; The length of the preview window for IN/OUT
Global $loopSlipLength = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "0.05") ; The trim slip length

Global $hotKeysActive = False ; boolean to tell whether or not hotkeys are active (either running the main GUI or MPC)

Global $isClicked = 0 ; Whether an item has been double-clicked or not

Global $HotkeyList[34] = ["i", "o", "^i", "^o", "^x", "+l", "^t", "+o", "[", "]", ";", "'", "+[", "+]", "+;", "+'", "^q", "^,", "^n", "^l", "^s", _
"{DEL}", "!^{BS}", "{SPACE}", "!{ENTER}", "^{PGUP}", "^{PGDN}", "^{UP}", "^{DOWN}", "^r", "^1", "^2", "^3", "^4"]

Global $tryingToQuit = 0 ; Triggers if the Quit command has been called, to prevent it from being called more than once

Global $MPCInitialized = 0 ; Whether or not MPC-HC is tied to this program

Global $displayTimer = 0 ; The second the timer started, defaults to not on at all
Global $displayMessage = 0 ; Whether we're looking at the current time or not

Global $inSearchMode = 0 ; Whether or not we've clicked on the search bar

Global $currentSpeed = 100 ; the current playback speed

Global $currentEventName = "" ; the name of the current event (for OSD display)
Global $currentEventCounter = "0 events in playlist (0:00 in entire playlist)" ; The current status text to display in the main GUI and OSD

Global $OSDWindow, $OSDWindowX = 22, $OSDWindowY = 22
Global $OSDeventNameTF, $OSDmodeTF, $OSDeventCounterTF, $OSDcurrentPositionTF, $OSDinPositionTF, $OSDoutPositionTF, $OSDCurrentRemainTF

Global $minWidth = (418 + 30), $minHeight = 266, $maxHeight = (@DesktopHeight - 50)

Global $randomPlayOrder[0]

Global $eventListIndex, $completeEventList
Global $currentlySearching = 0
Global $searchResultsList[0]

; **************************************************************************
; ****** HOLDING SHIFT DOWN IN THE BEGINNING TO TRIGGER DEFAULTS ***********
; **************************************************************************

Local $hDLL = DllOpen("user32.dll")

If _IsPressed("A0", $hDLL) Then ; If you hold SHIFT down at startup, it loads the default values for sizing
	$loadDefaults = True
Else
	$loadDefaults = False
EndIf

DllClose($hDLL)

; **************************************************************************
; ******* RUNNING MULTIPLE COPIES (OR NOT)**********************************
; **************************************************************************

$eventToPlay = ""

If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", 0) = 0 Then
	If _Singleton("MPC Looper", 1) = 0 Then ; we aren't allowing multiple instances, and Looper is already running, so
		launchFromExplorer() ; copy the filename into the text file for later opening
		Exit ; quit the new instance
	Else
		checkWhichLooperToLoad()
	EndIf
Else ; We are allowing multiple instances in Looper, let's check to see if MPC-HC is...
	$PathtoMPC = IniRead(@ScriptDir & "\MPCLooper.ini", "System", "MPCEXE", "") ; the path to MPC-HC for this session
	$PathtoMPC = StringLeft($PathtoMPC, StringInStr($PathtoMPC, "\", Default, -1)) ; MPC-HC's base program path

	; if none of the below give a positive value, or the files don't exist, the result at the end will just be 0 (no file = 0, by default)
	$MPCAllowCheck = IniRead($PathtoMPC & "mpc-hc.ini", "Settings", "AllowMultipleInstances", 0) ; check 32-bit INI file (if it exists)
	$MPCAllowCheck = $MPCAllowCheck + IniRead($PathtoMPC & "mpc-hc64.ini", "Settings", "AllowMultipleInstances", 0) ; check 64-bit INI file (if it exists)
	$MPCAllowCheck = $MPCAllowCheck + RegRead("HKCU\Software\MPC-HC\MPC-HC\Settings", "AllowMultipleInstances") ; check MPC-HC's registry setting

	If $MPCAllowCheck = 0 Then ; If we returned from all the checks above, and none had this flag set, then MPC-HC doesn't allow multiple instances...
		If _Singleton("MPC Looper", 1) = 0 Then ; we are allowing multiple instances, but MPC-HC is NOT...
			launchFromExplorer() ; copy the filename into the text file for later opening (for the main process to pick up)
			MsgBox(48 + 262144, "Multiple Instance Warning!", "You have multiple instances turned on in Looper, and you just launched another instance, but MPC-HC isn't set to allow multiple instances.  In that case, Looper will act like normal and not open any other multiple instances of itself." & @CRLF & @CRLF & "To allow the multiple instance feature, go to the MPC-HC options pane (View menu > Options), then click on " & '"Player"' & " at the top left and choose " & '"Open a new player for each media file played"' & ", and then save your changes - turning this on will allow you to have multiple Looper sessions running at the same time.")
			Exit ; quit the new instance
		Else
			checkWhichLooperToLoad() ; if we're allowing multiple instances, but MPC-HC is NOT, and this is the first, then check to see which .looper file to load
		EndIf
	Else
		checkWhichLooperToLoad() ; if we're running multiple processes, check which .looper file to load
	EndIf
EndIf

Func launchFromExplorer()
	If $cmdline[0] <> 0 Then
		$writingFile = FileOpen(@TempDir & "\MPC_Looper.txt", 34)
		FileWrite($writingFile, $cmdline[1])
		FileClose($writingFile)
	EndIf
EndFunc   ;==>launchFromExplorer

Func checkWhichLooperToLoad()
	If $cmdline[0] <> 0 Then
		$currentLooperFile = $cmdline[1]
		$eventToPlay = 0
	Else
		$lastPlayedLooper = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "")

		If $lastPlayedLooper <> "" Then ; if we're not loading factory defaults, and the value isn't clear
			If $lastPlayedLooper <> 1 Then ; if there actually is a value for the last played .looper file
				$lastPlayedLooper = StringSplit($lastPlayedLooper, "|", 2)

				If IsArray($lastPlayedLooper) Then
					$currentLooperFile = $lastPlayedLooper[0]
					$eventToPlay = Int($lastPlayedLooper[1])
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc   ;==>checkWhichLooperToLoad

$mainWindow = GUICreate("MPC-HC Looper!", (404 + 30), 538, (@DesktopWidth - (429 + 30)), 11, BitOR($WS_MAXIMIZEBOX, $WS_SIZEBOX, $WS_MINIMIZEBOX))

; main topmost GUI controls
$inButton = GUICtrlCreateLabel("IN", 38, 34, 34, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE) ; GUI Element 3
; ==================================================================
; Procedure to fix the "copy to clipboard" issue when clicking on labels
; using code snippet by rover 2k9 that stops double clicking labels (so it doesn't copy to clipboard)
; you have to create a control of a specific type first (which is why this snippet is after the IN
; button is created) before changing the declaration
; ==================================================================
#include <WinAPIEx.au3>
#include 'includes\SYS_Remove_CS_DBLCLKS.au3'
_Remove_CS_DBLCLKS(-1) ; remove double-click ability from static controls (but not from buttons or list views!)

; ==================================================================
$inTF = GUICtrlCreateInput("", 8, 64, 124, 25, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER)) ; GUI Element 4
$inDecButton = GUICtrlCreateLabel("-", 8, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$inIncButton = GUICtrlCreateLabel("+", 104, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE) ; GUI Element 6
$clearInButton = GUICtrlCreateLabel("X", 74, 34, 26, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE) ; GUI Element 7

$outButton = GUICtrlCreateLabel("OUT", 330, 34, 34, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE) ; GUI Element 8
$outTF = GUICtrlCreateInput("", 300, 64, 124, 25, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER)) ; GUI Element 9
$outDecButton = GUICtrlCreateLabel("-", 300, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE) ; GUI Element 10
$outIncButton = GUICtrlCreateLabel("+", 396, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE) ; GUI Element 11
$clearOutButton = GUICtrlCreateLabel("X", 366, 34, 26, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE) ; GUI Element 12

$clearAllButton = GUICtrlCreateButton("Clear All", 136, 34, 161, 25) ; GUI Element 13
$timeTF = GUICtrlCreateLabel("--:--:--", 144, 64, 150, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE)) ; GUI Element 14
$loopButton = GUICtrlCreateButton("Loop Mode", 7, 6, 124, 25) ; GUI Element 15

$dockLeftButton = GUICtrlCreateButton("", 136, 6, 11, 25) ; GUI Element 16
$dockLabel = GUICtrlCreateLabel("DOCK", 156, 10, 40, 21) ; GUI Element 17
$dockRightButton = GUICtrlCreateButton("", 200, 6, 11, 25) ; GUI Element 18

$OSDButton = GUICtrlCreateButton("OSD Off", 215, 6, 82, 25) ; GUI Element 19
$onTopButton = GUICtrlCreateButton("Always on Top", 300, 6, 124, 25) ; GUI Element 20

$previousEventButton = GUICtrlCreateButton("<<", 8, 92, 51, 28) ; GUI Element 21
$speedSlider = GUICtrlCreateSlider(64, 92, 305, 17, BitOR($GUI_SS_DEFAULT_SLIDER, $TBS_NOTICKS)) ; GUI Element 22
$__SPD_025X = GUICtrlCreateLabel("25%", 91, 110, 36, 17) ; GUI Element 23
$__SPD_05X = GUICtrlCreateLabel("50%", 126, 110, 30, 17) ; GUI Element 24
$__SPD_075X = GUICtrlCreateLabel("75%", 164, 110, 36, 17) ; GUI Element 25
$__SPD_1X = GUICtrlCreateLabel("100%", 195, 110, 27, 17) ; GUI Element 26
$__SPD_125X = GUICtrlCreateLabel("125%", 237, 110, 36, 17) ; GUI Element 27
$__SPD_15X = GUICtrlCreateLabel("150%", 274, 110, 30, 17) ; GUI Element 28
$__SPD_175X = GUICtrlCreateLabel("175%", 312, 110, 36, 17) ; GUI Element 29
$__SPD_2X = GUICtrlCreateLabel("200%", 345, 110, 25, 17) ; GUI Element 30
$nextEventButton = GUICtrlCreateButton(">>", 374, 92, 51, 28) ; GUI Element 31

$searchEventTF = GUICtrlCreateInput("", 8, 130, 330, 23) ; GUI Element 32
$searchEventButton = GUICtrlCreateButton("Go", 344, 129, 35, 24) ; GUI Element 33
$searchClearButton = GUICtrlCreateButton("Clear", 382, 129, 43, 24) ; GUI Element 34

; bottom event list GUI controls
$eventList = GUICtrlCreateListView("#|Event|In Point|Out Point|Duration|Filename", 0, 160, (403 + 30), 257, BitOR($LVS_REPORT, $LVS_SHOWSELALWAYS), BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT)) ; GUI Element 35
$HotKeyStatusTF = GUICtrlCreateLabel("", 6, 421, 90, 19) ; GUI Element 36
$currentEventStatusTF = GUICtrlCreateLabel("", 106, 421, 318, 19, $SS_RIGHT) ; GUI Element 37

$topVertLin = GUICtrlCreateGraphic(6, 441, 420, 1) ; GUI Element 38
$listSaveButton = GUICtrlCreateButton("Save", 7, 445, 61, 25) ; GUI Element 39
$listLoadButton = GUICtrlCreateButton("Load", 71, 445, 60, 25) ; GUI Element 40
$listDeleteButton = GUICtrlCreateButton("Delete Event", 134, 445, 83, 25) ; GUI Element 41
$listModifyButton = GUICtrlCreateButton("Modify Event", 220, 445, 83, 25) ; GUI Element 42
$listAddButton = GUICtrlCreateButton("Add", 305, 445, 57, 25) ; GUI Element 43
$listClearButton = GUICtrlCreateButton("Clear List", 364, 445, 63, 25) ; GUI Element 44

$vertLine = GUICtrlCreateGraphic(6, 473, 420, 1) ; GUI Element 45

; The name of the program - auto-generated for beta releases, uncomment to release a specific version!
$progTitle = GUICtrlCreateLabel("MPC-HC/MPC-BE Looper [04-27-20 RC]", 106, 481, 318, 19, $SS_RIGHT) ; GUI Element 46
$progInfo = GUICtrlCreateLabel(Chr(169) & " 2014-20 Zach Glenwright [www.gullswingmedia.com]", 106, 495, 318, 19, $SS_RIGHT) ; GUI Element 47

$optionsButton = GUICtrlCreateButton("", 8, 476, 40, 36, $BS_ICON) ; GUI Element 48
GUICtrlSetImage(-1, "C:\Windows\System32\shell32.dll", -91)
$goToDirectoryButton = GUICtrlCreateButton("", 48, 476, 40, 36, $BS_ICON) ; GUI Element 49
GUICtrlSetImage(-1, "C:\Windows\System32\shell32.dll", -46)

WinSetOnTop($mainWindow, "", 1) ; Set the GUI window on top of other windows, easier to do this instead of declaring it

GUISetOnEvent($GUI_EVENT_CLOSE, "Uninitialize") ; quit on close

GUISetOnEvent($GUI_EVENT_MAXIMIZE, "maximizeWindow") ; you clicked the maximize button
GUISetOnEvent($GUI_EVENT_MINIMIZE, "minimizeWindow") ; you clicked the minimize button
GUISetOnEvent($GUI_EVENT_RESTORE, "restoreWindow") ; restore the window if it's minimized

GUICtrlSetOnEvent($dockLeftButton, "clickLeftDockingButton")
GUICtrlSetOnEvent($dockLabel, "clickDockingButton")
GUICtrlSetOnEvent($dockRightButton, "clickRightDockingButton")

GUICtrlSetOnEvent($onTopButton, "setAlwaysOnTop")

GUICtrlSetOnEvent($inButton, "setInPoint")
GUICtrlSetOnEvent($outButton, "setOutPoint")
GUICtrlSetOnEvent($clearInButton, "clearInPoint")
GUICtrlSetOnEvent($clearOutButton, "clearOutPoint")
GUICtrlSetOnEvent($clearAllButton, "clearInOutPoint")

GUICtrlSetOnEvent($inDecButton, "trimInPointDec_Button")
GUICtrlSetOnEvent($inIncButton, "trimInPointInc_Button")
GUICtrlSetOnEvent($outDecButton, "trimOutPointDec_Button")
GUICtrlSetOnEvent($outIncButton, "trimOutPointInc_Button")

GUICtrlSetOnEvent($timeTF, "switchCurrentandRemaining")
GUICtrlSetOnEvent($currentEventStatusTF, "switchCurrentEventandTotalEvents")

GUICtrlSetOnEvent($loopButton, "clickLoopButton")
GUICtrlSetOnEvent($OSDButton, "clickOSDButton")

GUIRegisterMsg($WM_HSCROLL, "sliderMoving")
GUICtrlSetOnEvent($__SPD_025X, "setSpeed025")
GUICtrlSetOnEvent($__SPD_05X, "setSpeed05")
GUICtrlSetOnEvent($__SPD_075X, "setSpeed075")
GUICtrlSetOnEvent($__SPD_1X, "setSpeed1")
GUICtrlSetOnEvent($__SPD_125X, "setSpeed125")
GUICtrlSetOnEvent($__SPD_15X, "setSpeed15")
GUICtrlSetOnEvent($__SPD_175X, "setSpeed175")
GUICtrlSetOnEvent($__SPD_2X, "setSpeed2")

GUICtrlSetOnEvent($previousEventButton, "loadPrevEventButton")
GUICtrlSetOnEvent($nextEventButton, "loadNextEventButton")

GUICtrlSetOnEvent($searchEventButton, "searchEventList")
GUICtrlSetOnEvent($searchClearButton, "searchEventListRestore")

GUICtrlSetOnEvent($listAddButton, "addEvent")
GUICtrlSetOnEvent($listModifyButton, "modifyEventPrompt")
GUICtrlSetOnEvent($listDeleteButton, "deleteEvent")
GUICtrlSetOnEvent($listClearButton, "clearEvents")

GUICtrlSetOnEvent($listLoadButton, "loadListButtonClicked")
GUICtrlSetOnEvent($listSaveButton, "saveList")

GUICtrlSetOnEvent($optionsButton, "loadOptions")
GUICtrlSetOnEvent($goToDirectoryButton, "openPathtoFile")

#include 'includes\custom\MainGUIFonts.au3' ; Sets the fonts and colors for all of the buttons in the main window of MPC-HC Looper
#include 'includes\custom\Main-tooltips.au3' ; Adds tooltips to each of the main window buttons in MPC-HC Looper

If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "0") <> 1 Then
	loadToolTips(1)
EndIf

For $i = 3 To 34 ; set resizing of every single element to "don't move", the resize procedure sizes things as needed
	GUICtrlSetResizing($i, 802)
Next

GUICtrlSetResizing(35, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH) ; resize the event list in a different way

For $i = 36 To 49 ; set resizing of every element below the event list to don't move
	GUICtrlSetResizing($i, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Next

#include 'includes\SYS_GUIListViewEx.au3' ; The new listview control (that lets you drag, drop, etc.)
_GUIListViewEx_MsgRegister() ; for Dragging and Dropping items

#include 'includes\TRAY_createTray.au3' ; create "Headless mode" menu in Systray
#include 'includes\SYS_WM_GETMINMAXINFO.au3' ; forces the window to stay the same width

#include 'includes\DEFAULTS_loadWindowSizeDefaults.au3' ; procedure for setting opening window size dimensions when launching
#include 'includes\DEFAULTS_setAlwaysOnTopDefaults.au3' ; procedure for setting always on top when launching
#include 'includes\DEFAULTS_setDockingModeDefaults.au3' ; procedure for setting docking mode when launching
#include 'includes\DEFAULTS_setLoopModeDefaults.au3' ; procedure for setting loop mode when launching

; **************************************************************************
; ****** MEDIA PLAYER CLASSIC TIES TO THIS PROGRAM *************************
; **************************************************************************
#include 'includes\SYS_linkMPC.au3'
linkMPC() ; link Looper to an MPC-HC instance

GUISetState(@SW_SHOW) ; show the Looper window

If $loadDefaults = True Then ; If you hold SHIFT down at startup, it loads the default values for sizing
	$loopPreviewLength = 0.25 ; The length of the preview window for IN/OUT
	$loopSlipLength = 0.05 ; The trim slip length

	switchToLoop() ; if we're in defaults, then switch to Loop mode
Else ; You have preferences saved, and you didn't default to factory settings, so load the settings from the INI file
	setDockingModeDefaults()
	loadWindowSizeDefaults()
	setAlwaysOnTopDefaults()
EndIf

If $currentLooperFile <> "" Then ; if $currentLooperFile is defined, let's try opening that
	loadList($currentLooperFile)

	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") <> 1 Then
		If $eventToPlay <> -1 Then
			loadEvent($eventToPlay)
		EndIf
	EndIf
Else ;if $currentLooperFile is not defined, let's see if there's a file to open anyway...
	checkLoadingNewFile() ; check to see if there's a file to open (via Explorer) - if there is, then loadList() it
EndIf

If $loadDefaults <> True Then ; we look at the Loop mode *last*, because we have to load a .looper file first before switching
	setLoopModeDefaults() ; if we have a Loop mode default that's not standard, let's try switching it now...
EndIf

; **************************************************************************
; ****** FUNCTIONS FOR THE MAIN PROGRAM LOOP *******************************
; **************************************************************************
#include 'includes\theLoop_checkCurrentTitle.au3'
#include 'includes\theLoop_checkEventListActive.au3'
#include 'includes\theLoop_checkMPCSpeedAvailable.au3'
#include 'includes\theLoop_checkPlayingNewFile.au3'
#include 'includes\theLoop_checkWinActiveHotkeys.au3'
#include 'includes\theLoop_checkOSDWindowOn.au3'
#include 'includes\theLoop_updateStatusText.au3'
#include 'includes\theLoop_doTheLoop.au3'
#include 'includes\theLoop_checkLoadingNewFile.au3'
#include 'includes\theLoop_checkDocking.au3'

; **************************************************************************
; ****** SEARCH FUNCTION INCLUDES ******************************************
; **************************************************************************
#include 'includes\SEARCH_searchEventList.au3'
#include 'includes\SEARCH_searchEventListRestore.au3'

; *************************************************************************************************
; *******                                 MAIN PROGRAM LOOP                                 *******
; *************************************************************************************************

While 1 ; MAIN PROGRAM LOOP
	If $MPCInitialized = 2 Then ; if MPC-HC has given the signal that it's shut down
		; ======================= DS11 - If you ask for confirmation before closing MPC-HC =======================
		If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "") <> 1 Then
			If $currentLoadedFile <> "" Then ; if we have a .looper file open, ask if you want to resume playback
				$reloadMPC = MsgBox(4 + 32 + 262144 + 256, "MPC-HC Closed", "MPC-HC just closed, either you quit out of it, or it closed on it's own - would you like to re-open it?" & @CRLF & @CRLF & "If you choose " & '"Yes"' & " below, a new MPC-HC window will open and start playing the loop you're currently playing, and if you choose " & '"No"' & " below, MPC-HC Looper will shut down.")
			Else ; otherwise, just ask if you want to re-open MPC-HC
				$reloadMPC = MsgBox(4 + 32 + 262144 + 256, "MPC-HC Closed", "MPC-HC just closed, either you quit out of it, or it closed on it's own - would you like to re-open it?" & @CRLF & @CRLF & "If you choose " & '"Yes"' & " below, a new MPC-HC window will open, and if you choose " & '"No"' & " below, MPC-HC Looper will shut down.")
			EndIf

			If $reloadMPC = 6 Then
				linkMPC()
				Sleep(500)

				If $currentLoadedFile <> "" Then
					$currentLoadedFile = "" ; force loadEvent() to re-load the file by making the $currentLoadedFile variable blank
					loadEvent($currentPlayingEvent)

					If $currentSpeed <> 100 Then ; for some reason, we can't jump right into speed, so...
						Sleep(350) ; wait a little
						setSpeed($currentSpeed) ; then set the f'in speed
					EndIf
				EndIf
			Else ; if we don't want to re-open MPC, then bow out gracefully
				$MPCInitialized = 0
				Uninitialize()
			EndIf
		Else ; if we don't have the option to re-open MPC, then bow out gracefully
			$MPCInitialized = 0
			Uninitialize()
		EndIf
	Else ; THE MAIN LOOP!
		checkWinActiveHotkeys() ; checks to see if the Looper program of MPC-HC is active, if not, it turns off hotkeys, if so... whoo!

		refreshMPCInfo() ; refreshes nowPlayingInfo
		checkPlayingNewFile() ; checks to see if a new file has been opened in MPC-HC, and if so, it resets the in and out points and does other things...

		checkDocking() ; checks to see if the window needs to be docked

		checkCurrentTitle() ; checks to see if the current title has been modified or not, or has changed since the last loop
		checkEventListActive() ; checks to see if there are items in the event list, if not, it turns off the next/previous buttons
		checkMPCSpeedAvailable() ; checks to see if a file is playing in MPC-HC, if not, it turns off the speed controls

		checkOSDWindowOn() ; checks to see if the OSD window is on, if it is, it makes sure it's topmost
		updateStatusText() ; updates the status text if it needs to be updated

		doTheLoop() ; THE most important function in the whole program - except, of course, for the lemur generating one

		Sleep(20) ; short delay to save program resources

		checkLoadingNewFile() ; check to see if a new file has been optioned to open - if it has, then load loadList() it...
	EndIf
WEnd

; **************************************************************************
; ****** GUI FUNCTIONS *****************************************************
; **************************************************************************
#include 'includes\GUI_looperTitle.au3' ; returns what the title of the current looper file is (...Coatis.looper)
#include 'includes\GUI_setModified.au3' ; sets if the project is modified or not
#include 'includes\GUI_updateTime.au3' ; updates the current playback or remaining time
#include 'includes\GUI_displayStatusMsg.au3' ; shows a status message in the status area
#include 'includes\GUI_switchCurrentandRemaining.au3' ; switches between current and remaining time display
#include 'includes\GUI_switchCurrentEventandTotalEvents.au3' ; switches between showing the current playback event or a tally of all of them
#include 'includes\GUI_clickDockingButtons.au3' ; What happens when you click the left, right or middle "Docking" buttons

#include 'includes\GUI_clickLoopButton.au3' ; what happens when you click the "Loop Mode" button
#include 'includes\GUI_switchToOff.au3' ; switch Looper to OFF mode
#include 'includes\GUI_switchToLoop.au3' ; switch Looper to LOOP mode

#include 'includes\GUI_displayError.au3' ; show an error (if you can't jump to Playlist or Shuffle modes)
#include 'includes\GUI_switchToPlaylist.au3' ; switch Looper to PLAYLIST mode
#include 'includes\GUI_switchToShuffle.au3' ; switch Looper to SHUFFLE mode

#include 'includes\GUI_createRandomList.au3' ; create a random list for the shuffle mode
#include 'includes\GUI_clearRandomization.au3' ; clear any randomization in the Shuffle playlist

#include 'includes\GUI_clickOSDButton.au3' ; what happens when you click the OSD button
#include 'includes\GUI_switchEditingControls.au3' ; turns certain controls off or on based on Loop Mode
#include 'includes\GUI_switchModifyDelete.au3' ; if there's a selection, and it's the current file, then enable/disable Modify/Delete
#include 'includes\GUI_setAlwaysOnTop.au3' ; what happens when you click on the "Always on Top" button
#include 'includes\GUI_maximizeWindow.au3' ; maximizes the window to 3 predetermined sizes
#include 'includes\GUI_minimizeWindow.au3' ; minimizes the window
#include 'includes\GUI_restoreWindow.au3' ; makes the window normal size again

#include 'includes\MAIN_Uninitialize.au3' ; quitting procedure
#include 'includes\MAIN_writeCurrentlyPlayingFile.au3' ; if you choose to exit Looper and keep the current .looper file for the next session, this writes that INI value

; **************************************************************************
; ******* SPEED SETTING HANDLERS *******************************************
; **************************************************************************
#include 'includes\SPEED_checkNameSpeedSetting.au3' ; checks the current name to see if it has a speed setting in it (<S:50>)
#include 'includes\theLoop_checkNameRepeatSetting.au3' ; checks the current name to see if it has a repeat setting in it (<L:50>)
#include 'includes\SPEED_sliderMoving.au3' ; activates when you move the slider
#include 'includes\SPEED_setSpeed.au3' ; sets the speed to a specific percent

; **************************************************************************
; ******* OSD WINDOW HANDLERS **********************************************
; **************************************************************************
#include 'includes\OSD_OSDWindow.au3' ; activates the OSD window
#include 'includes\OSD_moveWindow.au3' ; acvtivates when you move the OSD window
#include 'includes\OSD_updateEventOSDInfo.au3' ; checks the IN and OUT against the current playing item
#include 'includes\OSD_getEventDur.au3' ; gets the duration of a specific event
#include 'includes\OSD_getTotalPlaylistDur.au3' ; gets the duration of the entire event list
#include 'includes\OSD_clearOSDInfo.au3' ; resets the status display to a total tally of events
#include 'includes\OSD_updateOSD.au3' ; updates the various text fields in the OSD window

; **************************************************************************
; ******* OPTIONS PANE HANDLERS ********************************************
; **************************************************************************
#include 'includes\Options_loadOptions.au3' ; loads the options pane and waits for results
#include 'includes\Options_isAcceptableNumber.au3' ; checks to see if the numbers in the text fields are actually numbers (and don't have text in them)

; **************************************************************************
; ******* MPC-HC HANDLERS **************************************************
; **************************************************************************
#include 'includes\MPC_makeMPCActive.au3' ; makes MPC Active
#include 'includes\MPC_openPathToFile.au3' ; opens Windows Explorer to the specific spot that the current playing file is
#include 'includes\MPC_refreshMPCInfo.au3' ; forces MPC-HC to refresh it's playback info

; **************************************************************************
; ******* HOTKEY HANDLING PROCEDURES ***************************************
; **************************************************************************
#include 'includes\HKEY_loadHotKeys.au3' ; loads the hotkeys into their handlers
#include 'includes\HKEY_getMode.au3' ; checks to see "Loop Mode" or "OFF" is the current loop mode
#include 'includes\HKEY_hotKeyPressed.au3' ; what happens when you press a hotkey

; **************************************************************************
; ******* FILE HANDLING PROCEDURES *****************************************
; **************************************************************************
#include 'includes\FILE_loadList.au3' ; loads a .looper file into MPC-HC Looper and loads the first event
#include 'includes\FILE_askForSave.au3' ; asks if you want to save before doing something (quitting, loading a new file, etc.)
#include 'includes\FILE_saveList.au3' ; saves a .looper file from the current events list

; **************************************************************************
; ******* IN AND OUT POINT HANDLERS ****************************************
; **************************************************************************
#include 'includes\EDIT_setInPoint.au3' ; sets the in point to the current playback position
#include 'includes\EDIT_checkOutPoint.au3' ; checks to see if the OUT is earlier than the IN
#include 'includes\EDIT_setOutPoint.au3' ; sets the out point to the current playback position

#include 'includes\EDIT_clearInPoint.au3' ; clears the in point
#include 'includes\EDIT_clearOutPoint.au3' ; clears the out point
#include 'includes\EDIT_clearInOutPoint.au3' ; clears both the in and out points

#include 'includes\EDIT_trimInPointDec.au3' ; trims the IN point backwards
#include 'includes\EDIT_trimInPointInc.au3' ; trims the IN point forwards
#include 'includes\EDIT_trimOutPointDec.au3' ; trims the OUT point backwards
#include 'includes\EDIT_trimOutPointInc.au3' ; trims the OUT point forwards

; **************************************************************************
; ******* EVENT LIST HANDLERS **********************************************
; **************************************************************************
#include 'includes\EVENT_getItemCount.au3' ; get the count of how many items are in the event list
#include 'includes\EVENT_eventNamePrompt.au3' ; prompt for a new name (either for new event of modified event)
#include 'includes\EVENT_initializeEventChange.au3' ; change specific GUI items if you're in the middle of adding or modifying an event

#include 'includes\EVENT_addEvent.au3' ; add an event to the event list
#include 'includes\EVENT_modifyEvent.au3' ; modify an event (and delete event(s) if necessary) from the event list
#include 'includes\EVENT_modifyEventPrompt.au3' ; prompt to modify an event from the event list
#include 'includes\EVENT_stripInfoFromName.au3' ; strip the <S: and F: from the event name and give just the name itself

#include 'includes\EVENT_deleteEvent.au3' ; deleting an event (or multiple events) from the event list
#include 'includes\EVENT_reorderArray.au3' ; re-order the # array after deleting an event
#include 'includes\EVENT_reloadList.au3' ; reload a new list (search, deleted, reordered, randomized, etc.) into the events list
#include 'includes\EVENT_clearEvents.au3' ; delete ALL events from the event list

#include 'includes\EVENT_loadPrevNextEvent.au3' ; what happens when you click on the previous or next event buttons
#include 'includes\EVENT_loadEvent.au3' ; load an event's loop

; **************************************************************************
; ******* SYSTEM PROCEDURES ************************************************
; **************************************************************************
#include 'includes\SYS_FindFileExists.au3' ; finds if the current media file is in it's original directory or in the directory the .looper file is in
#include 'includes\SYS_TimeConversion.au3' ; converts between numbers (61.5 -> 1:01.500) and time strings (1:01.500 -> 61.5)
