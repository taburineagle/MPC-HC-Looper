Func checkLoadingNewFile()
	If FileExists(@TempDir & "\MPC_Looper.txt") Then
		$readingFile = FileOpen(@TempDir & "\MPC_Looper.txt", FileGetEncoding(@TempDir & "\MPC_Looper.txt"))
		$fileToOpen = FileRead($readingFile)
		FileClose($readingFile)
		FileDelete(@TempDir & "\MPC_Looper.txt")

		Sleep(200)
		loadList($fileToOpen)
	EndIf
EndFunc
