Func findFileExists($theFile, $currentLooperFile) ; sees if a particular media file exists, if it does, it returns a path, or if not, -1
	$returnedFile = ""

	If $currentLooperFile <> "" Then
		$currentLooperFileDir = StringLeft($currentLooperFile, StringInStr($currentLooperFile, "\" , Default, -1))
		$theFileName = StringRight($theFile, StringLen($theFile) - StringInStr($theFile, "\" , Default, -1))

		If FileExists($currentLooperFileDir & $theFileName) = 1 Then
			$returnedFile = ($currentLooperFileDir & $theFileName)
		EndIf
	EndIf

	If $returnedFile = "" Then
		If FileExists($theFile) = 1 Then
			$returnedFile = ($theFile)
		Else
			$returnedFile = -1
		EndIf
	EndIf

	Return $returnedFile
EndFunc