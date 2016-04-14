GUIRegisterMsg($WM_GETMINMAXINFO, "_WM_GETMINMAXINFO") ; to keep the width of the window set to a specific size

Func _WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam) ; used to limit the minimum size of the GUI
	#forceref $hWnd, $Msg, $wParam, $lParam

	If $hWnd = $mainWindow Then
		Local $tagMaxinfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
		DllStructSetData($tagMaxinfo, 7, $minWidth) ; min width
		DllStructSetData($tagMaxinfo, 8, $minHeight) ; min height
		DllStructSetData($tagMaxinfo, 9, $minWidth) ; max width
		DllStructSetData($tagMaxinfo, 10,$maxHeight) ; max height
		Return $GUI_RUNDEFMSG
	EndIf
EndFunc ;==>_WM_GETMINMAXINFO