; **************************************************************************
; ******* MPC-HC API *******************************************************
; **************************************************************************

; Commands sent to MPC-HC (send variables)
Global Const $CMD_OPENFILE = 0xA0000000 ; opens a file in MPC

Global Const $CMD_GETNOWPLAYING = 0xA0003002 ; get information about what's currently open in MPC
Global Const $CMD_NOWPLAYING = 0x50000003 ; the information returned from MPC

Global Const $CMD_STATE = 0x50000001

Global Const $CMD_GETVERSION = 0xA0003006 ; Ask MPC-HC/BE for its version info
Global Const $CMD_GETCURRENTPOSITION = 0xA0003004 ; Ask for the current playback position
Global Const $CMD_SETPOSITION = 0xA0002000 ; Cue current file to specific position
Global Const $CMD_SETSPEED = 0xA0004008 ; Set the speed to a specific speed

Global Const $CMD_STOP = 0xA0000001 ; Stop playback but keep file in queue
Global Const $CMD_PLAY = 0xA0000004 ; Starts playback ONLY
Global Const $CMD_PAUSE = 0xA0000005 ; Pauses ONLY
Global Const $CMD_PLAYPAUSE = 0xA0000003 ; Toggles between PLAY and PAUSE
Global Const $CMD_TOGGLEFULLSCREEN = 0xA0004000 ; Toggles FULLSCREEN on and off

Global $gs_messages, $ghnd_MPC_handle

GUIRegisterMsg($WM_COPYDATA, "__Msg_WM_COPYDATA")

Func __MPC_send_message($prm_hnd_MPC, $prm_MPC_Command, $prm_MPC_parameter)
	Local $StructDef_COPYDATA
	Local $st_COPYDATA
	Local $p_COPYDATA
	Local $st_CDString
	Local $p_CDString
	Local $i_StringSize

	$StructDef_COPYDATA = "dword dwData;dword cbData;ptr lpData"; 32 bit command; length of string; pointer to string
	$st_COPYDATA = DllStructCreate($StructDef_COPYDATA) ; create the message struct

	$i_StringSize = StringLen($prm_MPC_parameter) + 1 ; +1 for null termination
	$st_CDString = DllStructCreate("wchar var1[" & $i_StringSize & "]") ; the array to hold the unicode string we are sending
	DllStructSetData($st_CDString, 1, $prm_MPC_parameter) ; set parameter string
	DllStructSetData($st_CDString, 1, 0, $i_StringSize) ; null termination
	$p_CDString = DllStructGetPtr($st_CDString) ; the pointer to the string

	DllStructSetData($st_COPYDATA, "dwData", $prm_MPC_Command) ; dwData 32 bit command
	DllStructSetData($st_COPYDATA, "cbData", $i_StringSize * 2) ; size of string * 2 for unicode
	DllStructSetData($st_COPYDATA, "lpData", $p_CDString) ; lpData pointer to data
	$p_COPYDATA = DllStructGetPtr($st_COPYDATA) ; pointer to COPYDATA struct

	_SendMessage($prm_hnd_MPC, $WM_COPYDATA, 0, $p_COPYDATA)

	$st_COPYDATA = 0 ; free the struct
	$st_CDString = 0 ; free the struct
EndFunc   ;==>__MPC_send_message

Func __Msg_WM_COPYDATA($hWnd, $Msg, $wParam, $lParam)
	; Receives WM_COPYDATA message from MPC
	; $LParam = pointer to a COPYDATA struct
	Local $StructDef_COPYDATA
	Local $st_COPYDATA
	Local $StructDef_DataString
	Local $st_DataString
	Local $s_DataString
	Local $s_dwData, $s_cbData, $s_lpData

	$StructDef_COPYDATA = "dword dwData;dword cbData;ptr lpData"
	$StructDef_DataString = "char DataString"
	$st_COPYDATA = DllStructCreate($StructDef_COPYDATA, $LParam)
	$s_dwData = DllStructGetData($st_COPYDATA, "dwData") ; 32bit MPC command
	$s_cbData = DllStructGetData($st_COPYDATA, "cbData") ; length of DataString
	$s_lpData = DllStructGetData($st_COPYDATA, "lpData") ; pointer to DataString

	$StructDef_DataString = "wchar DataString[" & Int($s_cbData) & "]" ;unicode string with length cbData

	$st_DataString = DllStructCreate($StructDef_DataString, $s_lpData)
	$s_DataString = DllStructGetData($st_DataString, "DataString")

	Switch $s_dwData
		Case 1342177290 ; MPC-HC/BE is reporting its version (for time offsets)
			$timeAdjustment = $s_DataString ; get the current version string from MPC-HC - this value will be overwritten in the linking step
		Case 1342177280 ; MPC-HC/BE has connected to Looper
			$ghnd_MPC_handle = $s_DataString ; Connect this script to MPC
		Case 1342177283
			$nowPlayingInfo = StringSplit($s_DataString, "|") ; gets the info for the currently loaded file (to figure out length of video)
		Case 1342177287
			$currentPosition = $s_DataString ; get the current position
		Case 1342177281
			$isLoaded = $s_DataString ; see whether or not MPC-HC has loaded the file completely
		Case 1342177291
			$MPCInitialized = 2 ; MPC-HC is initialized
	EndSwitch
EndFunc   ;==>__Msg_WM_COPYDATA