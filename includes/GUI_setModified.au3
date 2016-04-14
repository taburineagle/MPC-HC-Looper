Func setModified($newSetting = 1) ; sets whether the current project/looper file has been modified or not
	If $newSetting = 1 Then
		If $isModified = 0 Then
			$isModified = 1
			GUICtrlSetState($listSaveButton, $GUI_ENABLE)
		EndIf
	Else
		$isModified = 0
		GUICtrlSetState($listSaveButton, $GUI_DISABLE)
	EndIf
EndFunc