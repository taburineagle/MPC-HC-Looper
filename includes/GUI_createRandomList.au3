Func createRandomList()
	$countOfItems = getItemCount()
	Redim $randomPlayOrder[$countOfItems]

	For $i = 0 to $countOfItems - 1
		$randomPlayOrder[$i] = $i ; add all the events to an array
	Next

	_ArrayShuffle($randomPlayOrder) ; Shuffle the array twice...
	_ArrayShuffle($randomPlayOrder) ; to get a more randomized result

	; If the item before the current item is one less or more than the current item, put it at the end
	; for a more randomized result (so it doesn't go from 5 to 4, or 5 to 6 - or it does less often)

	For $i = 1 to UBound($randomPlayOrder) - 1
		If $randomPlayOrder[$i] = $randomPlayOrder[$i - 1] + 1 Or $randomPlayOrder[$i] = $randomPlayOrder[$i - 1] - 1 Then
			_ArraySwap($randomPlayOrder, $i, UBound($randomPlayOrder) - 1)
		EndIf
	Next

	If $randomPlayOrder[0] = $currentPlayingEvent Then ; if the currently playing item is the same as #0 in the new random list array
		_ArraySwap($randomPlayOrder, 0, UBound($randomPlayOrder) - 1) ; switch it with the last item in the random list array so we're not playing the current event
	EndIf

	Redim $randomPlayOrder[UBound($randomPlayOrder) + 1] ; adds one more element to the end of the random list array (to hold the current playing #)
	$randomPlayOrder[UBound($randomPlayOrder) - 1] = 1 ; sets the current item to "1" (because we load 0 in the next step)

	loadEvent($randomPlayOrder[0]) ; start playing from the new array's item order, starting at item #0
EndFunc