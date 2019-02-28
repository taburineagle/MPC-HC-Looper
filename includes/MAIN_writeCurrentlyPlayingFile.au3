Func writeCurrentlyPlayingFile()
	If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "") <> "" Then
		If $currentlySearching = 2 Then
			$currentItem = $searchResultsList[$currentPlayingEvent]
			$currentPlayingEvent = Int(StringLeft($currentItem, StringInStr($currentItem, "|"))) - 1
		EndIf

		If $currentLooperFile <> "" Then
			IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", $currentLooperFile & "|" & $currentPlayingEvent)
		Else
			IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "1")
		EndIf
	EndIf

	Exit
EndFunc