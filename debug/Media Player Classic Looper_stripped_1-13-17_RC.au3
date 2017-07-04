Global Const $BS_ICON = 0x0040
Global Const $ES_CENTER = 1
Global Const $ES_AUTOVSCROLL = 64
Global Const $GUI_SS_DEFAULT_INPUT = 0x00000080
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_MINIMIZE = -4
Global Const $GUI_EVENT_RESTORE = -5
Global Const $GUI_EVENT_MAXIMIZE = -6
Global Const $GUI_EVENT_PRIMARYDOWN = -7
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_CHECKED = 1
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $GUI_DEFBUTTON = 512
Global Const $GUI_DOCKLEFT = 0x0002
Global Const $GUI_DOCKTOP = 0x0020
Global Const $GUI_DOCKBOTTOM = 0x0040
Global Const $GUI_DOCKWIDTH = 0x0100
Global Const $GUI_DOCKHEIGHT = 0x0200
Global Const $SS_CENTER = 0x1
Global Const $SS_RIGHT = 0x2
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $WS_MAXIMIZEBOX = 0x00010000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SIZEBOX = 0x00040000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_EX_CLIENTEDGE = 0x00000200
Global Const $WM_GETMINMAXINFO = 0x0024
Global Const $WM_COPYDATA = 0x004A
Global Const $WM_SYSCOMMAND = 0x0112
Global Const $WM_HSCROLL = 0x0114
Global Const $COLOR_GREEN = 0x008000
Global Const $COLOR_RED = 0xFF0000
Global Const $COLOR_WHITE = 0xFFFFFF
Global Const $LV_ERR = -1
Global Const $LVHT_ABOVE = 0x00000008
Global Const $LVHT_BELOW = 0x00000010
Global Const $LVHT_NOWHERE = 0x00000001
Global Const $LVHT_ONITEMICON = 0x00000002
Global Const $LVHT_ONITEMLABEL = 0x00000004
Global Const $LVHT_ONITEMSTATEICON = 0x00000008
Global Const $LVHT_TOLEFT = 0x00000040
Global Const $LVHT_TORIGHT = 0x00000020
Global Const $LVHT_ONITEM = BitOR($LVHT_ONITEMICON, $LVHT_ONITEMLABEL, $LVHT_ONITEMSTATEICON)
Global Const $LVIF_PARAM = 0x00000004
Global Const $LVIF_STATE = 0x00000008
Global Const $LVIF_TEXT = 0x00000001
Global Const $LVIM_AFTER = 0x00000001
Global Const $LVIR_BOUNDS = 0
Global Const $LVIR_ICON = 1
Global Const $LVIS_FOCUSED = 0x0001
Global Const $LVIS_SELECTED = 0x0002
Global Const $LVS_REPORT = 0x0001
Global Const $LVS_SHOWSELALWAYS = 0x0008
Global Const $LVS_EX_FULLROWSELECT = 0x00000020
Global Const $LVS_EX_GRIDLINES = 0x00000001
Global Const $LVM_FIRST = 0x1000
Global Const $LVM_CREATEDRAGIMAGE =($LVM_FIRST + 33)
Global Const $LVM_DELETEALLITEMS =($LVM_FIRST + 9)
Global Const $LVM_ENSUREVISIBLE =($LVM_FIRST + 19)
Global Const $LVM_GETCOLUMNWIDTH =($LVM_FIRST + 29)
Global Const $LVM_GETEXTENDEDLISTVIEWSTYLE =($LVM_FIRST + 55)
Global Const $LVM_GETHEADER =($LVM_FIRST + 31)
Global Const $LVM_GETITEMA =($LVM_FIRST + 5)
Global Const $LVM_GETITEMW =($LVM_FIRST + 75)
Global Const $LVM_GETITEMCOUNT =($LVM_FIRST + 4)
Global Const $LVM_GETITEMRECT =($LVM_FIRST + 14)
Global Const $LVM_GETITEMSTATE =($LVM_FIRST + 44)
Global Const $LVM_GETITEMTEXTA =($LVM_FIRST + 45)
Global Const $LVM_GETITEMTEXTW =($LVM_FIRST + 115)
Global Const $LVM_GETNEXTITEM =($LVM_FIRST + 12)
Global Const $LVM_GETSELECTEDCOUNT =($LVM_FIRST + 50)
Global Const $LVM_GETSUBITEMRECT =($LVM_FIRST + 56)
Global Const $LVM_GETTOPINDEX =($LVM_FIRST + 39)
Global Const $LVM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $LVM_HITTEST =($LVM_FIRST + 18)
Global Const $LVM_INSERTITEMA =($LVM_FIRST + 7)
Global Const $LVM_INSERTITEMW =($LVM_FIRST + 77)
Global Const $LVM_SCROLL =($LVM_FIRST + 20)
Global Const $LVM_SETCOLUMNWIDTH =($LVM_FIRST + 30)
Global Const $LVM_SETINSERTMARK =($LVM_FIRST + 166)
Global Const $LVM_SETINSERTMARKCOLOR =($LVM_FIRST + 170)
Global Const $LVM_SETITEMA =($LVM_FIRST + 6)
Global Const $LVM_SETITEMW =($LVM_FIRST + 76)
Global Const $LVM_SETITEMSTATE =($LVM_FIRST + 43)
Global Const $LVN_FIRST = -100
Global Const $LVN_BEGINDRAG =($LVN_FIRST - 9)
Global Const $LVN_BEGINSCROLL =($LVN_FIRST - 80)
Global Const $LVN_COLUMNCLICK =($LVN_FIRST - 8)
Global Const $LVNI_ABOVE = 0x0100
Global Const $LVNI_BELOW = 0x0200
Global Const $LVNI_TOLEFT = 0x0400
Global Const $LVNI_TORIGHT = 0x0800
Global Const $LVNI_ALL = 0x0000
Global Const $LVNI_CUT = 0x0004
Global Const $LVNI_DROPHILITED = 0x0008
Global Const $LVNI_FOCUSED = 0x0001
Global Const $LVNI_SELECTED = 0x0002
Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $STR_STRIPTRAILING = 2
Global Const $STR_STRIPALL = 8
Global Const $STR_REGEXPARRAYGLOBALMATCH = 3
Func _ArrayDelete(ByRef $aArray, $vRange)
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
If IsArray($vRange) Then
If UBound($vRange, $UBOUND_DIMENSIONS) <> 1 Or UBound($vRange, $UBOUND_ROWS) < 2 Then Return SetError(4, 0, -1)
Else
Local $iNumber, $aSplit_1, $aSplit_2
$vRange = StringStripWS($vRange, 8)
$aSplit_1 = StringSplit($vRange, ";")
$vRange = ""
For $i = 1 To $aSplit_1[0]
If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
$aSplit_2 = StringSplit($aSplit_1[$i], "-")
Switch $aSplit_2[0]
Case 1
$vRange &= $aSplit_2[1] & ";"
Case 2
If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
$iNumber = $aSplit_2[1] - 1
Do
$iNumber += 1
$vRange &= $iNumber & ";"
Until $iNumber = $aSplit_2[2]
EndIf
EndSwitch
Next
$vRange = StringSplit(StringTrimRight($vRange, 1), ";")
EndIf
If $vRange[1] < 0 Or $vRange[$vRange[0]] > $iDim_1 Then Return SetError(5, 0, -1)
Local $iCopyTo_Index = 0
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
For $i = 1 To $vRange[0]
$aArray[$vRange[$i]] = ChrW(0xFAB1)
Next
For $iReadFrom_Index = 0 To $iDim_1
If $aArray[$iReadFrom_Index] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $iReadFrom_Index <> $iCopyTo_Index Then
$aArray[$iCopyTo_Index] = $aArray[$iReadFrom_Index]
EndIf
$iCopyTo_Index += 1
EndIf
Next
ReDim $aArray[$iDim_1 - $vRange[0] + 1]
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
For $i = 1 To $vRange[0]
$aArray[$vRange[$i]][0] = ChrW(0xFAB1)
Next
For $iReadFrom_Index = 0 To $iDim_1
If $aArray[$iReadFrom_Index][0] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $iReadFrom_Index <> $iCopyTo_Index Then
For $j = 0 To $iDim_2
$aArray[$iCopyTo_Index][$j] = $aArray[$iReadFrom_Index][$j]
Next
EndIf
$iCopyTo_Index += 1
EndIf
Next
ReDim $aArray[$iDim_1 - $vRange[0] + 1][$iDim_2 + 1]
Case Else
Return SetError(2, 0, False)
EndSwitch
Return UBound($aArray, $UBOUND_ROWS)
EndFunc
Func _ArrayFindAll(Const ByRef $aArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iSubItem = 0, $bRow = False)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iCase = Default Then $iCase = 0
If $iCompare = Default Then $iCompare = 0
If $iSubItem = Default Then $iSubItem = 0
If $bRow = Default Then $bRow = False
$iStart = _ArraySearch($aArray, $vValue, $iStart, $iEnd, $iCase, $iCompare, 1, $iSubItem, $bRow)
If @error Then Return SetError(@error, 0, -1)
Local $iIndex = 0, $avResult[UBound($aArray,($bRow ? $UBOUND_COLUMNS : $UBOUND_ROWS))]
Do
$avResult[$iIndex] = $iStart
$iIndex += 1
$iStart = _ArraySearch($aArray, $vValue, $iStart + 1, $iEnd, $iCase, $iCompare, 1, $iSubItem, $bRow)
Until @error
ReDim $avResult[$iIndex]
Return $avResult
EndFunc
Func _ArrayReverse(ByRef $aArray, $iStart = 0, $iEnd = 0)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
If UBound($aArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(3, 0, 0)
If Not UBound($aArray) Then Return SetError(4, 0, 0)
Local $vTmp, $iUBound = UBound($aArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
$vTmp = $aArray[$i]
$aArray[$i] = $aArray[$iEnd]
$aArray[$iEnd] = $vTmp
$iEnd -= 1
Next
Return 1
EndFunc
Func _ArraySearch(Const ByRef $aArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iForward = 1, $iSubItem = -1, $bRow = False)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iCase = Default Then $iCase = 0
If $iCompare = Default Then $iCompare = 0
If $iForward = Default Then $iForward = 1
If $iSubItem = Default Then $iSubItem = -1
If $bRow = Default Then $bRow = False
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray) - 1
If $iDim_1 = -1 Then Return SetError(3, 0, -1)
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
Local $bCompType = False
If $iCompare = 2 Then
$iCompare = 0
$bCompType = True
EndIf
If $bRow Then
If UBound($aArray, $UBOUND_DIMENSIONS) = 1 Then Return SetError(5, 0, -1)
If $iEnd < 1 Or $iEnd > $iDim_2 Then $iEnd = $iDim_2
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Else
If $iEnd < 1 Or $iEnd > $iDim_1 Then $iEnd = $iDim_1
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
EndIf
Local $iStep = 1
If Not $iForward Then
Local $iTmp = $iStart
$iStart = $iEnd
$iEnd = $iTmp
$iStep = -1
EndIf
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $bCompType And VarGetType($aArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $bCompType And VarGetType($aArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompare = 3 Then
If StringRegExp($aArray[$i], $vValue) Then Return $i
Else
If StringInStr($aArray[$i], $vValue, $iCase) > 0 Then Return $i
EndIf
Next
EndIf
Case 2
Local $iDim_Sub
If $bRow Then
$iDim_Sub = $iDim_1
If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iDim_Sub = $iSubItem
EndIf
Else
$iDim_Sub = $iDim_2
If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iDim_Sub = $iSubItem
EndIf
EndIf
For $j = $iSubItem To $iDim_Sub
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $bRow Then
If $bCompType And VarGetType($aArray[$j][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$j][$i] = $vValue Then Return $i
Else
If $bCompType And VarGetType($aArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i][$j] = $vValue Then Return $i
EndIf
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $bRow Then
If $bCompType And VarGetType($aArray[$j][$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$j][$i] == $vValue Then Return $i
Else
If $bCompType And VarGetType($aArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i][$j] == $vValue Then Return $i
EndIf
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompare = 3 Then
If $bRow Then
If StringRegExp($aArray[$j][$i], $vValue) Then Return $i
Else
If StringRegExp($aArray[$i][$j], $vValue) Then Return $i
EndIf
Else
If $bRow Then
If StringInStr($aArray[$j][$i], $vValue, $iCase) > 0 Then Return $i
Else
If StringInStr($aArray[$i][$j], $vValue, $iCase) > 0 Then Return $i
EndIf
EndIf
Next
EndIf
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return SetError(6, 0, -1)
EndFunc
Func _ArrayShuffle(ByRef $aArray, $iStart_Row = 0, $iEnd_Row = 0, $iCol = -1)
If $iStart_Row = Default Then $iStart_Row = 0
If $iEnd_Row = Default Then $iEnd_Row = 0
If $iCol = Default Then $iCol = -1
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
If $iEnd_Row = 0 Then $iEnd_Row = $iDim_1 - 1
If $iStart_Row < 0 Or $iStart_Row > $iDim_1 - 1 Then Return SetError(3, 0, -1)
If $iEnd_Row < 1 Or $iEnd_Row > $iDim_1 - 1 Then Return SetError(3, 0, -1)
If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)
Local $vTmp, $iRand
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
For $i = $iEnd_Row To $iStart_Row + 1 Step -1
$iRand = Random($iStart_Row, $i, 1)
$vTmp = $aArray[$i]
$aArray[$i] = $aArray[$iRand]
$aArray[$iRand] = $vTmp
Next
Return 1
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
If $iCol < -1 Or $iCol > $iDim_2 - 1 Then Return SetError(5, 0, -1)
Local $iCol_Start, $iCol_End
If $iCol = -1 Then
$iCol_Start = 0
$iCol_End = $iDim_2 - 1
Else
$iCol_Start = $iCol
$iCol_End = $iCol
EndIf
For $i = $iEnd_Row To $iStart_Row + 1 Step -1
$iRand = Random($iStart_Row, $i, 1)
For $j = $iCol_Start To $iCol_End
$vTmp = $aArray[$i][$j]
$aArray[$i][$j] = $aArray[$iRand][$j]
$aArray[$iRand][$j] = $vTmp
Next
Next
Return 1
Case Else
Return SetError(2, 0, -1)
EndSwitch
EndFunc
Func _ArraySort(ByRef $aArray, $iDescending = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0, $iPivot = 0)
If $iDescending = Default Then $iDescending = 0
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iSubItem = Default Then $iSubItem = 0
If $iPivot = Default Then $iPivot = 0
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
Local $iUBound = UBound($aArray) - 1
If $iUBound = -1 Then Return SetError(5, 0, 0)
If $iEnd = Default Then $iEnd = 0
If $iEnd < 1 Or $iEnd > $iUBound Or $iEnd = Default Then $iEnd = $iUBound
If $iStart < 0 Or $iStart = Default Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
If $iDescending = Default Then $iDescending = 0
If $iPivot = Default Then $iPivot = 0
If $iSubItem = Default Then $iSubItem = 0
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iPivot Then
__ArrayDualPivotSort($aArray, $iStart, $iEnd)
Else
__ArrayQuickSort1D($aArray, $iStart, $iEnd)
EndIf
If $iDescending Then _ArrayReverse($aArray, $iStart, $iEnd)
Case 2
If $iPivot Then Return SetError(6, 0, 0)
Local $iSubMax = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iSubItem > $iSubMax Then Return SetError(3, 0, 0)
If $iDescending Then
$iDescending = -1
Else
$iDescending = 1
EndIf
__ArrayQuickSort2D($aArray, $iDescending, $iStart, $iEnd, $iSubItem, $iSubMax)
Case Else
Return SetError(4, 0, 0)
EndSwitch
Return 1
EndFunc
Func __ArrayQuickSort1D(ByRef $aArray, Const ByRef $iStart, Const ByRef $iEnd)
If $iEnd <= $iStart Then Return
Local $vTmp
If($iEnd - $iStart) < 15 Then
Local $vCur
For $i = $iStart + 1 To $iEnd
$vTmp = $aArray[$i]
If IsNumber($vTmp) Then
For $j = $i - 1 To $iStart Step -1
$vCur = $aArray[$j]
If($vTmp >= $vCur And IsNumber($vCur)) Or(Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
$aArray[$j + 1] = $vCur
Next
Else
For $j = $i - 1 To $iStart Step -1
If(StringCompare($vTmp, $aArray[$j]) >= 0) Then ExitLoop
$aArray[$j + 1] = $aArray[$j]
Next
EndIf
$aArray[$j + 1] = $vTmp
Next
Return
EndIf
Local $L = $iStart, $R = $iEnd, $vPivot = $aArray[Int(($iStart + $iEnd) / 2)], $bNum = IsNumber($vPivot)
Do
If $bNum Then
While($aArray[$L] < $vPivot And IsNumber($aArray[$L])) Or(Not IsNumber($aArray[$L]) And StringCompare($aArray[$L], $vPivot) < 0)
$L += 1
WEnd
While($aArray[$R] > $vPivot And IsNumber($aArray[$R])) Or(Not IsNumber($aArray[$R]) And StringCompare($aArray[$R], $vPivot) > 0)
$R -= 1
WEnd
Else
While(StringCompare($aArray[$L], $vPivot) < 0)
$L += 1
WEnd
While(StringCompare($aArray[$R], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
$vTmp = $aArray[$L]
$aArray[$L] = $aArray[$R]
$aArray[$R] = $vTmp
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort1D($aArray, $iStart, $R)
__ArrayQuickSort1D($aArray, $L, $iEnd)
EndFunc
Func __ArrayQuickSort2D(ByRef $aArray, Const ByRef $iStep, Const ByRef $iStart, Const ByRef $iEnd, Const ByRef $iSubItem, Const ByRef $iSubMax)
If $iEnd <= $iStart Then Return
Local $vTmp, $L = $iStart, $R = $iEnd, $vPivot = $aArray[Int(($iStart + $iEnd) / 2)][$iSubItem], $bNum = IsNumber($vPivot)
Do
If $bNum Then
While($iStep *($aArray[$L][$iSubItem] - $vPivot) < 0 And IsNumber($aArray[$L][$iSubItem])) Or(Not IsNumber($aArray[$L][$iSubItem]) And $iStep * StringCompare($aArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While($iStep *($aArray[$R][$iSubItem] - $vPivot) > 0 And IsNumber($aArray[$R][$iSubItem])) Or(Not IsNumber($aArray[$R][$iSubItem]) And $iStep * StringCompare($aArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
Else
While($iStep * StringCompare($aArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While($iStep * StringCompare($aArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
For $i = 0 To $iSubMax
$vTmp = $aArray[$L][$i]
$aArray[$L][$i] = $aArray[$R][$i]
$aArray[$R][$i] = $vTmp
Next
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort2D($aArray, $iStep, $iStart, $R, $iSubItem, $iSubMax)
__ArrayQuickSort2D($aArray, $iStep, $L, $iEnd, $iSubItem, $iSubMax)
EndFunc
Func __ArrayDualPivotSort(ByRef $aArray, $iPivot_Left, $iPivot_Right, $bLeftMost = True)
If $iPivot_Left > $iPivot_Right Then Return
Local $iLength = $iPivot_Right - $iPivot_Left + 1
Local $i, $j, $k, $iAi, $iAk, $iA1, $iA2, $iLast
If $iLength < 45 Then
If $bLeftMost Then
$i = $iPivot_Left
While $i < $iPivot_Right
$j = $i
$iAi = $aArray[$i + 1]
While $iAi < $aArray[$j]
$aArray[$j + 1] = $aArray[$j]
$j -= 1
If $j + 1 = $iPivot_Left Then ExitLoop
WEnd
$aArray[$j + 1] = $iAi
$i += 1
WEnd
Else
While 1
If $iPivot_Left >= $iPivot_Right Then Return 1
$iPivot_Left += 1
If $aArray[$iPivot_Left] < $aArray[$iPivot_Left - 1] Then ExitLoop
WEnd
While 1
$k = $iPivot_Left
$iPivot_Left += 1
If $iPivot_Left > $iPivot_Right Then ExitLoop
$iA1 = $aArray[$k]
$iA2 = $aArray[$iPivot_Left]
If $iA1 < $iA2 Then
$iA2 = $iA1
$iA1 = $aArray[$iPivot_Left]
EndIf
$k -= 1
While $iA1 < $aArray[$k]
$aArray[$k + 2] = $aArray[$k]
$k -= 1
WEnd
$aArray[$k + 2] = $iA1
While $iA2 < $aArray[$k]
$aArray[$k + 1] = $aArray[$k]
$k -= 1
WEnd
$aArray[$k + 1] = $iA2
$iPivot_Left += 1
WEnd
$iLast = $aArray[$iPivot_Right]
$iPivot_Right -= 1
While $iLast < $aArray[$iPivot_Right]
$aArray[$iPivot_Right + 1] = $aArray[$iPivot_Right]
$iPivot_Right -= 1
WEnd
$aArray[$iPivot_Right + 1] = $iLast
EndIf
Return 1
EndIf
Local $iSeventh = BitShift($iLength, 3) + BitShift($iLength, 6) + 1
Local $iE1, $iE2, $iE3, $iE4, $iE5, $t
$iE3 = Ceiling(($iPivot_Left + $iPivot_Right) / 2)
$iE2 = $iE3 - $iSeventh
$iE1 = $iE2 - $iSeventh
$iE4 = $iE3 + $iSeventh
$iE5 = $iE4 + $iSeventh
If $aArray[$iE2] < $aArray[$iE1] Then
$t = $aArray[$iE2]
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
If $aArray[$iE3] < $aArray[$iE2] Then
$t = $aArray[$iE3]
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
If $aArray[$iE4] < $aArray[$iE3] Then
$t = $aArray[$iE4]
$aArray[$iE4] = $aArray[$iE3]
$aArray[$iE3] = $t
If $t < $aArray[$iE2] Then
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
EndIf
If $aArray[$iE5] < $aArray[$iE4] Then
$t = $aArray[$iE5]
$aArray[$iE5] = $aArray[$iE4]
$aArray[$iE4] = $t
If $t < $aArray[$iE3] Then
$aArray[$iE4] = $aArray[$iE3]
$aArray[$iE3] = $t
If $t < $aArray[$iE2] Then
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
EndIf
EndIf
Local $iLess = $iPivot_Left
Local $iGreater = $iPivot_Right
If(($aArray[$iE1] <> $aArray[$iE2]) And($aArray[$iE2] <> $aArray[$iE3]) And($aArray[$iE3] <> $aArray[$iE4]) And($aArray[$iE4] <> $aArray[$iE5])) Then
Local $iPivot_1 = $aArray[$iE2]
Local $iPivot_2 = $aArray[$iE4]
$aArray[$iE2] = $aArray[$iPivot_Left]
$aArray[$iE4] = $aArray[$iPivot_Right]
Do
$iLess += 1
Until $aArray[$iLess] >= $iPivot_1
Do
$iGreater -= 1
Until $aArray[$iGreater] <= $iPivot_2
$k = $iLess
While $k <= $iGreater
$iAk = $aArray[$k]
If $iAk < $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
ElseIf $iAk > $iPivot_2 Then
While $aArray[$iGreater] > $iPivot_2
$iGreater -= 1
If $iGreater + 1 = $k Then ExitLoop 2
WEnd
If $aArray[$iGreater] < $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $aArray[$iGreater]
$iLess += 1
Else
$aArray[$k] = $aArray[$iGreater]
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
$aArray[$iPivot_Left] = $aArray[$iLess - 1]
$aArray[$iLess - 1] = $iPivot_1
$aArray[$iPivot_Right] = $aArray[$iGreater + 1]
$aArray[$iGreater + 1] = $iPivot_2
__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 2, True)
__ArrayDualPivotSort($aArray, $iGreater + 2, $iPivot_Right, False)
If($iLess < $iE1) And($iE5 < $iGreater) Then
While $aArray[$iLess] = $iPivot_1
$iLess += 1
WEnd
While $aArray[$iGreater] = $iPivot_2
$iGreater -= 1
WEnd
$k = $iLess
While $k <= $iGreater
$iAk = $aArray[$k]
If $iAk = $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
ElseIf $iAk = $iPivot_2 Then
While $aArray[$iGreater] = $iPivot_2
$iGreater -= 1
If $iGreater + 1 = $k Then ExitLoop 2
WEnd
If $aArray[$iGreater] = $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iPivot_1
$iLess += 1
Else
$aArray[$k] = $aArray[$iGreater]
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
EndIf
__ArrayDualPivotSort($aArray, $iLess, $iGreater, False)
Else
Local $iPivot = $aArray[$iE3]
$k = $iLess
While $k <= $iGreater
If $aArray[$k] = $iPivot Then
$k += 1
ContinueLoop
EndIf
$iAk = $aArray[$k]
If $iAk < $iPivot Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
Else
While $aArray[$iGreater] > $iPivot
$iGreater -= 1
WEnd
If $aArray[$iGreater] < $iPivot Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $aArray[$iGreater]
$iLess += 1
Else
$aArray[$k] = $iPivot
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 1, True)
__ArrayDualPivotSort($aArray, $iGreater + 1, $iPivot_Right, False)
EndIf
EndFunc
Func _ArraySwap(ByRef $aArray, $iIndex_1, $iIndex_2, $bCol = False, $iStart = -1, $iEnd = -1)
If $bCol = Default Then $bCol = False
If $iStart = Default Then $iStart = -1
If $iEnd = Default Then $iEnd = -1
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iDim_2 = -1 Then
$bCol = False
$iStart = -1
$iEnd = -1
EndIf
If $iStart > $iEnd Then Return SetError(5, 0, -1)
If $bCol Then
If $iIndex_1 < 0 Or $iIndex_2 > $iDim_2 Then Return SetError(3, 0, -1)
If $iStart = -1 Then $iStart = 0
If $iEnd = -1 Then $iEnd = $iDim_1
Else
If $iIndex_1 < 0 Or $iIndex_2 > $iDim_1 Then Return SetError(3, 0, -1)
If $iStart = -1 Then $iStart = 0
If $iEnd = -1 Then $iEnd = $iDim_2
EndIf
Local $vTmp
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
$vTmp = $aArray[$iIndex_1]
$aArray[$iIndex_1] = $aArray[$iIndex_2]
$aArray[$iIndex_2] = $vTmp
Case 2
If $iStart < -1 Or $iEnd < -1 Then Return SetError(4, 0, -1)
If $bCol Then
If $iStart > $iDim_1 Or $iEnd > $iDim_1 Then Return SetError(4, 0, -1)
For $j = $iStart To $iEnd
$vTmp = $aArray[$j][$iIndex_1]
$aArray[$j][$iIndex_1] = $aArray[$j][$iIndex_2]
$aArray[$j][$iIndex_2] = $vTmp
Next
Else
If $iStart > $iDim_2 Or $iEnd > $iDim_2 Then Return SetError(4, 0, -1)
For $j = $iStart To $iEnd
$vTmp = $aArray[$iIndex_1][$j]
$aArray[$iIndex_1][$j] = $aArray[$iIndex_2][$j]
$aArray[$iIndex_2][$j] = $vTmp
Next
EndIf
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Global Const $MEM_COMMIT = 0x00001000
Global Const $MEM_RESERVE = 0x00002000
Global Const $PAGE_READWRITE = 0x00000004
Global Const $MEM_RELEASE = 0x00008000
Global Const $PROCESS_VM_OPERATION = 0x00000008
Global Const $PROCESS_VM_READ = 0x00000010
Global Const $PROCESS_VM_WRITE = 0x00000020
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Enum $SECURITYANONYMOUS = 0, $SECURITYIDENTIFICATION, $SECURITYIMPERSONATION, $SECURITYDELEGATION
Global Const $TOKEN_QUERY = 0x00000008
Global Const $TOKEN_ADJUST_PRIVILEGES = 0x00000020
Func _WinAPI_GetLastError(Const $_iCurrentError = @error, Const $_iCurrentExtended = @extended)
Local $aResult = DllCall("kernel32.dll", "dword", "GetLastError")
Return SetError($_iCurrentError, $_iCurrentExtended, $aResult[0])
EndFunc
Func _Security__AdjustTokenPrivileges($hToken, $bDisableAll, $tNewState, $iBufferLen, $tPrevState = 0, $pRequired = 0)
Local $aCall = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $hToken, "bool", $bDisableAll, "struct*", $tNewState, "dword", $iBufferLen, "struct*", $tPrevState, "struct*", $pRequired)
If @error Then Return SetError(@error, @extended, False)
Return Not($aCall[0] = 0)
EndFunc
Func _Security__ImpersonateSelf($iLevel = $SECURITYIMPERSONATION)
Local $aCall = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $iLevel)
If @error Then Return SetError(@error, @extended, False)
Return Not($aCall[0] = 0)
EndFunc
Func _Security__LookupPrivilegeValue($sSystem, $sName)
Local $aCall = DllCall("advapi32.dll", "bool", "LookupPrivilegeValueW", "wstr", $sSystem, "wstr", $sName, "int64*", 0)
If @error Or Not $aCall[0] Then Return SetError(@error, @extended, 0)
Return $aCall[3]
EndFunc
Func _Security__OpenThreadToken($iAccess, $hThread = 0, $bOpenAsSelf = False)
If $hThread = 0 Then
Local $aResult = DllCall("kernel32.dll", "handle", "GetCurrentThread")
If @error Then Return SetError(@error + 10, @extended, 0)
$hThread = $aResult[0]
EndIf
Local $aCall = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $hThread, "dword", $iAccess, "bool", $bOpenAsSelf, "handle*", 0)
If @error Or Not $aCall[0] Then Return SetError(@error, @extended, 0)
Return $aCall[4]
EndFunc
Func _Security__OpenThreadTokenEx($iAccess, $hThread = 0, $bOpenAsSelf = False)
Local $hToken = _Security__OpenThreadToken($iAccess, $hThread, $bOpenAsSelf)
If $hToken = 0 Then
Local Const $ERROR_NO_TOKEN = 1008
If _WinAPI_GetLastError() <> $ERROR_NO_TOKEN Then Return SetError(20, _WinAPI_GetLastError(), 0)
If Not _Security__ImpersonateSelf() Then Return SetError(@error + 10, _WinAPI_GetLastError(), 0)
$hToken = _Security__OpenThreadToken($iAccess, $hThread, $bOpenAsSelf)
If $hToken = 0 Then Return SetError(@error, _WinAPI_GetLastError(), 0)
EndIf
Return $hToken
EndFunc
Func _Security__SetPrivilege($hToken, $sPrivilege, $bEnable)
Local $iLUID = _Security__LookupPrivilegeValue("", $sPrivilege)
If $iLUID = 0 Then Return SetError(@error + 10, @extended, False)
Local Const $tagTOKEN_PRIVILEGES = "dword Count;align 4;int64 LUID;dword Attributes"
Local $tCurrState = DllStructCreate($tagTOKEN_PRIVILEGES)
Local $iCurrState = DllStructGetSize($tCurrState)
Local $tPrevState = DllStructCreate($tagTOKEN_PRIVILEGES)
Local $iPrevState = DllStructGetSize($tPrevState)
Local $tRequired = DllStructCreate("int Data")
DllStructSetData($tCurrState, "Count", 1)
DllStructSetData($tCurrState, "LUID", $iLUID)
If Not _Security__AdjustTokenPrivileges($hToken, False, $tCurrState, $iCurrState, $tPrevState, $tRequired) Then Return SetError(2, @error, False)
DllStructSetData($tPrevState, "Count", 1)
DllStructSetData($tPrevState, "LUID", $iLUID)
Local $iAttributes = DllStructGetData($tPrevState, "Attributes")
If $bEnable Then
$iAttributes = BitOR($iAttributes, $SE_PRIVILEGE_ENABLED)
Else
$iAttributes = BitAND($iAttributes, BitNOT($SE_PRIVILEGE_ENABLED))
EndIf
DllStructSetData($tPrevState, "Attributes", $iAttributes)
If Not _Security__AdjustTokenPrivileges($hToken, False, $tPrevState, $iPrevState, $tCurrState, $tRequired) Then Return SetError(3, @error, False)
Return True
EndFunc
Global Const $tagPOINT = "struct;long X;long Y;endstruct"
Global Const $tagRECT = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $tagLVHITTESTINFO = $tagPOINT & ";uint Flags;int Item;int SubItem;int iGroup"
Global Const $tagLVITEM = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
Global Const $tagREBARBANDINFO = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & "int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;handle hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & "uint cyIntegral;uint cxIdeal;lparam lParam;uint cxHeader" &((@OSVersion = "WIN_XP") ? "" : ";" & $tagRECT & ";uint uChevronState")
Global Const $tagSECURITY_ATTRIBUTES = "dword Length;ptr Descriptor;bool InheritHandle"
Global Const $tagMEMMAP = "handle hProc;ulong_ptr Size;ptr Mem"
Func _MemFree(ByRef $tMemMap)
Local $pMemory = DllStructGetData($tMemMap, "Mem")
Local $hProcess = DllStructGetData($tMemMap, "hProc")
Local $bResult = _MemVirtualFreeEx($hProcess, $pMemory, 0, $MEM_RELEASE)
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hProcess)
If @error Then Return SetError(@error, @extended, False)
Return $bResult
EndFunc
Func _MemInit($hWnd, $iSize, ByRef $tMemMap)
Local $aResult = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
If @error Then Return SetError(@error + 10, @extended, 0)
Local $iProcessID = $aResult[2]
If $iProcessID = 0 Then Return SetError(1, 0, 0)
Local $iAccess = BitOR($PROCESS_VM_OPERATION, $PROCESS_VM_READ, $PROCESS_VM_WRITE)
Local $hProcess = __Mem_OpenProcess($iAccess, False, $iProcessID, True)
Local $iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
Local $pMemory = _MemVirtualAllocEx($hProcess, 0, $iSize, $iAlloc, $PAGE_READWRITE)
If $pMemory = 0 Then Return SetError(2, 0, 0)
$tMemMap = DllStructCreate($tagMEMMAP)
DllStructSetData($tMemMap, "hProc", $hProcess)
DllStructSetData($tMemMap, "Size", $iSize)
DllStructSetData($tMemMap, "Mem", $pMemory)
Return $pMemory
EndFunc
Func _MemRead(ByRef $tMemMap, $pSrce, $pDest, $iSize)
Local $aResult = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", DllStructGetData($tMemMap, "hProc"), "ptr", $pSrce, "struct*", $pDest, "ulong_ptr", $iSize, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _MemWrite(ByRef $tMemMap, $pSrce, $pDest = 0, $iSize = 0, $sSrce = "struct*")
If $pDest = 0 Then $pDest = DllStructGetData($tMemMap, "Mem")
If $iSize = 0 Then $iSize = DllStructGetData($tMemMap, "Size")
Local $aResult = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($tMemMap, "hProc"), "ptr", $pDest, $sSrce, $pSrce, "ulong_ptr", $iSize, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
Local $aResult = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iAllocation, "dword", $iProtect)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
Local $aResult = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iFreeType)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func __Mem_OpenProcess($iAccess, $bInherit, $iProcessID, $bDebugPriv = False)
Local $aResult = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $bInherit, "dword", $iProcessID)
If @error Then Return SetError(@error + 10, @extended, 0)
If $aResult[0] Then Return $aResult[0]
If Not $bDebugPriv Then Return 0
Local $hToken = _Security__OpenThreadTokenEx(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
If @error Then Return SetError(@error + 20, @extended, 0)
_Security__SetPrivilege($hToken, "SeDebugPrivilege", True)
Local $iError = @error
Local $iLastError = @extended
Local $iRet = 0
If Not @error Then
$aResult = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $bInherit, "dword", $iProcessID)
$iError = @error
$iLastError = @extended
If $aResult[0] Then $iRet = $aResult[0]
_Security__SetPrivilege($hToken, "SeDebugPrivilege", False)
If @error Then
$iError = @error + 30
$iLastError = @extended
EndIf
Else
$iError = @error + 40
EndIf
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hToken)
Return SetError($iError, $iLastError, $iRet)
EndFunc
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc
Global Const $FO_READ = 0
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Global $__g_aInProcess_WinAPI[64][2] = [[0, 0]]
Func _WinAPI_GetAsyncKeyState($iKey)
Local $aResult = DllCall("user32.dll", "short", "GetAsyncKeyState", "int", $iKey)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetDlgCtrlID($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetWindowThreadProcessId($hWnd, ByRef $iPID)
Local $aResult = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
$iPID = $aResult[2]
Return $aResult[0]
EndFunc
Func _WinAPI_InProcess($hWnd, ByRef $hLastWnd)
If $hWnd = $hLastWnd Then Return True
For $iI = $__g_aInProcess_WinAPI[0][0] To 1 Step -1
If $hWnd = $__g_aInProcess_WinAPI[$iI][0] Then
If $__g_aInProcess_WinAPI[$iI][1] Then
$hLastWnd = $hWnd
Return True
Else
Return False
EndIf
EndIf
Next
Local $iPID
_WinAPI_GetWindowThreadProcessId($hWnd, $iPID)
Local $iCount = $__g_aInProcess_WinAPI[0][0] + 1
If $iCount >= 64 Then $iCount = 1
$__g_aInProcess_WinAPI[0][0] = $iCount
$__g_aInProcess_WinAPI[$iCount][0] = $hWnd
$__g_aInProcess_WinAPI[$iCount][1] =($iPID = @AutoItPID)
Return $__g_aInProcess_WinAPI[$iCount][1]
EndFunc
Func _WinAPI_SetFocus($hWnd)
Local $aResult = DllCall("user32.dll", "hwnd", "SetFocus", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_WindowFromPoint(ByRef $tPoint)
Local $aResult = DllCall("user32.dll", "hwnd", "WindowFromPoint", "struct", $tPoint)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Global Const $_UDF_STARTID = 10000
Global $__g_hLVLastWnd
Global Const $__LISTVIEWCONSTANT_WM_SETREDRAW = 0x000B
Global Const $tagLVINSERTMARK = "uint Size;dword Flags;int Item;dword Reserved"
Func _GUICtrlListView_AddArray($hWnd, ByRef $aItems)
Local $bUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $tItem = DllStructCreate($tagLVITEM)
Local $tBuffer
If $bUnicode Then
$tBuffer = DllStructCreate("wchar Text[4096]")
Else
$tBuffer = DllStructCreate("char Text[4096]")
EndIf
DllStructSetData($tItem, "Mask", $LVIF_TEXT)
DllStructSetData($tItem, "Text", DllStructGetPtr($tBuffer))
DllStructSetData($tItem, "TextMax", 4096)
Local $iLastItem = _GUICtrlListView_GetItemCount($hWnd)
_GUICtrlListView_BeginUpdate($hWnd)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
For $iI = 0 To UBound($aItems) - 1
DllStructSetData($tItem, "Item", $iI)
DllStructSetData($tItem, "SubItem", 0)
DllStructSetData($tBuffer, "Text", $aItems[$iI][0])
_SendMessage($hWnd, $LVM_INSERTITEMW, 0, $tItem, 0, "wparam", "struct*")
For $iJ = 1 To UBound($aItems, $UBOUND_COLUMNS) - 1
DllStructSetData($tItem, "SubItem", $iJ)
DllStructSetData($tBuffer, "Text", $aItems[$iI][$iJ])
_SendMessage($hWnd, $LVM_SETITEMW, 0, $tItem, 0, "wparam", "struct*")
Next
Next
Else
Local $iBuffer = DllStructGetSize($tBuffer)
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iItem
DllStructSetData($tItem, "Text", $pText)
For $iI = 0 To UBound($aItems) - 1
DllStructSetData($tItem, "Item", $iI + $iLastItem)
DllStructSetData($tItem, "SubItem", 0)
DllStructSetData($tBuffer, "Text", $aItems[$iI][0])
_MemWrite($tMemMap, $tItem, $pMemory, $iItem)
_MemWrite($tMemMap, $tBuffer, $pText, $iBuffer)
If $bUnicode Then
_SendMessage($hWnd, $LVM_INSERTITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
_SendMessage($hWnd, $LVM_INSERTITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
For $iJ = 1 To UBound($aItems, $UBOUND_COLUMNS) - 1
DllStructSetData($tItem, "SubItem", $iJ)
DllStructSetData($tBuffer, "Text", $aItems[$iI][$iJ])
_MemWrite($tMemMap, $tItem, $pMemory, $iItem)
_MemWrite($tMemMap, $tBuffer, $pText, $iBuffer)
If $bUnicode Then
_SendMessage($hWnd, $LVM_SETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
_SendMessage($hWnd, $LVM_SETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
Next
Next
_MemFree($tMemMap)
EndIf
Else
Local $pItem = DllStructGetPtr($tItem)
For $iI = 0 To UBound($aItems) - 1
DllStructSetData($tItem, "Item", $iI + $iLastItem)
DllStructSetData($tItem, "SubItem", 0)
DllStructSetData($tBuffer, "Text", $aItems[$iI][0])
If $bUnicode Then
GUICtrlSendMsg($hWnd, $LVM_INSERTITEMW, 0, $pItem)
Else
GUICtrlSendMsg($hWnd, $LVM_INSERTITEMA, 0, $pItem)
EndIf
For $iJ = 1 To UBound($aItems, $UBOUND_COLUMNS) - 1
DllStructSetData($tItem, "SubItem", $iJ)
DllStructSetData($tBuffer, "Text", $aItems[$iI][$iJ])
If $bUnicode Then
GUICtrlSendMsg($hWnd, $LVM_SETITEMW, 0, $pItem)
Else
GUICtrlSendMsg($hWnd, $LVM_SETITEMA, 0, $pItem)
EndIf
Next
Next
EndIf
_GUICtrlListView_EndUpdate($hWnd)
EndFunc
Func _GUICtrlListView_BeginUpdate($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Return _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETREDRAW, False) = 0
EndFunc
Func _GUICtrlListView_CreateDragImage($hWnd, $iIndex)
Local $aDrag[3]
Local $tPoint = DllStructCreate($tagPOINT)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
$aDrag[0] = _SendMessage($hWnd, $LVM_CREATEDRAGIMAGE, $iIndex, $tPoint, 0, "wparam", "struct*", "handle")
Else
Local $iPoint = DllStructGetSize($tPoint)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iPoint, $tMemMap)
$aDrag[0] = _SendMessage($hWnd, $LVM_CREATEDRAGIMAGE, $iIndex, $pMemory, 0, "wparam", "ptr", "handle")
_MemRead($tMemMap, $pMemory, $tPoint, $iPoint)
_MemFree($tMemMap)
EndIf
Else
$aDrag[0] = Ptr(GUICtrlSendMsg($hWnd, $LVM_CREATEDRAGIMAGE, $iIndex, DllStructGetPtr($tPoint)))
EndIf
$aDrag[1] = DllStructGetData($tPoint, "X")
$aDrag[2] = DllStructGetData($tPoint, "Y")
Return $aDrag
EndFunc
Func _GUICtrlListView_DeleteAllItems($hWnd)
If _GUICtrlListView_GetItemCount($hWnd) = 0 Then Return True
Local $vCID = 0
If IsHWnd($hWnd) Then
$vCID = _WinAPI_GetDlgCtrlID($hWnd)
Else
$vCID = $hWnd
$hWnd = GUICtrlGetHandle($hWnd)
EndIf
If $vCID < $_UDF_STARTID Then
Local $iParam = 0
For $iIndex = _GUICtrlListView_GetItemCount($hWnd) - 1 To 0 Step -1
$iParam = _GUICtrlListView_GetItemParam($hWnd, $iIndex)
If GUICtrlGetState($iParam) > 0 And GUICtrlGetHandle($iParam) = 0 Then
GUICtrlDelete($iParam)
EndIf
Next
If _GUICtrlListView_GetItemCount($hWnd) = 0 Then Return True
EndIf
Return _SendMessage($hWnd, $LVM_DELETEALLITEMS) <> 0
EndFunc
Func _GUICtrlListView_EndUpdate($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Return _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETREDRAW, True) = 0
EndFunc
Func _GUICtrlListView_EnsureVisible($hWnd, $iIndex, $bPartialOK = False)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_ENSUREVISIBLE, $iIndex, $bPartialOK)
Else
Return GUICtrlSendMsg($hWnd, $LVM_ENSUREVISIBLE, $iIndex, $bPartialOK)
EndIf
EndFunc
Func _GUICtrlListView_GetColumnCount($hWnd)
Return _SendMessage(_GUICtrlListView_GetHeader($hWnd), 0x1200)
EndFunc
Func _GUICtrlListView_GetColumnWidth($hWnd, $iCol)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETCOLUMNWIDTH, $iCol)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETCOLUMNWIDTH, $iCol, 0)
EndIf
EndFunc
Func _GUICtrlListView_GetExtendedListViewStyle($hWnd)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETEXTENDEDLISTVIEWSTYLE)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)
EndIf
EndFunc
Func _GUICtrlListView_GetHeader($hWnd)
If IsHWnd($hWnd) Then
Return HWnd(_SendMessage($hWnd, $LVM_GETHEADER))
Else
Return HWnd(GUICtrlSendMsg($hWnd, $LVM_GETHEADER, 0, 0))
EndIf
EndFunc
Func _GUICtrlListView_GetItemChecked($hWnd, $iIndex)
Local $bUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $tLVITEM = DllStructCreate($tagLVITEM)
Local $iSize = DllStructGetSize($tLVITEM)
If @error Then Return SetError($LV_ERR, $LV_ERR, False)
DllStructSetData($tLVITEM, "Mask", $LVIF_STATE)
DllStructSetData($tLVITEM, "Item", $iIndex)
DllStructSetData($tLVITEM, "StateMask", 0xffff)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
$iRet = _SendMessage($hWnd, $LVM_GETITEMW, 0, $tLVITEM, 0, "wparam", "struct*") <> 0
Else
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iSize, $tMemMap)
_MemWrite($tMemMap, $tLVITEM)
If $bUnicode Then
$iRet = _SendMessage($hWnd, $LVM_GETITEMW, 0, $pMemory, 0, "wparam", "ptr") <> 0
Else
$iRet = _SendMessage($hWnd, $LVM_GETITEMA, 0, $pMemory, 0, "wparam", "ptr") <> 0
EndIf
_MemRead($tMemMap, $pMemory, $tLVITEM, $iSize)
_MemFree($tMemMap)
EndIf
Else
Local $pItem = DllStructGetPtr($tLVITEM)
If $bUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMW, 0, $pItem) <> 0
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMA, 0, $pItem) <> 0
EndIf
EndIf
If Not $iRet Then Return SetError($LV_ERR, $LV_ERR, False)
Return BitAND(DllStructGetData($tLVITEM, "State"), 0x2000) <> 0
EndFunc
Func _GUICtrlListView_GetItemCount($hWnd)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETITEMCOUNT)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETITEMCOUNT, 0, 0)
EndIf
EndFunc
Func _GUICtrlListView_GetItemEx($hWnd, ByRef $tItem)
Local $bUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
$iRet = _SendMessage($hWnd, $LVM_GETITEMW, 0, $tItem, 0, "wparam", "struct*")
Else
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem, $tMemMap)
_MemWrite($tMemMap, $tItem)
If $bUnicode Then
_SendMessage($hWnd, $LVM_GETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
_SendMessage($hWnd, $LVM_GETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemRead($tMemMap, $pMemory, $tItem, $iItem)
_MemFree($tMemMap)
EndIf
Else
Local $pItem = DllStructGetPtr($tItem)
If $bUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMW, 0, $pItem)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMA, 0, $pItem)
EndIf
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_GetItemFocused($hWnd, $iIndex)
Return _GUICtrlListView_GetItemState($hWnd, $iIndex, $LVIS_FOCUSED) <> 0
EndFunc
Func _GUICtrlListView_GetItemParam($hWnd, $iIndex)
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tItem, "Mask", $LVIF_PARAM)
DllStructSetData($tItem, "Item", $iIndex)
_GUICtrlListView_GetItemEx($hWnd, $tItem)
Return DllStructGetData($tItem, "Param")
EndFunc
Func _GUICtrlListView_GetItemRect($hWnd, $iIndex, $iPart = 3)
Local $tRECT = _GUICtrlListView_GetItemRectEx($hWnd, $iIndex, $iPart)
Local $aRect[4]
$aRect[0] = DllStructGetData($tRECT, "Left")
$aRect[1] = DllStructGetData($tRECT, "Top")
$aRect[2] = DllStructGetData($tRECT, "Right")
$aRect[3] = DllStructGetData($tRECT, "Bottom")
Return $aRect
EndFunc
Func _GUICtrlListView_GetItemRectEx($hWnd, $iIndex, $iPart = 3)
Local $tRECT = DllStructCreate($tagRECT)
DllStructSetData($tRECT, "Left", $iPart)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
_SendMessage($hWnd, $LVM_GETITEMRECT, $iIndex, $tRECT, 0, "wparam", "struct*")
Else
Local $iRect = DllStructGetSize($tRECT)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iRect, $tMemMap)
_MemWrite($tMemMap, $tRECT, $pMemory, $iRect)
_SendMessage($hWnd, $LVM_GETITEMRECT, $iIndex, $pMemory, 0, "wparam", "ptr")
_MemRead($tMemMap, $pMemory, $tRECT, $iRect)
_MemFree($tMemMap)
EndIf
Else
GUICtrlSendMsg($hWnd, $LVM_GETITEMRECT, $iIndex, DllStructGetPtr($tRECT))
EndIf
Return $tRECT
EndFunc
Func _GUICtrlListView_GetItemState($hWnd, $iIndex, $iMask)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETITEMSTATE, $iIndex, $iMask)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETITEMSTATE, $iIndex, $iMask)
EndIf
EndFunc
Func _GUICtrlListView_GetItemText($hWnd, $iIndex, $iSubItem = 0)
Local $bUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $tBuffer
If $bUnicode Then
$tBuffer = DllStructCreate("wchar Text[4096]")
Else
$tBuffer = DllStructCreate("char Text[4096]")
EndIf
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tItem, "SubItem", $iSubItem)
DllStructSetData($tItem, "TextMax", 4096)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
DllStructSetData($tItem, "Text", $pBuffer)
_SendMessage($hWnd, $LVM_GETITEMTEXTW, $iIndex, $tItem, 0, "wparam", "struct*")
Else
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem + 4096, $tMemMap)
Local $pText = $pMemory + $iItem
DllStructSetData($tItem, "Text", $pText)
_MemWrite($tMemMap, $tItem, $pMemory, $iItem)
If $bUnicode Then
_SendMessage($hWnd, $LVM_GETITEMTEXTW, $iIndex, $pMemory, 0, "wparam", "ptr")
Else
_SendMessage($hWnd, $LVM_GETITEMTEXTA, $iIndex, $pMemory, 0, "wparam", "ptr")
EndIf
_MemRead($tMemMap, $pText, $tBuffer, 4096)
_MemFree($tMemMap)
EndIf
Else
Local $pItem = DllStructGetPtr($tItem)
DllStructSetData($tItem, "Text", $pBuffer)
If $bUnicode Then
GUICtrlSendMsg($hWnd, $LVM_GETITEMTEXTW, $iIndex, $pItem)
Else
GUICtrlSendMsg($hWnd, $LVM_GETITEMTEXTA, $iIndex, $pItem)
EndIf
EndIf
Return DllStructGetData($tBuffer, "Text")
EndFunc
Func _GUICtrlListView_GetItemTextArray($hWnd, $iItem = -1)
Local $sItems = _GUICtrlListView_GetItemTextString($hWnd, $iItem)
If $sItems = "" Then
Local $aItems[1] = [0]
Return SetError($LV_ERR, $LV_ERR, $aItems)
EndIf
Return StringSplit($sItems, Opt('GUIDataSeparatorChar'))
EndFunc
Func _GUICtrlListView_GetItemTextString($hWnd, $iItem = -1)
Local $sRow = "", $sSeparatorChar = Opt('GUIDataSeparatorChar'), $iSelected
If $iItem = -1 Then
$iSelected = _GUICtrlListView_GetNextItem($hWnd)
Else
$iSelected = $iItem
EndIf
For $x = 0 To _GUICtrlListView_GetColumnCount($hWnd) - 1
$sRow &= _GUICtrlListView_GetItemText($hWnd, $iSelected, $x) & $sSeparatorChar
Next
Return StringTrimRight($sRow, 1)
EndFunc
Func _GUICtrlListView_GetNextItem($hWnd, $iStart = -1, $iSearch = 0, $iState = 8)
Local $aSearch[5] = [$LVNI_ALL, $LVNI_ABOVE, $LVNI_BELOW, $LVNI_TOLEFT, $LVNI_TORIGHT]
Local $iFlags = $aSearch[$iSearch]
If BitAND($iState, 1) <> 0 Then $iFlags = BitOR($iFlags, $LVNI_CUT)
If BitAND($iState, 2) <> 0 Then $iFlags = BitOR($iFlags, $LVNI_DROPHILITED)
If BitAND($iState, 4) <> 0 Then $iFlags = BitOR($iFlags, $LVNI_FOCUSED)
If BitAND($iState, 8) <> 0 Then $iFlags = BitOR($iFlags, $LVNI_SELECTED)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETNEXTITEM, $iStart, $iFlags)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETNEXTITEM, $iStart, $iFlags)
EndIf
EndFunc
Func _GUICtrlListView_GetSelectedCount($hWnd)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETSELECTEDCOUNT)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETSELECTEDCOUNT, 0, 0)
EndIf
EndFunc
Func __GUICtrlListView_GetCheckedIndices($hWnd)
Local $iCount = _GUICtrlListView_GetItemCount($hWnd)
Local $aSelected[$iCount + 1] = [0]
For $i = 0 To $iCount - 1
If _GUICtrlListView_GetItemChecked($hWnd, $i) Then
$aSelected[0] += 1
$aSelected[$aSelected[0]] = $i
EndIf
Next
ReDim $aSelected[$aSelected[0] + 1]
Return $aSelected
EndFunc
Func _GUICtrlListView_GetSelectedIndices($hWnd, $bArray = False)
Local $sIndices, $aIndices[1] = [0]
Local $iRet, $iCount = _GUICtrlListView_GetItemCount($hWnd)
For $iItem = 0 To $iCount
If IsHWnd($hWnd) Then
$iRet = _SendMessage($hWnd, $LVM_GETITEMSTATE, $iItem, $LVIS_SELECTED)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMSTATE, $iItem, $LVIS_SELECTED)
EndIf
If $iRet Then
If(Not $bArray) Then
If StringLen($sIndices) Then
$sIndices &= "|" & $iItem
Else
$sIndices = $iItem
EndIf
Else
ReDim $aIndices[UBound($aIndices) + 1]
$aIndices[0] = UBound($aIndices) - 1
$aIndices[UBound($aIndices) - 1] = $iItem
EndIf
EndIf
Next
If(Not $bArray) Then
Return String($sIndices)
Else
Return $aIndices
EndIf
EndFunc
Func _GUICtrlListView_GetSubItemRect($hWnd, $iIndex, $iSubItem, $iPart = 0)
Local $aPart[2] = [$LVIR_BOUNDS, $LVIR_ICON]
Local $tRECT = DllStructCreate($tagRECT)
DllStructSetData($tRECT, "Top", $iSubItem)
DllStructSetData($tRECT, "Left", $aPart[$iPart])
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
_SendMessage($hWnd, $LVM_GETSUBITEMRECT, $iIndex, $tRECT, 0, "wparam", "struct*")
Else
Local $iRect = DllStructGetSize($tRECT)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iRect, $tMemMap)
_MemWrite($tMemMap, $tRECT, $pMemory, $iRect)
_SendMessage($hWnd, $LVM_GETSUBITEMRECT, $iIndex, $pMemory, 0, "wparam", "ptr")
_MemRead($tMemMap, $pMemory, $tRECT, $iRect)
_MemFree($tMemMap)
EndIf
Else
GUICtrlSendMsg($hWnd, $LVM_GETSUBITEMRECT, $iIndex, DllStructGetPtr($tRECT))
EndIf
Local $aRect[4]
$aRect[0] = DllStructGetData($tRECT, "Left")
$aRect[1] = DllStructGetData($tRECT, "Top")
$aRect[2] = DllStructGetData($tRECT, "Right")
$aRect[3] = DllStructGetData($tRECT, "Bottom")
Return $aRect
EndFunc
Func _GUICtrlListView_GetTopIndex($hWnd)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETTOPINDEX)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETTOPINDEX, 0, 0)
EndIf
EndFunc
Func _GUICtrlListView_GetUnicodeFormat($hWnd)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETUNICODEFORMAT) <> 0
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETUNICODEFORMAT, 0, 0) <> 0
EndIf
EndFunc
Func _GUICtrlListView_HitTest($hWnd, $iX = -1, $iY = -1)
Local $aTest[10]
Local $iMode = Opt("MouseCoordMode", 1)
Local $aPos = MouseGetPos()
Opt("MouseCoordMode", $iMode)
Local $tPoint = DllStructCreate($tagPOINT)
DllStructSetData($tPoint, "X", $aPos[0])
DllStructSetData($tPoint, "Y", $aPos[1])
Local $aResult = DllCall("user32.dll", "bool", "ScreenToClient", "hwnd", $hWnd, "struct*", $tPoint)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] = 0 Then Return 0
If $iX = -1 Then $iX = DllStructGetData($tPoint, "X")
If $iY = -1 Then $iY = DllStructGetData($tPoint, "Y")
Local $tTest = DllStructCreate($tagLVHITTESTINFO)
DllStructSetData($tTest, "X", $iX)
DllStructSetData($tTest, "Y", $iY)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
$aTest[0] = _SendMessage($hWnd, $LVM_HITTEST, 0, $tTest, 0, "wparam", "struct*")
Else
Local $iTest = DllStructGetSize($tTest)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iTest, $tMemMap)
_MemWrite($tMemMap, $tTest, $pMemory, $iTest)
$aTest[0] = _SendMessage($hWnd, $LVM_HITTEST, 0, $pMemory, 0, "wparam", "ptr")
_MemRead($tMemMap, $pMemory, $tTest, $iTest)
_MemFree($tMemMap)
EndIf
Else
$aTest[0] = GUICtrlSendMsg($hWnd, $LVM_HITTEST, 0, DllStructGetPtr($tTest))
EndIf
Local $iFlags = DllStructGetData($tTest, "Flags")
$aTest[1] = BitAND($iFlags, $LVHT_NOWHERE) <> 0
$aTest[2] = BitAND($iFlags, $LVHT_ONITEMICON) <> 0
$aTest[3] = BitAND($iFlags, $LVHT_ONITEMLABEL) <> 0
$aTest[4] = BitAND($iFlags, $LVHT_ONITEMSTATEICON) <> 0
$aTest[5] = BitAND($iFlags, $LVHT_ONITEM) <> 0
$aTest[6] = BitAND($iFlags, $LVHT_ABOVE) <> 0
$aTest[7] = BitAND($iFlags, $LVHT_BELOW) <> 0
$aTest[8] = BitAND($iFlags, $LVHT_TOLEFT) <> 0
$aTest[9] = BitAND($iFlags, $LVHT_TORIGHT) <> 0
Return $aTest
EndFunc
Func _GUICtrlListView_Scroll($hWnd, $iDX, $iDY)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_SCROLL, $iDX, $iDY) <> 0
Else
Return GUICtrlSendMsg($hWnd, $LVM_SCROLL, $iDX, $iDY) <> 0
EndIf
EndFunc
Func _GUICtrlListView_SetColumnWidth($hWnd, $iCol, $iWidth)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_SETCOLUMNWIDTH, $iCol, $iWidth)
Else
Return GUICtrlSendMsg($hWnd, $LVM_SETCOLUMNWIDTH, $iCol, $iWidth)
EndIf
EndFunc
Func _GUICtrlListView_SetInsertMark($hWnd, $iIndex, $bAfter = False)
Local $tMark = DllStructCreate($tagLVINSERTMARK)
Local $iMark = DllStructGetSize($tMark)
DllStructSetData($tMark, "Size", $iMark)
If $bAfter Then DllStructSetData($tMark, "Flags", $LVIM_AFTER)
DllStructSetData($tMark, "Item", $iIndex)
DllStructSetData($tMark, "Reserved", 0)
Local $iRet
If IsHWnd($hWnd) Then
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iMark, $tMemMap)
_MemWrite($tMemMap, $tMark, $pMemory, $iMark)
$iRet = _SendMessage($hWnd, $LVM_SETINSERTMARK, 0, $pMemory, 0, "wparam", "ptr")
_MemFree($tMemMap)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETINSERTMARK, 0, DllStructGetPtr($tMark))
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_SetInsertMarkColor($hWnd, $iColor)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_SETINSERTMARKCOLOR, 0, $iColor)
Else
Return GUICtrlSendMsg($hWnd, $LVM_SETINSERTMARKCOLOR, 0, $iColor)
EndIf
EndFunc
Func _GUICtrlListView_SetItemChecked($hWnd, $iIndex, $bCheck = True)
Local $bUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $pMemory, $tMemMap, $iRet
Local $tItem = DllStructCreate($tagLVITEM)
Local $pItem = DllStructGetPtr($tItem)
Local $iItem = DllStructGetSize($tItem)
If @error Then Return SetError($LV_ERR, $LV_ERR, $LV_ERR)
If $iIndex <> -1 Then
DllStructSetData($tItem, "Mask", $LVIF_STATE)
DllStructSetData($tItem, "Item", $iIndex)
If($bCheck) Then
DllStructSetData($tItem, "State", 0x2000)
Else
DllStructSetData($tItem, "State", 0x1000)
EndIf
DllStructSetData($tItem, "StateMask", 0xf000)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
Return _SendMessage($hWnd, $LVM_SETITEMW, 0, $tItem, 0, "wparam", "struct*") <> 0
Else
$pMemory = _MemInit($hWnd, $iItem, $tMemMap)
_MemWrite($tMemMap, $tItem)
If $bUnicode Then
$iRet = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_SETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
Return $iRet <> 0
EndIf
Else
If $bUnicode Then
Return GUICtrlSendMsg($hWnd, $LVM_SETITEMW, 0, $pItem) <> 0
Else
Return GUICtrlSendMsg($hWnd, $LVM_SETITEMA, 0, $pItem) <> 0
EndIf
EndIf
Else
For $x = 0 To _GUICtrlListView_GetItemCount($hWnd) - 1
DllStructSetData($tItem, "Mask", $LVIF_STATE)
DllStructSetData($tItem, "Item", $x)
If($bCheck) Then
DllStructSetData($tItem, "State", 0x2000)
Else
DllStructSetData($tItem, "State", 0x1000)
EndIf
DllStructSetData($tItem, "StateMask", 0xf000)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
If Not _SendMessage($hWnd, $LVM_SETITEMW, 0, $tItem, 0, "wparam", "struct*") <> 0 Then Return SetError($LV_ERR, $LV_ERR, $LV_ERR)
Else
$pMemory = _MemInit($hWnd, $iItem, $tMemMap)
_MemWrite($tMemMap, $tItem)
If $bUnicode Then
$iRet = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_SETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
If Not $iRet <> 0 Then Return SetError($LV_ERR, $LV_ERR, $LV_ERR)
EndIf
Else
If $bUnicode Then
If Not GUICtrlSendMsg($hWnd, $LVM_SETITEMW, 0, $pItem) <> 0 Then Return SetError($LV_ERR, $LV_ERR, $LV_ERR)
Else
If Not GUICtrlSendMsg($hWnd, $LVM_SETITEMA, 0, $pItem) <> 0 Then Return SetError($LV_ERR, $LV_ERR, $LV_ERR)
EndIf
EndIf
Next
Return True
EndIf
Return False
EndFunc
Func _GUICtrlListView_SetItemEx($hWnd, ByRef $tItem)
Local $bUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $iRet
If IsHWnd($hWnd) Then
Local $iItem = DllStructGetSize($tItem)
Local $iBuffer = DllStructGetData($tItem, "TextMax")
Local $pBuffer = DllStructGetData($tItem, "Text")
If $bUnicode Then $iBuffer *= 2
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iItem
DllStructSetData($tItem, "Text", $pText)
_MemWrite($tMemMap, $tItem, $pMemory, $iItem)
If $pBuffer <> 0 Then _MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
If $bUnicode Then
$iRet = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_SETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
Else
Local $pItem = DllStructGetPtr($tItem)
If $bUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMW, 0, $pItem)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMA, 0, $pItem)
EndIf
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_SetItemParam($hWnd, $iIndex, $iParam)
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tItem, "Mask", $LVIF_PARAM)
DllStructSetData($tItem, "Item", $iIndex)
DllStructSetData($tItem, "Param", $iParam)
Return _GUICtrlListView_SetItemEx($hWnd, $tItem)
EndFunc
Func _GUICtrlListView_SetItemSelected($hWnd, $iIndex, $bSelected = True, $bFocused = False)
Local $tStruct = DllStructCreate($tagLVITEM)
Local $iRet, $iSelected = 0, $iFocused = 0, $iSize, $tMemMap, $pMemory
If($bSelected = True) Then $iSelected = $LVIS_SELECTED
If($bFocused = True And $iIndex <> -1) Then $iFocused = $LVIS_FOCUSED
DllStructSetData($tStruct, "Mask", $LVIF_STATE)
DllStructSetData($tStruct, "Item", $iIndex)
DllStructSetData($tStruct, "State", BitOR($iSelected, $iFocused))
DllStructSetData($tStruct, "StateMask", BitOR($LVIS_SELECTED, $iFocused))
$iSize = DllStructGetSize($tStruct)
If IsHWnd($hWnd) Then
$pMemory = _MemInit($hWnd, $iSize, $tMemMap)
_MemWrite($tMemMap, $tStruct, $pMemory, $iSize)
$iRet = _SendMessage($hWnd, $LVM_SETITEMSTATE, $iIndex, $pMemory)
_MemFree($tMemMap)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMSTATE, $iIndex, DllStructGetPtr($tStruct))
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_SetItemState($hWnd, $iIndex, $iState, $iStateMask)
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tItem, "Mask", $LVIF_STATE)
DllStructSetData($tItem, "Item", $iIndex)
DllStructSetData($tItem, "State", $iState)
DllStructSetData($tItem, "StateMask", $iStateMask)
Return _GUICtrlListView_SetItemEx($hWnd, $tItem) <> 0
EndFunc
Func _GUICtrlListView_SetItemText($hWnd, $iIndex, $sText, $iSubItem = 0)
Local $bUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $iRet
If $iSubItem = -1 Then
Local $sSeparatorChar = Opt('GUIDataSeparatorChar')
Local $i_Cols = _GUICtrlListView_GetColumnCount($hWnd)
Local $a_Text = StringSplit($sText, $sSeparatorChar)
If $i_Cols > $a_Text[0] Then $i_Cols = $a_Text[0]
For $i = 1 To $i_Cols
$iRet = _GUICtrlListView_SetItemText($hWnd, $iIndex, $a_Text[$i], $i - 1)
If Not $iRet Then ExitLoop
Next
Return $iRet
EndIf
Local $iBuffer = StringLen($sText) + 1
Local $tBuffer
If $bUnicode Then
$tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
$iBuffer *= 2
Else
$tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
EndIf
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tBuffer, "Text", $sText)
DllStructSetData($tItem, "Mask", $LVIF_TEXT)
DllStructSetData($tItem, "item", $iIndex)
DllStructSetData($tItem, "SubItem", $iSubItem)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__g_hLVLastWnd) Then
DllStructSetData($tItem, "Text", $pBuffer)
$iRet = _SendMessage($hWnd, $LVM_SETITEMW, 0, $tItem, 0, "wparam", "struct*")
Else
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iItem
DllStructSetData($tItem, "Text", $pText)
_MemWrite($tMemMap, $tItem, $pMemory, $iItem)
_MemWrite($tMemMap, $tBuffer, $pText, $iBuffer)
If $bUnicode Then
$iRet = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_SETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
EndIf
Else
Local $pItem = DllStructGetPtr($tItem)
DllStructSetData($tItem, "Text", $pBuffer)
If $bUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMW, 0, $pItem)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMA, 0, $pItem)
EndIf
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_SimpleSort($hWnd, ByRef $vSortSense, $iCol, $bToggleSense = True)
Local $iItemCount = _GUICtrlListView_GetItemCount($hWnd)
If $iItemCount Then
Local $iDescending = 0
If UBound($vSortSense) Then
$iDescending = $vSortSense[$iCol]
Else
$iDescending = $vSortSense
EndIf
Local $vSeparatorChar = Opt('GUIDataSeparatorChar')
Local $iColumnCount = _GUICtrlListView_GetColumnCount($hWnd)
Local Enum $iIndexValue = $iColumnCount, $iItemParam
Local $aListViewItems[$iItemCount][$iColumnCount + 2]
Local $aSelectedItems = StringSplit(_GUICtrlListView_GetSelectedIndices($hWnd), $vSeparatorChar)
Local $aCheckedItems = __GUICtrlListView_GetCheckedIndices($hWnd)
Local $sItemText, $iFocused = -1
For $i = 0 To $iItemCount - 1
If $iFocused = -1 Then
If _GUICtrlListView_GetItemFocused($hWnd, $i) Then $iFocused = $i
EndIf
_GUICtrlListView_SetItemSelected($hWnd, $i, False)
_GUICtrlListView_SetItemChecked($hWnd, $i, False)
For $j = 0 To $iColumnCount - 1
$sItemText = StringStripWS(_GUICtrlListView_GetItemText($hWnd, $i, $j), $STR_STRIPTRAILING)
If(StringIsFloat($sItemText) Or StringIsInt($sItemText)) Then
$aListViewItems[$i][$j] = Number($sItemText)
Else
$aListViewItems[$i][$j] = $sItemText
EndIf
Next
$aListViewItems[$i][$iIndexValue] = $i
$aListViewItems[$i][$iItemParam] = _GUICtrlListView_GetItemParam($hWnd, $i)
Next
_ArraySort($aListViewItems, $iDescending, 0, 0, $iCol)
For $i = 0 To $iItemCount - 1
For $j = 0 To $iColumnCount - 1
_GUICtrlListView_SetItemText($hWnd, $i, $aListViewItems[$i][$j], $j)
Next
_GUICtrlListView_SetItemParam($hWnd, $i, $aListViewItems[$i][$iItemParam])
For $j = 1 To $aSelectedItems[0]
If $aListViewItems[$i][$iIndexValue] = $aSelectedItems[$j] Then
If $aListViewItems[$i][$iIndexValue] = $iFocused Then
_GUICtrlListView_SetItemSelected($hWnd, $i, True, True)
Else
_GUICtrlListView_SetItemSelected($hWnd, $i, True)
EndIf
ExitLoop
EndIf
Next
For $j = 1 To $aCheckedItems[0]
If $aListViewItems[$i][$iIndexValue] = $aCheckedItems[$j] Then
_GUICtrlListView_SetItemChecked($hWnd, $i, True)
ExitLoop
EndIf
Next
Next
If $bToggleSense Then
If UBound($vSortSense) Then
$vSortSense[$iCol] = Not $iDescending
Else
$vSortSense = Not $iDescending
EndIf
EndIf
EndIf
EndFunc
Global Const $tagOSVERSIONINFO = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $__WINVER = __WINVER()
Func __Iif($bTest, $vTrue, $vFalse)
Return $bTest ? $vTrue : $vFalse
EndFunc
Func __WINVER()
Local $tOSVI = DllStructCreate($tagOSVERSIONINFO)
DllStructSetData($tOSVI, 1, DllStructGetSize($tOSVI))
Local $aRet = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $tOSVI)
If @error Or Not $aRet[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($tOSVI, 2), -8), DllStructGetData($tOSVI, 3))
EndFunc
Global Const $tagPRINTDLG = __Iif(@AutoItX64, '', 'align 2;') & 'dword Size;hwnd hOwner;handle hDevMode;handle hDevNames;handle hDC;dword Flags;word FromPage;word ToPage;word MinPage;word MaxPage;word Copies;handle hInstance;lparam lParam;ptr PrintHook;ptr SetupHook;ptr PrintTemplateName;ptr SetupTemplateName;handle hPrintTemplate;handle hSetupTemplate'
Global Const $GCL_STYLE = -26
Func _WinAPI_GetClassLongEx($hWnd, $iIndex)
Local $aRet
If @AutoItX64 Then
$aRet = DllCall('user32.dll', 'ulong_ptr', 'GetClassLongPtrW', 'hwnd', $hWnd, 'int', $iIndex)
Else
$aRet = DllCall('user32.dll', 'dword', 'GetClassLongW', 'hwnd', $hWnd, 'int', $iIndex)
EndIf
If @error Or Not $aRet[0] Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _WinAPI_SetClassLongEx($hWnd, $iIndex, $iNewLong)
Local $aRet
If @AutoItX64 Then
$aRet = DllCall('user32.dll', 'ulong_ptr', 'SetClassLongPtrW', 'hwnd', $hWnd, 'int', $iIndex, 'long_ptr', $iNewLong)
Else
$aRet = DllCall('user32.dll', 'dword', 'SetClassLongW', 'hwnd', $hWnd, 'int', $iIndex, 'long', $iNewLong)
EndIf
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _FileCountLines($sFilePath)
Local $hFileOpen = FileOpen($sFilePath, $FO_READ)
If $hFileOpen = -1 Then Return SetError(1, 0, 0)
Local $sFileRead = StringStripWS(FileRead($hFileOpen), $STR_STRIPTRAILING)
FileClose($hFileOpen)
Return UBound(StringRegExp($sFileRead, "\R", $STR_REGEXPARRAYGLOBALMATCH)) + 1 - Int($sFileRead = "")
EndFunc
Global Const $TBS_AUTOTICKS = 0x0001
Global Const $TBS_NOTICKS = 0x0010
Global Const $GUI_SS_DEFAULT_SLIDER = $TBS_AUTOTICKS
Func _Singleton($sOccurrenceName, $iFlag = 0)
Local Const $ERROR_ALREADY_EXISTS = 183
Local Const $SECURITY_DESCRIPTOR_REVISION = 1
Local $tSecurityAttributes = 0
If BitAND($iFlag, 2) Then
Local $tSecurityDescriptor = DllStructCreate("byte;byte;word;ptr[4]")
Local $aRet = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $tSecurityDescriptor, "dword", $SECURITY_DESCRIPTOR_REVISION)
If @error Then Return SetError(@error, @extended, 0)
If $aRet[0] Then
$aRet = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $tSecurityDescriptor, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aRet[0] Then
$tSecurityAttributes = DllStructCreate($tagSECURITY_ATTRIBUTES)
DllStructSetData($tSecurityAttributes, 1, DllStructGetSize($tSecurityAttributes))
DllStructSetData($tSecurityAttributes, 2, DllStructGetPtr($tSecurityDescriptor))
DllStructSetData($tSecurityAttributes, 3, 0)
EndIf
EndIf
EndIf
Local $aHandle = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $tSecurityAttributes, "bool", 1, "wstr", $sOccurrenceName)
If @error Then Return SetError(@error, @extended, 0)
Local $aLastError = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $aLastError[0] = $ERROR_ALREADY_EXISTS Then
If BitAND($iFlag, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $aHandle[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($aLastError[0], $aLastError[0], 0)
Else
Exit -1
EndIf
EndIf
Return $aHandle[0]
EndFunc
Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
Local $a_R = DllCall($vDLL, "short", "GetAsyncKeyState", "int", '0x' & $sHexKey)
If @error Then Return SetError(@error, @extended, False)
Return BitAND($a_R[0], 0x8000) <> 0
EndFunc
Global Const $CMD_OPENFILE = 0xA0000000
Global Const $CMD_GETNOWPLAYING = 0xA0003002
Global Const $CMD_GETCURRENTPOSITION = 0xA0003004
Global Const $CMD_SETPOSITION = 0xA0002000
Global Const $CMD_SETSPEED = 0xA0004008
Global Const $CMD_STOP = 0xA0000001
Global Const $CMD_PLAY = 0xA0000004
Global Const $CMD_PAUSE = 0xA0000005
Global Const $CMD_PLAYPAUSE = 0xA0000003
Global Const $CMD_TOGGLEFULLSCREEN = 0xA0004000
Global $gs_messages, $ghnd_MPC_handle
GUIRegisterMsg($WM_COPYDATA, "__Msg_WM_COPYDATA")
Func __MPC_send_message($prm_hnd_MPC, $prm_MPC_Command, $prm_MPC_parameter)
Local $StructDef_COPYDATA
Local $st_COPYDATA
Local $p_COPYDATA
Local $st_CDString
Local $p_CDString
Local $i_StringSize
$StructDef_COPYDATA = "dword dwData;dword cbData;ptr lpData"
$st_COPYDATA = DllStructCreate($StructDef_COPYDATA)
$i_StringSize = StringLen($prm_MPC_parameter) + 1
$st_CDString = DllStructCreate("wchar var1[" & $i_StringSize & "]")
DllStructSetData($st_CDString, 1, $prm_MPC_parameter)
DllStructSetData($st_CDString, 1, 0, $i_StringSize)
$p_CDString = DllStructGetPtr($st_CDString)
DllStructSetData($st_COPYDATA, "dwData", $prm_MPC_Command)
DllStructSetData($st_COPYDATA, "cbData", $i_StringSize * 2)
DllStructSetData($st_COPYDATA, "lpData", $p_CDString)
$p_COPYDATA = DllStructGetPtr($st_COPYDATA)
_SendMessage($prm_hnd_MPC, $WM_COPYDATA, 0, $p_COPYDATA)
$st_COPYDATA = 0
$st_CDString = 0
EndFunc
Func __Msg_WM_COPYDATA($hWnd, $Msg, $wParam, $lParam)
Local $StructDef_COPYDATA
Local $st_COPYDATA
Local $StructDef_DataString
Local $st_DataString
Local $s_DataString
Local $s_dwData, $s_cbData, $s_lpData
$StructDef_COPYDATA = "dword dwData;dword cbData;ptr lpData"
$StructDef_DataString = "char DataString"
$st_COPYDATA = DllStructCreate($StructDef_COPYDATA, $LParam)
$s_dwData = DllStructGetData($st_COPYDATA, "dwData")
$s_cbData = DllStructGetData($st_COPYDATA, "cbData")
$s_lpData = DllStructGetData($st_COPYDATA, "lpData")
$StructDef_DataString = "wchar DataString[" & Int($s_cbData) & "]"
$st_DataString = DllStructCreate($StructDef_DataString, $s_lpData)
$s_DataString = DllStructGetData($st_DataString, "DataString")
Switch $s_dwData
Case 1342177280
$ghnd_MPC_handle = $s_DataString
Case 1342177283
$nowPlayingInfo = StringSplit($s_DataString, "|")
Case 1342177287
$currentPosition = $s_DataString
Case 1342177281
$isLoaded = $s_DataString
Case 1342177291
$MPCInitialized = 2
EndSwitch
EndFunc
Func _ShellFile_Install($sText, $sFileType, $sName = @ScriptName, $sFilePath = @ScriptFullPath, $sIconPath = @ScriptFullPath, $iIcon = 0, $fAllUsers = False, $fExtended = False)
Local $i64Bit = '', $sRegistryKey = ''
If $iIcon = Default Then
$iIcon = 0
EndIf
If $sFilePath = Default Then
$sFilePath = @ScriptFullPath
EndIf
If $sIconPath = Default Then
$sIconPath = @ScriptFullPath
EndIf
If $sName = Default Then
$sName = @ScriptName
EndIf
If @OSArch = 'X64' Then
$i64Bit = '64'
EndIf
If $fAllUsers Then
$sRegistryKey = 'HKEY_LOCAL_MACHINE' & $i64Bit & '\SOFTWARE\Classes\'
Else
$sRegistryKey = 'HKEY_CURRENT_USER' & $i64Bit & '\SOFTWARE\Classes\'
EndIf
$sFileType = StringRegExpReplace($sFileType, '^\.+', '')
$sName = StringLower(StringRegExpReplace($sName, '\.[^.\\/]*$', ''))
If StringStripWS($sName, $STR_STRIPALL) = '' Or FileExists($sFilePath) = 0 Or StringStripWS($sFileType, $STR_STRIPALL) = '' Then
Return SetError(1, 0, False)
EndIf
_ShellFile_Uninstall($sFileType, $fAllUsers)
Local $iReturn = 0
$iReturn += RegWrite($sRegistryKey & '.' & $sFileType, '', 'REG_SZ', $sName)
$iReturn += RegWrite($sRegistryKey & $sName & '\DefaultIcon\', '', 'REG_SZ', $sIconPath & ',' & $iIcon)
$iReturn += RegWrite($sRegistryKey & $sName & '\shell\open', '', 'REG_SZ', $sText)
$iReturn += RegWrite($sRegistryKey & $sName & '\shell\open', 'Icon', 'REG_EXPAND_SZ', $sIconPath & ',' & $iIcon)
$iReturn += RegWrite($sRegistryKey & $sName & '\shell\open\command\', '', 'REG_SZ', '"' & $sFilePath & '" "%1"')
$iReturn += RegWrite($sRegistryKey & $sName, '', 'REG_SZ', $sText)
$iReturn += RegWrite($sRegistryKey & $sName, 'Icon', 'REG_EXPAND_SZ', $sIconPath & ',' & $iIcon)
$iReturn += RegWrite($sRegistryKey & $sName & '\command', '', 'REG_SZ', '"' & $sFilePath & '" "%1"')
If $fExtended Then
$iReturn += RegWrite($sRegistryKey & $sName, 'Extended', 'REG_SZ', '')
EndIf
Return $iReturn > 0
EndFunc
Func _ShellFile_Uninstall($sFileType, $fAllUsers = False)
Local $i64Bit = '', $sRegistryKey = ''
If @OSArch = 'X64' Then
$i64Bit = '64'
EndIf
If $fAllUsers Then
$sRegistryKey = 'HKEY_LOCAL_MACHINE' & $i64Bit & '\SOFTWARE\Classes\'
Else
$sRegistryKey = 'HKEY_CURRENT_USER' & $i64Bit & '\SOFTWARE\Classes\'
EndIf
$sFileType = StringRegExpReplace($sFileType, '^\.+', '')
If StringStripWS($sFileType, $STR_STRIPALL) = '' Then
Return SetError(1, 0, False)
EndIf
Local $iReturn = 0, $sName = RegRead($sRegistryKey & '.' & $sFileType, '')
If @error Then
Return SetError(2, 0, False)
EndIf
$iReturn += RegDelete($sRegistryKey & '.' & $sFileType)
$iReturn += RegDelete($sRegistryKey & $sName)
Return $iReturn > 0
EndFunc
Func _GUIImageList_BeginDrag($hWnd, $iTrack, $iXHotSpot, $iYHotSpot)
Local $aResult = DllCall("comctl32.dll", "bool", "ImageList_BeginDrag", "handle", $hWnd, "int", $iTrack, "int", $iXHotSpot, "int", $iYHotSpot)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0] <> 0
EndFunc
Func _GUIImageList_Destroy($hWnd)
Local $aResult = DllCall("comctl32.dll", "bool", "ImageList_Destroy", "handle", $hWnd)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0] <> 0
EndFunc
Func _GUIImageList_DragLeave($hWnd)
Local $aResult = DllCall("comctl32.dll", "bool", "ImageList_DragLeave", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0] <> 0
EndFunc
Func _GUIImageList_EndDrag()
DllCall("comctl32.dll", "none", "ImageList_EndDrag")
If @error Then Return SetError(@error, @extended)
EndFunc
Global $aGLVEx_Data[1][13] = [[0, 0, -1]]
Global $hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVEx_SrcIndex, $aGLVEx_SrcArray
Global $hGLVEx_TgtHandle, $cGLVEx_TgtID, $iGLVEx_TgtIndex, $aGLVEx_TgtArray
Global $iGLVEx_Dragging = 0, $iGLVEx_DraggedIndex, $hGLVEx_DraggedImage = 0
Global $iGLVEx_InsertIndex = -1, $iGLVEx_LastY, $fGLVEx_BarUnder
Global $hGLVEx_Editing, $cGLVEx_EditID = 9999, $fGLVEx_EditClickFlag = False, $fGLVEx_HeaderEdit = False
Global $sGLVEx_SepChar = Opt("GUIDataSeparatorChar")
Func _GUIListViewEx_Init($hLV, $aArray = "", $iStart = 0, $iColour = 0, $fImage = False, $iAdded = 0, $sCols = "*")
Local $iIndex = 0
For $i = 1 To $aGLVEx_Data[0][0]
If $aGLVEx_Data[$i][0] = 0 Then
$iIndex = $i
ExitLoop
EndIf
Next
If $iIndex = 0 Then
$aGLVEx_Data[0][0] += 1
ReDim $aGLVEx_Data[$aGLVEx_Data[0][0] + 1][UBound($aGLVEx_Data, 2)]
$iIndex = $aGLVEx_Data[0][0]
EndIf
If IsHWnd($hLV) Then
$aGLVEx_Data[$iIndex][0] = $hLV
$aGLVEx_Data[$iIndex][1] = 0
Else
$aGLVEx_Data[$iIndex][0] = GUICtrlGetHandle($hLV)
$aGLVEx_Data[$iIndex][1] = $hLV
EndIf
$aGLVEx_Data[$iIndex][2] = _GUIListViewEx_ReadToArray($hLV, 1)
$aGLVEx_Data[$iIndex][3] = $iStart
If IsArray($aArray) Then
If UBound($aArray, 0) = 2 Then $aGLVEx_Data[$iIndex][3] += 2
EndIf
_GUICtrlListView_SetInsertMarkColor($hLV, BitOR(BitShift(BitAND($iColour, 0x000000FF), -16), BitAND($iColour, 0x0000FF00), BitShift(BitAND($iColour, 0x00FF0000), 16)))
If $fImage Then
$aGLVEx_Data[$iIndex][5] = 1
EndIf
If BitAND($iAdded, 1) Then
Local $aLVSortState[_GUICtrlListView_GetColumnCount($hLV)]
$aGLVEx_Data[$iIndex][4] = $aLVSortState
Else
$aGLVEx_Data[$iIndex][4] = 0
EndIf
If BitAND($iAdded, 2) Then
$aGLVEx_Data[$iIndex][7] = _GUIListViewEx_ExpandCols($sCols)
Opt("GUICloseOnESC", 0)
If BitAND($iAdded, 4) Then
$aGLVEx_Data[$iIndex][7] &= ";#"
EndIf
If BitAND($iAdded, 8) Then
$aGLVEx_Data[$iIndex][8] = 1
EndIf
Else
$aGLVEx_Data[$iIndex][7] = ""
EndIf
If BitAND($iAdded, 16) Then
$aGLVEx_Data[$iIndex][9] = 1
EndIf
If BitAND($iAdded, 32) Then
Local $aComboData_Array[_GUICtrlListView_GetColumnCount($hLV)]
$aGLVEx_Data[$iIndex][11] = $aComboData_Array
EndIf
If BitAnd($iAdded, 64) Then
$aGLVEx_Data[$iIndex][12] = 1
EndIf
If BitAnd($iAdded, 128) Then
$aGLVEx_Data[$iIndex][12] += 2
EndIf
If BitAnd($iAdded, 256) Then
$aGLVEx_Data[$iIndex][12] += 4
EndIf
If BitAND(_GUICtrlListView_GetExtendedListViewStyle($hLV), 4) Then
$aGLVEx_Data[$iIndex][6] = 1
EndIf
Local $aRect = _GUICtrlListView_GetItemRect($aGLVEx_Data[$iIndex][0], 0)
$aGLVEx_Data[$iIndex][10] = $aRect[3] - $aRect[1]
Local $iListView_Count = 0
For $i = 1 To $iIndex
If $aGLVEx_Data[$i][0] Then $iListView_Count += 1
Next
If $iListView_Count = 1 Then _GUIListViewEx_SetActive($iIndex)
Return $iIndex
EndFunc
Func _GUIListViewEx_Close($iIndex = 0)
If $iIndex < 0 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, 0)
If $iIndex = 0 Then
Global $aGLVEx_Data[1][UBound($aGLVEx_Data, 2)] = [[0, 0]]
Else
For $i = 0 To UBound($aGLVEx_Data, 2) - 1
$aGLVEx_Data[$iIndex][$i] = 0
Next
If $aGLVEx_Data[0][1] = $iIndex Then $aGLVEx_Data[0][1] = 0
EndIf
Return 1
EndFunc
Func _GUIListViewEx_SetActive($iIndex)
If $iIndex < 0 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, -1)
Local $iCurr_Index = $aGLVEx_Data[0][1]
If $iIndex Then
$aGLVEx_Data[0][1] = $iIndex
$hGLVEx_SrcHandle = $aGLVEx_Data[$iIndex][0]
$cGLVEx_SrcID = $aGLVEx_Data[$iIndex][1]
Else
$aGLVEx_Data[0][1] = 0
$hGLVEx_SrcHandle = 0
$cGLVEx_SrcID = 0
EndIf
Return $iCurr_Index
EndFunc
Func _GUIListViewEx_ReadToArray($hLV, $iStart = 0)
Local $aLVArray = "", $aRow
If Not IsHWnd($hLV) Then
$hLV = GUICtrlGetHandle($hLV)
If Not IsHWnd($hLV) Then
Return SetError(1, 0, "")
EndIf
EndIf
Local $iRows = _GUICtrlListView_GetItemCount($hLV)
If $iRows + $iStart <> 0 Then
Local $iCols = _GUICtrlListView_GetColumnCount($hLV)
Local $aLVArray[$iRows + $iStart][$iCols] = [[$iRows]]
For $i = 0 To $iRows - 1
$aRow = _GUICtrlListView_GetItemTextArray($hLV, $i)
For $j = 1 To $aRow[0]
$aLVArray[$i + $iStart][$j - 1] = $aRow[$j]
Next
Next
EndIf
Return $aLVArray
EndFunc
Func _GUIListViewEx_ReturnArray($iIndex, $iCheck = 0)
If $iIndex < 1 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, "")
Local $aRetArray = $aGLVEx_Data[$iIndex][2]
If $iCheck Then
If $aGLVEx_Data[$iIndex][6] Then
Local $aCheck_Array[UBound($aRetArray)]
For $i = 1 To UBound($aRetArray) - 1
$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($aGLVEx_Data[$iIndex][0], $i - 1)
Next
If BitAND($aGLVEx_Data[$iIndex][3], 1) = 0 Then
If $aRetArray[0][0] = 0 Then Return SetError(2, 0, "")
_GUIListViewEx_Array_Delete($aCheck_Array, 0)
EndIf
Return $aCheck_Array
Else
Return SetError(3, 0, "")
EndIf
EndIf
Local $iCount = 1
If BitAND($aGLVEx_Data[$iIndex][3], 1) = 0 Then
$iCount = 0
If $aRetArray[0][0] = 0 Then Return SetError(2, 0, "")
_GUIListViewEx_Array_Delete($aRetArray, 0, True)
EndIf
If BitAND($aGLVEx_Data[$iIndex][3], 2) = 0 Then
Local $iCols = UBound($aRetArray, 2)
Local $aTempArray[UBound($aRetArray)] = [$aRetArray[0][0]]
For $i = $iCount To UBound($aTempArray) - 1
Local $aLine = ""
For $j = 0 To $iCols - 1
$aLine &= $aRetArray[$i][$j] & $sGLVEx_SepChar
Next
$aTempArray[$i] = StringTrimRight($aLine, 1)
Next
$aRetArray = $aTempArray
EndIf
Return $aRetArray
EndFunc
Func _GUIListViewEx_Insert($vData, $fMultiRow = False, $fRetainWidth = False)
Local $vInsert
Local $iArray_Index = $aGLVEx_Data[0][1]
If $iArray_Index = 0 Then Return SetError(1, 0, "")
$hGLVEx_SrcHandle = $aGLVEx_Data[$iArray_Index][0]
$cGLVEx_SrcID = $aGLVEx_Data[$iArray_Index][1]
Local $fCheckBox = $aGLVEx_Data[$iArray_Index][6]
$aGLVEx_SrcArray = $aGLVEx_Data[$iArray_Index][2]
Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
For $i = 1 To UBound($aCheck_Array) - 1
$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
Next
Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
Local $iInsert_Index = $iIndex
If $iIndex = "" Then $iInsert_Index = -1
If StringInStr($iIndex, $sGLVEx_SepChar) Then
Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
$iIndex = $aIndex[1]
For $i = 2 To $aIndex[0]
_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, $aIndex[$i], False)
Next
EndIf
Local $aCol_Width, $iColCount
If $fRetainWidth And $cGLVEx_SrcID Then
$iColCount = _GUICtrlListView_GetColumnCount($hGLVEx_SrcHandle)
Local $aCol_Width[$iColCount]
For $i = 1 To $iColCount - 1
$aCol_Width[$i] = _GUICtrlListView_GetColumnWidth($hGLVEx_SrcHandle, $i)
Next
EndIf
If $aGLVEx_SrcArray[0][0] = 0 Then $iInsert_Index = 0
If IsArray($vData) Then
$vInsert = $vData
Else
Local $aData = StringSplit($vData, $sGLVEx_SepChar)
Switch $aData[0]
Case 1
$vInsert = $aData[1]
Case Else
Local $vInsert[$aData[0]]
For $i = 0 To $aData[0] - 1
$vInsert[$i] = $aData[$i + 1]
Next
EndSwitch
EndIf
If $iIndex = "" Then
_GUIListViewEx_Array_Add($aGLVEx_SrcArray, $vInsert, $fMultiRow)
_GUIListViewEx_Array_Add($aCheck_Array, $vInsert, $fMultiRow)
Else
_GUIListViewEx_Array_Insert($aGLVEx_SrcArray, $iInsert_Index + 2, $vInsert, $fMultiRow)
_GUIListViewEx_Array_Insert($aCheck_Array, $iInsert_Index + 2, $vInsert, $fMultiRow)
EndIf
_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iArray_Index, $fCheckBox)
If $iIndex = "" Then
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, _GUICtrlListView_GetItemCount($hGLVEx_SrcHandle) - 1)
Else
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iInsert_Index + 1)
EndIf
If $fRetainWidth And $cGLVEx_SrcID Then
For $i = 1 To $iColCount - 1
$aCol_Width[$i] = _GUICtrlListView_SetColumnWidth($hGLVEx_SrcHandle, $i, $aCol_Width[$i])
Next
EndIf
$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_SrcArray
$aGLVEx_SrcArray = 0
Return _GUIListViewEx_ReturnArray($iArray_Index)
EndFunc
Func _GUIListViewEx_Delete($vRange = "")
Local $iArray_Index = $aGLVEx_Data[0][1]
If $iArray_Index = 0 Then Return SetError(1, 0, "")
$hGLVEx_SrcHandle = $aGLVEx_Data[$iArray_Index][0]
$cGLVEx_SrcID = $aGLVEx_Data[$iArray_Index][1]
$aGLVEx_SrcArray = $aGLVEx_Data[$iArray_Index][2]
Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
For $i = 1 To UBound($aCheck_Array) - 1
$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
Next
Local $aSplit_1, $aSplit_2, $iIndex
If $vRange Then
Local $iNumber
$vRange = StringStripWS($vRange, 8)
$aSplit_1 = StringSplit($vRange, ";")
$vRange = ""
For $i = 1 To $aSplit_1[0]
If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(4, 0, -1)
$aSplit_2 = StringSplit($aSplit_1[$i], "-")
Switch $aSplit_2[0]
Case 1
$vRange &= $aSplit_2[1] & $sGLVEx_SepChar
Case 2
If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
$iNumber = $aSplit_2[1] - 1
Do
$iNumber += 1
$vRange &= $iNumber & $sGLVEx_SepChar
Until $iNumber = $aSplit_2[2]
EndIf
EndSwitch
Next
$iIndex = StringTrimRight($vRange, 1)
Else
$iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
If $iIndex = "" Then Return SetError(2, 0, "")
EndIf
Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
For $i = 1 To $aIndex[0]
_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, $i, False)
Next
Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
For $i = 1 To UBound($aCheck_Array) - 1
$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
Next
For $i = $aIndex[0] To 1 Step -1
_GUIListViewEx_Array_Delete($aGLVEx_SrcArray, $aIndex[$i] + 1)
_GUIListViewEx_Array_Delete($aCheck_Array, $aIndex[$i] + 1)
Next
_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iArray_Index)
If $aIndex[1] = 0 Then
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, 0)
Else
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $aIndex[1] - 1)
EndIf
$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_SrcArray
$aGLVEx_SrcArray = 0
Return _GUIListViewEx_ReturnArray($iArray_Index)
EndFunc
Func _GUIListViewEx_Up()
Local $iGLVExMove_Index, $iGLVEx_Moving = 0
Local $iArray_Index = $aGLVEx_Data[0][1]
If $iArray_Index = 0 Then Return SetError(1, 0, 0)
$hGLVEx_SrcHandle = $aGLVEx_Data[$iArray_Index][0]
$cGLVEx_SrcID = $aGLVEx_Data[$iArray_Index][1]
$aGLVEx_SrcArray = $aGLVEx_Data[$iArray_Index][2]
Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
For $i = 1 To UBound($aCheck_Array) - 1
$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
Next
Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
If $iIndex = "" Then
Return SetError(2, 0, "")
EndIf
Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
$iGLVExMove_Index = $aIndex[1]
If $aIndex[0] > 1 Then
For $i = 1 To $aIndex[0] - 1
If $aIndex[$i + 1] = $aIndex[1] + $i Then
$iGLVEx_Moving += 1
Else
ExitLoop
EndIf
Next
Else
$iGLVExMove_Index = $aIndex[1]
EndIf
If $iGLVExMove_Index < 1 Then
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, 0)
Return SetError(3, 0, "")
EndIf
_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, -1, False)
For $iIndex = $iGLVExMove_Index To $iGLVExMove_Index + $iGLVEx_Moving
_GUIListViewEx_Array_Swap($aGLVEx_SrcArray, $iIndex, $iIndex + 1)
_GUIListViewEx_Array_Swap($aCheck_Array, $iIndex, $iIndex + 1)
Next
_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iArray_Index)
For $i = 0 To $iGLVEx_Moving
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVExMove_Index + $i - 1)
Next
$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_SrcArray
$aGLVEx_SrcArray = 0
Return _GUIListViewEx_ReturnArray($iArray_Index)
EndFunc
Func _GUIListViewEx_MsgRegister($fNOTIFY = True, $fMOUSEMOVE = True, $fLBUTTONUP = True)
If $fNOTIFY Then GUIRegisterMsg(0x004E, "_GUIListViewEx_WM_NOTIFY_Handler")
If $fMOUSEMOVE Then GUIRegisterMsg(0x0200, "_GUIListViewEx_WM_MOUSEMOVE_Handler")
If $fLBUTTONUP Then GUIRegisterMsg(0x0202, "_GUIListViewEx_WM_LBUTTONUP_Handler")
EndFunc
Func _GUIListViewEx_WM_NOTIFY_Handler($hWnd, $iMsg, $wParam, $lParam)
#forceref $hWnd, $iMsg, $wParam
Local $tStruct = DllStructCreate("hwnd;uint_ptr;int_ptr;int;int", $lParam)
If @error Then Return
For $iLV_Index = 1 To $aGLVEx_Data[0][0]
If DllStructGetData($tStruct, 1) = $aGLVEx_Data[$iLV_Index][0] Then
ExitLoop
EndIf
Next
If $iLV_Index > $aGLVEx_Data[0][0] Then Return
Local $iCode = BitAND(DllStructGetData($tStruct, 3), 0xFFFFFFFF)
Switch $iCode
Case $LVN_BEGINSCROLL
If $cGLVEx_EditID <> 9999 Then
GUICtrlDelete($cGLVEx_EditID)
$cGLVEx_EditID = 9999
WinSetState($hGLVEx_Editing, "", @SW_ENABLE)
EndIf
Case $LVN_COLUMNCLICK, -2
$aGLVEx_Data[0][1] = $iLV_Index
$hGLVEx_SrcHandle = $aGLVEx_Data[$iLV_Index][0]
$cGLVEx_SrcID = $aGLVEx_Data[$iLV_Index][1]
Local $iCol = DllStructGetData($tStruct, 5)
$aGLVEx_Data[0][2] = $iCol
If $iCode = $LVN_COLUMNCLICK Then
Local $aRect = _GUICtrlListView_GetSubItemRect($hGLVEx_SrcHandle, 0, $iCol)
_WinAPI_GetAsyncKeyState(0x11)
If _WinAPI_GetAsyncKeyState(0x11) Then
Local $sValidCols = $aGLVEx_Data[$iLV_Index][7]
If StringInStr($sValidCols, "*") Or StringInStr(";" & $sValidCols, ";" & $iCol) Then
$fGLVEx_HeaderEdit = True
EndIf
Else
If IsArray($aGLVEx_Data[$iLV_Index][4]) Then
$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
Local $aLVSortState = $aGLVEx_Data[$iLV_Index][4]
_GUICtrlListView_SimpleSort($hGLVEx_SrcHandle, $aLVSortState, $iCol)
setModified()
$aGLVEx_Data[$iLV_Index][4] = $aLVSortState
Local $iDim2 = UBound($aGLVEx_SrcArray, 2) - 1
For $j = 1 To $aGLVEx_SrcArray[0][0]
For $k = 0 To $iDim2
$aGLVEx_SrcArray[$j][$k] = _GUICtrlListView_GetItemText($hGLVEx_SrcHandle, $j - 1, $k)
Next
Next
$aGLVEx_Data[$iLV_Index][2] = $aGLVEx_SrcArray
$aGLVEx_SrcArray = 0
EndIf
EndIf
ElseIf $iCode = -2 Then
$isClicked = 1
EndIf
Case $LVN_BEGINDRAG
$aGLVEx_Data[0][1] = $iLV_Index
$hGLVEx_SrcHandle = $aGLVEx_Data[$iLV_Index][0]
$cGLVEx_SrcID = $aGLVEx_Data[$iLV_Index][1]
$iGLVEx_SrcIndex = $iLV_Index
$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
$hGLVEx_TgtHandle = $hGLVEx_SrcHandle
$cGLVEx_TgtID = $cGLVEx_SrcID
$iGLVEx_TgtIndex = $iGLVEx_SrcIndex
$aGLVEx_TgtArray = $aGLVEx_SrcArray
$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
Local $fImage = $aGLVEx_Data[$iLV_Index][5]
If $cGLVEx_SrcID Then
GUICtrlSetState($cGLVEx_SrcID, 256)
Else
_WinAPI_SetFocus($hGLVEx_SrcHandle)
EndIf
$iGLVEx_DraggedIndex = DllStructGetData($tStruct, 4)
$iGLVEx_Dragging = 1
Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
If StringInStr($iIndex, $iGLVEx_DraggedIndex) And StringInStr($iIndex, $sGLVEx_SepChar) Then
Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
For $i = 1 To $aIndex[0]
If $aIndex[$i] = $iGLVEx_DraggedIndex Then ExitLoop
Next
If $i <> 1 Then
For $j = $i - 1 To 1 Step -1
If $aIndex[$j] <> $aIndex[$j + 1] - 1 Then ExitLoop
$iGLVEx_DraggedIndex -= 1
$iGLVEx_Dragging += 1
Next
EndIf
If $i <> $aIndex[0] Then
For $j = $i + 1 To $aIndex[0]
If $aIndex[$j] <> $aIndex[$j - 1] + 1 Then ExitLoop
$iGLVEx_Dragging += 1
Next
EndIf
Else
$iGLVEx_Dragging = 1
EndIf
_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, -1, False)
If $fImage Then
Local $aImageData = _GUICtrlListView_CreateDragImage($hGLVEx_SrcHandle, $iGLVEx_DraggedIndex)
$hGLVEx_DraggedImage = $aImageData[0]
_GUIImageList_BeginDrag($hGLVEx_DraggedImage, 0, 0, 0)
EndIf
Case -3
If $aGLVEx_Data[$iLV_Index][7] <> "" Then
$aGLVEx_Data[0][1] = $iLV_Index
$hGLVEx_SrcHandle = $aGLVEx_Data[$iLV_Index][0]
$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
$fGLVEx_EditClickFlag = True
EndIf
$isClicked = 2
EndSwitch
EndFunc
Func _GUIListViewEx_WM_MOUSEMOVE_Handler($hWnd, $iMsg, $wParam, $lParam)
#forceref $hWnd, $iMsg, $wParam
Local $iVertScroll
If $iGLVEx_Dragging = 0 Then
Return "GUI_RUNDEFMSG"
EndIf
If $aGLVEx_Data[$aGLVEx_Data[0][1]][10] Then
$iVertScroll = $aGLVEx_Data[$aGLVEx_Data[0][1]][10]
Else
Local $aRect = _GUICtrlListView_GetItemRect($hGLVEx_SrcHandle, 0)
$iVertScroll = $aRect[3] - $aRect[1]
EndIf
Local $hCurrent_Wnd = _GUIListViewEx_GetCursorWnd()
If $hCurrent_Wnd <> $hGLVEx_TgtHandle Then
If BitAnd($aGLVEx_Data[$iGLVEx_TgtIndex][12], 1) Then
Return "GUI_RUNDEFMSG"
EndIf
For $i = 1 To $aGLVEx_Data[0][0]
If $aGLVEx_Data[$i][0] = $hCurrent_Wnd Then
If BitAnd($aGLVEx_Data[$i][12], 2) Then
Return "GUI_RUNDEFMSG"
EndIf
If $aGLVEx_Data[$iGLVEx_SrcIndex][6] + $aGLVEx_Data[$i][6] = 0 Then
If _GUICtrlListView_GetColumnCount($hGLVEx_SrcHandle) = _GUICtrlListView_GetColumnCount($hCurrent_Wnd) Then
_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, -1, True)
$hGLVEx_TgtHandle = $hCurrent_Wnd
$cGLVEx_TgtID = $aGLVEx_Data[$i][1]
$iGLVEx_TgtIndex = $i
$aGLVEx_TgtArray = $aGLVEx_Data[$i][2]
$aGLVEx_Data[0][3] = $aGLVEx_Data[$i][10]
ExitLoop
EndIf
EndIf
EndIf
Next
EndIf
Local $iCurr_Y = BitShift($lParam, 16)
If $iGLVEx_InsertIndex <> -1 Then
If $iGLVEx_LastY = $iCurr_Y Then
Return "GUI_RUNDEFMSG"
ElseIf $iGLVEx_LastY > $iCurr_Y Then
$fGLVEx_BarUnder = False
_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, $iGLVEx_InsertIndex, False)
Else
$fGLVEx_BarUnder = True
_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, $iGLVEx_InsertIndex, True)
EndIf
EndIf
$iGLVEx_LastY = $iCurr_Y
Local $aLVHit = _GUICtrlListView_HitTest($hGLVEx_TgtHandle)
Local $iCurr_Index = $aLVHit[0]
If $iCurr_Index = -1 Then
If $fGLVEx_BarUnder Then
_GUICtrlListView_Scroll($hGLVEx_TgtHandle, 0, $iVertScroll)
Else
_GUICtrlListView_Scroll($hGLVEx_TgtHandle, 0, -$iVertScroll)
EndIf
Sleep(10)
EndIf
If $iGLVEx_InsertIndex <> $iCurr_Index Then
_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, $iCurr_Index, $fGLVEx_BarUnder)
$iGLVEx_InsertIndex = $iCurr_Index
EndIf
Return "GUI_RUNDEFMSG"
EndFunc
Func _GUIListViewEx_WM_LBUTTONUP_Handler($hWnd, $iMsg, $wParam, $lParam)
#forceref $hWnd, $iMsg, $wParam, $lParam
If Not $iGLVEx_Dragging Then
Return "GUI_RUNDEFMSG"
EndIf
Local $iMultipleItems = $iGLVEx_Dragging - 1
$iGLVEx_Dragging = 0
Local $hCurrent_Wnd = _GUIListViewEx_GetCursorWnd()
If $hCurrent_Wnd <> $hGLVEx_TgtHandle Then
_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, -1, True)
For $i = 0 To $iMultipleItems
_GUIListViewEx_Highlight($hGLVEx_TgtHandle, $cGLVEx_TgtID, $iGLVEx_DraggedIndex + $i)
Next
$aGLVEx_SrcArray = 0
$aGLVEx_TgtArray = 0
Return
EndIf
_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, -1, True)
If $hGLVEx_DraggedImage Then
_GUIImageList_DragLeave($hGLVEx_SrcHandle)
_GUIImageList_EndDrag()
_GUIImageList_Destroy($hGLVEx_DraggedImage)
$hGLVEx_DraggedImage = 0
EndIf
If $hGLVEx_SrcHandle = $hGLVEx_TgtHandle Then
If $fGLVEx_BarUnder Then
If $iGLVEx_DraggedIndex > $iGLVEx_InsertIndex Then $iGLVEx_InsertIndex += 1
Else
If $iGLVEx_DraggedIndex < $iGLVEx_InsertIndex Then $iGLVEx_InsertIndex -= 1
EndIf
Switch $iGLVEx_InsertIndex
Case $iGLVEx_DraggedIndex To $iGLVEx_DraggedIndex + $iMultipleItems
For $i = 0 To $iMultipleItems
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVEx_DraggedIndex + $i)
Next
$aGLVEx_SrcArray = 0
$aGLVEx_TgtArray = 0
Return
EndSwitch
Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
For $i = 1 To UBound($aCheck_Array) - 1
$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
Next
Local $aCheckDrag_Array[$iMultipleItems + 1]
If $iMultipleItems Then
Local $aInsertData[$iMultipleItems + 1]
For $i = 0 To $iMultipleItems
Local $aItemData[UBound($aGLVEx_SrcArray, 2)]
For $j = 0 To UBound($aGLVEx_SrcArray, 2) - 1
$aItemData[$j] = $aGLVEx_SrcArray[$iGLVEx_DraggedIndex + 1 + $i][$j]
Next
$aInsertData[$i] = $aItemData
$aCheckDrag_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $iGLVEx_DraggedIndex + $i)
Next
Else
Local $aInsertData[1]
Local $aItemData[UBound($aGLVEx_SrcArray, 2)]
For $i = 0 To UBound($aGLVEx_SrcArray, 2) - 1
$aItemData[$i] = $aGLVEx_SrcArray[$iGLVEx_DraggedIndex + 1][$i]
Next
$aInsertData[0] = $aItemData
$aCheckDrag_Array[0] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $iGLVEx_DraggedIndex)
EndIf
For $i = 0 To $iMultipleItems
_GUIListViewEx_Array_Delete($aGLVEx_SrcArray, $iGLVEx_DraggedIndex + 1)
_GUIListViewEx_Array_Delete($aCheck_Array, $iGLVEx_DraggedIndex + 1)
Next
If $iGLVEx_DraggedIndex < $iGLVEx_InsertIndex Then
$iGLVEx_InsertIndex -= $iMultipleItems
EndIf
For $i = $iMultipleItems To 0 Step -1
_GUIListViewEx_Array_Insert($aGLVEx_SrcArray, $iGLVEx_InsertIndex + 1, $aInsertData[$i])
_GUIListViewEx_Array_Insert($aCheck_Array, $iGLVEx_InsertIndex + 1, $aCheckDrag_Array[$i])
Next
_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iGLVEx_SrcIndex)
For $i = 0 To $iMultipleItems
_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVEx_InsertIndex + $i)
Next
$aGLVEx_Data[$aGLVEx_Data[0][1]][2] = $aGLVEx_SrcArray
$aGLVEx_SrcArray = 0
$aGLVEx_TgtArray = 0
Else
If $fGLVEx_BarUnder Then
$iGLVEx_InsertIndex += 1
EndIf
If $iMultipleItems Then
Local $aInsertData[$iMultipleItems + 1]
For $i = 0 To $iMultipleItems
Local $aItemData[UBound($aGLVEx_SrcArray, 2)]
For $j = 0 To UBound($aGLVEx_SrcArray, 2) - 1
$aItemData[$j] = $aGLVEx_SrcArray[$iGLVEx_DraggedIndex + 1 + $i][$j]
Next
$aInsertData[$i] = $aItemData
Next
Else
Local $aInsertData[1]
Local $aItemData[UBound($aGLVEx_SrcArray, 2)]
For $i = 0 To UBound($aGLVEx_SrcArray, 2) - 1
$aItemData[$i] = $aGLVEx_SrcArray[$iGLVEx_DraggedIndex + 1][$i]
Next
$aInsertData[0] = $aItemData
EndIf
If Not BitAnd($aGLVEx_Data[$iGLVEx_SrcIndex][12], 4) Then
For $i = 0 To $iMultipleItems
_GUIListViewEx_Array_Delete($aGLVEx_SrcArray, $iGLVEx_DraggedIndex + 1)
Next
EndIf
If $iGLVEx_InsertIndex < 0 Then
$iGLVEx_InsertIndex = _GUICtrlListView_GetItemCount($hGLVEx_TgtHandle)
EndIf
For $i = $iMultipleItems To 0 Step -1
_GUIListViewEx_Array_Insert($aGLVEx_TgtArray, $iGLVEx_InsertIndex + 1, $aInsertData[$i])
Next
_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aGLVEx_SrcArray, $iGLVEx_SrcIndex, False)
_GUIListViewEx_ReWriteLV($hGLVEx_TgtHandle, $aGLVEx_TgtArray, $aGLVEx_TgtArray, $iGLVEx_TgtIndex, False)
_GUIListViewEx_SetActive($iGLVEx_TgtIndex)
For $i = 0 To $iMultipleItems
_GUIListViewEx_Highlight($hGLVEx_TgtHandle, $cGLVEx_TgtID, $iGLVEx_InsertIndex + $i)
Next
$aGLVEx_Data[$iGLVEx_SrcIndex][2] = $aGLVEx_SrcArray
$aGLVEx_Data[$iGLVEx_TgtIndex][2] = $aGLVEx_TgtArray
EndIf
$aGLVEx_SrcArray = 0
$aGLVEx_TgtArray = 0
EndFunc
Func _GUIListViewEx_ExpandCols($sCols)
Local $iNumber
$sCols = StringStripWS($sCols, 8)
If $sCols <> "*" Then
If StringInStr($sCols, "-") Then
Local $aSplit_1, $aSplit_2
$aSplit_1 = StringSplit($sCols, ";")
$sCols = ""
For $i = 1 To $aSplit_1[0]
$aSplit_2 = StringSplit($aSplit_1[$i], "-")
$sCols &= $aSplit_2[1] & ";"
If($aSplit_2[0]) > 1 And(Number($aSplit_2[2]) > Number($aSplit_2[1])) Then
$iNumber = $aSplit_2[1]
Do
$iNumber += 1
$sCols &= $iNumber & ";"
Until $iNumber = $aSplit_2[2]
EndIf
Next
EndIf
EndIf
Return $sCols
EndFunc
Func _GUIListViewEx_Highlight($hLVHandle, $cLV_CID, $iIndexA, $iIndexB = -1)
If $cLV_CID Then
GUICtrlSetState($cLV_CID, 256)
Else
_WinAPI_SetFocus($hLVHandle)
EndIf
If $iIndexB <> -1 Then _GUICtrlListView_SetItemSelected($hLVHandle, $iIndexB, False)
_GUICtrlListView_SetItemState($hLVHandle, $iIndexA, $LVIS_SELECTED, $LVIS_SELECTED)
_GUICtrlListView_EnsureVisible($hLVHandle, $iIndexA)
EndFunc
Func _GUIListViewEx_ReWriteLV($hLVHandle, ByRef $aLV_Array, ByRef $aCheck_Array, $iLV_Index, $fCheckBox = True)
Local $iVertScroll
If $aGLVEx_Data[$iLV_Index][10] Then
$iVertScroll = $aGLVEx_Data[$iLV_Index][10]
Else
Local $aRect = _GUICtrlListView_GetItemRect($hLVHandle, 0)
$aGLVEx_Data[$iLV_Index][10] = $aRect[3] - $aRect[1]
If $iVertScroll = 0 Then
$iVertScroll = 20
EndIf
EndIf
Local $iTopIndex_Org = _GUICtrlListView_GetTopIndex($hLVHandle)
_GUICtrlListView_BeginUpdate($hLVHandle)
_GUICtrlListView_DeleteAllItems($hLVHandle)
_GUICtrlListView_BeginUpdate($hLVHandle)
Local $aArray = $aLV_Array
_ArrayDelete($aArray, 0)
_GUICtrlListView_AddArray($hLVHandle, $aArray)
For $i = 1 To $aLV_Array[0][0]
If $fCheckBox And $aCheck_Array[$i] Then
_GUICtrlListView_SetItemChecked($hLVHandle, $i - 1)
EndIf
Next
Local $iTopIndex_Curr = _GUICtrlListView_GetTopIndex($hLVHandle)
While $iTopIndex_Curr < $iTopIndex_Org
_GUICtrlListView_Scroll($hLVHandle, 0, $iVertScroll)
If _GUICtrlListView_GetTopIndex($hLVHandle) = $iTopIndex_Curr Then
ExitLoop
Else
$iTopIndex_Curr = _GUICtrlListView_GetTopIndex($hLVHandle)
EndIf
WEnd
_GUICtrlListView_EndUpdate($hLVHandle)
setModified()
EndFunc
Func _GUIListViewEx_GetCursorWnd()
Local $tMPos = DllStructCreate("struct;long X;long Y;endstruct")
DllStructSetData($tMPos, "X", MouseGetPos(0))
DllStructSetData($tMPos, "Y", MouseGetPos(1))
Return _WinAPI_WindowFromPoint($tMPos)
EndFunc
Func _GUIListViewEx_Array_Add(ByRef $avArray, $vAdd, $fMultiRow = False)
Local $iIndex_Max = UBound($avArray)
Local $iAdd_Dim
Switch UBound($avArray, 0)
Case 1
If UBound($vAdd, 0) = 2 Or $fMultiRow Then
$iAdd_Dim = UBound($vAdd, 1)
ReDim $avArray[$iIndex_Max + $iAdd_Dim]
Else
ReDim $avArray[$iIndex_Max + 1]
EndIf
Case 2
Local $iDim2 = UBound($avArray, 2)
If UBound($vAdd, 0) = 2 Then
$iAdd_Dim = UBound($vAdd, 1)
ReDim $avArray[$iIndex_Max + $iAdd_Dim][$iDim2]
$avArray[0][0] += $iAdd_Dim
Local $iAdd_Max = UBound($vAdd, 2)
For $i = 0 To $iAdd_Dim - 1
For $j = 0 To $iDim2 -1
If $j > $iAdd_Max - 1 Then
$avArray[$iIndex_Max + $i][$j] = ""
Else
$avArray[$iIndex_Max + $i][$j] = $vAdd[$i][$j]
EndIf
Next
Next
ElseIf $fMultiRow Then
$iAdd_Dim = UBound($vAdd, 1)
ReDim $avArray[$iIndex_Max + $iAdd_Dim][$iDim2]
$avArray[0][0] += $iAdd_Dim
For $i = 0 To $iAdd_Dim - 1
$avArray[$iIndex_Max + $i][0] = $vAdd[$i]
Next
Else
ReDim $avArray[$iIndex_Max + 1][$iDim2]
$avArray[0][0] += 1
If IsArray($vAdd) Then
Local $vAdd_Max = UBound($vAdd)
For $j = 0 To $iDim2 - 1
If $j > $vAdd_Max - 1 Then
$avArray[$iIndex_Max][$j] = ""
Else
$avArray[$iIndex_Max][$j] = $vAdd[$j]
EndIf
Next
Else
For $j = 0 To $iDim2 - 1
$avArray[$iIndex_Max][$j] = $vAdd
Next
EndIf
EndIf
EndSwitch
EndFunc
Func _GUIListViewEx_Array_Insert(ByRef $avArray, $iIndex, $vInsert, $fMultiRow = False)
Local $iIndex_Max = UBound($avArray)
Local $iInsert_Dim
Switch UBound($avArray, 0)
Case 1
If UBound($vInsert, 0) = 2 Or $fMultiRow Then
$iInsert_Dim = UBound($vInsert, 1)
ReDim $avArray[$iIndex_Max + $iInsert_Dim]
For $i = $iIndex_Max + $iInsert_Dim - 1 To $iIndex + 1 Step -1
$avArray[$i] = $avArray[$i - 1]
Next
Else
ReDim $avArray[$iIndex_Max + 1]
For $i = $iIndex_Max To $iIndex + 1 Step -1
$avArray[$i] = $avArray[$i - 1]
Next
EndIf
Case 2
If $iIndex > $iIndex_Max - 1 Then
_GUIListViewEx_Array_Add($avArray, $vInsert, $fMultiRow)
Return
EndIf
Local $iDim2 = UBound($avArray, 2)
If UBound($vInsert, 0) = 2 Then
$iInsert_Dim = UBound($vInsert, 1)
ReDim $avArray[$iIndex_Max + $iInsert_Dim][$iDim2]
$avArray[0][0] += $iInsert_Dim
For $i = $iIndex_Max + $iInsert_Dim - 1 To $iIndex + $iInsert_Dim Step -1
For $j = 0 To $iDim2 - 1
$avArray[$i][$j] = $avArray[$i - $iInsert_Dim][$j]
Next
Next
Local $iInsert_Max = UBound($vInsert, 2)
For $i = 0 To $iInsert_Dim - 1
For $j = 0 To $iDim2 -1
If $j > $iInsert_Max - 1 Then
$avArray[$iIndex + $i][$j] = ""
Else
$avArray[$iIndex + $i][$j] = $vInsert[$i][$j]
EndIf
Next
Next
ElseIf $fMultiRow Then
$iInsert_Dim = UBound($vInsert, 1)
ReDim $avArray[$iIndex_Max + $iInsert_Dim][$iDim2]
$avArray[0][0] += $iInsert_Dim
For $i = $iIndex_Max + $iInsert_Dim - 1 To $iIndex + $iInsert_Dim Step -1
For $j = 0 To $iDim2 - 1
$avArray[$i][$j] = $avArray[$i - $iInsert_Dim][$j]
Next
Next
For $i = 0 To $iInsert_Dim - 1
$avArray[$iIndex + $i][0] = $vInsert[$i]
Next
Else
ReDim $avArray[$iIndex_Max + 1][$iDim2]
$avArray[0][0] += 1
For $i = $iIndex_Max To $iIndex + 1 Step -1
For $j = 0 To $iDim2 - 1
$avArray[$i][$j] = $avArray[$i - 1][$j]
Next
Next
If IsArray($vInsert) Then
Local $vInsert_Max = UBound($vInsert)
For $j = 0 To $iDim2 - 1
If $j > $vInsert_Max - 1 Then
$avArray[$iIndex][$j] = ""
Else
$avArray[$iIndex][$j] = $vInsert[$j]
EndIf
Next
Else
For $j = 0 To $iDim2 - 1
$avArray[$iIndex][$j] = $vInsert
Next
EndIf
EndIf
EndSwitch
EndFunc
Func _GUIListViewEx_Array_Delete(ByRef $avArray, $iIndex, $bDelCount = False)
Local $iIndex_Max = UBound($avArray)
Switch UBound($avArray, 0)
Case 1
For $i = $iIndex To $iIndex_Max - 2
$avArray[$i] = $avArray[$i + 1]
Next
ReDim $avArray[$iIndex_Max - 1]
Case 2
Local $iDim2 = UBound($avArray, 2)
For $i = $iIndex To $iIndex_Max - 2
For $j = 0 To $iDim2 - 1
$avArray[$i][$j] = $avArray[$i + 1][$j]
Next
Next
ReDim $avArray[$iIndex_Max - 1][$iDim2]
If Not $bDelCount Then
$avArray[0][0] -= 1
EndIf
EndSwitch
EndFunc
Func _GUIListViewEx_Array_Swap(ByRef $avArray, $iIndex1, $iIndex2)
Local $vTemp
Switch UBound($avArray, 0)
Case 1
$vTemp = $avArray[$iIndex1]
$avArray[$iIndex1] = $avArray[$iIndex2]
$avArray[$iIndex2] = $vTemp
Case 2
Local $iDim2 = UBound($avArray, 2)
For $i = 0 To $iDim2 - 1
$vTemp = $avArray[$iIndex1][$i]
$avArray[$iIndex1][$i] = $avArray[$iIndex2][$i]
$avArray[$iIndex2][$i] = $vTemp
Next
EndSwitch
Return 0
EndFunc
Func _Remove_CS_DBLCLKS($Ctrl)
If Not IsHWnd($Ctrl) Then
$Ctrl = GUICtrlGetHandle($Ctrl)
If Not IsHWnd($Ctrl) Then Return SetError(1, 0, 0)
EndIf
If Not IsDeclared("GCL_STYLE") Then Local Const $GCL_STYLE = -26
If Not IsDeclared("CS_DBLCLKS") Then Local Const $CS_DBLCLKS = 0x8
Local $ClassStyle = _WinAPI_GetClassLongEx($Ctrl, $GCL_STYLE)
If @error Or Not $ClassStyle Then Return SetError(2, @error, 0)
Local $NewStyle = BitAND($ClassStyle, BitNOT($CS_DBLCLKS))
_WinAPI_SetClassLongEx($Ctrl, $GCL_STYLE, $NewStyle)
If @error Then Return SetError(3, @error, 0)
Local $ClassChk = _WinAPI_GetClassLongEx($Ctrl, $GCL_STYLE)
If @error Or Not $ClassChk Then Return SetError(4, @error, 0)
If $ClassStyle = $ClassChk Then Return SetError(5, 0, 0)
Return SetError(0, 0, 1)
EndFunc
Opt("GUIEventOptions", 1)
Opt("GUIOnEventMode", 1)
Opt("GUICloseOnESC", 0)
Const $windowTitle = "MPC-HC Looper!"
Const $openWatchFile = @TempDir & "\MPC_Looper.txt"
Global $isModified = 0
Global $currentLooperFile
Global $currentPlayingEvent = -1
Global $isLoaded = 0
Global $currentLoadedFile = ""
Global $nowPlayingInfo
Global $currentOrRemaining = 0
Global $pastPosition, $currentPosition
Global $trimmingOut = 0
Global $loopPreviewLength = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "0.25")
Global $loopSlipLength = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "0.05")
Global $hotKeysActive = False
Global $isClicked = 0
Global $HotkeyList[34] = ["i", "o", "^i", "^o", "^x", "+l", "^t", "+o", "[", "]", ";", "'", "+[", "+]", "+;", "+'","^q", "^,", "^n", "^l", "^s", "{DEL}", "!^{BS}", "{SPACE}", "!{ENTER}", "^{PGUP}", "^{PGDN}", "^{UP}", "^{DOWN}", "^r", "^1", "^2", "^3", "^4"]
Global $tryingToQuit = 0
Global $MPCInitialized = 0
Global $displayTimer = 0
Global $displayMessage = 0
Global $currentSpeed = 100
Global $currentEventName = ""
Global $currentEventCounter = "0 events in playlist (0:00 in entire playlist)"
Global $OSDWindow, $OSDWindowX = 22, $OSDWindowY = 22
Global $OSDeventNameTF, $OSDmodeTF, $OSDeventCounterTF, $OSDcurrentPositionTF, $OSDinPositionTF, $OSDoutPositionTF, $OSDCurrentRemainTF
Global $minWidth =(418 + 30), $minHeight = 266, $maxHeight =(@DesktopHeight - 50)
Global $randomPlayOrder[0]
Global $eventListIndex, $completeEventList
Global $currentlySearching = 0
Global $searchResultsList[0]
Local $hDLL = DllOpen("user32.dll")
If _IsPressed("A0", $hDLL) Then
$loadDefaults = True
Else
$loadDefaults = False
EndIf
DLLClose($hDLL)
$eventToPlay = ""
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", 0) = 0 Then
If _Singleton("MPC Looper", 1) = 0 Then
launchFromExplorer()
Exit
Else
checkWhichLooperToLoad()
EndIf
Else
If RegRead("HKCU\Software\MPC-HC\MPC-HC\Settings", "AllowMultipleInstances") <> 1 Then
If _Singleton("MPC Looper", 1) = 0 Then
launchFromExplorer()
MsgBox(48 + 262144, "Multiple Instance Warning!", "You have multiple instances turned on in Looper, and you just launched another instance, but MPC-HC isn't set to allow multiple instances.  In that case, Looper will act like normal and not open any other multiple instances of itself." & @CRLF & @CRLF & "To allow the multiple instance feature, go to the MPC-HC options pane (View menu > Options), then click on " & '"Player"' & " at the top left and choose " & '"Open a new player for each media file played"' & ", and then save your changes - turning this on will allow you to have multiple Looper sessions running at the same time.")
Exit
Else
checkWhichLooperToLoad()
EndIf
Else
checkWhichLooperToLoad()
EndIf
EndIf
Func launchFromExplorer()
If $cmdline[0] <> 0 Then
$writingFile = FileOpen($openWatchFile, 34)
FileWrite($writingFile, $cmdline[1])
FileClose($writingFile)
EndIf
EndFunc
Func checkWhichLooperToLoad()
If $cmdline[0] <> 0 Then
$currentLooperFile = $cmdline[1]
$eventToPlay = 0
Else
$lastPlayedLooper = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "")
If $lastPlayedLooper <> "" Then
If $lastPlayedLooper <> 1 Then
$lastPlayedLooper = StringSplit($lastPlayedLooper, "|", 2)
If IsArray($lastPlayedLooper) Then
$currentLooperFile = $lastPlayedLooper[0]
$eventToPlay = Int($lastPlayedLooper[1])
EndIf
EndIf
EndIf
EndIf
EndFunc
$mainWindow = GUICreate("MPC-HC Looper!",(404 + 30), 538,(@DesktopWidth -(429 + 30)), 11, BitOR($WS_MAXIMIZEBOX, $WS_SIZEBOX, $WS_MINIMIZEBOX))
$inButton = GUICtrlCreateLabel("IN", 38, 34, 34, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
_Remove_CS_DBLCLKS(-1)
$inTF = GUICtrlCreateInput("", 8, 64, 124, 25, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
$inDecButton = GUICtrlCreateLabel("-", 8, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$inIncButton = GUICtrlCreateLabel("+", 104, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$clearInButton = GUICtrlCreateLabel("X", 74, 34, 26, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$outButton = GUICtrlCreateLabel("OUT", 330, 34, 34, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$outTF = GUICtrlCreateInput("", 300, 64, 124, 25, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
$outDecButton = GUICtrlCreateLabel("-", 300, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$outIncButton = GUICtrlCreateLabel("+", 396, 34, 27, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$clearOutButton = GUICtrlCreateLabel("X", 366, 34, 26, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_CLIENTEDGE)
$clearAllButton = GUICtrlCreateButton("Clear All", 136, 34, 161, 25)
$timeTF = GUICtrlCreateLabel("--:--:--", 144, 64, 150, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
$loopButton = GUICtrlCreateButton("Loop Mode", 7, 6, 124, 25)
$dockLeftButton = GUICtrlCreateButton("", 136, 6, 11, 25)
$dockLabel = GUICtrlCreateLabel("DOCK", 156, 10, 40, 21)
$dockRightButton = GUICtrlCreateButton("", 200, 6, 11, 25)
$OSDButton = GUICtrlCreateButton("OSD Off", 215, 6, 82, 25)
$onTopButton = GUICtrlCreateButton("Always on Top", 300, 6, 124, 25)
$previousEventButton = GUICtrlCreateButton("<<", 8, 92, 51, 28)
$speedSlider = GUICtrlCreateSlider(64, 92, 305, 17, BitOR($GUI_SS_DEFAULT_SLIDER,$TBS_NOTICKS))
$__SPD_025X = GUICtrlCreateLabel("25%", 91, 110, 36, 17)
$__SPD_05X = GUICtrlCreateLabel("50%", 126, 110, 30, 17)
$__SPD_075X = GUICtrlCreateLabel("75%", 164, 110, 36, 17)
$__SPD_1X = GUICtrlCreateLabel("100%", 195, 110, 27, 17)
$__SPD_125X = GUICtrlCreateLabel("125%", 237, 110, 36, 17)
$__SPD_15X = GUICtrlCreateLabel("150%", 274, 110, 30, 17)
$__SPD_175X = GUICtrlCreateLabel("175%", 312, 110, 36, 17)
$__SPD_2X = GUICtrlCreateLabel("200%", 345, 110, 25, 17)
$nextEventButton = GUICtrlCreateButton(">>", 374, 92, 51, 28)
$searchEventTF = GUICtrlCreateInput("", 8, 130, 330, 23)
$searchEventButton = GUICtrlCreateButton("Go", 344, 129, 35, 24)
$searchClearButton = GUICtrlCreateButton("Clear", 382, 129, 43, 24)
$eventList = GUICtrlCreateListView("#|Event|In Point|Out Point|Duration|Filename", 0, 160,(403 + 30), 257, BitOR($LVS_REPORT, $LVS_SHOWSELALWAYS), BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
$HotKeyStatusTF = GUICtrlCreateLabel("", 6, 421, 90, 19)
$currentEventStatusTF = GUICtrlCreateLabel("", 106, 421, 318, 19, $SS_RIGHT)
$topVertLin = GUICtrlCreateGraphic(6, 441, 420, 1)
$listSaveButton = GUICtrlCreateButton("Save", 7, 445, 61, 25)
$listLoadButton = GUICtrlCreateButton("Load", 71, 445, 60, 25)
$listDeleteButton = GUICtrlCreateButton("Delete Event", 134, 445, 83, 25)
$listModifyButton = GUICtrlCreateButton("Modify Event", 220, 445, 83, 25)
$listAddButton = GUICtrlCreateButton("Add", 305, 445, 57, 25)
$listClearButton = GUICtrlCreateButton("Clear List", 364, 445, 63, 25)
$vertLine = GUICtrlCreateGraphic(6, 473, 420, 1)
$progTitle = GUICtrlCreateLabel("Media Player Classic Looper [01-13-17]", 106, 481, 318, 19, $SS_RIGHT)
$progInfo = GUICtrlCreateLabel(Chr(169) & " 2014-17 Zach Glenwright [www.gullswingmedia.com]", 106, 495, 318, 19, $SS_RIGHT)
$optionsButton = GUICtrlCreateButton("", 8, 476, 40, 36, $BS_ICON)
GUICtrlSetImage(-1, "C:\Windows\System32\shell32.dll", -91)
$goToDirectoryButton = GUICtrlCreateButton("", 48, 476, 40, 36, $BS_ICON)
GUICtrlSetImage(-1, "C:\Windows\System32\shell32.dll", -46)
WinSetOnTop($mainWindow, "", 1)
GUISetOnEvent($GUI_EVENT_CLOSE, "Uninitialize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "maximizeWindow")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "minimizeWindow")
GUISetOnEvent($GUI_EVENT_RESTORE, "restoreWindow")
GUICtrlSetOnEvent($dockLeftButton, "clickLeftDockingButton")
GUICtrlSetOnEvent($dockLabel, "clickDockingButton")
GUICtrlSetOnEvent($dockRightButton, "clickRightDockingButton")
GUICtrlSetOnEvent($onTopButton, "setAlwaysOnTop")
GUICtrlSetOnEvent($inButton, "setInPoint")
GUICtrlSetOnEvent($outButton, "setOutPoint")
GUICtrlSetOnEvent($clearInButton, "clearInPoint")
GUICtrlSetOnEvent($clearOutButton, "clearOutPoint")
GUICtrlSetOnEvent($clearAllButton, "clearInOutPoint")
GUICtrlSetOnEvent($inDecButton, "trimInPointDec")
GUICtrlSetOnEvent($inIncButton, "trimInPointInc")
GUICtrlSetOnEvent($outDecButton, "trimOutPointDec")
GUICtrlSetOnEvent($outIncButton, "trimOutPointInc")
GUICtrlSetOnEvent($timeTF, "switchCurrentandRemaining")
GUICtrlSetOnEvent($currentEventStatusTF, "switchCurrentEventandTotalEvents")
GUICtrlSetOnEvent($loopButton, "clickLoopButton")
GUICtrlSetOnEvent($OSDButton, "clickOSDButton")
GUIRegisterMsg($WM_HSCROLL, "sliderMoving")
GUICtrlSetOnEvent($__SPD_025X, "setSpeed025")
GUICtrlSetOnEvent($__SPD_05X, "setSpeed05")
GUICtrlSetOnEvent($__SPD_075X, "setSpeed075")
GUICtrlSetOnEvent($__SPD_1X, "setSpeed1")
GUICtrlSetOnEvent($__SPD_125X, "setSpeed125")
GUICtrlSetOnEvent($__SPD_15X, "setSpeed15")
GUICtrlSetOnEvent($__SPD_175X, "setSpeed175")
GUICtrlSetOnEvent($__SPD_2X, "setSpeed2")
GUICtrlSetOnEvent($previousEventButton, "loadPrevEventButton")
GUICtrlSetOnEvent($nextEventButton, "loadNextEventButton")
GUICtrlSetOnEvent($searchEventButton, "searchEventList")
GUICtrlSetOnEvent($searchClearButton, "searchEventListRestore")
GUICtrlSetOnEvent($listAddButton, "addEvent")
GUICtrlSetOnEvent($listModifyButton, "modifyEvent")
GUICtrlSetOnEvent($listDeleteButton, "deleteEvent")
GUICtrlSetOnEvent($listClearButton, "clearEvents")
GUICtrlSetOnEvent($listLoadButton, "loadListButtonClicked")
GUICtrlSetOnEvent($listSaveButton, "saveList")
GUICtrlSetOnEvent($optionsButton, "loadOptions")
GUICtrlSetOnEvent($goToDirectoryButton, "openPathtoFile")
GUICtrlSetOnEvent($progInfo, "loadURL")
GUICtrlSetFont($inButton, 8, 800, 0, "MS Sans Serif")
GUICtrlSetFont($inTF, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($inDecButton, 12, 800, 0, "MS Sans Serif")
GUICtrlSetFont($clearInButton, 8, 800, 0, "MS Sans Serif")
GUICtrlSetFont($outButton, 8, 800, 0, "MS Sans Serif")
GUICtrlSetFont($outTF, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($outDecButton, 12, 800, 0, "MS Sans Serif")
GUICtrlSetFont($clearOutButton, 8, 800, 0, "MS Sans Serif")
GUICtrlSetFont($clearAllButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($timeTF, 12, 800, 0, "Segoe UI")
GUICtrlSetFont($loopButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($dockLeftButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($dockLabel, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($dockRightButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($OSDButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($onTopButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($previousEventButton, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($__SPD_025X, 8, 400, 0, "Segoe UI")
GUICtrlSetFont($__SPD_05X, 8, 400, 0, "Segoe UI")
GUICtrlSetFont($__SPD_075X, 8, 400, 0, "Segoe UI")
GUICtrlSetFont($__SPD_1X, 8, 800, 0, "Segoe UI")
GUICtrlSetFont($__SPD_125X, 8, 400, 0, "Segoe UI")
GUICtrlSetFont($__SPD_15X, 8, 400, 0, "Segoe UI")
GUICtrlSetFont($__SPD_175X, 8, 400, 0, "Segoe UI")
GUICtrlSetFont($__SPD_2X, 8, 400, 0, "Segoe UI")
GUICtrlSetFont($nextEventButton, 10, 400, 0, "Segoe UI")
GUICtrlSetLimit($speedSlider, 200, 10)
GUICtrlSetData($speedSlider, 100)
GUICtrlSetFont($searchEventTF, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($searchEventButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($searchClearButton, 9, 400, 0, "Segoe UI")
GUICtrlSetState($searchEventButton, $GUI_DEFBUTTON)
GUICtrlSetState($searchClearButton, $GUI_DISABLE)
GUICtrlSetFont($eventList, 9, 400, 0, "Segoe UI")
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 0, 27)
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 1, 180)
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 2, 72)
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 3, 72)
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 4, 72)
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 5, 600)
GUICtrlSetFont($HotKeyStatusTF, 9, 800, 0, "Segoe UI")
GUICtrlSetFont($currentEventStatusTF, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($listSaveButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($listLoadButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($listDeleteButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($listAddButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($listModifyButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($listClearButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($progTitle, 9, 800, 0, "Segoe UI")
GUICtrlSetFont($progInfo, 9, 400, 0, "Segoe UI")
GUICtrlSetBkColor($dockRightButton, 0xffffff)
GUICtrlSetBkColor($dockLeftButton, 0xffffff)
GUICtrlSetBkColor($OSDButton, 0xbfd1db)
GUICtrlSetBkColor($onTopButton, 0xb7baf3)
GUICtrlSetBkColor($topVertLin, 0x3399FF)
GUICtrlSetBkColor($vertLine, 0x3399FF)
GUICtrlSetState($listSaveButton, $GUI_DISABLE)
GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
GUICtrlSetState($listModifyButton, $GUI_DISABLE)
GUICtrlSetState($listClearButton, $GUI_DISABLE)
GUICtrlSetState($nextEventButton, $GUI_DISABLE)
GUICtrlSetState($previousEventButton, $GUI_DISABLE)
GUICtrlSetCursor($progInfo, 0)
Func loadToolTips($yesOrNo)
If $yesOrNo = 1 Then
GUICtrlSetTip($inButton, "Chooses the IN Point for the A/B Loop" & @CRLF & @CRLF & "Keyboard Shortcut: I", "The IN Button")
GUICtrlSetTip($inTF, "The current position of the IN point for the current A/B Loop", "The Current IN Point Display")
GUICtrlSetTip($inDecButton, "Trims the IN point backwards a specific amount" & @CRLF & "(settable in 'Options' as the 'Slip Time Amount')" & @CRLF & @CRLF & "Keyboard Shortcut: [ (left bracket)", "The Trim Backwards Button - on the IN Side")
GUICtrlSetTip($inIncButton, "Trims the IN point forwards a specific amount" & @CRLF & "(settable in 'Options' as the 'Slip Time Amount')" & @CRLF & @CRLF & "Keyboard Shortcut: ] (right bracket)", "The Trim Forwards Button - on the IN Side")
GUICtrlSetTip($clearInButton, "Clears the IN point for the A/B Loop, resetting the loop's" & @CRLF & "start time to 0:00" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-I", "The Clear IN Button")
GUICtrlSetTip($outButton, "Chooses the OUT Point for the A/B Loop" & @CRLF & @CRLF & "Keyboard Shortcut: O", "The OUT Button")
GUICtrlSetTip($outTF, "The current position of the OUT point for the current A/B Loop", "The Current OUT Point Display")
GUICtrlSetTip($outDecButton, "Trims the OUT point backwards a specific amount" & @CRLF & "(settable out 'Options' as the 'Slip Time Amount')" & @CRLF & @CRLF & "Keyboard Shortcut: ; (colon/semicolon button)", "The Trim Backwards Button - on the OUT Side")
GUICtrlSetTip($outIncButton, "Trims the OUT point forwards a specific amount" & @CRLF & "(settable out 'Options' as the 'Slip Time Amount')" & @CRLF & @CRLF & "Keyboard Shortcut: ' (quotation mark/apostrophe button)", "The Trim Forwards Button - on the OUT Side")
GUICtrlSetTip($clearOutButton, "Clears the OUT point for the A/B Loop, resetting the loop's end time" & @CRLF & "to to the length of the current video" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-O", "The Clear OUT Button")
GUICtrlSetTip($clearAllButton, "Clears both the IN and OUT points, resetting the loop" & @CRLF & "to the entire length of the current video" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-X", "The Clear All Button")
GUICtrlSetTip($timeTF, "Click on this to switch between display of the current playback time" & @CRLF & "in MPC-HC, and the remaining time of the current loop", "The Current Time / Remaining Time Display")
GUICtrlSetTip($loopButton, "Click*** on this to change between looping modes - " & @CRLF & @CRLF & "'Loop Mode' - will loop the current IN and OUT points as a loop" & @CRLF & "'Playlist Mode' (if you have events in the Event Playlist) - loop through the playlist, one item at a time" & @CRLF & "'OFF' - MPC-HC acts like the Looper program isn't running, but you can still make IN and OUT" & @CRLF & "points and add them to the playlist, which is useful for EDL-like lists of IN and OUT points" & @CRLF & "'Shuffle Mode'*** - If you click this button with both the left and right mouse buttons, you can load Shuffle Mode," & @CRLF & "which acts similar to Playlist Mode, but randomizes the order in which the events play." & @CRLF & @CRLF & "You can also jump right to one of the modes directly by using keyboard shortcuts -" & @CRLF & " CTRL-1 - Jump to the OFF mode directly" & @CRLF & " CTRL-2 - Jump to Loop Mode directly" & @CRLF & " CTRL-3 - Jump to Playlist Mode directly" & @CRLF & " CTRL-4 - Jump to Shuffle Mode directly" & @CRLF & " CTRL-L - Alternate between OFF / Loop Mode / Playlist Mode", "The Loop Mode button")
GUICtrlSetTip($dockLeftButton, "Click on this button to set window docking to the left - this will align" & @CRLF & "Looper to the left side of the MPC-HC window.  Moving either window" & @CRLF & "will move both windows together, always snapping Looper's window to" & @CRLF & "the left of MPC-HC's window." & @CRLF & @CRLF & "If you click it again, it will disable docking and again allow you to move" & @CRLF & "the windows independently of one another.", "The Left Window Docking Button")
GUICtrlSetTip($dockLeftButton, "Click on this button to set window docking to the left - this will align" & @CRLF & "Looper to the left side of the MPC-HC window.  Moving either window" & @CRLF & "will move both windows together, always snapping Looper's window to" & @CRLF & "the left of MPC-HC's window." & @CRLF & @CRLF & "If you click it again, it will disable docking and again allow you to move" & @CRLF & "the windows independently of one another.", "The Left Window Docking Button")
GUICtrlSetTip($dockLabel, "Click on this button to clear the current window docking setting, and" & @CRLF & "allow the Looper and MPC-HC windows to move independently of" & @CRLF & "one another.", "The Clear Window Docking Button")
GUICtrlSetTip($dockRightButton, "Click on this button to set window docking to the right - this will align" & @CRLF & "Looper to the right side of the MPC-HC window.  Moving either window" & @CRLF & "will move both windows together, always snapping Looper's window to" & @CRLF & "the right of MPC-HC's window." & @CRLF & @CRLF & "If you click it again, it will disable docking and again allow you to move" & @CRLF & "the windows independently of one another.", "The Right Window Docking Button")
GUICtrlSetTip($OSDButton, "On-screen display (similar to Media Player Classic's OSD) that shows Loop Mode, the IN and OUT points, " & @CRLF & "the current playback position in Media Player Classic, the current event # (and the total # of events) " & @CRLF & "and the name of the current event" & @CRLF & @CRLF & "The transparent OSD window can also be moved by clicking and dragging to a new position" & @CRLF & @CRLF & "Keyboard Shortcut: SHIFT-O", "The OSD Button")
GUICtrlSetTip($onTopButton, "Click on this to change whether MPC-HC Looper sits on top of all other windows" & @CRLF & "or acts like a normal window and disappears behind other windows" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-T", "The Always on Top Button")
GUICtrlSetTip($speedSlider, "Drag this slider to set the playback speed" & @CRLF & "to any percent ranging from 10% to 200%", "The Playback Speed Slider")
GUICtrlSetTip($__SPD_025X, "Click on this to set playback speed to 25% of original" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 25%")
GUICtrlSetTip($__SPD_05X, "Click on this to set playback speed to 50% of original" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 50%")
GUICtrlSetTip($__SPD_075X, "Click on this to set playback speed to 75% of original" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 75%")
GUICtrlSetTip($__SPD_1X, "Click on this to set playback speed to 100% (normal speed)" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 100%")
GUICtrlSetTip($__SPD_125X, "Click on this to set playback speed to 125% of original" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 125%")
GUICtrlSetTip($__SPD_15X, "Click on this to set playback speed to 150% of original" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 150%")
GUICtrlSetTip($__SPD_175X, "Click on this to set playback speed to 175% of original" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 175%")
GUICtrlSetTip($__SPD_2X, "Click on this to set playback speed to 200% (twice normal speed)" & @CRLF & @CRLF & "Speed Keyboard Shortcuts:" & @CRLF & "--------------------------------------------------------" & @CRLF & "CTRL-Down - Lower Speed by 10%" & @CRLF & "CTRL-Up - Raise Speed by 10%" & @CRLF & "CTRL-R - Set Speed to 100%", "Set Playback Speed to 200%")
GUICtrlSetTip($previousEventButton, "Click on this to load the previous event in the event list" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-PAGE UP", "The Previous Event Button")
GUICtrlSetTip($nextEventButton, "Click on this to load the next event in the event list" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-PAGE DOWN", "The Next Event Button")
GUICtrlSetTip($searchEventTF, "Click on this text field and type a word or phrase you want" & @CRLF & "to search the event list for, 'comedy', for example", "The Search Field")
GUICtrlSetTip($searchEventButton, "Click on this button to perform a search with the phrase" & @CRLF & "you typed into the Search field - the results will show up" & @CRLF & "in the events list.", "The Search Button")
GUICtrlSetTip($searchClearButton, "Click on this button to clear the current search and restore" & @CRLF & "the events list to it's original order", "The Clear Search Button")
GUICtrlSetTip($eventList, "A list of separate A/B Loops for the current .looper session", "The Event Playlist")
GUICtrlSetTip($listSaveButton, "Save the current playlist to a .looper file for later playback" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-S", "The Save .looper Button")
GUICtrlSetTip($listLoadButton, "Load a .looper file, saved from a previous session, into the playlist for playback" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-L", "The Load .looper Button")
GUICtrlSetTip($listDeleteButton, "Delete the current selected item/items from the playlist" & @CRLF & @CRLF & "Keyboard Shortcut: DEL (small delete, not Backspace)", "The Delete Event Button")
GUICtrlSetTip($listAddButton, "Add the current set of IN and OUT points to the playlist as a new event" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-N", "The Add Event Button")
GUICtrlSetTip($listModifyButton, "Modify the current playlist item's IN and OUT points and (if needed) it's name", "The Modify Event Button")
GUICtrlSetTip($listClearButton, "Removes every item from the playlist and unloads the current .looper file -" & @CRLF & "restoring everything to 'like new' for a new session", "The Clear List Button")
GUICtrlSetTip($HotKeyStatusTF, "Displays whether or not hotkeys (keyboard shortcuts) are:" & @CRLF & "Turned on (MPC-HC or the Looper program are active) or" & @CRLF & "Turned off (another window is active)", "The Hotkeys Status Display")
GUICtrlSetTip($currentEventStatusTF, "Displays the current event's duration, or the duration of the entire playlist," & @CRLF & "or status messages from the program (adding/deleting events, setting speed, etc.)" & @CRLF & "Click on this to change between single event duration and total playlist duration", "The Playback Display / Status Bar")
GUICtrlSetTip($optionsButton, "Click on this button to set default MPC-HC Looper settings, including preview time, slip time," & @CRLF & "associating .looper files with Windows Explorer, running multiple instances and many more" & @CRLF & "options" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-, (comma button)", "The Options Button")
GUICtrlSetTip($goToDirectoryButton, "Clicking on this button will reveal the path of the file currently" & @CRLF & "playing in MPC-HC by highlighting it in Windows Explorer" & @CRLF & @CRLF & "Keyboard Shortcut: CTRL-ALT-BACKSPACE", "The Reveal Path Button")
Else
GUICtrlSetTip($inButton, "")
GUICtrlSetTip($inTF, "")
GUICtrlSetTip($inDecButton, "")
GUICtrlSetTip($inIncButton, "")
GUICtrlSetTip($clearInButton, "")
GUICtrlSetTip($outButton, "")
GUICtrlSetTip($outTF, "")
GUICtrlSetTip($outDecButton, "")
GUICtrlSetTip($outIncButton, "")
GUICtrlSetTip($clearOutButton, "")
GUICtrlSetTip($clearAllButton, "")
GUICtrlSetTip($timeTF, "")
GUICtrlSetTip($loopButton, "")
GUICtrlSetTip($dockLeftButton, "")
GUICtrlSetTip($dockLeftButton, "")
GUICtrlSetTip($dockLabel, "")
GUICtrlSetTip($dockRightButton, "")
GUICtrlSetTip($OSDButton, "")
GUICtrlSetTip($onTopButton, "")
GUICtrlSetTip($speedSlider, "")
GUICtrlSetTip($__SPD_025X, "")
GUICtrlSetTip($__SPD_05X, "")
GUICtrlSetTip($__SPD_075X, "")
GUICtrlSetTip($__SPD_1X, "")
GUICtrlSetTip($__SPD_125X, "")
GUICtrlSetTip($__SPD_15X, "")
GUICtrlSetTip($__SPD_175X, "")
GUICtrlSetTip($__SPD_2X, "")
GUICtrlSetTip($previousEventButton, "")
GUICtrlSetTip($nextEventButton, "")
GUICtrlSetTip($searchEventTF, "")
GUICtrlSetTip($searchEventButton, "")
GUICtrlSetTip($searchClearButton, "")
GUICtrlSetTip($eventList, "")
GUICtrlSetTip($listSaveButton, "")
GUICtrlSetTip($listLoadButton, "")
GUICtrlSetTip($listDeleteButton, "")
GUICtrlSetTip($listAddButton, "")
GUICtrlSetTip($listModifyButton, "")
GUICtrlSetTip($listClearButton, "")
GUICtrlSetTip($HotKeyStatusTF, "")
GUICtrlSetTip($currentEventStatusTF, "")
GUICtrlSetTip($optionsButton, "")
GUICtrlSetTip($goToDirectoryButton, "")
EndIf
EndFunc
$disableToolTips = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "0")
If $disableToolTips <> 1 Then
loadToolTips(1)
EndIf
For $i = 3 To 34
GUICtrlSetResizing($i, 802)
Next
GUICtrlSetResizing(35, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH)
For $i = 36 to 49
GUICtrlSetResizing($i, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Next
_GUIListViewEx_MsgRegister()
GUIRegisterMsg($WM_GETMINMAXINFO, "_WM_GETMINMAXINFO")
Func _WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam)
#forceref $hWnd, $Msg, $wParam, $lParam
If $hWnd = $mainWindow Then
Local $tagMaxinfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
DllStructSetData($tagMaxinfo, 7, $minWidth)
DllStructSetData($tagMaxinfo, 8, $minHeight)
DllStructSetData($tagMaxinfo, 9, $minWidth)
DllStructSetData($tagMaxinfo, 10,$maxHeight)
Return $GUI_RUNDEFMSG
EndIf
EndFunc
Func setDockingModeDefaults()
WinActivate($mainWindow, "")
Switch IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "OFF")
Case "Left"
clickLeftDockingButton()
Case "Right"
clickRightDockingButton()
Case "OFF"
EndSwitch
EndFunc
Func loadWindowSizeDefaults()
$startPositionW = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionW", "404")
$startPositionH = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionH", "552")
$startPositionL = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL",(@DesktopWidth -(429 + 30)))
$startPositionT = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionT", "11")
WinMove($mainWindow, "", $startPositionL, $startPositionT, $startPositionW, $startPositionH)
EndFunc
Func setAlwaysOnTopDefaults()
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", 1) = 0 Then
setAlwaysOnTop()
EndIf
EndFunc
Func setLoopModeDefaults()
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "Loop Mode") = "OFF" Then
switchToOff()
Else
switchToLoop()
EndIf
EndFunc
Func linkMPC()
$MPCInitialized = 0
$s_formHandle = Dec(StringMid(String($mainWindow), 3))
$PathtoMPC = IniRead(@ScriptDir & "\MPCLooper.ini", "System", "MPCEXE", "")
If Not FileExists($PathtoMPC) Then
$PathtoMPC = ""
EndIf
While $MPCInitialized = 0
If $PathtoMPC = "" Then
$PathtoMPC = FileOpenDialog("Where is MPC-HC's executable?", "", "MPC-HC Execuatables (mpc*.exe)", 1)
If $PathtoMPC <> "" Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "System", "MPCEXE", $PathtoMPC)
EndIf
EndIf
$pid_MPC = Run($PathtoMPC & " /slave " & $s_formHandle)
If $pid_MPC = 0 Then
$tryAgain = MsgBox(262144 + 5, "Error - Could not run Media Player Classic", "Could not launch the Media Player Classic .exe file - this happens if you cancel the dialog asking you to find MPC-HC's .exe file, or you choose the wrong .exe file to launch.  Do you want to try to find the file again?")
If $tryAgain = 2 Then
Exit
EndIf
Else
$MPCInitialized = 1
EndIf
WEnd
EndFunc
linkMPC()
GUISetState(@SW_SHOW)
If $loadDefaults = True Then
$loopPreviewLength = 0.25
$loopSlipLength = 0.05
switchToLoop()
Else
setDockingModeDefaults()
loadWindowSizeDefaults()
setAlwaysOnTopDefaults()
setLoopModeDefaults()
EndIf
If $currentLooperFile <> "" Then
loadList($currentLooperFile)
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") <> 1 Then
If $eventToPlay <> -1 Then
loadEvent($eventToPlay)
EndIf
EndIf
EndIf
Func checkCurrentTitle()
If $currentLooperFile <> "" Then
If $isModified = 0 Then
If WinGetTitle($mainWindow) <> $windowTitle & " - " & looperTitle() Then
WinSetTitle($mainWindow, "", $windowTitle & " - " & looperTitle())
EndIf
Else
If WinGetTitle($mainWindow) <> $windowTitle & " - " & looperTitle() & " (*)" Then
WinSetTitle($mainWindow, "", $windowTitle & " - " & looperTitle() & " (*)")
EndIf
EndIf
Else
If $isModified = 0 Then
If WinGetTitle($mainWindow) <> $windowTitle & " - Untitled" Then
WinSetTitle($mainWindow, "", $windowTitle & " - Untitled")
EndIf
Else
If WinGetTitle($mainWindow) <> $windowTitle & " - Untitled (*)" Then
WinSetTitle($mainWindow, "", $windowTitle & " - Untitled (*)")
EndIf
EndIf
EndIf
EndFunc
Func checkEventListActive()
If getItemCount() > 0 Then
If GUICtrlRead($loopButton) <> "Playlist Mode" Then
If GUICtrlGetState($listClearButton) = 144 Then GUICtrlSetState($listClearButton, $GUI_ENABLE)
EndIf
If GUICtrlGetState($previousEventButton) = 144 Then GUICtrlSetState($previousEventButton, $GUI_ENABLE)
If GUICtrlGetState($nextEventButton) = 144 Then GUICtrlSetState($nextEventButton, $GUI_ENABLE)
Else
If GUICtrlRead($loopButton) <> "Playlist Mode" Then
If GUICtrlGetState($listClearButton) = 80 Then GUICtrlSetState($listClearButton, $GUI_DISABLE)
EndIf
If GUICtrlGetState($previousEventButton) = 80 Then GUICtrlSetState($previousEventButton, $GUI_DISABLE)
If GUICtrlGetState($nextEventButton) = 80 Then GUICtrlSetState($nextEventButton, $GUI_DISABLE)
EndIf
EndFunc
Func checkMPCSpeedAvailable()
If WinGetTitle(HWnd($ghnd_MPC_handle)) = "Media Player Classic Home Cinema" Then
If GUICtrlRead($loopButton) <> "Playlist Mode" Then
If GUICtrlGetState($listAddButton) = 80 Then GUICtrlSetState($listAddButton, $GUI_DISABLE)
EndIf
If GUICtrlGetState($speedSlider) = 80 Then GUICtrlSetState($speedSlider, $GUI_DISABLE)
If GUICtrlGetState($__SPD_025X) = 80 Then GUICtrlSetState($__SPD_025X, $GUI_DISABLE)
If GUICtrlGetState($__SPD_05X) = 80 Then GUICtrlSetState($__SPD_05X, $GUI_DISABLE)
If GUICtrlGetState($__SPD_075X) = 80 Then GUICtrlSetState($__SPD_075X, $GUI_DISABLE)
If GUICtrlGetState($__SPD_1X) = 80 Then GUICtrlSetState($__SPD_1X, $GUI_DISABLE)
If GUICtrlGetState($__SPD_125X) = 80 Then GUICtrlSetState($__SPD_125X, $GUI_DISABLE)
If GUICtrlGetState($__SPD_15X) = 80 Then GUICtrlSetState($__SPD_15X, $GUI_DISABLE)
If GUICtrlGetState($__SPD_175X) = 80 Then GUICtrlSetState($__SPD_175X, $GUI_DISABLE)
If GUICtrlGetState($__SPD_2X) = 80 Then GUICtrlSetState($__SPD_2X, $GUI_DISABLE)
Else
If GUICtrlRead($loopButton) <> "Playlist Mode" Then
If GUICtrlGetState($listAddButton) = 144 Then GUICtrlSetState($listAddButton, $GUI_ENABLE)
EndIf
If GUICtrlGetState($speedSlider) = 144 Then GUICtrlSetState($speedSlider, $GUI_ENABLE)
If GUICtrlGetState($__SPD_025X) = 144 Then GUICtrlSetState($__SPD_025X, $GUI_ENABLE)
If GUICtrlGetState($__SPD_05X) = 144 Then GUICtrlSetState($__SPD_05X, $GUI_ENABLE)
If GUICtrlGetState($__SPD_075X) = 144 Then GUICtrlSetState($__SPD_075X, $GUI_ENABLE)
If GUICtrlGetState($__SPD_1X) = 144 Then GUICtrlSetState($__SPD_1X, $GUI_ENABLE)
If GUICtrlGetState($__SPD_125X) = 144 Then GUICtrlSetState($__SPD_125X, $GUI_ENABLE)
If GUICtrlGetState($__SPD_15X) = 144 Then GUICtrlSetState($__SPD_15X, $GUI_ENABLE)
If GUICtrlGetState($__SPD_175X) = 144 Then GUICtrlSetState($__SPD_175X, $GUI_ENABLE)
If GUICtrlGetState($__SPD_2X) = 144 Then GUICtrlSetState($__SPD_2X, $GUI_ENABLE)
EndIf
EndFunc
Func checkPlayingNewFile()
If IsArray($nowPlayingInfo) = 1 Then
If $currentLoadedFile = "" Or $currentLoadedFile <> $nowPlayingInfo[4] Then
clearInOutPoint()
setSpeed(100)
$currentLoadedFile = $nowPlayingInfo[4]
EndIf
EndIf
EndFunc
Func checkWinActiveHotkeys()
If WinActive($mainWindow) Or WinActive(Hwnd($ghnd_MPC_handle)) Or WinActive("OSD Window") Then
If $hotKeysActive = False Then
$currentFocus = ControlGetFocus($mainWindow, "")
If $currentFocus = "Edit3" Then
loadHotKeys(0)
Else
loadHotKeys(1)
EndIf
EndIf
Else
If $hotKeysActive = True Then
loadHotKeys(0)
EndIf
EndIf
EndFunc
Func checkOSDWindowOn()
If GUICtrlRead($OSDButton) = "OSD On" Then
WinSetOnTop($OSDWindow, "", 1)
updateOSD()
EndIf
EndFunc
Func updateStatusText()
If $displayTimer <> "" Then
If Mod($displayTimer, 100) = 0 Then
If $displayMessage = 2 Then ToolTip("")
$displayMessage = 0
$displayTimer = 0
Else
$displayTimer = $displayTimer + 1
EndIf
EndIf
If $displayMessage = 0 Then
If getItemCount() > 0 Then
updateEventOSDInfo($currentPlayingEvent + 1)
Else
clearOSDInfo(0)
EndIf
ElseIf $displayMessage = 1 Then
clearOSDInfo(0)
Else
EndIf
If GUICtrlRead($currentEventStatusTF) <> $currentEventCounter Then
GUICtrlSetData($currentEventStatusTF, $currentEventCounter)
EndIf
EndFunc
Func doTheLoop()
$currentFocus = ControlGetFocus($mainWindow, "")
If $currentFocus = "Edit3" Then
loadHotKeys(0)
EndIf
If $isClicked = 1 Then
switchModifyDelete()
$isClicked = 0
ElseIf $isClicked = 2 Then
$selectedItem = _GUICtrlListView_GetSelectedIndices($eventList, False)
loadEvent(Number($selectedItem))
switchModifyDelete()
If $currentlySearching = 1 Then
$currentlySearching = 2
EndIf
$isClicked = 0
EndIf
__MPC_send_message($ghnd_MPC_handle, $CMD_GETCURRENTPOSITION, "")
If $pastPosition <> $currentPosition Then
updateTime()
EndIf
If GUICtrlRead($loopButton) = "Loop Mode" Or GUICtrlRead($loopButton) = "Playlist Mode" Or GUICtrlRead($loopButton) = "Shuffle Mode" Then
$currentInPoint = TimeStringToNumber(GUICtrlRead($inTF)) - 0.5
$currentOutPoint = TimeStringToNumber(GUICtrlRead($outTF)) - 0.5
If $trimmingOut = 1 Then
$currentOutPoint = $currentOutPoint +($loopPreviewLength / 4)
EndIf
If $currentOutPoint <> "" Then
If $currentOutPoint < $currentPosition Then
If GUICtrlRead($inTF) <> "" Then
If GUICtrlRead($loopButton) = "Loop Mode" Then
__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION,(TimeStringToNumber($currentInPoint)))
ElseIf GUICtrlRead($loopButton) = "Playlist Mode" Then
loadPrevNextEvent(1)
ElseIf GUICtrlRead($loopButton) = "Shuffle Mode" Then
$nextEvent = $randomPlayOrder[$randomPlayOrder[UBound($randomPlayOrder) - 1]]
loadEvent($nextEvent)
Sleep(200)
If UBound($randomPlayOrder) <> 0 Then
If $randomPlayOrder[UBound($randomPlayOrder) - 1] =(getItemCount() - 1) Then
$randomPlayOrder[UBound($randomPlayOrder) - 1] = 0
Else
$randomPlayOrder[UBound($randomPlayOrder) - 1] += 1
EndIf
Else
EndIf
EndIf
$trimmingOut = 0
EndIf
EndIf
EndIf
Else
EndIf
EndFunc
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
Func checkDocking()
If GUICtrlRead($dockLeftButton) = " " Or GUICtrlRead($dockRightButton) = " " Then
$currentMPCPos = WinGetPos(HWnd($ghnd_MPC_handle))
$currentLooperPos = WinGetPos($mainWindow)
If WinActive(HWnd($ghnd_MPC_handle)) Then
If GUICtrlRead($dockLeftButton) = " " Then
If $currentMPCPos[0] <>($currentLooperPos[0] + $currentLooperPos[2]) Then
Local $hDLL = DllOpen("user32.dll")
If _IsPressed("01", $hDLL) Then
WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 1)
While _IsPressed("01", $hDLL)
WEnd
EndIf
DllClose($hDLL)
WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 0)
WinMove($mainWindow, "",($currentMPCPos[0] - $currentLooperPos[2]), $currentMPCPos[1])
EndIf
ElseIf GUICtrlRead($dockRightButton) = " " Then
If $currentMPCPos[0] <>($currentLooperPos[0] - $currentLooperPos[2]) Then
Local $hDLL = DllOpen("user32.dll")
If _IsPressed("01", $hDLL) Then
WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 1)
While _IsPressed("01", $hDLL)
WEnd
EndIf
DllClose($hDLL)
WinSetOnTop(Hwnd($ghnd_MPC_handle), "", 0)
WinMove($mainWindow, "",($currentMPCPos[0] + $currentMPCPos[2]), $currentMPCPos[1])
EndIf
EndIf
ElseIf WinActive($mainWindow) Then
If GUICtrlRead($dockLeftButton) = " " Then
If $currentLooperPos[0] <>($currentMPCPos[0] - $currentLooperPos[2]) Then
WinMove(Hwnd($ghnd_MPC_handle), "",($currentLooperPos[0] + $currentLooperPos[2]), $currentLooperPos[1])
EndIf
ElseIf GUICtrlRead($dockRightButton) = " " Then
If $currentLooperPos[0] <>($currentMPCPos[0] + $currentMPCPos[2]) Then
WinMove(Hwnd($ghnd_MPC_handle), "",($currentLooperPos[0] - $currentMPCPos[2]), $currentLooperPos[1])
EndIf
EndIf
EndIf
Else
EndIf
EndFunc
Func searchEventList()
$currentSearch = GUICtrlRead($searchEventTF)
If $currentlySearching = 0 Then
$completeEventList = _GUIListViewEx_ReturnArray($eventListIndex)
EndIf
Local $completeEventListArray[UBound($completeEventList)][5]
For $i = 0 to UBound($completeEventList) - 1
$currentItem = StringSplit($completeEventList[$i], "|", 2)
$completeEventListArray[$i][0] = $currentItem[0]
$completeEventListArray[$i][1] = $currentItem[1]
$completeEventListArray[$i][2] = $currentItem[2]
$completeEventListArray[$i][3] = $currentItem[3]
$completeEventListArray[$i][4] = $currentItem[4]
Next
$foundItems = _ArrayFindAll($completeEventListArray, $currentSearch, Default, Default, Default, 1, 1)
If IsArray($foundItems) Then
ReDim $searchResultsList[UBound($foundItems)]
For $i = 0 to UBound($foundItems) - 1
$currentItem = StringSplit($completeEventList[$foundItems[$i]], "|", 2)
$searchResultsList[$i] = $completeEventList[$foundItems[$i]]
Next
GUICtrlSetBkColor($searchEventTF, 0xb8ebcd)
GUICtrlSetBkColor($eventList, 0xe4ffef)
GUICtrlSetFont($eventList, 9, 400, 2, "Segoe UI")
$currentlySearching = 1
clearEvents()
_GUICtrlListView_BeginUpdate($eventList)
For $i = 0 to UBound($searchResultsList) - 1
GUICtrlCreateListViewItem($searchResultsList[$i], $eventList)
Next
_GUICtrlListView_EndUpdate($eventList)
$eventListIndex = _GUIListViewEx_Init($eventList, $searchResultsList, 0, 0, True, 1)
_GUICtrlListView_SetItemSelected($eventList, -1, False, False)
GUICtrlSetState($searchClearButton, $GUI_ENABLE)
GUICtrlSetState($listClearButton, $GUI_HIDE)
Else
MsgBox(0, "", 'No results were found for "' & $currentSearch & '" in the current events list')
EndIf
EndFunc
Func searchEventListRestore()
If $currentlySearching <> 0 Then
GUICtrlSetData($searchEventTF, "")
clearEvents()
Redim $searchResultsList[0]
$currentlySearching = 0
_GUICtrlListView_BeginUpdate($eventList)
GUICtrlSetBkColor($searchEventTF, $COLOR_WHITE)
GUICtrlSetBkColor($eventList, $COLOR_WHITE)
GUICtrlSetFont($eventList, 9, 400, 0, "Segoe UI")
For $i = 0 to UBound($completeEventList) - 1
GUICtrlCreateListViewItem($completeEventList[$i], $eventList)
Next
_GUICtrlListView_EndUpdate($eventList)
$eventListIndex = _GUIListViewEx_Init($eventList, $completeEventList, 0, 0, True, 1)
_GUICtrlListView_SetItemSelected($eventList, -1, False, False)
GUICtrlSetState($searchClearButton, $GUI_DISABLE)
GUICtrlSetState($listClearButton, $GUI_SHOW)
EndIf
EndFunc
While 1
If $MPCInitialized = 2 Then
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "") <> 1 Then
If $currentLoadedFile <> "" Then
$reloadMPC= MsgBox(4 + 32 + 262144 + 256, "MPC-HC Closed", "MPC-HC just closed, either you quit out of it, or it closed on it's own - would you like to re-open it?" & @CRLF & @CRLF & "If you choose " & '"Yes"' & " below, a new MPC-HC window will open and start playing the loop you're currently playing, and if you choose " & '"No"' & " below, MPC-HC Looper will shut down.")
Else
$reloadMPC= MsgBox(4 + 32 + 262144 + 256, "MPC-HC Closed", "MPC-HC just closed, either you quit out of it, or it closed on it's own - would you like to re-open it?" & @CRLF & @CRLF & "If you choose " & '"Yes"' & " below, a new MPC-HC window will open, and if you choose " & '"No"' & " below, MPC-HC Looper will shut down.")
EndIf
If $reloadMPC = 6 Then
linkMPC()
Sleep(500)
If $currentLoadedFile <> "" Then
$currentLoadedFile = ""
loadEvent($currentPlayingEvent)
If $currentSpeed <> 100 Then
Sleep(350)
setSpeed($currentSpeed)
EndIf
EndIf
Else
$MPCInitialized = 0
Uninitialize()
EndIf
Else
$MPCInitialized = 0
Uninitialize()
EndIf
Else
checkWinActiveHotkeys()
refreshMPCInfo()
checkPlayingNewFile()
checkDocking()
checkCurrentTitle()
checkEventListActive()
checkMPCSpeedAvailable()
checkOSDWindowOn()
updateStatusText()
doTheLoop()
Sleep(20)
checkLoadingNewFile()
EndIf
WEnd
Func looperTitle()
If $currentLooperFile <> "" Then
$looperTitle = StringRight($currentLooperFile, StringLen($currentLooperFile) - StringInStr($currentLooperFile, "\" , Default, -1))
Return $looperTitle
EndIf
EndFunc
Func setModified($newSetting = 1)
If $newSetting = 1 Then
If $isModified = 0 Then
$isModified = 1
GUICtrlSetState($listSaveButton, $GUI_ENABLE)
EndIf
Else
$isModified = 0
GUICtrlSetState($listSaveButton, $GUI_DISABLE)
EndIf
EndFunc
Func updateTime()
If $currentOrRemaining = 0 Then
GUICtrlSetData($timeTF, NumberToTimeString($currentPosition + 0.5))
Else
$remainingTime = Round(TimeStringToNumber(GUICtrlRead($outTF)) - 0.5 - $currentPosition, 4)
If $remainingTime > 0 Then
GUICtrlSetData($timeTF, "-" & NumberToTimeString($remainingTime))
Else
GUICtrlSetData($timeTF, "<--------->")
EndIf
EndIf
$pastPosition = $currentPosition
EndFunc
Func displayStatusMsg($theMessage)
$displayTimer = 60
$displayMessage = 2
$currentEventCounter = $theMessage
EndFunc
Func switchCurrentandRemaining()
If $currentOrRemaining = 0 Then
$currentOrRemaining = 1
Else
$currentOrRemaining = 0
EndIf
updateTime()
EndFunc
Func switchCurrentEventandTotalEvents()
If $displayMessage = 0 Then
$displayTimer = 1
$displayMessage = 1
Else
$displayTimer = 0
$displayMessage = 0
EndIf
EndFunc
Func clickLeftDockingButton()
If GUICtrlRead($dockLeftButton) <> " " Then
GUICtrlSetData($dockLeftButton, " ")
GUICtrlSetData($dockRightButton, "")
GUICtrlSetBkColor($dockLeftButton, 0x3daf05)
GUICtrlSetBkColor($dockRightButton, 0xffffff)
WinMove($mainWindow, "", 11, 11)
Else
clickDockingButton()
EndIf
EndFunc
Func clickDockingButton()
GUICtrlSetData($dockLeftButton, "")
GUICtrlSetData($dockRightButton, "")
GUICtrlSetBkColor($dockLeftButton, 0xffffff)
GUICtrlSetBkColor($dockRightButton, 0xffffff)
EndFunc
Func clickRightDockingButton()
If GUICtrlRead($dockRightButton) <> " " Then
GUICtrlSetData($dockLeftButton, "")
GUICtrlSetData($dockRightButton, " ")
GUICtrlSetBkColor($dockLeftButton, 0xffffff)
GUICtrlSetBkColor($dockRightButton, 0x3daf05)
WinMove($mainWindow, "",(@DesktopWidth -(429 + 30)), 11)
Else
clickDockingButton()
EndIf
EndFunc
Func clickLoopButton()
loadHotkeys(0)
Local $hDLL = DllOpen("user32.dll")
If _IsPressed("02", $hDLL) Then
switchToShuffle()
Else
Switch GUICtrlRead($loopButton)
Case "Loop Mode"
If getItemCount() > 0 Then
switchToPlaylist()
Else
switchToOff()
EndIf
Case "Playlist Mode"
switchToOff()
Case "Shuffle Mode"
switchToLoop()
Case "OFF"
switchToLoop()
EndSwitch
EndIf
DllClose($hDLL)
Sleep(200)
loadHotkeys(1)
EndFunc
Func switchToLoop()
GUICtrlSetData($loopButton, "Loop Mode")
GUICtrlSetBkColor($loopButton, 0xb0f6b0)
switchEditingControls($GUI_ENABLE)
clearRandomization()
EndFunc
Func switchToPlaylist()
If getItemCount() > 0 Then
GUICtrlSetData($loopButton, "Playlist Mode")
GUICtrlSetBkColor($loopButton, 0xffa882)
switchEditingControls($GUI_DISABLE)
clearRandomization()
Else
displayError("Playlist Mode")
switchToLoop()
EndIf
EndFunc
Func switchToShuffle()
If getItemCount() > 0 Then
If GUICtrlRead($loopButton) <> "Shuffle Mode" Then
GUICtrlSetData($loopButton, "Shuffle Mode")
GUICtrlSetBkColor($loopButton, 0x85e7f0)
switchEditingControls($GUI_DISABLE)
createRandomList()
Else
switchToLoop()
EndIf
Else
displayError("Shuffle Mode")
EndIf
EndFunc
Func switchToOff()
GUICtrlSetData($loopButton, "OFF")
GUICtrlSetBkColor($loopButton, 0xFFFFE1)
switchEditingControls($GUI_ENABLE)
clearRandomization()
EndFunc
Func clearRandomization()
If UBound($randomPlayOrder) > 0 Then
_ArrayDelete($randomPlayOrder, "0-" & UBound($randomPlayOrder) - 1)
EndIf
EndFunc
Func displayError($errorMode)
If $errorMode = "Playlist Mode" Then
$errorTitle = "Can't switch to Playlist Mode (CTRL-3)... yet"
$errorMsg = "You can't switch to Playlist Mode manually (by pressing" & @CRLF & "CTRL-3) unless you have at least one event in the playlist."
ElseIf $errorMode = "Shuffle Mode" Then
$errorTitle = "Can't switch to Shuffle Mode (CTRL-4)... yet"
$errorMsg = "You can't switch to Shuffle Mode manually (by pressing" & @CRLF & "CTRL-4) unless you have at least one event in the playlist."
EndIf
Local $mWCoords = WinGetPos($mainWindow)
Local $coords = ControlGetPos($mainWindow, "", $loopButton)
For $p = 0 to 1
$coords[$p] =(Int($mWCoords[$p]) + Int($coords[$p])) + 25
Next
$coords[1] = Int($coords[1]) +(Int($coords[3]) / 2)
ToolTip($errorMsg, $coords[0], $coords[1], $errorTitle, 2, 1)
$displayTimer = 1
$displayMessage = 2
EndFunc
Func clickOSDButton()
Switch GUICtrlRead($OSDButton)
Case "OSD Off"
OSDWindow()
GUICtrlSetData($OSDButton, "OSD On")
GUICtrlSetBkColor($OSDButton, 0x49b9f3)
Case "OSD On"
$currentWndSize = WinGetPos($OSDWindow, "")
$OSDWindowX = $currentWndSize[0]
$OSDWindowY = $currentWndSize[1]
GUIDelete($OSDWindow)
GUICtrlSetData($OSDButton, "OSD Off")
GUICtrlSetBkColor($OSDButton, 0xbfd1db)
EndSwitch
EndFunc
Func createRandomList()
$countOfItems = getItemCount()
If IsInt($countOfItems / 2) Then
$halfOfList =($countOfItems / 2)
Local $randomNumArray1[$halfOfList]
Local $randomNumArray2[$halfOfList]
For $i = 0 to($halfOfList - 1)
$randomNumArray1[$i] = $i
Next
For $i = 0 to($halfOfList - 1)
$randomNumArray2[$i] = $halfOfList + $i
Next
Else
$halfOfList = Int(($countOfItems / 2) + 1)
Local $randomNumArray1[$halfOfList]
Local $randomNumArray2[$countOfItems - $halfOfList]
For $i = 0 to($halfOfList - 1)
$randomNumArray1[$i] = $i
Next
For $i = 0 to(($countOfItems - $halfOfList) - 1)
$randomNumArray2[$i] = $halfOfList + $i
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
If $randomPlayOrder[0] = $currentPlayingEvent Then
_ArraySwap($randomPlayOrder, 0, UBound($randomPlayOrder) - 1)
EndIf
Redim $randomPlayOrder[UBound($randomPlayOrder) + 1]
$randomPlayOrder[UBound($randomPlayOrder) - 1] = 1
loadEvent($randomPlayOrder[0])
EndFunc
Func switchEditingControls($onOrOff)
GUICtrlSetState($inButton, $onOrOff)
GUICtrlSetState($outButton, $onOrOff)
GUICtrlSetState($clearInButton, $onOrOff)
GUICtrlSetState($clearOutButton, $onOrOff)
GUICtrlSetState($clearAllButton, $onOrOff)
GUICtrlSetState($inDecButton, $onOrOff)
GUICtrlSetState($inIncButton, $onOrOff)
GUICtrlSetState($outDecButton, $onOrOff)
GUICtrlSetState($outIncButton, $onOrOff)
GUICtrlSetState($listAddButton, $onOrOff)
If $onOrOff = 64 Then
switchModifyDelete()
Else
GUICtrlSetState($listModifyButton, $onOrOff)
GUICtrlSetState($listDeleteButton, $onOrOff)
EndIf
GUICtrlSetState($listClearButton, $onOrOff)
EndFunc
Func switchModifyDelete()
$iCount = _GUICtrlListView_GetSelectedCount($eventList)
If $iCount Then
If $currentPlayingEvent <> -1 Then
GUICtrlSetState($listDeleteButton, $GUI_ENABLE)
GUICtrlSetState($listModifyButton, $GUI_ENABLE)
Else
GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
GUICtrlSetState($listModifyButton, $GUI_DISABLE)
EndIf
Else
GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
GUICtrlSetState($listModifyButton, $GUI_DISABLE)
EndIf
EndFunc
Func setAlwaysOnTop()
$currentState = GUICtrlRead($onTopButton)
If $currentState = "Always on Top" Then
WinSetOnTop($mainWindow, "", 0)
GUICtrlSetData($onTopButton, "Not Topmost")
GUICtrlSetBkColor($onTopButton, 0xd1d1d1)
ElseIf $currentState = "Not Topmost" Then
WinSetOnTop($mainWindow, "", 1)
GUICtrlSetData($onTopButton, "Always on Top")
GUICtrlSetBkColor($onTopButton, 0xb7baf3)
EndIf
EndFunc
Func maximizeWindow()
$windowDim = WinGetPos($mainWindow)
If $windowDim[3] = $minHeight Then
WinMove($mainWindow, "", Default, Default, Default,(@DesktopHeight / 2))
ElseIf $windowDim[3] = $maxHeight Then
WinMove($mainWindow, "", Default, Default, Default, $minHeight)
Else
WinMove($mainWindow, "", Default, Default, Default, $maxHeight)
EndIf
EndFunc
Func minimizeWindow()
WinSetState($mainWindow, "", @SW_MINIMIZE)
EndFunc
Func restoreWindow()
WinSetState($mainWindow, "", @SW_RESTORE)
EndFunc
Func loadURL()
ShellExecute("http://www.gullswingmedia.com/mpc-hc-looper.html")
EndFunc
Func Uninitialize()
If getItemCount() = 0 Then
writeCurrentlyPlayingFile()
EndIf
If $tryingToQuit = 0 Then
$tryingToQuit = 1
__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "")
loadHotKeys(0)
If $MPCInitialized <> 0 Then
$isQuitting = MsgBox(262144 + 52, "Quitting?", "Do you want to quit Media Player Classic Looper?")
Else
$isQuitting = "6"
EndIf
If $isQuitting = "6" Then
If $isModified = 1 Then
$saveState = askForSave("Do you want to save before quitting?")
If($saveState <> "") Or($saveState = -1) Then
writeCurrentlyPlayingFile()
Else
If $MPCInitialized <> 0 Then
$saveState = MsgBox(262144 + 4, "You did not save", "You chose not to save a new .looper file - do you still want to quit?")
Else
$saveState = "6"
EndIf
If $saveState = "6" Then
writeCurrentlyPlayingFile()
Else
$tryingToQuit = 0
loadHotKeys(1)
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "")
EndIf
EndIf
EndIf
Else
writeCurrentlyPlayingFile()
EndIf
Else
$tryingToQuit = 0
loadHotKeys(1)
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "")
EndIf
EndIf
EndIf
EndFunc
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
Func checkNameSpeedSetting($theName)
$speedSetting = 0
If StringInStr($theName, "<S:") = 1 Then
$theOffset = StringInStr($theName, ">")
$speedSetting = StringLeft($theName, $theOffset - 1)
$speedSetting = StringRight($speedSetting, StringLen($speedSetting) - 3)
EndIf
Return $speedSetting
EndFunc
Func sliderMoving($hWnd, $iMsg, $wParam, $lParam)
#forceref $hWnd, $iMsg, $wParam
If $lParam = GUICtrlGetHandle($speedSlider) Then
setSpeed(GUICtrlRead($speedSlider))
EndIf
Return $GUI_RUNDEFMSG
EndFunc
Func setSpeed025()
setSpeed(25)
EndFunc
Func setSpeed05()
setSpeed(50)
EndFunc
Func setSpeed075()
setSpeed(75)
EndFunc
Func setSpeed1()
setSpeed(100)
EndFunc
Func setSpeed125()
setSpeed(125)
EndFunc
Func setSpeed15()
setSpeed(150)
EndFunc
Func setSpeed175()
setSpeed(175)
EndFunc
Func setSpeed2()
setSpeed(200)
EndFunc
Func setSpeed($theSpeed)
displayStatusMsg("Setting speed to " & $theSpeed & " percent")
__MPC_send_message($ghnd_MPC_handle, $CMD_SETSPEED, Number($theSpeed) / 100)
GUICtrlSetData($speedSlider, $theSpeed)
$currentSpeed = $theSpeed
EndFunc
Func OSDWindow()
$OSDWindow = GUICreate("OSD Window", 524, 89, $OSDWindowX, $OSDWindowY, $WS_POPUP)
$OSDmodeTF = GUICtrlCreateLabel("", 8, 1, 97, 25)
$OSDeventNameTF = GUICtrlCreateLabel($currentEventName, 5, 30, 511, 29, $SS_RIGHT)
$OSDeventCounterTF = GUICtrlCreateLabel($currentEventCounter, 164, 1, 352, 25, $SS_RIGHT)
$OSDcurrentPositionTF = GUICtrlCreateLabel("", 400, 58, 120, 29)
$OSDinPositionTF = GUICtrlCreateLabel("", 28, 58, 120, 29)
$OSDoutPositionTF = GUICtrlCreateLabel("", 200, 58, 120, 29)
$OSDCurrentRemainTF = GUICtrlCreateLabel("CURRENT", 336, 64, 62, 21)
$_SEPERATOR = GUICtrlCreateGraphic(8, 26, 513, 1)
$_IN = GUICtrlCreateLabel("IN", 8, 64, 18, 21)
$_OUT = GUICtrlCreateLabel("OUT", 168, 64, 31, 21)
GUICtrlSetFont($OSDmodeTF, 12, 400, 0, "Segoe UI")
GUICtrlSetFont($OSDeventNameTF, 14, 800, 0, "Segoe UI")
GUICtrlSetFont($OSDeventCounterTF, 12, 400, 0, "Segoe UI")
GUICtrlSetFont($OSDcurrentPositionTF, 14, 400, 0, "Segoe UI")
GUICtrlSetFont($OSDinPositionTF, 14, 400, 0, "Segoe UI")
GUICtrlSetFont($OSDoutPositionTF, 14, 400, 0, "Segoe UI")
GUICtrlSetFont($OSDCurrentRemainTF, 10, 800, 0, "Segoe UI")
GUICtrlSetFont($_IN, 10, 800, 0, "Segoe UI")
GUICtrlSetFont($_OUT, 10, 800, 0, "Segoe UI")
GUICtrlSetColor($OSDmodeTF, 0x000000)
GUICtrlSetColor($OSDeventCounterTF, 0x000000)
GUICtrlSetBkColor($_SEPERATOR, 0x000000)
GUISetState(@SW_SHOWNOACTIVATE)
GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, "moveWindow")
GUICtrlSetOnEvent($OSDcurrentPositionTF, "switchCurrentandRemaining")
GUICtrlSetOnEvent($OSDeventCounterTF, "switchCurrentEventandTotalEvents")
WinSetTrans($OSDWindow, "", 188)
WinSetOnTop($OSDWindow, "", 1)
EndFunc
Func moveWindow()
_SendMessage($OSDWindow, $WM_SYSCOMMAND, 0xF012, 0)
EndFunc
Func updateEventOSDInfo($eventToLoad)
$numOfEvents = getItemCount()
$currentEventIN = _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 2)
$currentEventOUT = _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 3)
If $currentEventIN = GUICtrlRead($inTF) And $currentEventOut = GUICtrlRead($outTF) Then
If $eventToLoad <> 0 Then
$currentEventName = _GUICtrlListView_GetItemText($eventList, $eventToLoad - 1, 1)
$currentEventDur = NumberToTimeString(getEventDur($eventToLoad))
$currentEventCounter = "Playing event " & $eventToLoad & " out of " & $numOfEvents & " (" & $currentEventDur & ")"
Else
clearOSDInfo()
EndIf
Else
clearOSDInfo()
EndIf
EndFunc
Func getEventDur($eventNumOrInPoint, $outPoint = 0)
If $outPoint <> "0" Then
$inPoint = TimeStringToNumber($eventNumOrInPoint)
$outPoint = TimeStringToNumber($outPoint)
Else
$eventNumOrInPoint = $eventNumOrInPoint - 1
$inPoint = TimeStringToNumber(_GUICtrlListView_GetItemText($eventList, $eventNumOrInPoint, 2))
$outPoint = TimeStringToNumber(_GUICtrlListView_GetItemText($eventList, $eventNumOrInPoint, 3))
EndIf
$theDifference = $outPoint - $inPoint
If $theDifference > 0 Then
Return $theDifference
Else
Return 0
EndIf
EndFunc
Func getTotalPlaylistDur()
$numOfEvents = getItemCount()
$totalTimeTally = 0
For $p = 1 to $numOfEvents
$currentItemDur = getEventDur($p)
$totalTimeTally = $totalTimeTally + $currentItemDur
Next
Return $totalTimeTally
EndFunc
Func clearOSDInfo($changeName = 1)
If $changeName = 1 Then
$currentEventName = ""
EndIf
$numOfEvents = getItemCount()
If $numOfEvents > 1 Or $numOfEvents = 0 Then
$currentEventCounter = $numOfEvents & " events in playlist"
Else
$currentEventCounter = "1 event in playlist"
EndIf
$totalTimeTally = getTotalPlaylistDur()
$currentEventCounter = $currentEventCounter & " (" & NumberToTimeString($totalTimeTally) & " in entire playlist)"
EndFunc
Func updateOSD()
If GUICtrlRead($OSDButton) = "OSD On" Then
If GUICtrlRead($OSDmodeTF) <> GUICtrlRead($loopButton) Then
GUICtrlSetData($OSDmodeTF, GUICtrlRead($loopButton))
EndIf
If GUICtrlRead($OSDeventNameTF) <> $currentEventName Then
GUICtrlSetData($OSDeventNameTF, $currentEventName)
EndIf
If GUICtrlRead($OSDeventCounterTF) <> $currentEventCounter Then
GUICtrlSetData($OSDeventCounterTF, $currentEventCounter)
EndIf
If GUICtrlRead($OSDcurrentPositionTF) <> GUICtrlRead($timeTF) Then
GUICtrlSetData($OSDcurrentPositionTF, GUICtrlRead($timeTF))
EndIf
If GUICtrlRead($OSDinPositionTF) <> GUICtrlRead($inTF) Then
GUICtrlSetData($OSDinPositionTF, GUICtrlRead($inTF))
EndIf
If GUICtrlRead($OSDoutPositionTF) <> GUICtrlRead($outTF) Then
GUICtrlSetData($OSDoutPositionTF, GUICtrlRead($outTF))
EndIf
If $currentOrRemaining = 1 Then
If GUICtrlRead($OSDCurrentRemainTF) <> "  REMAIN" Then
GUICtrlSetData($OSDCurrentRemainTF, "  REMAIN")
EndIf
Else
If GUICtrlRead($OSDCurrentRemainTF) <> "CURRENT" Then
GUICtrlSetData($OSDCurrentRemainTF, "CURRENT")
EndIf
EndIf
EndIf
EndFunc
Func loadOptions()
Opt("GUIOnEventMode",0)
loadHotKeys(0)
__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "")
$optionsWindow = GUICreate("MPC-HC Looper Options", 411, 486, Default, Default)
$_NOTE1 = GUICtrlCreateLabel("Preview Time (in seconds)", 8, 8, 166, 21)
$_NOTE2 = GUICtrlCreateLabel("Slip Amount (in seconds)", 208, 8, 160, 21)
$prevDelayTF = GUICtrlCreateInput($loopPreviewLength, 8, 32, 193, 25)
$slipTF = GUICtrlCreateInput($loopSlipLength, 208, 32, 185, 25)
$_NOTE3 = GUICtrlCreateLabel("Default Settings for new Looper sessions", 8, 64, 257, 21)
$_DESC1 = GUICtrlCreateLabel("NOTE: To restore any setting below to its default, un-check any of", 8, 88, 372, 21)
$_DESC2 = GUICtrlCreateLabel("the preference(s) you want to restore below and click Save Prefs", 8, 106, 357, 21)
$currentDelayCheck = GUICtrlCreateCheckbox(" Save Preview Time as default", 8, 132, 193, 25)
$currentSlipCheck = GUICtrlCreateCheckbox("Save Slip Amount as default", 208, 132, 177, 25)
$savePosCheck = GUICtrlCreateCheckbox(" Save current Looper window positions and sizes as default", 8, 160, 361, 17)
$saveLoopCheck = GUICtrlCreateCheckbox(" Save current Loop Mode button setting as default", 8, 184, 361, 17)
$saveAOTCheck = GUICtrlCreateCheckbox(" Save current Always on Top button setting as default", 8, 208, 361, 17)
$saveDockCheck = GUICtrlCreateCheckbox(" Save current Window Docking setting as default", 8, 232, 361, 17)
$_NOTE4 = GUICtrlCreateLabel("Extra System Options", 8, 256, 136, 21)
$disableToolTips = GUICtrlCreateCheckbox(" Disable tool tips on the main Looper panel", 8, 281, 361, 17)
$autoloadCheck = GUICtrlCreateCheckbox(" Auto-load the last open .looper file on Looper launch", 8, 305, 361, 17)
$allowMICheck = GUICtrlCreateCheckbox(" Allow multiple instances of Looper if MPC-HC allows more", 8, 329, 369, 17)
$MI_desc_2 = GUICtrlCreateLabel("than one instance (settable in MPC-HC Options)", 32, 350, 281, 21)
$autoPlayDialogsCheck = GUICtrlCreateCheckbox(" Disable auto-playing after exiting Looper dialogs", 8, 373, 305, 17)
$autoPlayCheck = GUICtrlCreateCheckbox(" Disable auto-playing first event when opening new .looper file", 8, 397, 393, 17)
$askConfCheck = GUICtrlCreateCheckbox(" Disable re-open confirmation when closing MPC-HC on its own", 8, 422, 393, 17)
$looperAssociateButton = GUICtrlCreateButton("Associate .looper files", 8, 451, 175, 25)
$optionsCancelButton = GUICtrlCreateButton("Cancel", 192, 451, 91, 25)
$optionsSaveButton = GUICtrlCreateButton("Save Prefs", 288, 451, 107, 25)
Dim $optionsWindow_AccelTable[2][2] = [["{ENTER}", $optionsSaveButton],["{ESC}", $optionsCancelButton]]
GUISetAccelerators($optionsWindow_AccelTable)
GUICtrlSetFont($_NOTE1, 10, 800, 0, "Segoe UI")
GUICtrlSetFont($_NOTE2, 10, 800, 0, "Segoe UI")
GUICtrlSetFont($_NOTE3, 10, 800, 0, "Segoe UI")
GUICtrlSetFont($_NOTE4, 10, 800, 0, "Segoe UI")
GUICtrlSetFont($_DESC1, 10, 400, 2, "Segoe UI")
GUICtrlSetFont($_DESC2, 10, 400, 2, "Segoe UI")
GUICtrlSetFont($currentDelayCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($prevDelayTF, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($currentSlipCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($slipTF, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($savePosCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($saveLoopCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($saveAOTCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($saveDockCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($disableToolTips, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($autoloadCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($autoPlayCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($allowMICheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($MI_desc_2, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($autoPlayDialogsCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($askConfCheck, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($looperAssociateButton, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($optionsCancelButton, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($optionsSaveButton, 10, 800, 0, "Segoe UI")
GUICtrlSetTip($_NOTE1, "The amount of time (in seconds) that a preview will skip back and play " & @CRLF & "(acting as pre-roll) when previewing a slip forward or back" & @CRLF & @CRLF & "The default is 0.25 (1/4th of a second)")
GUICtrlSetTip($prevDelayTF, "The amount of time (in seconds) that a preview will skip back and play " & @CRLF & "(acting as pre-roll) when previewing a slip forward or back" & @CRLF & @CRLF & "The default is 0.25 (1/4th of a second)")
GUICtrlSetTip($_NOTE2, "The amount of time (in seconds) that a slip forward" & @CRLF & "or back will move the current IN or OUT point" & @CRLF & @CRLF & "The default is 0.05 (1/20th of a second)")
GUICtrlSetTip($slipTF, "The amount of time (in seconds) that a slip forward" & @CRLF & "or back will move the current IN or OUT point" & @CRLF & @CRLF & "The default is 0.05 (1/20th of a second)")
GUICtrlSetTip($currentDelayCheck, "If you enable this checkbox, the current preview time above" & @CRLF & "will be saved as the default preview time for new Looper sessions")
GUICtrlSetTip($currentSlipCheck, "If you enable this checkbox, the current slip time above" & @CRLF & "will be saved as the default slip time for new Looper sessions")
GUICtrlSetTip($savePosCheck, "If you enable this checkbox, the current MPC-HC Looper size" & @CRLF & "and it's position on the screen will be saved as the default" & @CRLF & "settings for new Looper sessions")
GUICtrlSetTip($saveLoopCheck, "If you enable this checkbox, the current Loop Mode" & @CRLF & "will be saved as the default mode for new Looper sessions")
GUICtrlSetTip($saveAOTCheck, "If you enable this checkbox, the current Always On Top setting" & @CRLF & "will be saved as the default setting for new Looper sessions")
GUICtrlSetTip($saveDockCheck, "If you enable this checkbox, the current window docking setting" & @CRLF & "will be saved as the default docking setting for new Looper sessions")
GUICtrlSetTip($disableToolTips, "If you enable this checkbox, tool tips will not display on" & @CRLF & "the main Looper panel when you hover over different things - " & @CRLF & "tool tips will always display in the Options panel")
GUICtrlSetTip($autoloadCheck, "If you enable this checkbox, the last open .looper file" & @CRLF & "when you quit out of Looper will load automatically" & @CRLF & "when you start a new session")
GUICtrlSetTip($allowMICheck, "If you enable this checkbox, you can run multiple" & @CRLF & "instances of Looper if MPC-HC allows multiple" & @CRLF & "instances of itself")
GUICtrlSetTip($MI_desc_2, "If you enable this checkbox, you can run multiple" & @CRLF & "instances of Looper if MPC-HC allows multiple" & @CRLF & "instances of itself")
GUICtrlSetTip($autoPlayDialogsCheck, "If you enable this checkbox, Looper will not" & @CRLF & "automatically start playing when exiting out" & @CRLF & "of Looper dialogs")
GUICtrlSetTip($autoPlayCheck, "If you enable this checkbox, Looper will not" & @CRLF & "automatically start playing the first event" & @CRLF & "when opening a new .looper file")
GUICtrlSetTip($askConfCheck, "If you enable this checkbox, Looper disables the" & @CRLF & "confirmation to re-open MPC-HC if it closes during a Looper session")
GUICtrlSetTip($looperAssociateButton, "Associate .looper files with Windows Explorer, so" & @CRLF & "double-clicking on a .looper file will open it" & @CRLF & "in MPC-HC Looper")
Local $entrySettings[12]
$entrySettings[0] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "")
$entrySettings[1] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "")
$entrySettings[2] = IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", "")
$entrySettings[3] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "")
$entrySettings[4] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", "")
$entrySettings[5] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "")
$entrySettings[6] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "")
$entrySettings[7] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "")
$entrySettings[8] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", "")
$entrySettings[9] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "")
$entrySettings[10] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "")
$entrySettings[11] = IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "")
If $entrySettings[0] <> "" Then GUICtrlSetState($currentDelayCheck, $GUI_CHECKED)
If $entrySettings[1] <> "" Then GUICtrlSetState($currentSlipCheck, $GUI_CHECKED)
If $entrySettings[2] <> "" Then GUICtrlSetState($savePosCheck, $GUI_CHECKED)
If $entrySettings[3] <> "" Then GUICtrlSetState($saveLoopCheck, $GUI_CHECKED)
If $entrySettings[4] <> "" Then GUICtrlSetState($saveAOTCheck, $GUI_CHECKED)
If $entrySettings[5] <> "" Then GUICtrlSetState($saveDockCheck, $GUI_CHECKED)
If $entrySettings[6] <> "" Then GUICtrlSetState($autoloadCheck, $GUI_CHECKED)
If $entrySettings[7] <> "" Then GUICtrlSetState($autoPlayCheck, $GUI_CHECKED)
If $entrySettings[8] <> "" Then GUICtrlSetState($allowMICheck, $GUI_CHECKED)
If $entrySettings[9] <> "" Then GUICtrlSetState($autoPlayDialogsCheck, $GUI_CHECKED)
If $entrySettings[10] <> "" Then GUICtrlSetState($askConfCheck, $GUI_CHECKED)
If $entrySettings[11] <> "" Then GUICtrlSetState($disableToolTips,$GUI_CHECKED)
GUISetState(@SW_SHOW)
WinSetOnTop($optionsWindow, "", 1)
WinActivate($optionsWindow)
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE, $optionsCancelButton
GUIDelete($optionsWindow)
ExitLoop
Case $optionsSaveButton
$currentSavedDialog = ""
If isAcceptable(GUICtrlRead($prevDelayTF)) and isAcceptable(GUICtrlRead($slipTF)) Then
If $loopPreviewLength <> Number(GUICtrlRead($prevDelayTF)) Or $loopSlipLength <> Number(GUICtrlRead($slipTF)) Then
$currentSavedDialog = $currentSavedDialog & "You've made the following changes to the current Looper session:" & @CRLF
If $loopPreviewLength <> Number(GUICtrlRead($prevDelayTF)) Then
$currentSavedDialog = $currentSavedDialog & "- You changed the Preview Time from " & $loopPreviewLength & " to " & Number(GUICtrlRead($prevDelayTF)) & @CRLF
$loopPreviewLength = Number(GUICtrlRead($prevDelayTF))
EndIf
If $loopSlipLength <> Number(GUICtrlRead($slipTF)) Then
$currentSavedDialog = $currentSavedDialog & "- You changed the Slip Time from " & $loopSlipLength & " to " & Number(GUICtrlRead($slipTF)) & @CRLF
$loopSlipLength = Number(GUICtrlRead($slipTF))
EndIf
$currentSavedDialog = $currentSavedDialog & @CRLF
EndIf
EndIf
$currentSavedDialog = $currentSavedDialog & "You've made the following changes to the default settings:" & @CRLF
If GUICtrlRead($currentDelayCheck) = 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", $loopPreviewLength)
If $entrySettings[0] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Current Preview Time" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength")
If $entrySettings[0] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopPreviewLength", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Preview Time" & @CRLF
EndIf
EndIf
If GUICtrlRead($currentSlipCheck) = 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", $loopSlipLength)
If $entrySettings[1] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Current Slip Time" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength")
If $entrySettings[1] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopSlipLength", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Slip Time" & @CRLF
EndIf
EndIf
If GUICtrlRead($savePosCheck) = 1 Then
$currentWndSize = WinGetPos($mainWindow, "")
IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", $currentWndSize[0])
IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionT", $currentWndSize[1])
IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionW", $currentWndSize[2])
IniWrite(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionH", $currentWndSize[3])
If $entrySettings[2] <> IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Current Looper window positions and size" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "StartPos")
If $entrySettings[2] <> IniRead(@ScriptDir & "\MPCLooper.ini", "StartPos", "startPositionL", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Looper window positions and size" & @CRLF
EndIf
EndIf
If GUICtrlRead($saveLoopCheck) = 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", GUICtrlRead($loopButton))
If $entrySettings[3] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Current Loop Mode button setting" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode")
If $entrySettings[3] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "loopButtonMode", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Loop Mode button setting" & @CRLF
EndIf
EndIf
If GUICtrlRead($saveAOTCheck) = 1 Then
If GUICtrlRead($onTopButton) = "Always on Top" Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", 1)
Else
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", 0)
EndIf
If $entrySettings[4] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Current Always on Top button setting" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop")
If $entrySettings[4] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "alwaysOnTop", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Always on Top button setting" & @CRLF
EndIf
EndIf
If GUICtrlRead($saveDockCheck) = 1 Then
If GUICtrlRead($dockLeftButton) = " " Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "Left")
ElseIf GUICtrlRead($dockRightButton) = " " Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "Right")
Else
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "OFF")
EndIf
If $entrySettings[5] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Current Window Docking setting" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode")
If $entrySettings[5] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "dockMode", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Current Window Docking setting" & @CRLF
EndIf
EndIf
If GUICtrlRead($disableToolTips) = 1 Then
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "") <> 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", 1)
EndIf
If $entrySettings[11] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Disable tool tips on the main Looper panel" & @CRLF
EndIf
loadToolTips(0)
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips")
If $entrySettings[11] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "disableToolTips", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable tool tips on the main Looper panel" & @CRLF
EndIf
loadToolTips(1)
EndIf
If GUICtrlRead($autoloadCheck) = 1 Then
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "") = "" Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", 1)
EndIf
If $entrySettings[6] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Auto-load the last open .looper file when launching" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper")
If $entrySettings[6] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoloadLastLooper", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Auto-load the last open .looper file when launching" & @CRLF
EndIf
EndIf
If GUICtrlRead($autoPlayCheck) = 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", 1)
If $entrySettings[7] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Disable auto-playing first event when opening new .looper file" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent")
If $entrySettings[7] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable auto-playing first event when opening new .looper file" & @CRLF
EndIf
EndIf
If GUICtrlRead($allowMICheck) = 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", 1)
If $entrySettings[8] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Allowing/Denying Multiple instances" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances")
If $entrySettings[8] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "allowMultipleInstances", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Allowing/Denying Multiple instances" & @CRLF
EndIf
EndIf
If GUICtrlRead($autoPlayDialogsCheck) = 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", 1)
If $entrySettings[9] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Disable auto-play after exiting Looper dialogs" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs")
If $entrySettings[9] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable auto-play after exiting Looper dialogs" & @CRLF
EndIf
EndIf
If GUICtrlRead($askConfCheck) = 1 Then
IniWrite(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", 1)
If $entrySettings[10] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "") Then
$currentSavedDialog = $currentSavedDialog & "SAVED - Disable re-open confirmation when closing MPC-HC on its own" & @CRLF
EndIf
Else
IniDelete(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm")
If $entrySettings[10] <> IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "MPCConfirm", "") Then
$currentSavedDialog = $currentSavedDialog & "CLEARED - Disable re-open confirmation when closing MPC-HC on its own" & @CRLF
EndIf
EndIf
WinSetOnTop($optionsWindow, "", 0)
If $currentSavedDialog = "You've made the following changes to the default settings:" & @CRLF Then
MsgBox(0, "Heads-up!", "You haven't made any changes to any of the settings...")
Else
MsgBox(0, "Saved settings!", $currentSavedDialog)
EndIf
GUIDelete($optionsWindow)
ExitLoop
Case $looperAssociateButton
$associateFiles = MsgBox(262144 + 36, "Associate file extensions?", "Do you want to associate (or re-associate, if already associated before) .looper files with MPC-HC Looper?" & @CRLF & @CRLF & "(this lets you double click on .looper files to open them with MPC-HC Looper)")
If $associateFiles = "6" Then
_ShellFile_Install('MPC-HC Looper Events File', 'looper', Default, Default, Default, -201)
If @error Then
MsgBox(262144 + 0, "Error!", ".looper files not successfully associated with Windows Explorer")
Else
MsgBox(262144 + 0, "Success!", ".looper files are successfully associated with Windows Explorer")
EndIf
EndIf
EndSwitch
WEnd
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "")
EndIf
loadHotKeys(1)
Opt("GUIOnEventMode", 1)
EndFunc
Func isAcceptable($theNumber)
If StringIsDigit($theNumber) or StringIsFloat($theNumber) Then
return 1
Else
MsgBox(262144 + 16, "Error!", "Please only use numbers in the Current Delay and Slip Time fields.")
return 0
EndIf
EndFunc
Func makeMPCActive()
If WinActive(HWnd($ghnd_MPC_handle)) = 0 Then
WinActivate(HWnd($ghnd_MPC_handle))
EndIf
EndFunc
Func openPathtoFile()
refreshMPCInfo()
If IsArray($nowPlayingInfo) = 1 Then
If $nowPlayingInfo[4] <> "" Then
Run("explorer.exe /n,/e,/select," & $nowPlayingInfo[4])
EndIf
EndIf
EndFunc
Func refreshMPCInfo()
__MPC_send_message($ghnd_MPC_handle, $CMD_GETNOWPLAYING, "")
EndFunc
Func loadHotKeys($loadOrCancel)
For $i = 0 To(UBound($HotkeyList) - 1)
If $loadOrCancel = 1 Then
HotKeySet($HotkeyList[$i], "hotKeyPressed")
$hotKeysActive = True
If GUICtrlRead($HotKeyStatusTF) <> "HOTKEYS ON" Then
GUICtrlSetData($HotKeyStatusTF, "HOTKEYS ON")
GUICtrlSetColor($HotKeyStatusTF, $COLOR_GREEN)
EndIf
Else
HotKeySet($HotkeyList[$i])
$hotKeysActive = False
If GUICtrlRead($HotKeyStatusTF) <> "HOTKEYS OFF" Then
GUICtrlSetData($HotKeyStatusTF, "HOTKEYS OFF")
GUICtrlSetColor($HotKeyStatusTF, $COLOR_RED)
EndIf
EndIf
Next
EndFunc
Func getMode()
If GUICtrlRead($loopButton) = "Loop Mode" Or GUICtrlRead($loopButton) = "OFF" Then
Return True
Else
Return False
EndIf
EndFunc
Func hotKeyPressed()
Switch @HotKeyPressed
Case "i"
If getMode() Then setInPoint()
Case "o"
If getMode() Then setOutPoint()
Case "^i"
If getMode() Then clearInPoint()
Case "^o"
If getMode() Then clearOutPoint()
Case "^x"
If getMode() Then clearInOutPoint()
Case "["
If getMode() Then trimInPointDec()
Case "]"
If getMode() Then trimInPointInc()
Case ";"
If getMode() Then trimOutPointDec()
Case "'"
If getMode() Then trimOutPointInc()
Case "+["
If getMode() Then trimInPointDec(0.050)
Case "+]"
If getMode() Then trimInPointInc(0.050)
Case "+;"
If getMode() Then trimOutPointDec(0.050)
Case "+'"
If getMode() Then trimOutPointInc(0.050)
Case "^n"
If getMode() Then addEvent()
Case "{DEL}"
If GUICtrlGetState($listDeleteButton) = 80 Then deleteEvent()
Case "^l"
loadList()
Case "^s"
saveList()
Case "+l"
clickLoopButton()
Case "^t"
setAlwaysOnTop()
Case "+o"
clickOSDButton()
Case "^q"
Uninitialize()
Case "^,"
loadOptions()
Case "!^{BS}"
openPathtoFile()
Case "{SPACE}"
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAYPAUSE, "")
makeMPCActive()
Case "!{ENTER}"
makeMPCActive()
__MPC_send_message($ghnd_MPC_handle, $CMD_TOGGLEFULLSCREEN, "")
Case "^{PGUP}"
If getItemCount() > 0 Then loadPrevNextEvent(-1)
Case "^{PGDN}"
If getItemCount() > 0 Then loadPrevNextEvent(1)
Case "^{UP}"
setspeed($currentSpeed + 10)
Case "^{DOWN}"
setspeed($currentSpeed - 10)
Case "^r"
setSpeed(100)
Case "^1"
switchToOff()
Case "^2"
switchToLoop()
Case "^3"
switchToPlaylist()
Case "^4"
switchToShuffle()
EndSwitch
EndFunc
Func loadListButtonClicked()
loadList()
EndFunc
Func loadList($fileToOpen = "")
searchEventListRestore()
loadHotKeys(0)
askForSave("Do you want to save before loading a new .looper file?")
If $fileToOpen = "" Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "")
$fileToOpen = FileOpenDialog("Where is the loop events file you want to load?", @DesktopDir, "MPC-HC Looper Events File (*.looper)")
EndIf
If $fileToOpen <> "" Then
clearEvents()
$eventCount = _FileCountLines($fileToOpen)
$readingFile = FileOpen($fileToOpen, FileGetEncoding($fileToOpen))
Local $eventArray[$eventCount]
For $i = 0 to($eventCount - 1)
$currentItem = FileReadLine($readingFile,($i + 1))
$currentItemArray = StringSplit($currentItem, "|", 2)
$newItem =($i + 1) & "|"
$newItem = $newItem & $currentItemArray[0] & "|"
$newItem = $newItem & $currentItemArray[1] & "|"
$newItem = $newItem & $currentItemArray[2] & "|"
$newItem = $newItem & NumberToTimeString(getEventDur($currentItemArray[1], $currentItemArray[2])) & "|"
$newItem = $newItem & $currentItemArray[3]
$eventArray[$i] = $newItem
Next
FileClose($readingFile)
_GUICtrlListView_BeginUpdate($eventList)
For $i = 0 to UBound($eventArray) - 1
GUICtrlCreateListViewItem($eventArray[$i], $eventList)
Next
_GUICtrlListView_EndUpdate($eventList)
$eventListIndex = _GUIListViewEx_Init($eventList, $eventArray, 0, 0, True, 1)
_GUICtrlListView_SetItemSelected($eventList, -1, False, False)
$currentLooperFile = $fileToOpen
setModified(0)
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoplayFirstEvent", "") <> 1 Then
$isClicked = 1
loadEvent(0)
Else
$currentPlayingEvent = -1
EndIf
EndIf
loadHotKeys(1)
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "")
EndIf
EndFunc
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
Func saveList()
$numOfEvents = getItemCount()
If $numOfEvents > 0 Then
If $isModified = 1 Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "")
loadHotKeys(0)
$currentSaveFile = ""
If $currentlySearching <> 0 Then
$savePartial = MsgBox(262144 + 4, "Save file - Save partial list?", "You are currently in search mode - in search mode, you can save a partial list of events (the events listed in the search), or you can choose to save the entire list of events (including those outside of the current search)..." & @CRLF & @CRLF & "To save just the partial list (the events currently shown in the search), choose YES" & @CRLF & "To clear the search results and save the entire events list, choose NO")
If $savePartial = "6" Then
Else
searchEventListRestore()
EndIf
EndIf
If $currentlySearching = 0 Then
If $currentLooperFile <> "" Then
$saveOldFile = MsgBox(262144 + 4, "Overwrite file", "Do you want to overwrite the current .looper file?")
If $saveOldFile = "6" Then
$currentSaveFile = $currentLooperFile
EndIf
EndIf
EndIf
If $currentSaveFile = "" Then
If $currentlySearching = 0 Then
$currentSaveFile = FileSaveDialog("Where do you want to save the loop events file?", @DesktopDir, "MPC-HC Looper Events File (*.looper)", 16, ".looper")
Else
$currentSaveFile = FileSaveDialog("Where do you want to save the partial loop events file?", @DesktopDir, "MPC-HC Looper Events File (*.looper)", 16, ".looper")
EndIf
If $currentSaveFile <> "" Then
If StringLen($currentSaveFile) > 7 Then
$isLooper = StringTrimLeft($currentSaveFile, StringLen($currentSaveFile) - 7)
Else
$isLooper = ""
EndIf
If $isLooper <> ".looper" Then
$currentSaveFile = $currentSaveFile & ".looper"
Else
EndIf
EndIf
EndIf
If $currentSaveFile <> "" Then
$writingFile = FileOpen($currentSaveFile, 34)
For $i = 0 To $numOfEvents - 1
$writingLine = _GUICtrlListView_GetItemText($eventList, $i, 1) & "|"
$writingLine = $writingLine & _GUICtrlListView_GetItemText($eventList, $i, 2) & "|"
$writingLine = $writingLine & _GUICtrlListView_GetItemText($eventList, $i, 3) & "|"
$writingLine = $writingLine & _GUICtrlListView_GetItemText($eventList, $i, 5)
FileWriteLine($writingFile, $writingLine)
Next
FileClose($writingFile)
setModified(0)
$currentLooperFile = $currentSaveFile
EndIf
loadHotKeys(1)
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "")
EndIf
Return $currentSaveFile
EndIf
EndIf
EndFunc
Func setInPoint()
GUICtrlSetBkColor($inButton, 0xb9b9b9)
__MPC_send_message($ghnd_MPC_handle, $CMD_GETCURRENTPOSITION, "")
GUICtrlSetData($inTF, NumberToTimeString($currentPosition + 0.5 - 0.15))
clearOSDInfo()
checkOutPoint()
Sleep(50)
GUICtrlSetBkColor($inButton, 0xFF000000)
EndFunc
Func checkOutPoint()
$currentInPoint = TimeStringToNumber(GUICtrlRead($inTF))
$currentOutPoint = TimeStringToNumber(GUICtrlRead($outTF))
If $currentOutPoint < $currentInPoint Then
clearOutPoint()
EndIf
EndFunc
Func setOutPoint()
GUICtrlSetBkColor($outButton, 0xb9b9b9)
__MPC_send_message($ghnd_MPC_handle, $CMD_GETCURRENTPOSITION, "")
GUICtrlSetData($outTF, NumberToTimeString($currentPosition + 0.5))
clearOSDInfo()
Sleep(50)
GUICtrlSetBkColor($outButton, 0xFF000000)
EndFunc
Func clearInPoint()
GUICtrlSetBkColor($clearInButton, 0xb9b9b9)
GUICtrlSetData($inTF, "0:00")
clearOSDInfo()
Sleep(30)
GUICtrlSetBkColor($clearInButton, 0xFF000000)
EndFunc
Func clearOutPoint()
GUICtrlSetBkColor($clearOutButton, 0xb9b9b9)
refreshMPCInfo()
If IsArray($nowPlayingInfo) Then
GUICtrlSetData($outTF, NumberToTimeString($nowPlayingInfo[5] + 0.5 - 0.057))
EndIf
clearOSDInfo()
Sleep(30)
GUICtrlSetBkColor($clearOutButton, 0xFF000000)
EndFunc
Func clearInOutPoint()
clearInPoint()
clearOutPoint()
EndFunc
Func trimInPointDec($trimAmount = 0)
GUICtrlSetBkColor($inDecButton, 0xb9b9b9)
Local $hDLL = DllOpen("user32.dll")
$isDone = False
$firstRun = True
If $trimAmount = 0 Then
$trimAmount = $loopSlipLength
EndIf
While $isDone = False
$newInPoint = NumberToTimeString(TimeStringToNumber(GUICtrlRead($inTF)) - $trimAmount)
If TimeStringToNumber($newInPoint) > 0 Then
GUICtrlSetData($inTF, $newInPoint)
Else
GUICtrlSetData($inTF, 0)
EndIf
clearOSDInfo()
__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - 0.5)
If $firstRun = True Then
Sleep(250)
$firstRun = False
EndIf
If _IsPressed("01", $hDLL) Then
$isDone = False
Sleep(60)
Else
$isDone = True
EndIf
WEnd
DllClose($hDLL)
GUICtrlSetBkColor($inDecButton, 0xFF000000)
EndFunc
Func trimInPointInc($trimAmount = 0)
GUICtrlSetBkColor($inIncButton, 0xb9b9b9)
Local $hDLL = DllOpen("user32.dll")
$isDone = False
$firstRun = True
If $trimAmount = 0 Then
$trimAmount = $loopSlipLength
EndIf
While $isDone = False
$newInPoint = NumberToTimeString(TimeStringToNumber(GUICtrlRead($inTF)) + $trimAmount)
GUICtrlSetData($inTF, $newInPoint)
clearOSDInfo()
__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - 0.5)
If $firstRun = True Then
Sleep(250)
$firstRun = False
EndIf
If _IsPressed("01", $hDLL) Then
$isDone = False
Sleep(60)
Else
$isDone = True
EndIf
WEnd
DllClose($hDLL)
GUICtrlSetBkColor($inIncButton, 0xFF000000)
EndFunc
Func trimOutPointDec($trimAmount = 0)
GUICtrlSetBkColor($outDecButton, 0xb9b9b9)
Local $hDLL = DllOpen("user32.dll")
$isDone = False
$firstRun = True
If $trimAmount = 0 Then
$trimAmount = $loopSlipLength
EndIf
While $isDone = False
$newOutPoint = NumberToTimeString(TimeStringToNumber(GUICtrlRead($outTF)) - $trimAmount)
If TimeStringToNumber($newOutPoint) > 0 Then
GUICtrlSetData($outTF, $newOutPoint)
Else
GUICtrlSetData($outTF, 0)
EndIf
$trimmingOut = 1
clearOSDInfo()
__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION,(TimeStringToNumber(GUICtrlRead($outTF)) - 0.5 -($loopPreviewLength / 2)))
If $firstRun = True Then
Sleep(250)
$firstRun = False
EndIf
If _IsPressed("01", $hDLL) Then
$isDone = False
Sleep(60)
Else
$isDone = True
EndIf
WEnd
DllClose($hDLL)
GUICtrlSetBkColor($outDecButton, 0xFF000000)
EndFunc
Func trimOutPointInc($trimAmount = 0)
GUICtrlSetBkColor($outIncButton, 0xb9b9b9)
Local $hDLL = DllOpen("user32.dll")
$isDone = False
$firstRun = True
If $trimAmount = 0 Then
$trimAmount = $loopSlipLength
EndIf
While $isDone = False
$newOutPoint = NumberToTimeString(TimeStringToNumber(GUICtrlRead($outTF)) + $trimAmount)
GUICtrlSetData($outTF, $newOutPoint)
$trimmingOut = 1
clearOSDInfo()
__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION,(TimeStringToNumber(GUICtrlRead($outTF)) - 0.5 -($loopPreviewLength / 2)))
If $firstRun = True Then
Sleep(250)
$firstRun = False
EndIf
If _IsPressed("01", $hDLL) Then
$isDone = False
Sleep(60)
Else
$isDone = True
EndIf
WEnd
DllClose($hDLL)
GUICtrlSetBkColor($outIncButton, 0xFF000000)
EndFunc
Func getItemCount()
$itemCount = _GUICtrlListView_GetItemCount($eventList)
Return $itemCount
EndFunc
Func eventNamePrompt($textToInsert = "")
Opt("GUIOnEventMode",0)
$eventDialogWindow = GUICreate("Loop event name", 338, 91, -1, -1)
If $textToInsert = "" Then
$eventHappenedLabel = GUICtrlCreateLabel("What do you want to name this event?", 8, 4, 323, 21, $SS_CENTER)
If $currentSpeed <> 100 Then
$eventNameTF = GUICtrlCreateEdit("<S:" & $currentSpeed & ">", 8, 26, 321, 22, $ES_AUTOVSCROLL)
Else
$eventNameTF = GUICtrlCreateEdit("", 8, 26, 321, 22, $ES_AUTOVSCROLL)
EndIf
Else
$eventHappenedLabel = GUICtrlCreateLabel("What do you want to re-name this event?", 8, 4, 323, 21, $SS_CENTER)
$speedSetting = checkNameSpeedSetting($textToInsert)
If $speedSetting <> 0 Then
$theOffset = StringInStr($textToInsert, ">")
$textToInsert = StringTrimLeft($textToInsert, $theOffset)
EndIf
If $currentSpeed <> 100 Then
$eventNameTF = GUICtrlCreateEdit("<S:" & $currentSpeed & ">" & $textToInsert, 8, 26, 321, 22, $ES_AUTOVSCROLL)
Else
$eventNameTF = GUICtrlCreateEdit($textToInsert, 8, 26, 321, 22, $ES_AUTOVSCROLL)
EndIf
EndIf
GUICtrlSetFont($eventHappenedLabel, 10, 400, 0, "Segoe UI")
GUICtrlSetFont($eventNameTF, 10, 400, 0, "Segoe UI")
$eventDialogOKButton = GUICtrlCreateButton("OK", 8, 56, 158, 25)
GUICtrlSetFont(-1, 10, 800, 0, "Segoe UI")
$eventDialogCancelButton = GUICtrlCreateButton("Cancel", 172, 56, 158, 25)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
Dim $eventDialogWindow_AccelTable[2][2] = [["{ENTER}", $eventDialogOKButton],["{ESC}", $eventDialogCancelButton]]
GUISetAccelerators($eventDialogWindow_AccelTable)
GUISetState(@SW_SHOW)
_WinAPI_SetFocus(ControlGetHandle($eventDialogWindow, "", $eventNameTF))
WinSetOnTop($eventDialogWindow, "", 1)
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE, $eventDialogCancelButton
$textReturned = ""
GUIDelete($eventDialogWindow)
ExitLoop
Case $eventDialogOKButton
If GUICtrlRead($eventNameTF) = "" Then
$textReturned = "New Loop Event"
ElseIf GUICtrlRead($eventNameTF) = "<S:" & $currentSpeed & ">" Then
$textReturned = "<S:" & $currentSpeed & ">" & "New Loop Event"
Else
$textReturned = GUICtrlRead($eventNameTF)
EndIf
GUIDelete($eventDialogWindow)
ExitLoop
EndSwitch
WEnd
Opt("GUIOnEventMode",1)
Return $textReturned
EndFunc
Func initializeEventChange($onOrOff)
If $onOrOff = $GUI_DISABLE Then
loadHotKeys(0)
__MPC_send_message($ghnd_MPC_handle, $CMD_PAUSE, "")
Else
If IniRead(@ScriptDir & "\MPCLooper.ini", "Prefs", "autoPlayDialogs", "") <> 1 Then
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "")
EndIf
makeMPCActive()
Sleep(200)
loadHotKeys(1)
EndIf
If getItemCount() > 0 Then
GUICtrlSetState($listSaveButton, $onOrOff)
GUICtrlSetState($listClearButton, $onOrOff)
EndIf
If $onOrOff = 64 Then
switchModifyDelete()
Else
GUICtrlSetState($listModifyButton, $onOrOff)
GUICtrlSetState($listDeleteButton, $onOrOff)
EndIf
GUICtrlSetState($listLoadButton, $onOrOff)
GUICtrlSetState($listAddButton, $onOrOff)
EndFunc
Func addEvent()
searchEventListRestore()
initializeEventChange($GUI_DISABLE)
$currentName = eventNamePrompt()
If $currentName <> "" Then
$inPoint = GUICtrlRead($inTF)
$outPoint = GUICtrlRead($outTF)
If GUICtrlRead($loopButton) = "OFF" Or GUICtrlRead($loopButton) = "Loop Mode" Then
HotKeySet("^x", hotKeyPressed)
EndIf
refreshMPCInfo()
If IsArray($nowPlayingInfo) = 1 Then
$currentFile = $nowPlayingInfo[4]
Else
$currentFile = ""
EndIf
$newItem =(getItemCount() + 1) & "|" & $currentName & "|" & $inPoint & "|" & $outPoint & "|" & NumberToTimeString(getEventDur($inPoint, $outPoint)) & "|" & $currentFile
If $eventListIndex = 0 Then
$eventListIndex = _GUIListViewEx_Init($eventList, "", 0, 0, True, 1)
EndIf
_GUICtrlListView_SetItemSelected($eventList, -1, false, false)
_GUIListViewEx_Insert($newItem)
GUICtrlSetData($currentEventStatusTF, "Please wait, adding event to list...")
$currentPlayingEvent = getItemCount() - 1
EndIf
initializeEventChange($GUI_ENABLE)
EndFunc
Func modifyEvent()
If $currentlySearching = 2 Then
$currentItem = $searchResultsList[$currentPlayingEvent]
$currentPlayingEvent = Int(StringLeft($currentItem, StringInStr($currentItem, "|"))) - 1
EndIf
searchEventListRestore()
initializeEventChange($GUI_DISABLE)
$currentEvent = _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 0)
$currentName = _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 1)
$currentName = eventNamePrompt($currentName)
If $currentName <> "" Then
$inPoint = GUICtrlRead($inTF)
$outPoint = GUICtrlRead($outTF)
refreshMPCInfo()
$currentFile = $nowPlayingInfo[4]
_GUICtrlListView_SetItemSelected($eventList, -1, false, false)
_GUICtrlListView_SetItemSelected($eventList, $currentPlayingEvent, True, True)
_GUIListViewEx_Delete()
_GUIListViewEx_Insert($currentEvent & "|" & $currentName & "|" & $inPoint & "|" & $outPoint & "|" & NumberToTimeString(getEventDur($inPoint, $outPoint)) & "|" & $currentFile)
If $currentPlayingEvent = 0 Then
_GUIListViewEx_Up()
EndIf
GUICtrlSetData($currentEventStatusTF, "Please wait, saving event data...")
EndIf
initializeEventChange($GUI_ENABLE)
EndFunc
Func deleteEvent()
If getItemCount() > 0 Then
initializeEventChange($GUI_DISABLE)
GUICtrlSetState($eventList, $GUI_DISABLE)
$deleteFiles = 0
$selectedItems = _GUICtrlListView_GetSelectedIndices($eventList, True)
If $selectedItems[0] = getItemCount() Then
If $currentlySearching = 0 Then
$deleteFiles = MsgBox(262144 + 36, "Delete", "You chose to delete all of the events (" & $selectedItems[0] & " of " & getItemCount() & ") in the event list" & @CRLF & @CRLF & 'Deleting all the events will unload the current .looper file and clear the event list, creating a new session (the same as hitting the "Clear List" button) - are you sure you want to do that?')
If $deleteFiles = "6" Then
clearEvents()
EndIf
Else
$deleteFiles = MsgBox(262144 + 36, "Delete - Search Mode", "Deleting an event in Search Mode also deletes it in the main playlist -" & @CRLF & @CRLF & "Do you want to delete all of the search mode events from the main playlist?" & @CRLF & @CRLF & "HINT - if you just want to exit Search Mode and not delete the events, just click on the " & '"Clear"' & "button to the right of the Search area.")
If $deleteFiles = 6 Then
$deleteFiles = 1
EndIf
EndIf
Else
If $selectedItems[0] = 1 Then
If $currentlySearching = 0 Then
$deleteFiles = MsgBox(262144 + 36, "Delete", "Are you sure you want to delete" & @CRLF & @CRLF & '"' & _GUICtrlListView_GetItemText($eventList, Number($selectedItems[1]), 1) & '"' & @CRLF & @CRLF & "From the main events playlist?")
If $deleteFiles = 6 Then
$deleteFiles = 1
EndIf
Else
$deleteFiles = MsgBox(262144 + 36, "Delete - Search Mode", "Deleting an event in Search Mode also deletes it in the main playlist - " & @CRLF & @CRLF & "Do you want to delete " & @CRLF & '"' & _GUICtrlListView_GetItemText($eventList, Number($selectedItems[1]), 1) & '"' & @CRLF & "From the main events playlist also?")
If $deleteFiles = 6 Then
$deleteFiles = 1
EndIf
EndIf
Else
If $currentlySearching = 0 Then
$deleteFiles = MsgBox(262144 + 36, "Delete", "Are you sure you want to delete these " & $selectedItems[0] & " events from the main events playlist?")
If $deleteFiles = 6 Then
$deleteFiles = 1
EndIf
Else
$deleteFiles = MsgBox(262144 + 36, "Delete - Search Mode", "Deleting an event in Search Mode also deletes it in the main playlist - " & @CRLF & @CRLF & "Do you want to delete these " & $selectedItems[0] & " events?")
If $deleteFiles = 6 Then
$deleteFiles = 1
EndIf
EndIf
EndIf
EndIf
If $deleteFiles = 1 Then
_ArrayDelete($selectedItems, 0)
Local $deleteArray[UBound($selectedItems)]
If $currentlySearching = 0 Then
$completeEventList = _GUIListViewEx_ReturnArray($eventListIndex)
EndIf
For $i = 0 to UBound($selectedItems) - 1
If $currentlySearching = 0 Then
$currentItem = $completeEventList[$selectedItems[$i]]
Else
$currentItem = $searchResultsList[$selectedItems[$i]]
EndIf
$deleteArray[$i] = Int(StringLeft($currentItem, StringInStr($currentItem, "|") - 1))
Next
_ArraySort($deleteArray, 1)
If $currentlySearching <> 0 Then
$searchResultsList = reorderArray($searchResultsList, $deleteArray)
EndIf
$completeEventList = reorderArray($completeEventList, $deleteArray)
If $currentlySearching <> 0 Then
If UBound($searchResultsList) > 0 Then
reloadList($searchResultsList)
Else
searchEventListRestore()
EndIf
Else
reloadList($completeEventList)
EndIf
setModified()
If $currentPlayingEvent = getItemCount() Then
loadEvent($currentPlayingEvent - 1)
Else
loadEvent($currentPlayingEvent)
EndIf
_GUICtrlListView_SetItemSelected($eventList, $currentPlayingEvent, true, true)
EndIf
EndIf
initializeEventChange($GUI_ENABLE)
GUICtrlSetState($eventList, $GUI_ENABLE)
EndFunc
Func reorderArray($arrayToSort, $deleteArray)
Local $arrayToWorkWith[UBound($arrayToSort)][3]
For $i = 0 to UBound($arrayToSort) - 1
$currentItem = $arrayToSort[$i]
$currentItemDelim = StringInStr($currentItem, "|") - 1
$arrayToWorkWith[$i][0] = $currentItem
$arrayToWorkWith[$i][1] = $i
$arrayToWorkWith[$i][2] = Int(StringLeft($currentItem, $currentItemDelim))
Next
_ArraySort($arrayToWorkWith, 1, -1, -1, 2)
$deleteOffset = 0
For $a = 0 to UBound($arrayToWorkWith) - 1
If $arrayToWorkWith[$a][2] > $deleteArray[$deleteOffset] Then
$arrayToWorkWith[$a][2] = $arrayToWorkWith[$a][2] -(UBound($deleteArray) - $deleteOffset)
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
For $b = 0 to UBound($arrayToWorkWith) - 1
If $arrayToWorkWith[$b][2] <> "XX" Then
Redim $arrayToSort[UBound($arrayToSort) + 1]
$currentItem = $arrayToWorkWith[$b][0]
$currentItemDelim = StringInStr($currentItem, "|") - 1
$arrayToSort[UBound($arrayToSort) - 1] = $arrayToWorkWith[$b][2] & StringTrimLeft($currentItem, $currentItemDelim)
EndIf
Next
Return $arrayToSort
EndFunc
Func reloadList($listToLoad)
_GUIListViewEx_Close($eventListIndex)
$eventListIndex = 0
_GUICtrlListView_DeleteAllItems($eventList)
_GUICtrlListView_BeginUpdate($eventList)
For $i = 0 to UBound($listToLoad) - 1
GUICtrlCreateListViewItem($listToLoad[$i], $eventList)
Next
_GUICtrlListView_EndUpdate($eventList)
$eventListIndex = _GUIListViewEx_Init($eventList, $listToLoad, 0, 0, True, 1)
EndFunc
Func clearEvents()
_GUIListViewEx_Close($eventListIndex)
$eventListIndex = 0
_GUICtrlListView_DeleteAllItems($eventList)
GUICtrlSetData($loopButton, "Loop Mode")
GUICtrlSetBkColor($loopButton, 0xb0f6b0)
switchEditingControls($GUI_ENABLE)
GUICtrlSetState($listDeleteButton, $GUI_DISABLE)
GUICtrlSetState($listModifyButton, $GUI_DISABLE)
If $currentlySearching <> 1 Then
$currentLooperFile = ""
setModified(0)
EndIf
clearOSDInfo()
EndFunc
Func loadPrevEventButton()
loadPrevNextEvent(-1)
EndFunc
Func loadNextEventButton()
loadPrevNextEvent(1)
EndFunc
Func loadPrevNextEvent($nextOrPrev)
$numOfEvents = getItemCount()
$currentPlayingEvent = $currentPlayingEvent + $nextOrPrev
If $currentPlayingEvent = -1 Then
$currentPlayingEvent = $numOfEvents - 1
ElseIf $currentPlayingEvent = $numOfEvents Then
$currentPlayingEvent = 0
EndIf
loadEvent($currentPlayingEvent)
EndFunc
Func loadEvent($selectedItem)
$currentFile = _GUICtrlListView_GetItemText($eventList, $selectedItem, 5)
$fileToLoad = findFileExists($currentFile, $currentLooperFile)
If $fileToLoad <> -1 Then
GUICtrlSetData($inTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 2))
GUICtrlSetData($outTF, _GUICtrlListView_GetItemText($eventList, $selectedItem, 3))
_GUICtrlListView_SetItemSelected($eventList, -1, false, false)
_GUICtrlListView_SetItemSelected($eventList, $selectedItem, True, True)
$currentName = _GUICtrlListView_GetItemText($eventList, $selectedItem, 1)
If $fileToLoad <> $currentLoadedFile Then
__MPC_send_message($ghnd_MPC_handle, $CMD_OPENFILE, $fileToLoad)
While $isLoaded <> 2
WEnd
__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - 0.5)
__MPC_send_message($ghnd_MPC_handle, $CMD_STOP, "")
Sleep(200)
$currentSpeed = 100
$currentLoadedFile = $fileToLoad
EndIf
__MPC_send_message($ghnd_MPC_handle, $CMD_SETPOSITION, TimeStringToNumber(GUICtrlRead($inTF)) - 0.5)
$speedSetting = checkNameSpeedSetting($currentName)
If $speedSetting <> 0 Then
If $currentSpeed <> $speedSetting Then
setSpeed($speedSetting)
EndIf
Else
If $currentSpeed <> 100 Then
setSpeed(100)
EndIf
EndIf
MakeMPCActive()
__MPC_send_message($ghnd_MPC_handle, $CMD_PLAY, "")
$currentPlayingEvent = $selectedItem
_GUICtrlListView_EnsureVisible($eventList, $currentPlayingEvent, True)
updateEventOSDInfo($currentPlayingEvent + 1)
Else
MsgBox(262144 + 48, "Can't find media file for the event you loaded", "This event's media file can not be found:" & @CRLF & $currentFile & @CRLF & @CRLF & "Media files either need to be in the same directory as the .looper file:" & @CRLF & "          > [example: (path to current .looper file)\MediaFile.mp4] <" & @CRLF & "or in the original directory they were in:" & @CRLF & "         > [example: E:\Media\MediaFile.mp4] <" & @CRLF & "for MPC-HC Looper to be able find them to load them for playback.")
EndIf
EndFunc
Func findFileExists($theFile, $currentLooperFile)
$returnedFile = ""
If $currentLooperFile <> "" Then
$currentLooperFileDir = StringLeft($currentLooperFile, StringInStr($currentLooperFile, "\" , Default, -1))
$theFileName = StringRight($theFile, StringLen($theFile) - StringInStr($theFile, "\" , Default, -1))
If FileExists($currentLooperFileDir & $theFileName) = 1 Then
$returnedFile =($currentLooperFileDir & $theFileName)
EndIf
EndIf
If $returnedFile = "" Then
If FileExists($theFile) = 1 Then
$returnedFile =($theFile)
Else
$returnedFile = -1
EndIf
EndIf
Return $returnedFile
EndFunc
Func NumberToTimeString($number)
$timeString = StringSplit($number, ":")
If $timeString[0] = 1 Then
$timeString = ""
$hours = Int($number / 3600)
$minutes = Int(($number -($hours * 3600)) / 60)
$seconds = Round($number -($hours * 3600) -($minutes * 60), 3)
If $seconds = 60 Then
$seconds = 0
$minutes = $minutes + 1
EndIf
If $hours > 0 Then
$timeString = $hours & ":"
If $minutes < 10 Then $timeString = $timeString & "0"
EndIf
If $minutes >= 0 Then
$timeString = $timeString & $minutes & ":"
If $seconds < 10 Then $timeString = $timeString & "0"
EndIf
$timeString = $timeString & StringFormat("%.3f", $seconds)
Else
$timeString = $number
EndIf
Return $timeString
EndFunc
Func TimeStringToNumber($timeString)
$timeString = StringSplit($timeString, ":")
If $timeString[0] = 1 Then
Return Number($timeString[1])
ElseIf $timeString[0] = 2 Then
Return Number(($timeString[1] * 60) + $timeString[2])
ElseIf $timeString[0] = 3 Then
Return Number(($timeString[1] * 3600) +($timeString[2] * 60) + $timeString[3])
EndIf
EndFunc
