Func _Remove_CS_DBLCLKS($Ctrl)
	;Author; rover 2k9 - updated 2k12
	;Requires WinAPIEx.au3

	If Not IsHWnd($Ctrl) Then
		$Ctrl = GUICtrlGetHandle($Ctrl)
		If Not IsHWnd($Ctrl) Then Return SetError(1, 0, 0)
	EndIf

	If Not IsDeclared("GCL_STYLE") Then Local Const $GCL_STYLE = -26
	If Not IsDeclared("CS_DBLCLKS") Then Local Const $CS_DBLCLKS = 0x8

	Local $ClassStyle = _WinAPI_GetClassLongEx($Ctrl, $GCL_STYLE)
	If @error Or Not $ClassStyle Then Return SetError(2, @error, 0)

	Local $NewStyle = BitAND($ClassStyle, BitNOT($CS_DBLCLKS))
	_WinAPI_SetClassLongEx($Ctrl, $GCL_STYLE, $NewStyle)
	If @error Then Return SetError(3, @error, 0)

	Local $ClassChk = _WinAPI_GetClassLongEx($Ctrl, $GCL_STYLE)
	If @error Or Not $ClassChk Then Return SetError(4, @error, 0)
	If $ClassStyle = $ClassChk Then Return SetError(5, 0, 0)

	Return SetError(0, 0, 1)
EndFunc