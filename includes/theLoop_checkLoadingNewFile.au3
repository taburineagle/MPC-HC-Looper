Func checkLoadingNewFile()
	If FileExists($openWatchFile) Then
		$readingFile = FileOpen($openWatchFile, FileGetEncoding($openWatchFile))
		$fileToOpen = FileRead($readingFile)
		FileClose($readingFile)
		FileDelete($openWatchFile)

		Sleep(200)
		loadList($fileToOpen)
	EndIf
EndFunc