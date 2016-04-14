#include-once

; #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7
; #INDEX# =======================================================================================================================
; Title .........: _ShellFile
; AutoIt Version : v3.2.12.1 or higher
; Language ......: English
; Description ...: Create an entry in the shell contextmenu when selecting an assigned filetype, includes the program icon as well.
; Note ..........:
; Author(s) .....: guinness
; Remarks .......:
; ===============================================================================================================================

; #INCLUDES# ====================================================================================================================
#include <Constants.au3>

; #GLOBAL VARIABLES# ============================================================================================================
; None

; #CURRENT# =====================================================================================================================
; _ShellFile_Install: Creates an entry in the 'All Users/Current Users' registry for displaying a program entry in the shell contextmenu, but only displays when selecting an assigned filetype to the program.
; _ShellFile_Uninstall: Deletes an entry in the 'All Users/Current Users' registry for displaying a program entry in the shell contextmenu.
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
; None
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _ShellFile_Install
; Description ...: Creates an entry in the 'All Users/Current Users' registry for displaying a program entry in the shell contextmenu, but only displays when selecting an assigned filetype to the program.
; Syntax ........: _ShellFile_Install($sText, $sFileType[, $sName = @ScriptName[, $sFilePath = @ScriptFullPath[, $sIconPath = @ScriptFullPath[,
;                  $iIcon = 0[, $fAllUsers = False[, $fExtended = False]]]]]])
; Parameters ....: $sText               - Text to be shown in the contextmenu.
;                  $sFileType           - Filetype to be associated with the application e.g. .autoit or autoit.
;                  $sName               - [optional] Name of the program. Default is @ScriptName.
;                  $sFilePath           - [optional] Location of the program executable. Default is @ScriptFullPath.
;                  $sIconPath           - [optional] Location of the icon e.g. program executable or dll file. Default is @ScriptFullPath.
;                  $iIcon               - [optional] Index of icon to be used. Default is 0.
;                  $fAllUsers           - [optional] Add to Current Users (False) or All Users (True) Default is False.
;                  $fExtended           - [optional] Show in the Extended contextmenu using Shift + Right click. Default is False.
; Return values .: Success - Returns True
;                  Failure - Returns False and sets @error to non-zero.
; Author ........: guinness
; Example .......: Yes
; ===============================================================================================================================
Func _ShellFile_Install($sText, $sFileType, $sName = @ScriptName, $sFilePath = @ScriptFullPath, $sIconPath = @ScriptFullPath, $iIcon = 0, $fAllUsers = False, $fExtended = False)
	Local $i64Bit = '', $sRegistryKey = ''

	If $iIcon = Default Then
		$iIcon = 0
	EndIf
	If $sFilePath = Default Then
		$sFilePath = @ScriptFullPath
	EndIf
	If $sIconPath = Default Then
		$sIconPath = @ScriptFullPath
	EndIf
	If $sName = Default Then
		$sName = @ScriptName
	EndIf
	If @OSArch = 'X64' Then
		$i64Bit = '64'
	EndIf
	If $fAllUsers Then
		$sRegistryKey = 'HKEY_LOCAL_MACHINE' & $i64Bit & '\SOFTWARE\Classes\'
	Else
		$sRegistryKey = 'HKEY_CURRENT_USER' & $i64Bit & '\SOFTWARE\Classes\'
	EndIf

	$sFileType = StringRegExpReplace($sFileType, '^\.+', '')
	$sName = StringLower(StringRegExpReplace($sName, '\.[^.\\/]*$', ''))
	If StringStripWS($sName, $STR_STRIPALL) = '' Or FileExists($sFilePath) = 0 Or StringStripWS($sFileType, $STR_STRIPALL) = '' Then
		Return SetError(1, 0, False)
	EndIf

	_ShellFile_Uninstall($sFileType, $fAllUsers)

	Local $iReturn = 0
	$iReturn += RegWrite($sRegistryKey & '.' & $sFileType, '', 'REG_SZ', $sName)
	$iReturn += RegWrite($sRegistryKey & $sName & '\DefaultIcon\', '', 'REG_SZ', $sIconPath & ',' & $iIcon)
	$iReturn += RegWrite($sRegistryKey & $sName & '\shell\open', '', 'REG_SZ', $sText)
	$iReturn += RegWrite($sRegistryKey & $sName & '\shell\open', 'Icon', 'REG_EXPAND_SZ', $sIconPath & ',' & $iIcon)
	$iReturn += RegWrite($sRegistryKey & $sName & '\shell\open\command\', '', 'REG_SZ', '"' & $sFilePath & '" "%1"')
	$iReturn += RegWrite($sRegistryKey & $sName, '', 'REG_SZ', $sText)
	$iReturn += RegWrite($sRegistryKey & $sName, 'Icon', 'REG_EXPAND_SZ', $sIconPath & ',' & $iIcon)
	$iReturn += RegWrite($sRegistryKey & $sName & '\command', '', 'REG_SZ', '"' & $sFilePath & '" "%1"')
	If $fExtended Then
		$iReturn += RegWrite($sRegistryKey & $sName, 'Extended', 'REG_SZ', '')
	EndIf
	Return $iReturn > 0
EndFunc   ;==>_ShellFile_Install

; #FUNCTION# ====================================================================================================================
; Name ..........: _ShellFile_Uninstall
; Description ...: Deletes an entry in the 'All Users/Current Users' registry for displaying a program entry in the shell contextmenu.
; Syntax ........: _ShellFile_Uninstall($sFileType[, $fAllUsers = False])
; Parameters ....: $sFileType           - Filetype to be associated with the application e.g. .autoit or autoit.
;                  $fAllUsers           - [optional] Add to Current Users (False) or All Users (True) Default is False.
; Return values .: Success - Returns True
;                  Failure - Returns False and sets @error to non-zero.
; Author ........: guinness
; Example .......: Yes
; ===============================================================================================================================
Func _ShellFile_Uninstall($sFileType, $fAllUsers = False)
	Local $i64Bit = '', $sRegistryKey = ''

	If @OSArch = 'X64' Then
		$i64Bit = '64'
	EndIf
	If $fAllUsers Then
		$sRegistryKey = 'HKEY_LOCAL_MACHINE' & $i64Bit & '\SOFTWARE\Classes\'
	Else
		$sRegistryKey = 'HKEY_CURRENT_USER' & $i64Bit & '\SOFTWARE\Classes\'
	EndIf

	$sFileType = StringRegExpReplace($sFileType, '^\.+', '')
	If StringStripWS($sFileType, $STR_STRIPALL) = '' Then
		Return SetError(1, 0, False)
	EndIf

	Local $iReturn = 0, $sName = RegRead($sRegistryKey & '.' & $sFileType, '')
	If @error Then
		Return SetError(2, 0, False)
	EndIf
	$iReturn += RegDelete($sRegistryKey & '.' & $sFileType)
	$iReturn += RegDelete($sRegistryKey & $sName)
	Return $iReturn > 0
EndFunc   ;==>_ShellFile_Uninstall