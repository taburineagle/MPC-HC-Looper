Func looperTitle()
	If $currentLooperFile <> "" Then
		$looperTitle = StringRight($currentLooperFile, StringLen($currentLooperFile) - StringInStr($currentLooperFile, "\" , Default, -1))
		Return $looperTitle
	EndIf
EndFunc