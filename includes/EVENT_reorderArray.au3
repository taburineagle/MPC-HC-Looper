Func reorderArray($arrayToSort, $deleteArray)
	Local $arrayToWorkWith[UBound($arrayToSort)][3]

	For $i = 0 to UBound($arrayToSort) - 1
		$currentItem = $arrayToSort[$i]
		$currentItemDelim = StringInStr($currentItem, "|") - 1

		$arrayToWorkWith[$i][0] = $currentItem ; the current item in the list
		$arrayToWorkWith[$i][1] = $i ; the current item's position in the list
		$arrayToWorkWith[$i][2] = Int(StringLeft($currentItem, $currentItemDelim)) ; the current item's position in the global list
	Next

	_ArraySort($arrayToWorkWith, 1, -1, -1, 2)

	$deleteOffset = 0

	For $a = 0 to UBound($arrayToWorkWith) - 1
		If $arrayToWorkWith[$a][2] > $deleteArray[$deleteOffset] Then
			$arrayToWorkWith[$a][2] = $arrayToWorkWith[$a][2] - (UBound($deleteArray) - $deleteOffset)
		ElseIf $arrayToWorkWith[$a][2] = $deleteArray[$deleteOffset] Then
			$arrayToWorkWith[$a][2] = "XX"

			If $deleteOffset <> UBound($deleteArray) - 1 Then
				$deleteOffset = $deleteOffset + 1
			EndIf
		Else

		EndIf
	Next

	_ArraySort($arrayToWorkWith, 0, -1, -1, 1)
	Redim $arrayToSort[0]

	For $b  = 0 to UBound($arrayToWorkWith) - 1
		If $arrayToWorkWith[$b][2] <> "XX" Then
			Redim $arrayToSort[UBound($arrayToSort) + 1]

			$currentItem = $arrayToWorkWith[$b][0]
			$currentItemDelim = StringInStr($currentItem, "|") - 1

			$arrayToSort[UBound($arrayToSort) - 1] = $arrayToWorkWith[$b][2] & StringTrimLeft($currentItem, $currentItemDelim)
		EndIf
	Next

	Return $arrayToSort
EndFunc