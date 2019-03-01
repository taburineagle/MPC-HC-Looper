GUIRegisterMsg($WM_GETMINMAXINFO, "_WM_GETMINMAXINFO") ; to keep the width of the window set to a specific size

Func _WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam) ; used to limit the minimum size of the GUI
	#forceref $hWnd, $Msg, $wParam, $lParam

	If $hWnd = $mainWindow Then
		Local $tagMaxinfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
		DllStructSetData($tagMaxinfo, 7, 448) ; min width - width stays the same, only the height changes...
		DllStructSetData($tagMaxinfo, 8, 266) ; min height
		DllStructSetData($tagMaxinfo, 9, 448) ; max width - so the min and max are the same
		DllStructSetData($tagMaxinfo, 10, (@DesktopHeight - 50)) ; max height
		Return $GUI_RUNDEFMSG
	EndIf
EndFunc ;==>_WM_GETMINMAXINFO
