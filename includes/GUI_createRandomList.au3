Func createRandomList()
	$countOfItems = getItemCount()

	If IsInt($countOfItems / 2) Then
		$halfOfList = ($countOfItems / 2)

		Local $randomNumArray1[$halfOfList]
		Local $randomNumArray2[$halfOfList]

		For $i = 0 to ($halfOfList - 1)
			$randomNumArray1[$i] = $i
		Next

		For $i = 0 to ($halfOfList - 1)
			$randomNumArray2[$i] = $halfOfList + $i
		Next
	Else
		$halfOfList = Int(($countOfItems / 2) + 1)

		Local $randomNumArray1[$halfOfList]
		Local $randomNumArray2[$countOfItems - $halfOfList]

		For $i = 0 to ($halfOfList - 1)
			$randomNumArray1[$i] = $i
		Next

		For $i = 0 to (($countOfItems - $halfOfList) - 1)
			$randomNumArray2[$i] = $halfOfList  + $i
		Next
	EndIf

	_ArrayShuffle($randomNumArray1)
	_ArrayShuffle($randomNumArray2)

	Redim $randomPlayOrder[$countOfItems]

	For $i = 0 to $halfOfList - 1
		$randomPlayOrder[$i + $i] = $randomNumArray1[$i]

		If $i <> UBound($randomNumArray2) Then
			$randomPlayOrder[$i + $i + 1] = $randomNumArray2[$i]
		EndIf
	Next

	If $randomPlayOrder[0] = $currentPlayingEvent Then ; if the currently playing item is the same as #0 in the new random list array
		_ArraySwap($randomPlayOrder, 0, UBound($randomPlayOrder) - 1) ; switch it with the last item in the random list array for more randomization
	EndIf

	Redim $randomPlayOrder[UBound($randomPlayOrder) + 1] ; adds one more element to the end of the random list array (to hold the current playing #)
	$randomPlayOrder[UBound($randomPlayOrder) - 1] = 1 ; sets the current item to "1" (because we load 0 in the next step)

	loadEvent($randomPlayOrder[0]) ; start playing from the new array's item order, starting at item #0
EndFunc
