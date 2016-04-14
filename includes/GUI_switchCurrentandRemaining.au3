Func switchCurrentandRemaining()
	If $currentOrRemaining = 0 Then
		$currentOrRemaining = 1 ; Switch current/remaining time display back to current
	Else
		$currentOrRemaining = 0 ; Switch current/remaining time to remaining time (in the loop)
	EndIf

	updateTime()
EndFunc