Func askForSave($savePrompt)
	If $isModified = 1 Then
		$saveOrQuit = MsgBox(262144 + 4, "Save?", $savePrompt)
		$saveState = "-1"

		If $saveOrQuit = "6" Then
			$saveState = saveList()
		EndIf

		Return $saveState
	EndIf
EndFunc