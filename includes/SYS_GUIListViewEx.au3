#include-once

; #INDEX# ============================================================================================================
; Title .........: GUIListViewEx
; AutoIt Version : 3.3 +
; Language ......: English
; Description ...: Permits insertion, deletion, moving, dragging, sorting and editing of items within activated ListViews
; Remarks .......: - It is important to use _GUIListViewEx_Close when a enabled ListView is deleted to free the memory used
;                    by the $aGLVEx_Data array which shadows the ListView contents.
;                  - Windows message handlers required:
;                     - WM_NOTIFY: All UDF functions
;                     - WM_MOUSEMOVE and WM_LBUTTONUP: Dragging
;                  - If the script already has WM_NOTIFY, WM_MOUSEMOVE or WM_LBUTTONUPhandlers then only set unregistered
;                    messages in _GUIListViewEx_MsgRegister and call the relevant _GUIListViewEx_WM_#####_Handler
;                    from within the existing handler
;                  - Uses 2 undocumented functions within GUIListView UDF to set and colour insert mark (thanks rover)
;                  - If ListView editable, Opt("GUICloseOnESC") set to 0 as ESC = edit cancel.  Do not reset Opt in script
; Author ........: Melba23
; Credits .......: martin (basic drag code), Array.au3 authors (array functions), KaFu and ProgAndy (font function)
; ====================================================================================================================

;#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7

; #INCLUDES# =========================================================================================================
#include <GuiListView.au3>
#include <GUIImageList.au3>

; #GLOBAL VARIABLES# =================================================================================================
; Array to hold registered ListView data
Global $aGLVEx_Data[1][13] = [[0, 0, -1]]
; [0][0] = Count			[n][0]  = ListView handle
; [0][1] = Active Index		[n][1]  = Native ListView ControlID / 0
; [0][2] = Active Column	[n][2]  = Shadow array
; [0][3] = Item Depth		[n][3]  = Shadow array count element (0/1) & 2D return (+ 2)
;                          [n][4]  = Sort status
;                          [n][5]  = Drag image flag
; 							[n][6]  = Checkbox array flag
;                          [n][7]  = Editable columns range
;                          [n][8]  = Editable header flag
;                          [n][9]  = Edit cursor active flag
;                          [n][10] = Item depth for scrolling
;                          [n][11] = Edit combo flag/data
;                          [n][12] = External dragdrop flag
; Variables for all UDF functions
Global $hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVEx_SrcIndex, $aGLVEx_SrcArray
; Variables for UDF dragging handlers
Global $hGLVEx_TgtHandle, $cGLVEx_TgtID, $iGLVEx_TgtIndex, $aGLVEx_TgtArray
Global $iGLVEx_Dragging = 0, $iGLVEx_DraggedIndex, $hGLVEx_DraggedImage = 0
Global $iGLVEx_InsertIndex = -1, $iGLVEx_LastY, $fGLVEx_BarUnder
; Variables for UDF edit
Global $hGLVEx_Editing, $cGLVEx_EditID = 9999, $fGLVEx_EditClickFlag = False, $fGLVEx_HeaderEdit = False
; Variable for separator character to use
Global $sGLVEx_SepChar = Opt("GUIDataSeparatorChar")

; #CURRENT# ==========================================================================================================
; _GUIListViewEx_Init:                 Enables UDF functions for the ListView and sets various flags
; _GUIListViewEx_Close:                Disables all UDF functions for the specified ListView and clears all memory used
; _GUIListViewEx_SetActive:            Set specified ListView as active for UDF functions
; _GUIListViewEx_GetActive:            Get index number of ListView active for UDF functions
; _GUIListViewEx_ReadToArray:          Creates an array from the current ListView content to be loaded in _Init function
; _GUIListViewEx_ReturnArray:          Returns an array reflecting the current content of the ListView
; _GUIListViewEx_Insert:               Inserts data just below selected item in active ListView
; _GUIListViewEx_Delete:               Deletes selected item(s) in active ListView
; _GUIListViewEx_Up:                   Moves selected item(s) in active ListView up 1 row
; _GUIListViewEx_Down:                 Moves selected item(s) in active ListView down 1 row
; _GUIListViewEx_EditOnClick:          Edit ListView items in user-defined columns when doubleclicked
; _GUIListViewEx_EditItem:             Edit ListView items programatically
; _GUIListViewEx_EditHeader:           Edit ListView headers programatically
; _GUIListViewEx_ComboData:            Set data for edit combo
; _GUIListViewEx_MsgRegister:          Registers Windows messages required for the UDF
; _GUIListViewEx_WM_NOTIFY_Handler:    Windows message handler for WM_NOTIFY - needed for dall UDF functions
; _GUIListViewEx_WM_MOUSEMOVE_Handler: Windows message handler for WM_MOUSEMOVE - needed for drag
; _GUIListViewEx_WM_LBUTTONUP_Handler: Windows message handler for WM_LBUTTONUP - needed for drag
; ====================================================================================================================

; #INTERNAL_USE_ONLY#=================================================================================================
; _GUIListViewEx_ExpandCols:   Expands column ranges to list each column separately
; _GUIListViewEx_HighLight:    Highlights specified ListView item and ensures it is visible
; _GUIListViewEx_EditProcess:  Runs ListView editing process
; _GUIListViewEx_GetLVFont:    Gets font details for ListView to be edited
; _GUIListViewEx_EditCoords:   Ensures item in view then locates and sizes edit control
; _GUIListViewEx_ReWriteLV:    Deletes all ListView content and refills to match array
; _GUIListViewEx_GetLVCoords:  Gets screen coords for ListView
; _GUIListViewEx_GetCursorWnd: Gets handle of control under the mouse cursor
; _GUIListViewEx_Array_Add:    Adds a specified value at the end of an array
; _GUIListViewEx_Array_Insert: Adds a value at the specified index of an array
; _GUIListViewEx_Array_Delete: Deletes a specified index from an array
; _GUIListViewEx_Array_Swap:   Swaps specified elements within an array
; ====================================================================================================================

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Init
; Description ...: Enables UDF functions for the ListView and sets various flags
; Syntax.........: _GUIListViewEx_Init($hLV, [$aArray = ""[, $iStart = 0[, $iColour[, $fImage[, $iAdded[, $sCols]]]]]])
; Parameters ....: $hLV     - Handle or ControlID of ListView
;                  $aArray  - Name of array used to fill ListView.  "" for empty ListView
;                  $iStart  - 0 = ListView data starts in [0] element of array (default)
;                             1 = Count in [0] element
;                  $iColour - RGB colour for insert mark (default = black)
;                  $fImage  - True  = Shadow image of dragged item when dragging
;                             False = No shadow image (default)
;                  $iAdded  - 0     - No added features (default).  To get added features add the following
;                             + 1   - Sortable by clicking on column headers
;                             + 2   - Edit control available when double clicking on a subitem in user-defined columns
;                             + 4   - Edit continues within same ListView by triple mouse-click (only if ListView editable)
;                             + 8   - Headers editable by Ctrl-click (only if ListView editable)
;                             + 16  - Left/right cursor active in edit - use Ctrl-arrow to move to next item (if set)
;                             + 32  - Combo control used for editing
;                             + 64  - No external drag
;                             + 128 - No external drop
;                             + 256 - No delete on external drag/drop
;                  $sCols   - Editable columns - only used if Editable flag set in $iAdded
;                                 All columns: "*" (default)
;                                 Limit columns: example "1;2;5-6;8-9;10" - ranges expanded automatically
; Requirement(s).: v3.3 +
; Return values .: Index number of ListView for use in other GUIListViewEx functions
; Author ........: Melba23
; Modified ......:
; Remarks .......: - If the ListView is the only one enabled, it is automatically set as active
;                  - If no array is passed a shadow array is created automatically
;                  - The $iStart parameter determines if a count element will be returned by other GUIListViewEx functions
;                  - The _GUIListViewEx_ReadToArray function will read an existing ListView into an array
;                  - Only first item of a multiple selection is shadow imaged when dragging (API limitation)
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Init($hLV, $aArray = "", $iStart = 0, $iColour = 0, $fImage = False, $iAdded = 0, $sCols = "*")

	Local $iIndex = 0

	; See if there is a blank line available in the array
	For $i = 1 To $aGLVEx_Data[0][0]
		If $aGLVEx_Data[$i][0] = 0 Then
			$iIndex = $i
			ExitLoop
		EndIf
	Next
	; If no blank line found then increase array size
	If $iIndex = 0 Then
		$aGLVEx_Data[0][0] += 1
		ReDim $aGLVEx_Data[$aGLVEx_Data[0][0] + 1][UBound($aGLVEx_Data, 2)]
		$iIndex = $aGLVEx_Data[0][0]
	EndIf

	; Store ListView handle and ControlID (if it exists)
	If IsHWnd($hLV) Then
		$aGLVEx_Data[$iIndex][0] = $hLV
		$aGLVEx_Data[$iIndex][1] = 0
	Else
		$aGLVEx_Data[$iIndex][0] = GUICtrlGetHandle($hLV)
		$aGLVEx_Data[$iIndex][1] = $hLV
	EndIf

	; Store ListView content in shadow array
	$aGLVEx_Data[$iIndex][2] = _GUIListViewEx_ReadToArray($hLV, 1)

	; Store array count flag
	$aGLVEx_Data[$iIndex][3] = $iStart
	; Store 1D/2D array return type flag
	If IsArray($aArray) Then
		If UBound($aArray, 0) = 2 Then $aGLVEx_Data[$iIndex][3] += 2
	EndIf

	; Set insert mark colour after conversion to BGR
	_GUICtrlListView_SetInsertMarkColor($hLV, BitOR(BitShift(BitAND($iColour, 0x000000FF), -16), BitAND($iColour, 0x0000FF00), BitShift(BitAND($iColour, 0x00FF0000), 16)))
	; If drag image required
	If $fImage Then
		$aGLVEx_Data[$iIndex][5] = 1
	EndIf

	; If sortable, store sort array
	If BitAND($iAdded, 1) Then
		Local $aLVSortState[_GUICtrlListView_GetColumnCount($hLV)]
		$aGLVEx_Data[$iIndex][4] = $aLVSortState
	Else
		$aGLVEx_Data[$iIndex][4] = 0
	EndIf
	; If editable
	If BitAND($iAdded, 2) Then
		$aGLVEx_Data[$iIndex][7] = _GUIListViewEx_ExpandCols($sCols)
		; Limit ESC to edit cancel
		Opt("GUICloseOnESC", 0)
		; If move edit by click add flag to valid col list
		If BitAND($iAdded, 4) Then
			$aGLVEx_Data[$iIndex][7] &= ";#"
		EndIf
		; If header editable on Ctrl-click set flag
		If BitAND($iAdded, 8) Then
			$aGLVEx_Data[$iIndex][8] = 1
		EndIf
	Else
		$aGLVEx_Data[$iIndex][7] = ""
	EndIf
	; If Edit cursor
	If BitAND($iAdded, 16) Then
		$aGLVEx_Data[$iIndex][9] = 1
	EndIf

	; If Combo
	If BitAND($iAdded, 32) Then
		Local $aComboData_Array[_GUICtrlListView_GetColumnCount($hLV)]
		$aGLVEx_Data[$iIndex][11] = $aComboData_Array
	EndIf

	; If no external drag
	If BitAnd($iAdded, 64) Then
		$aGLVEx_Data[$iIndex][12] = 1
	EndIf

	; If no external drop
	If BitAnd($iAdded, 128) Then
		$aGLVEx_Data[$iIndex][12] += 2
	EndIf

	; If no delete on external drag/drop
	If BitAnd($iAdded, 256) Then
		$aGLVEx_Data[$iIndex][12] += 4
	EndIf

	;  If checkbox extended style
	If BitAND(_GUICtrlListView_GetExtendedListViewStyle($hLV), 4) Then ; $LVS_EX_CHECKBOXES
		$aGLVEx_Data[$iIndex][6] = 1
	EndIf

	; Measure item depth for scroll - if empty reset when filled later
	Local $aRect = _GUICtrlListView_GetItemRect($aGLVEx_Data[$iIndex][0], 0)
	$aGLVEx_Data[$iIndex][10] =  $aRect[3] - $aRect[1]

	; If only 1 current ListView then activate
	Local $iListView_Count = 0
	For $i = 1 To $iIndex
		If $aGLVEx_Data[$i][0] Then $iListView_Count += 1
	Next
	If $iListView_Count = 1 Then _GUIListViewEx_SetActive($iIndex)

	; Return ListView index
	Return $iIndex

EndFunc   ;==>_GUIListViewEx_Init

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Close
; Description ...: Disables all UDF functions for the specified ListView and clears all memory used
; Syntax.........: _GUIListViewEx_Close($iIndex)
; Parameters ....: $iIndex - Index number of ListView to close as returned by _GUIListViewEx_Init
;                            0 (default) = Closes all ListViews
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: 0 and @error set to 1 - Invalid index number
; Author ........: Melba23
; Modified ......:
; Remarks .......:
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Close($iIndex = 0)

	; Check valid index
	If $iIndex < 0 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, 0)

	If $iIndex = 0 Then
		; Remove all ListView data
		Global $aGLVEx_Data[1][UBound($aGLVEx_Data, 2)] = [[0, 0]]
	Else
		; Reset all data for ListView
		For $i = 0 To UBound($aGLVEx_Data, 2) - 1
			$aGLVEx_Data[$iIndex][$i] = 0
		Next

		; Cancel active index if set to this ListView
		If $aGLVEx_Data[0][1] = $iIndex Then $aGLVEx_Data[0][1] = 0
	EndIf

	Return 1

EndFunc   ;==>_GUIListViewEx_Close

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_SetActive
; Description ...: Set specified ListView as active for UDF functions
; Syntax.........: _GUIListViewEx_SetActive($iIndex)
; Parameters ....: $iIndex - Index number of ListView as returned by _GUIListViewEx_Init
;                  An index of 0 clears any current setting
; Requirement(s).: v3.3 +
; Return values .: Success: Returns previous active index number, 0 = no previously active ListView
;                  Failure: -1 and @error set to 1 - Invalid index number
; Author ........: Melba23
; Modified ......:
; Remarks .......: ListViews can also be activated by clicking on them
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_SetActive($iIndex)

	; Check valid index
	If $iIndex < 0 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, -1)

	Local $iCurr_Index = $aGLVEx_Data[0][1]

	If $iIndex Then
		; Store index of specified ListView
		$aGLVEx_Data[0][1] = $iIndex
		; Set values for specified ListView
		$hGLVEx_SrcHandle = $aGLVEx_Data[$iIndex][0]
		$cGLVEx_SrcID = $aGLVEx_Data[$iIndex][1]
	Else
		; Clear active index
		$aGLVEx_Data[0][1] = 0
		$hGLVEx_SrcHandle = 0
		$cGLVEx_SrcID = 0
	EndIf

	Return $iCurr_Index

EndFunc   ;==>_GUIListViewEx_SetActive

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_GetActive
; Description ...: Get index number of ListView active for UDF functions
; Syntax.........: _GUIListViewEx_GetActive()
; Parameters ....: None
; Requirement(s).: v3.3 +
; Return values .: Success: Index number as returned by _GUIListViewEx_Init, 0 = no active ListView
; Author ........: Melba23
; Modified ......:
; Remarks .......:
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_GetActive()

	Return $aGLVEx_Data[0][1]

EndFunc   ;==>_GUIListViewEx_GetActive

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_ReadToArray
; Description ...: Creates an array from the current ListView content to be loaded in _Init function
; Syntax.........: _GUIListViewEx_ReadToArray($hLV[, $iCount = 0])
; Parameters ....: $hLV    - ControlID or handle of ListView
;                  $iCount - 0 (default) = ListView data starts in [0] element of array, 1 = Count in [0] element
; Requirement(s).: v3.3 +
; Return values .: Success: 2D array of current ListView content
;                           Empty string if ListView empty and no count element
;                  Failure: Returns null string and sets @error as follows:
;                           1 = Invalid ListView ControlID or handle
; Author ........: Melba23
; Modified ......:
; Remarks .......: If returned array is used in _GUIListViewEx_Init the $iStart parameters must match in the 2 functions
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_ReadToArray($hLV, $iStart = 0)

	Local $aLVArray = "", $aRow

	; Use the ListView handle
	If Not IsHWnd($hLV) Then
		$hLV = GUICtrlGetHandle($hLV)
		If Not IsHWnd($hLV) Then
			Return SetError(1, 0, "")
		EndIf
	EndIf
	; Get ListView row count
	Local $iRows = _GUICtrlListView_GetItemCount($hLV)
	; Check for empty ListView with no count
	If $iRows + $iStart <> 0 Then
		; Get ListView column count
		Local $iCols = _GUICtrlListView_GetColumnCount($hLV)
		; Create 2D array to hold ListView content and add count - count overwritten if not needed
		Local $aLVArray[$iRows + $iStart][$iCols] = [[$iRows]]
		; Read ListView content into array
		For $i = 0 To $iRows - 1
			; Read the row content
			$aRow = _GUICtrlListView_GetItemTextArray($hLV, $i)
			For $j = 1 To $aRow[0]
				; Add to the ListView content array
				$aLVArray[$i + $iStart][$j - 1] = $aRow[$j]
			Next
		Next
	EndIf
	; Return array or empty string
	Return $aLVArray

EndFunc   ;==>_GUIListViewEx_ReadToArray

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_ReturnArray
; Description ...: Returns an array reflecting the current content of an activated ListView
; Syntax.........: _GUIListViewEx_ReturnArray($iIndex[, $iCheck])
; Parameters ....: $iIndex - Index number of ListView as returned by _GUIListViewEx_Init
;                  $iCheck - If non-zero then the state of the checkboxes is returned (Default = 0)
; Requirement(s).: v3.3 +
; Return values .: Success: Array of current ListView content - _GUIListViewEx_Init parameters determine:
;                               Whether count in top element - $iStart = 0/1
;                               1D/2D array type - same as $aArray
;                                   If no array passed then single col => 1D; multiple column => 2D
;                  Failure: Empty array returns null string and sets @error as follows:
;                               1 = Invalid index number
;                               2 = Empty array (no items in ListView)
;                               3 = $iCheck set to True but ListView does not have checkbox style
; Author ........: Melba23
; Modified ......:
; Remarks .......:
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_ReturnArray($iIndex, $iCheck = 0)

	; Check valid index
	If $iIndex < 1 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, "")

	; Copy current array
	Local $aRetArray = $aGLVEx_Data[$iIndex][2]

	; Check if checkbox array
	If $iCheck Then
		If $aGLVEx_Data[$iIndex][6] Then
			Local $aCheck_Array[UBound($aRetArray)]
			For $i = 1 To UBound($aRetArray) - 1
				$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($aGLVEx_Data[$iIndex][0], $i - 1)
			Next
			; Remove count element if required
			If BitAND($aGLVEx_Data[$iIndex][3], 1) = 0 Then
				; Check at least one entry in array
				If $aRetArray[0][0] = 0 Then Return SetError(2, 0, "")
				; Delete count element
				_GUIListViewEx_Array_Delete($aCheck_Array, 0)
			EndIf
			Return $aCheck_Array
		Else
			Return SetError(3, 0, "")
		EndIf
	EndIf

	; Remove count element of array if required
	Local $iCount = 1
	If BitAND($aGLVEx_Data[$iIndex][3], 1) = 0 Then
		$iCount = 0
		; Check at least one entry in array
		If $aRetArray[0][0] = 0 Then Return SetError(2, 0, "")
		; Delete count element
		_GUIListViewEx_Array_Delete($aRetArray, 0, True)
	EndIf

	; Now check if 1D array to be returned
	If BitAND($aGLVEx_Data[$iIndex][3], 2) = 0 Then
		; Get number of 2D elements
		Local $iCols = UBound($aRetArray, 2)
		; Create 1D array - count will be overwritten if not needed
		Local $aTempArray[UBound($aRetArray)] = [$aRetArray[0][0]]
		; Fill with concatenated lines
		For $i = $iCount To UBound($aTempArray) - 1
			Local $aLine = ""
			For $j = 0 To $iCols - 1
				$aLine &= $aRetArray[$i][$j] & $sGLVEx_SepChar
			Next
			$aTempArray[$i] = StringTrimRight($aLine, 1)
		Next
		$aRetArray = $aTempArray
	EndIf

	; Return array
	Return $aRetArray

EndFunc   ;==>_GUIListViewEx_ReturnArray

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Insert
; Description ...: Inserts data just below selected item in active ListView - if no selection, data added at end
; Syntax.........: _GUIListViewEx_Insert($vData[, $fRetainWidth = False])
; Parameters ....: $vData        - Data to insert, can be in array or delimited string format
;                  $fMultiRow    - If $vData is a 1D array:
;                                     - False (default) - elements added as subitems to a single row
;                                     - True - elements added as rows containing a single item
;                                  Ignored if $vData is a single item or a 2D array
;                  $fRetainWidth - True  = native ListView column width is retained on insert
;                                  False = native ListView columns expand to fit data (default)
; Requirement(s).: v3.3 +
; Return values .: Success: Array of current ListView with count in [0] element
;                  Failure: If no ListView active then returns "" and sets @error to 1
; Author ........: Melba23
; Modified ......:
; Remarks .......: - New data is inserted after the selected item.  If no item is selected then the data is added at
;                  the end of the ListView.  If multiple items are selected, the data is inserted after the first
;                  - $vData can be passed in string or array format - it is automatically transformed if required
;                  - $vData as single item - item added to all columns
;                  - $vData as 1D array - see $fMultiRow above
;                  - $vData as 2D array - added as rows/columns
;                  - Native ListViews automatically expand subitem columns to fit inserted data.  Setting the
;                  $fRetainWidth parameter resets the original width after insertion
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Insert($vData, $fMultiRow = False, $fRetainWidth = False)

	Local $vInsert

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, "")

	; Load active ListView details
	$hGLVEx_SrcHandle = $aGLVEx_Data[$iArray_Index][0]
	$cGLVEx_SrcID = $aGLVEx_Data[$iArray_Index][1]
	Local $fCheckBox = $aGLVEx_Data[$iArray_Index][6]

	; Copy array for manipulation
	$aGLVEx_SrcArray = $aGLVEx_Data[$iArray_Index][2]

	; Create Local array for checkboxes (if no checkboxes makes no difference)
	Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
	For $i = 1 To UBound($aCheck_Array) - 1
		$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
	Next

	; Get selected item in ListView
	Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)

	Local $iInsert_Index = $iIndex
	; If no selection
	If $iIndex = "" Then $iInsert_Index = -1
	; Check for multiple selections
	If StringInStr($iIndex, $sGLVEx_SepChar) Then
		Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
		; Use first selection
		$iIndex = $aIndex[1]
		; Cancel all other selections
		For $i = 2 To $aIndex[0]
			_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, $aIndex[$i], False)
		Next
	EndIf

	Local $aCol_Width, $iColCount
	; If width retain required and native ListView
	If $fRetainWidth And $cGLVEx_SrcID Then
		$iColCount = _GUICtrlListView_GetColumnCount($hGLVEx_SrcHandle)
		; Store column widths
		Local $aCol_Width[$iColCount]
		For $i = 1 To $iColCount - 1
			$aCol_Width[$i] = _GUICtrlListView_GetColumnWidth($hGLVEx_SrcHandle, $i)
		Next
	EndIf

	; If empty array insert at 0
	If $aGLVEx_SrcArray[0][0] = 0 Then $iInsert_Index = 0
	; Get data into array format for insert
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

	; Insert data into arrays
	If $iIndex = "" Then
		_GUIListViewEx_Array_Add($aGLVEx_SrcArray, $vInsert, $fMultiRow)
		_GUIListViewEx_Array_Add($aCheck_Array, $vInsert, $fMultiRow)
	Else
		_GUIListViewEx_Array_Insert($aGLVEx_SrcArray, $iInsert_Index + 2, $vInsert, $fMultiRow)
		_GUIListViewEx_Array_Insert($aCheck_Array, $iInsert_Index + 2, $vInsert, $fMultiRow)
	EndIf

	; Rewrite ListView
	_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iArray_Index, $fCheckBox)

	; Set highlight
	If $iIndex = "" Then
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, _GUICtrlListView_GetItemCount($hGLVEx_SrcHandle) - 1)
	Else
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iInsert_Index + 1)
	EndIf

	; Restore column widths if required
	If $fRetainWidth And $cGLVEx_SrcID Then
		For $i = 1 To $iColCount - 1
			$aCol_Width[$i] = _GUICtrlListView_SetColumnWidth($hGLVEx_SrcHandle, $i, $aCol_Width[$i])
		Next
	EndIf

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_SrcArray
	; Delete copied array
	$aGLVEx_SrcArray = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Insert

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Delete
; Description ...: Deletes selected item(s) in active ListView
; Syntax.........: _GUIListViewEx_Delete()
; Parameters ....: $vRange - items to delete.  if no parameter passed any selected items are deleted
; Requirement(s).: v3.3 +
; Return values .: Success: Array of active ListView with count in [0] element
;                  Failure: Returns "" and sets @error as follows:
;                      1 = No ListView active
;                      2 = No item selected
;                      3 = No items to delete
; Author ........: Melba23
; Modified ......:
; Remarks .......: If multiple items are selected, all are deleted
;                  $vRange must be semicolon-delimited with hypenated consecutive values.
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Delete($vRange = "")

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, "")

	; Load active ListView details
	$hGLVEx_SrcHandle = $aGLVEx_Data[$iArray_Index][0]
	$cGLVEx_SrcID = $aGLVEx_Data[$iArray_Index][1]

	; Copy array for manipulation
	$aGLVEx_SrcArray = $aGLVEx_Data[$iArray_Index][2]

	; Create Local array for checkboxes (if no checkboxes makes no difference)
	Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
	For $i = 1 To UBound($aCheck_Array) - 1
		$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
	Next

	Local $aSplit_1, $aSplit_2, $iIndex

	; Check for range
	If $vRange Then
		Local $iNumber
		$vRange = StringStripWS($vRange, 8)
		$aSplit_1 = StringSplit($vRange, ";")
		$vRange = ""
		For $i = 1 To $aSplit_1[0]
			; Check for correct range syntax
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
		; Get selected items
		$iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
		If $iIndex = "" Then Return SetError(2, 0, "")
	EndIf

	; Extract all selected items
	Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
	For $i = 1 To $aIndex[0]
		; Remove highlighting from items
		_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, $i, False)
	Next

	Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
	For $i = 1 To UBound($aCheck_Array) - 1
		$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
	Next

	; Delete elements from array - start from bottom
	For $i = $aIndex[0] To 1 Step -1
		_GUIListViewEx_Array_Delete($aGLVEx_SrcArray, $aIndex[$i] + 1)
		_GUIListViewEx_Array_Delete($aCheck_Array, $aIndex[$i] + 1)
	Next

	; Rewrite ListView
	_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iArray_Index)

	; Set highlight
	If $aIndex[1] = 0 Then
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, 0)
	Else
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $aIndex[1] - 1)
	EndIf

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_SrcArray
	; Delete copied array
	$aGLVEx_SrcArray = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Delete

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Up
; Description ...: Moves selected item(s) in active ListView up 1 row
; Syntax.........: _GUIListViewEx_Up()
; Parameters ....: None
; Requirement(s).: v3.3 +
; Return values .: Success: Array of active ListView with count in [0] element
;                  Failure: Returns "" and sets @error as follows:
;                      1 = No ListView active
;                      2 = No item selected
;                      3 = Item already at top
; Author ........: Melba23
; Modified ......:
; Remarks .......: If multiple items are selected, only the top consecutive block is moved
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Up()

	Local $iGLVExMove_Index, $iGLVEx_Moving = 0

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, 0)

	; Load active ListView details
	$hGLVEx_SrcHandle = $aGLVEx_Data[$iArray_Index][0]
	$cGLVEx_SrcID = $aGLVEx_Data[$iArray_Index][1]

	; Copy array for manipulation
	$aGLVEx_SrcArray = $aGLVEx_Data[$iArray_Index][2]

	; Create Local array for checkboxes (if no checkboxes makes no difference)
	Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
	For $i = 1 To UBound($aCheck_Array) - 1
		$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
	Next

	; Check for selected items
	Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
	If $iIndex = "" Then
		Return SetError(2, 0, "")
	EndIf
	Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
	$iGLVExMove_Index = $aIndex[1]
	; Check if item is part of a multiple selection
	If $aIndex[0] > 1 Then
		; Check for consecutive items
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

	; Check not top item
	If $iGLVExMove_Index < 1 Then
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, 0)
		Return SetError(3, 0, "")
	EndIf

	; Remove all highlighting
	_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, -1, False)

	; Move consecutive items
	For $iIndex = $iGLVExMove_Index To $iGLVExMove_Index + $iGLVEx_Moving
		; Swap array elements
		_GUIListViewEx_Array_Swap($aGLVEx_SrcArray, $iIndex, $iIndex + 1)
		_GUIListViewEx_Array_Swap($aCheck_Array, $iIndex, $iIndex + 1)
	Next

	; Rewrite ListView
	_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iArray_Index)

	; Set highlight
	For $i = 0 To $iGLVEx_Moving
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVExMove_Index + $i - 1)
	Next

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_SrcArray
	; Delete copied array
	$aGLVEx_SrcArray = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Up

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Down
; Description ...: Moves selected item(s) in active ListView down 1 row
; Syntax.........: _GUIListViewEx_Down()
; Parameters ....: None
; Requirement(s).: v3.3 +
; Return values .: Success: Array of active ListView with count in [0] element
;                  Failure: Returns "" and sets @error as follows:
;                      1 = No ListView active
;                      2 = No item selected
;                      3 = Item already at bottom
; Author ........: Melba23
; Modified ......:
; Remarks .......: If multiple items are selected, only the bottom consecutive block is moved
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Down()

	Local $iGLVExMove_Index, $iGLVEx_Moving = 0

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, 0)

	; Load active ListView details
	$hGLVEx_SrcHandle = $aGLVEx_Data[$iArray_Index][0]
	$cGLVEx_SrcID = $aGLVEx_Data[$iArray_Index][1]

	; Copy array for manipulation
	$aGLVEx_SrcArray = $aGLVEx_Data[$iArray_Index][2]

	; Create Local array for checkboxes (if no checkboxes makes no difference)
	Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
	For $i = 1 To UBound($aCheck_Array) - 1
		$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
	Next

	; Check for selected items
	Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
	If $iIndex = "" Then
		Return SetError(2, 0, "")
	EndIf
	Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
	; Check if item is part of a multiple selection
	If $aIndex[0] > 1 Then
		$iGLVExMove_Index = $aIndex[$aIndex[0]]
		; Check for consecutive items
		For $i = 1 To $aIndex[0] - 1
			If $aIndex[$aIndex[0] - $i] = $aIndex[$aIndex[0]] - $i Then
				$iGLVEx_Moving += 1
			Else
				ExitLoop
			EndIf
		Next
	Else
		$iGLVExMove_Index = $aIndex[1]
	EndIf

	; Remove all highlighting
	_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, -1, False)

	; Check not last item
	If $iGLVExMove_Index = _GUICtrlListView_GetItemCount($hGLVEx_SrcHandle) - 1 Then
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iIndex)
		Return SetError(3, 0, "")
	EndIf

	; Move consecutive items
	For $iIndex = $iGLVExMove_Index To $iGLVExMove_Index - $iGLVEx_Moving Step -1
		; Swap array elements
		_GUIListViewEx_Array_Swap($aGLVEx_SrcArray, $iIndex + 1, $iIndex + 2)
		_GUIListViewEx_Array_Swap($aCheck_Array, $iIndex + 1, $iIndex + 2)
	Next

	; Rewrite ListView
	_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iArray_Index)

	; Set highlight
	For $i = 0 To $iGLVEx_Moving
		_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVExMove_Index - $iGLVEx_Moving + $i + 1)
	Next

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_SrcArray
	; Delete copied array
	$aGLVEx_SrcArray = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Down

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_EditOnClick
; Description ...: Edit ListView items and headers in user-defined columns when doubleclicked
; Syntax.........: _GUIListViewEx_EditOnClick([$iEditMode = 0[, $iDelta_X = 0[, $iDelta_Y = 0]]])
; Parameters ....: $iEditMode - Only used if using Edit control:
;                                    Return after single edit - 0 (default)
;                                    {TAB} and arrow keys move to next item - 2-digit code (row mode/column mode)
;                                        1 = Reaching edge terminates edit process
;                                        2 = Reaching edge remains in place
;                                        3 = Reaching edge loops to opposite edge
;                               	     Positive value = ESC abandons current edit only, previous edits remain
;                                        Negative value = ESC resets all edits in current session
;                               Ignored if using Combo control - return after single edit
;                  $iDelta_X  - Permits fine adjustment of edit control in X axis if needed
;                  $iDelta_Y  - Permits fine adjustment of edit control in Y axis if needed
; Requirement(s).: v3.3 +
; Return values .: If no double-click: Empty string
;                  After double-click on ListView item:
;                      2D array of [row][column] items edited (both zero-based) - total edits in [0][0]
;                  After double-click just above ListView header:
;                      2D array  [column edited][new header text]
;                  Failure: Sets @error as follows:
;                      1 - ListView not editable
;                      2 - Empty ListView
;                      3 - Column not editable
; Author ........: Melba23
; Modified ......:
; Remarks .......: This function must be placed within the script idle loop.
;                  Edit control depends on _GUIListViewEx_Init $iAdded parameter:
;                      + 2  = Element editable - default edit control
;                      + 32 = Combo control used for editing
;                  Once item edit process started, all other script activity is suspended until following occurs:
;                      {ENTER}  = Current edit confirmed and editing process ended
;                      {ESCAPE} = Current or all edits cancelled and editing process ended
;                      If using Edit control:
;                          If $iEditMode non-zero then {TAB} and arrow keys = Current edit confirmed & continue editing
;                          Click outside edit = Editing process ends and
;                              If $iAdded + 4 : Current edit accepted
;                              Else :           Current edit cancelled
;                      If using Combo control:
;                          Combo actioned     = Combo selection accepted and editing process ended
;                          Click outside edit = Edit process ended and editing process ended
;                  For header edit only {ENTER}, {ESCAPE} and mouse click are actioned - single edit only
;                  The function only returns an array after an edit process launched by a double-click.  If no
;                  double-click has occurred, the function returns an empty string.  The user should check that a
;                  valid array is present before attempting to access it.
;                  If header edited [0][1] element of returned array exists - if items edited this element is empty
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_EditOnClick($iEditMode = 0, $iDelta_X = 0, $iDelta_Y = 0)

	Local $aEdited, $iError

	; If an item was double clicked
	If $fGLVEx_EditClickFlag Then

		; Clear flag
		$fGLVEx_EditClickFlag = False

		; Check Type parameter
		Switch Abs($iEditMode)
			Case 0, 11, 12, 13, 21, 22, 23, 31, 32, 33 ; Single edit or both axes set to valid parameter
				; Allow
			Case Else
				Return SetError(1, 0, "")
		EndSwitch

		; Set data for active ListView
		Local $iLV_Index = $aGLVEx_Data[0][1]
		; If no ListView active then return
		If $iLV_Index = 0 Then
			Return SetError(2, 0, "")
		EndIf

		; Get clicked item info
		Local $aLocation = _GUICtrlListView_SubItemHitTest($hGLVEx_SrcHandle)
		; Check valid row
		If $aLocation[0] = -1 Then
			Return SetError(3, 0, "")
		EndIf

		; Get valid column string
		Local $sCols = $aGLVEx_Data[$iLV_Index][7]
		; And validate selected column
		If Not StringInStr($sCols, "*") Then
			If Not StringInStr(";" & $sCols, ";" & $aLocation[1]) Then
				Return SetError(1, 0, "")
			EndIf
		EndIf

		; Start edit
		$aEdited = _GUIListViewEx_EditProcess($iLV_Index, $aLocation, $sCols, $iDelta_X, $iDelta_Y, $iEditMode)
		$iError = @error
		; Return result array
		Return SetError($iError, 0, $aEdited)

	EndIf

	; If a header was double clicked
	If $fGLVEx_HeaderEdit Then

		; Clear the flag
		$fGLVEx_HeaderEdit = False

		; Wait until mouse button released as click occurs outside the control
		While _WinAPI_GetAsyncKeyState(0x01)
			Sleep(10)
		WEnd

		; Edit header using the default values set by the handler
		$aEdited = _GUIListViewEx_EditHeader()
		$iError = @error
		; Return result
		Return SetError($iError, 0, $aEdited)

	EndIf

	; If nothing was clicked
	Return ""

EndFunc   ;==>_GUIListViewEx_EditOnClick

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_EditItem
; Description ...: Edit ListView items programatically
; Syntax.........: _GUIListViewEx_EditItem($iLV_Index, $iRow, $iCol[, $iEditMode = 0[, $iDelta_X = 0[, $iDelta_Y = 0]]])
; Parameters ....: $iLV_Index - Index number of ListView as returned by _GUIListViewEx_Init
;                  $iRow      - Zero-based row of item to edit
;                  $iCol      - Zero-based column of item to edit
;                  $iEditMode - Only used if using Edit control:
;                                    Return after single edit - 0 (default)
;                                    {TAB} and arrow keys move to next item - 2-digit code (row mode/column mode)
;                                        1 = Reaching edge terminates edit process
;                                        2 = Reaching edge remains in place
;                                        3 = Reaching edge loops to opposite edge
;                               	     Positive value = ESC abandons current edit only, previous edits remain
;                                        Negative value = ESC resets all edits in current session
;                               Ignored if using Combo control - return after single edit
;                  $iDelta_X  - Permits fine adjustment of edit control in X axis if needed
;                  $iDelta_Y  - Permits fine adjustment of edit control in Y axis if needed
; Requirement(s).: v3.3 +
; Return values .: Success: 2D array of zero-based [row][column] items edited - total number of edits in [0][0] element
;                  Failure: Sets @error as follows:
;                           1 - Invalid ListView Index
;                           2 - ListView not editable
;                           3 - Invalid row
;                           4 - Invalid column
;                           5 - Invalid edit mode
; Author ........: Melba23
; Modified ......:
; Remarks .......: Once edit started, all other script activity is suspended until following occurs:
;                      {ENTER}  = Current edit confirmed and editing ended
;                      {ESCAPE} = Current edit cancelled and editing ended
;                      If $iEditMode non-zero then {TAB} and arrow keys = Current edit confirmed continue editing
;                      Click outside edit = Editing process ends and
;                          If $iAdded + 4 : Current edit accepted
;                          Else :           Current edit cancelled
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_EditItem($iLV_Index, $iRow, $iCol, $iEditMode = 0, $iDelta_X = 0, $iDelta_Y = 0)

	; Activate the ListView
	_GUIListViewEx_SetActive($iLV_Index)
	If @error Then
		Return SetError(1, 0, "")
	EndIf
	; Check ListView is editable
	If $aGLVEx_Data[$iLV_Index][7] = "" Then
		Return SetError(2, 0, "")
	EndIf
	; Check row and col values
	Local $iMax = _GUICtrlListView_GetItemCount($hGLVEx_SrcHandle)
	If $iRow < 0 Or $iRow > $iMax - 1 Then
		Return SetError(3, 0, "")
	EndIf
	$iMax = _GUICtrlListView_GetColumnCount($hGLVEx_SrcHandle)
	If $iCol < 0 Or $iCol > $iMax - 1 Then
		Return SetError(4, 0, "")
	EndIf
	; Check edit mode parameter
	Switch Abs($iEditMode)
		Case 0, 11, 12, 13, 21, 22, 23, 31, 32, 33 ; Single edit or both axes set to valid parameter
			; Allow
		Case Else
			Return SetError(5, 0, "")
	EndSwitch

	; Declare location array
	Local $aLocation[2] = [$iRow, $iCol]
	; Load valid column string
	Local $sValidCols = $aGLVEx_Data[$iLV_Index][7]
	; Start edit
	Local $aEdited = _GUIListViewEx_EditProcess($iLV_Index, $aLocation, $sValidCols, $iDelta_X, $iDelta_Y, $iEditMode)
	; Return result array
	Return $aEdited

EndFunc   ;==>_GUIListViewEx_EditItem

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_EditHeader($iLV_Index = Default, $iCol = Default, $iDelta_X = 0, $iDelta_Y = 0)
; Description ...: Edit ListView headers programatically
; Syntax.........: _GUIListViewEx_EditHeader([$iLV_Index = Default[, $iCol = Default[, $iDelta_X = 0[, $iDelta_Y = 0]]]])
; Parameters ....: $iLV_Index - Index number of ListView as returned by _GUIListViewEx_Init - default active ListView
;                  $iCol      - Zero-based column of header to edit
;                  $iDelta_X  - Permits fine adjustment of edit control in X axis if needed
;                  $iDelta_Y  - Permits fine adjustment of edit control in Y axis if needed
; Requirement(s).: v3.3 +
; Return values .: Success: Array: 2D array [column][new text]
;                  Failure: Empty string and sets @error as follows:
;                           1 - Invalid ListView Index
;                           2 - ListView not editable
;                           3 - Invalid column
; Author ........: Melba23
; Modified ......:
; Remarks .......: Once edit started, all other script activity is suspended until following occurs:
;                      {ENTER}  = Current edit confirmed and editing ended
;                      {ESCAPE} or click on other control = Current edit cancelled and editing ended
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_EditHeader($iLV_Index = Default, $iCol = Default, $iDelta_X = 0, $iDelta_Y = 0)

	Local $aRet = ""

	If $iLV_Index = Default Then
		$iLV_Index = $aGLVEx_Data[0][1]
	EndIf

	; Activate the ListView
	_GUIListViewEx_SetActive($iLV_Index)
	If @error Then
		Return SetError(1, 0, $aRet)
	EndIf

	Local $hLV_Handle = $aGLVEx_Data[$iLV_Index][0]
	Local $cLV_CID = $aGLVEx_Data[$iLV_Index][1]

	; Check ListView is editable
	If $aGLVEx_Data[$iLV_Index][7] = "" Then
		Return SetError(2, 0, $aRet)
	EndIf
	; Check col value
	If $iCol = Default Then
		$iCol = $aGLVEx_Data[0][2]
	EndIf
	Local $iMax = _GUICtrlListView_GetColumnCount($hLV_Handle)
	If $iCol < 0 Or $iCol > $iMax - 1 Then
		Return SetError(3, 0, $aRet)
	EndIf

	Local $tLVPos = DllStructCreate("struct;long X;long Y;endstruct")
	; Get position of ListView within GUI client area
	_GUIListViewEx_GetLVCoords($hLV_Handle, $tLVPos)
	; Get ListView client area to allow for scrollbars
	Local $aLVClient = WinGetClientSize($hLV_Handle)
	; Get ListView font details
	Local $aLV_FontDetails = _GUIListViewEx_GetLVFont($hLV_Handle)
	; Disable ListView
	WinSetState($hLV_Handle, "", @SW_DISABLE)
	; Read current text of header
	Local $aHeader_Data = _GUICtrlListView_GetColumn($hLV_Handle, $iCol)
	Local $sHeaderOrgText = $aHeader_Data[5]
	; Get required edit coords for 0 item
	Local $aLocation[2] = [0, $iCol]
	Local $aEdit_Coords = _GUIListViewEx_EditCoords($hLV_Handle, $cLV_CID, $aLocation, $tLVPos, $aLVClient[0] - 5, $iDelta_X, $iDelta_Y)
	; Now get header size and adjust coords for header
	Local $hHeader = _GUICtrlListView_GetHeader($hLV_Handle)
	Local $aHeader_Pos = WinGetPos($hHeader)
	$aEdit_Coords[0] -= 2
	$aEdit_Coords[1] -= $aHeader_Pos[3]
	$aEdit_Coords[3] = $aHeader_Pos[3]
	; Create temporary edit - get handle, set font size, give keyboard focus and select all text
	$cGLVEx_EditID = GUICtrlCreateEdit($sHeaderOrgText, $aEdit_Coords[0], $aEdit_Coords[1], $aEdit_Coords[2], $aEdit_Coords[3], 0)
	Local $hTemp_Edit = GUICtrlGetHandle($cGLVEx_EditID)
	GUICtrlSetFont($cGLVEx_EditID, $aLV_FontDetails[0], Default, Default, $aLV_FontDetails[1])
	GUICtrlSetState($cGLVEx_EditID, 256) ; $GUI_FOCUS
	GUICtrlSendMsg($cGLVEx_EditID, 0xB1, 0, -1) ; $EM_SETSEL
	; Valid keys to action (ENTER, ESC)
	Local $aKeys[2] = [0x0D, 0x1B]
	; Clear key code flag
	Local $iKey_Code = 0
	; Wait for a key press
	While 1
		; Check for valid key or mouse button pressed
		For $i = 0 To 1
			If _WinAPI_GetAsyncKeyState($aKeys[$i]) Then
				; Set key pressed flag
				$iKey_Code = $aKeys[$i]
				ExitLoop 2
			EndIf
		Next
		; Temp input loses focus
		If _WinAPI_GetFocus() <> $hTemp_Edit Then
			ExitLoop
		EndIf
		; If edit moveable by click then check for mouse pressed outside edit
		If _WinAPI_GetAsyncKeyState(0x01) Then
			Local $aCInfo = GUIGetCursorInfo()
			If Not(IsArray($aCInfo)) Or $aCInfo[4] <> $cGLVEx_EditID Then
				$iKey_Code = 0x01
				ExitLoop
			EndIf
		EndIf
		; Save CPU
		Sleep(10)
	WEnd
	; Action keypress
	Switch $iKey_Code
		Case 0x0D
			; Change column header text
			Local $sHeaderNewText = GUICtrlRead($cGLVEx_EditID)
			If $sHeaderNewText <> $sHeaderOrgText Then
				_GUICtrlListView_SetColumn($hLV_Handle, $iCol, $sHeaderNewText)
				Local $aRet[1][2] = [[$iCol, $sHeaderNewText]]
			EndIf
	EndSwitch
	; Delete Edit
	GUICtrlDelete($cGLVEx_EditID)
	; Reenable ListView
	WinSetState($hLV_Handle, "", @SW_ENABLE)

	Return $aRet

EndFunc   ;==>_GUIListViewEx_EditHeader

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_ComboData
; Description ...: Set data for edit combo
; Syntax.........: _GUIListViewEx_ComboData($iLV_Index, $iCol, $vData, $fRead_Only = False)
; Parameters ....: $iLV_Index  - Index number of ListView as returned by _GUIListViewEx_Init - default active ListView
;                  $iCol       - Column of ListView to show this data.  Use -1 for all columns
;                  $vData      - Content of combo - either delimited string or 0-based array
;                  $fRead_Only - Whether combo is readonly - default editable
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: 0 and sets @error as follows:
;                           1 - Invalid ListView Index
;                           2 - Combo not enabled
;                           3 - Invalid column parameter
; Author ........: Melba23
; Modified ......:
; Remarks .......: Once edit started, all other script activity is suspended until following occurs:
;                      Combo selection made or {ENTER} = Current edit confirmed and editing ended
;                      {ESCAPE} or click on other control = Current edit cancelled and editing ended
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_ComboData($iIndex, $iCol, $vData, $fRead_Only = False)

	; Check valid index
	If $iIndex < 1 Or $iIndex > $aGLVEx_Data[0][0] Then
		Return SetError(1, 0, 0)
	EndIf
	; Check if combo enabled
	If Not IsArray($aGLVEx_Data[$iIndex][11]) Then
		Return SetError(2, 0, 0)
	EndIf
	; Check if valid col
	If $iCol < -1 Or $iCol > _GUICtrlListView_GetColumnCount($aGLVEx_Data[$iIndex][0]) - 1 Then
		Return SetError(3, 0, 0)
	EndIf
	; Extract array
	Local $aComboData_Array = $aGLVEx_Data[$iIndex][11]
	; Clear current combo data
	If $iCol = -1 Then
		For $i = 0 To UBound($aComboData_Array) - 1
			$aComboData_Array[$i] = ""
		Next
	Else
		$aComboData_Array[$iCol] = ""
	EndIf
	Local $sCombo_Data = ""
	; If array passed
	If IsArray($vData) Then
		; Loop through at create delimited string
		For $i = 0 To UBound($vData) - 1
			$sCombo_Data &= $sGLVEx_SepChar & $vData[$i]
		Next
	Else
		; Check for leading |
		If StringLeft($vData, 1) <> $sGLVEx_SepChar Then
			$sCombo_Data = $sGLVEx_SepChar & $vData
		EndIf
	EndIf
	; Set readonly flag if required
	If $fRead_Only Then
		$sCombo_Data = "#" & $sCombo_Data
	EndIf
	; Set new value into array
	If $iCol = -1 Then
		For $i = 0 To UBound($aComboData_Array) - 1
			$aComboData_Array[$i] = $sCombo_Data
		Next
	Else
		$aComboData_Array[$iCol] = $sCombo_Data
	EndIf
	; Store array
	$aGLVEx_Data[$iIndex][11] = $aComboData_Array
	; Show success
	Return 1

EndFunc

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_MsgRegister
; Description ...: Registers Windows messages required for the UDF
; Syntax.........: _GUIListViewEx_MsgRegister([$fNOTIFY = True, [$fMOUSEMOVE = True, [$fLBUTTONUP = True]]])
; Parameters ....: $fNOTIFY    - True = Register WM_NOTIFY message
;                  $fMOUSEMOVE - True = Register WM_MOUSEMOVE message
;                  $fLBUTTONUP - True = Register WM_LBUTTONUP message
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If message handlers already registered, then call the relevant handler function from within that handler
;                  WM_NOTIFY handler required for all UDF functions
;                  WM_MOUSEMOVE and WM_LBUTTONUP handlers required for drag
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_MsgRegister($fNOTIFY = True, $fMOUSEMOVE = True, $fLBUTTONUP = True)

	; Register required messages
	If $fNOTIFY    Then GUIRegisterMsg(0x004E, "_GUIListViewEx_WM_NOTIFY_Handler")    ; $WM_NOTIFY
	If $fMOUSEMOVE Then GUIRegisterMsg(0x0200, "_GUIListViewEx_WM_MOUSEMOVE_Handler") ; $WM_MOUSEMOVE
	If $fLBUTTONUP Then GUIRegisterMsg(0x0202, "_GUIListViewEx_WM_LBUTTONUP_Handler") ; $WM_LBUTTONUP

EndFunc   ;==>_GUIListViewEx_MsgRegister

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_WM_NOTIFY_Handler
; Description ...: Windows message handler for WM_NOTIFY
; Syntax.........: _GUIListViewEx_WM_NOTIFY_Handler()
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If a WM_NOTIFY handler already registered, then call this function from within that handler
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_WM_NOTIFY_Handler($hWnd, $iMsg, $wParam, $lParam)

	#forceref $hWnd, $iMsg, $wParam

	; Struct = $tagNMHDR and "int Item;int SubItem" from $tagNMLISTVIEW
	Local $tStruct = DllStructCreate("hwnd;uint_ptr;int_ptr;int;int", $lParam)
	If @error Then Return

	; Check if enabled ListView
	For $iLV_Index = 1 To $aGLVEx_Data[0][0]
		If DllStructGetData($tStruct, 1) = $aGLVEx_Data[$iLV_Index][0] Then
			ExitLoop
		EndIf
	Next
	If $iLV_Index > $aGLVEx_Data[0][0] Then Return ; Not enabled

	Local $iCode = BitAND(DllStructGetData($tStruct, 3), 0xFFFFFFFF)
	Switch $iCode

		Case $LVN_BEGINSCROLL
			; if editing then abandon
			If $cGLVEx_EditID <> 9999 Then
				; Delete temp edit control and set placeholder
				GUICtrlDelete($cGLVEx_EditID)
				$cGLVEx_EditID = 9999
				; Reactivate ListView
				WinSetState($hGLVEx_Editing, "", @SW_ENABLE)
			EndIf

		Case $LVN_COLUMNCLICK, -2 ; $NM_CLICK

			; Set values for active ListView
			$aGLVEx_Data[0][1] = $iLV_Index
			$hGLVEx_SrcHandle = $aGLVEx_Data[$iLV_Index][0]
			$cGLVEx_SrcID = $aGLVEx_Data[$iLV_Index][1]
			; Get column index
			Local $iCol = DllStructGetData($tStruct, 5)
			; Store it
			$aGLVEx_Data[0][2] = $iCol

			; If a column was clicked
			If $iCode = $LVN_COLUMNCLICK Then
				; Scroll column into view
				; Get X coord of first item in column
				Local $aRect = _GUICtrlListView_GetSubItemRect($hGLVEx_SrcHandle, 0, $iCol)
				; Get col width
;~ 				Local $aLV_Pos = WinGetPos($hGLVEx_SrcHandle)
				; Scroll to left edge if all column not in view
;~ 				If $aRect[0] < 0 Or $aRect[2] > $aLV_Pos[2] - 17 Then
;~ 					_GUICtrlListView_Scroll($hGLVEx_SrcHandle, $aRect[0], 0)
;~ 				EndIf

				; Look for Ctrl key pressed
				_WinAPI_GetAsyncKeyState(0x11) ; Needed to avoid double setting
				If _WinAPI_GetAsyncKeyState(0x11) Then
					; Load valid column string
					Local $sValidCols = $aGLVEx_Data[$iLV_Index][7]
					; Check column is editable
					If StringInStr($sValidCols, "*") Or StringInStr(";" & $sValidCols, ";" & $iCol) Then
						; Set header edit flag
						$fGLVEx_HeaderEdit = True
					EndIf

				Else
					; If ListView sortable
					If IsArray($aGLVEx_Data[$iLV_Index][4]) Then
						; ZAG added line - 2-24-19 - put the correct # back in the event order column before sorting
						If _GUICtrlListView_GetItemText($eventList, $currentPlayingEvent, 0) = "▶" Then
							_GUICtrlListView_SetItemText($eventList, $currentPlayingEvent, $currentPlayingEventPos, 0)
						EndIf

						; Load array
						$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
						; Load current ListView sort state array
						Local $aLVSortState = $aGLVEx_Data[$iLV_Index][4]
						; Sort column - get column from from struct
						_GUICtrlListView_SimpleSort($hGLVEx_SrcHandle, $aLVSortState, $iCol)
;~ 						_GUICtrlListView_SortItems($hGLVEx_SrcHandle, $iCol)
						; Store new ListView sort state array
						$aGLVEx_Data[$iLV_Index][4] = $aLVSortState
						; Reread listview items into array
						Local $iDim2 = UBound($aGLVEx_SrcArray, 2) - 1
						For $j = 1 To $aGLVEx_SrcArray[0][0]
							For $k = 0 To $iDim2
								$aGLVEx_SrcArray[$j][$k] = _GUICtrlListView_GetItemText($hGLVEx_SrcHandle, $j - 1, $k)
							Next
						Next
						; Store amended array
						$aGLVEx_Data[$iLV_Index][2] = $aGLVEx_SrcArray
						; Delete array
						$aGLVEx_SrcArray = 0
					EndIf
				EndIf
			ElseIf $iCode = -2 Then
				$isClicked = 1
			EndIf

		Case $LVN_BEGINDRAG

			; Set values for this ListView
			$aGLVEx_Data[0][1] = $iLV_Index

			; Store source & target ListView data for eventual inter-LV drag
			$hGLVEx_SrcHandle = $aGLVEx_Data[$iLV_Index][0]
			$cGLVEx_SrcID = $aGLVEx_Data[$iLV_Index][1]
			$iGLVEx_SrcIndex = $iLV_Index
			$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
			$hGLVEx_TgtHandle = $hGLVEx_SrcHandle
			$cGLVEx_TgtID = $cGLVEx_SrcID
			$iGLVEx_TgtIndex = $iGLVEx_SrcIndex
			$aGLVEx_TgtArray = $aGLVEx_SrcArray

			; Copy array for manipulation
			$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]

			; Set drag image flag
			Local $fImage = $aGLVEx_Data[$iLV_Index][5]

			; Check if Native or UDF and set focus
			If $cGLVEx_SrcID Then
				GUICtrlSetState($cGLVEx_SrcID, 256) ; $GUI_FOCUS
			Else
				_WinAPI_SetFocus($hGLVEx_SrcHandle)
			EndIf

			; Get dragged item index
			$iGLVEx_DraggedIndex = DllStructGetData($tStruct, 4) ; Item
			; Set dragged item count
			$iGLVEx_Dragging = 1

			; Check for selected items
			Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_SrcHandle)
			; Check if item is part of a multiple selection
			If StringInStr($iIndex, $iGLVEx_DraggedIndex) And StringInStr($iIndex, $sGLVEx_SepChar) Then
				; Extract all selected items
				Local $aIndex = StringSplit($iIndex, $sGLVEx_SepChar)
				For $i = 1 To $aIndex[0]
					If $aIndex[$i] = $iGLVEx_DraggedIndex Then ExitLoop
				Next
				; Now check for consecutive items
				If $i <> 1 Then ; Up
					For $j = $i - 1 To 1 Step -1
						; Consecutive?
						If $aIndex[$j] <> $aIndex[$j + 1] - 1 Then ExitLoop
						; Adjust dragged index to this item
						$iGLVEx_DraggedIndex -= 1
						; Increase number to drag
						$iGLVEx_Dragging += 1
					Next
				EndIf
				If $i <> $aIndex[0] Then ; Down
					For $j = $i + 1 To $aIndex[0]
						; Consecutive
						If $aIndex[$j] <> $aIndex[$j - 1] + 1 Then ExitLoop
						; Increase number to drag
						$iGLVEx_Dragging += 1
					Next
				EndIf
			Else ; Either no selection or only a single
				; Set flag
				$iGLVEx_Dragging = 1
			EndIf

			; Remove all highlighting
			_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, -1, False)

			; Create drag image
			If $fImage Then
				Local $aImageData = _GUICtrlListView_CreateDragImage($hGLVEx_SrcHandle, $iGLVEx_DraggedIndex)
				$hGLVEx_DraggedImage = $aImageData[0]
				_GUIImageList_BeginDrag($hGLVEx_DraggedImage, 0, 0, 0)
			EndIf

		Case -3 ; $NM_DBLCLK
			; Only if editable
			If $aGLVEx_Data[$iLV_Index][7] <> "" Then
				; Set values for active ListView
				$aGLVEx_Data[0][1] = $iLV_Index;
				$hGLVEx_SrcHandle = $aGLVEx_Data[$iLV_Index][0]
				; Copy array for manipulation
				$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
				; Set editing flag
				$fGLVEx_EditClickFlag = True
			EndIf

			$isClicked = 2 ; open the file in the editor
	EndSwitch

EndFunc   ;==>_GUIListViewEx_WM_NOTIFY_Handler

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_WM_MOUSEMOVE_Handler
; Description ...: Windows message handler for WM_NOTIFY
; Syntax.........: _GUIListViewEx_WM_MOUSEMOVE_Handler()
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If a WM_MOUSEMOVE handler already registered, then call this function from within that handler
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_WM_MOUSEMOVE_Handler($hWnd, $iMsg, $wParam, $lParam)

	#forceref $hWnd, $iMsg, $wParam

	Local $iVertScroll

	If $iGLVEx_Dragging = 0 Then
		Return "GUI_RUNDEFMSG"
	EndIf

	; Get item depth to make sure scroll is enough to get next item into view
	If $aGLVEx_Data[$aGLVEx_Data[0][1]][10] Then
		$iVertScroll = $aGLVEx_Data[$aGLVEx_Data[0][1]][10]
	Else
		Local $aRect = _GUICtrlListView_GetItemRect($hGLVEx_SrcHandle, 0)
		$iVertScroll = $aRect[3] - $aRect[1]
	EndIf

	; Get window under mouse cursor
	Local $hCurrent_Wnd = _GUIListViewEx_GetCursorWnd()

	; If not over the current tgt ListView
	If $hCurrent_Wnd <> $hGLVEx_TgtHandle Then

		; Check if external drag permitted
		If BitAnd($aGLVEx_Data[$iGLVEx_TgtIndex][12], 1) Then
			Return "GUI_RUNDEFMSG"
		EndIf

		; Is it another initiated ListView
		For $i = 1 To $aGLVEx_Data[0][0]
			If $aGLVEx_Data[$i][0] = $hCurrent_Wnd Then

					; Check if external drop permitted
					If BitAnd($aGLVEx_Data[$i][12], 2) Then
						Return "GUI_RUNDEFMSG"
					EndIf

				; Check compatibility between Src and Tgt ListViews
				; Check neither has checkboxes
				If $aGLVEx_Data[$iGLVEx_SrcIndex][6] + $aGLVEx_Data[$i][6] = 0 Then
					; Check same column count
					If _GUICtrlListView_GetColumnCount($hGLVEx_SrcHandle) = _GUICtrlListView_GetColumnCount($hCurrent_Wnd) Then
						; Compatible so switch to new target
						; Clear insert mark in current tgt ListView
						_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, -1, True)
						; Set data for new tgt ListView
						$hGLVEx_TgtHandle = $hCurrent_Wnd
						$cGLVEx_TgtID = $aGLVEx_Data[$i][1]
						$iGLVEx_TgtIndex = $i
						$aGLVEx_TgtArray = $aGLVEx_Data[$i][2]
						$aGLVEx_Data[0][3] = $aGLVEx_Data[$i][10] ; Set item depth
						; No point in looping further
						ExitLoop
					EndIf
				EndIf
			EndIf
		Next
	EndIf

	; Get current mouse Y coord
	Local $iCurr_Y = BitShift($lParam, 16)

	; Set insert mark to correct side of items depending on sense of movement when cursor within range
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
	; Store current Y coord
	$iGLVEx_LastY = $iCurr_Y

	; Get ListView item under mouse
	Local $aLVHit = _GUICtrlListView_HitTest($hGLVEx_TgtHandle)
	Local $iCurr_Index = $aLVHit[0]

	; If mouse is above or below ListView then scroll ListView
	If $iCurr_Index = -1 Then
		If $fGLVEx_BarUnder Then
			_GUICtrlListView_Scroll($hGLVEx_TgtHandle, 0, $iVertScroll)
		Else
			_GUICtrlListView_Scroll($hGLVEx_TgtHandle, 0, -$iVertScroll)
		EndIf
		Sleep(10)
	EndIf

	; Check if over same item
	If $iGLVEx_InsertIndex <> $iCurr_Index Then
		; Show insert mark on current item
		_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, $iCurr_Index, $fGLVEx_BarUnder)
		; Store current item
		$iGLVEx_InsertIndex = $iCurr_Index
	EndIf

	Return "GUI_RUNDEFMSG"

EndFunc   ;==>_GUIListViewEx_WM_MOUSEMOVE_Handler

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_WM_LBUTTONUP_Handler
; Description ...: Windows message handler for WM_NOTIFY
; Syntax.........: _GUIListViewEx_WM_LBUTTONUP_Handler()
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If a WM_LBUTTONUP handler already registered, then call this function from within that handler
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_WM_LBUTTONUP_Handler($hWnd, $iMsg, $wParam, $lParam)

	#forceref $hWnd, $iMsg, $wParam, $lParam

	If Not $iGLVEx_Dragging Then
		Return "GUI_RUNDEFMSG"
	EndIf

	; Get item count
	Local $iMultipleItems = $iGLVEx_Dragging - 1

	; Reset flag
	$iGLVEx_Dragging = 0

	; Get window under mouse cursor
	Local $hCurrent_Wnd = _GUIListViewEx_GetCursorWnd()

	; Abandon if mouse not within tgt ListView
	If $hCurrent_Wnd <> $hGLVEx_TgtHandle Then
		; Clear insert mark
		_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, -1, True)
		; Reset highlight to original items in Src ListView
		For $i = 0 To $iMultipleItems
			_GUIListViewEx_Highlight($hGLVEx_TgtHandle, $cGLVEx_TgtID, $iGLVEx_DraggedIndex + $i)
		Next
		; Delete copied arrays
		$aGLVEx_SrcArray = 0
		$aGLVEx_TgtArray = 0
		Return
	EndIf

	; Clear insert mark
	_GUICtrlListView_SetInsertMark($hGLVEx_TgtHandle, -1, True)

	; Clear drag image
	If $hGLVEx_DraggedImage Then
		_GUIImageList_DragLeave($hGLVEx_SrcHandle)
		_GUIImageList_EndDrag()
		_GUIImageList_Destroy($hGLVEx_DraggedImage)
		$hGLVEx_DraggedImage = 0
	EndIf

	; Dropping within same ListView
	If $hGLVEx_SrcHandle = $hGLVEx_TgtHandle Then
		; Determine position to insert
		If $fGLVEx_BarUnder Then
			If $iGLVEx_DraggedIndex > $iGLVEx_InsertIndex Then $iGLVEx_InsertIndex += 1
		Else
			If $iGLVEx_DraggedIndex < $iGLVEx_InsertIndex Then $iGLVEx_InsertIndex -= 1
		EndIf

		; Check not dropping on dragged item(s)
		Switch $iGLVEx_InsertIndex
			Case $iGLVEx_DraggedIndex To $iGLVEx_DraggedIndex + $iMultipleItems
				; Reset highlight to original items
				For $i = 0 To $iMultipleItems
					_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVEx_DraggedIndex + $i)
				Next
				; Delete copied arrays
				$aGLVEx_SrcArray = 0
				$aGLVEx_TgtArray = 0
				Return
		EndSwitch

		; Create Local array for checkboxes (if no checkboxes makes no difference)
		Local $aCheck_Array[UBound($aGLVEx_SrcArray)]
		For $i = 1 To UBound($aCheck_Array) - 1
			$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $i - 1)
		Next

		; Create Local array for dragged items checkbox state
		Local $aCheckDrag_Array[$iMultipleItems + 1]

		; Amend arrays
		; Get data from dragged element(s)
		If $iMultipleItems Then
			; Multiple dragged elements
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
			; Single dragged element
			Local $aInsertData[1]
			Local $aItemData[UBound($aGLVEx_SrcArray, 2)]
			For $i = 0 To UBound($aGLVEx_SrcArray, 2) - 1
				$aItemData[$i] = $aGLVEx_SrcArray[$iGLVEx_DraggedIndex + 1][$i]
			Next
			$aInsertData[0] = $aItemData
			$aCheckDrag_Array[0] = _GUICtrlListView_GetItemChecked($hGLVEx_SrcHandle, $iGLVEx_DraggedIndex)
		EndIf

		; Delete dragged element(s) from arrays
		For $i = 0 To $iMultipleItems
			_GUIListViewEx_Array_Delete($aGLVEx_SrcArray, $iGLVEx_DraggedIndex + 1)
			_GUIListViewEx_Array_Delete($aCheck_Array, $iGLVEx_DraggedIndex + 1)
		Next

		; Amend insert positon for multiple items deleted above
		If $iGLVEx_DraggedIndex < $iGLVEx_InsertIndex Then
			$iGLVEx_InsertIndex -= $iMultipleItems
		EndIf

		; Re-insert dragged element(s) into array
		For $i = $iMultipleItems To 0 Step -1
			_GUIListViewEx_Array_Insert($aGLVEx_SrcArray, $iGLVEx_InsertIndex + 1, $aInsertData[$i])
			_GUIListViewEx_Array_Insert($aCheck_Array, $iGLVEx_InsertIndex + 1, $aCheckDrag_Array[$i])
		Next

		; Rewrite ListView to match array
		_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aCheck_Array, $iGLVEx_SrcIndex)

		; Set highlight to inserted item(s)
		For $i = 0 To $iMultipleItems
			_GUIListViewEx_Highlight($hGLVEx_SrcHandle, $cGLVEx_SrcID, $iGLVEx_InsertIndex + $i)
		Next

		; Store amended array
		$aGLVEx_Data[$aGLVEx_Data[0][1]][2] = $aGLVEx_SrcArray

		; Find the new currently playing event and put the arrow next to it
		$currentPlayingEvent = _ArraySearch($aGLVEx_SrcArray, $currentPlayingEventPos, Default, Default, Default, Default, Default, 0) - 1
		_GUICtrlListView_SetItemText($eventList, $currentPlayingEvent, "▶", 0) ; tell the event list that the event is now playing in its new place

		; Delete copied arrays
		$aGLVEx_SrcArray = 0
		$aGLVEx_TgtArray = 0

		; ======================================================
		; = NEW LOCATION FUNCTION                              =
		; ======================================================

	Else ; Dropping in another ListView

		; Determine position to insert
		If $fGLVEx_BarUnder Then
			$iGLVEx_InsertIndex += 1
		EndIf

		; Amend array
		; Get data from dragged element(s)
		If $iMultipleItems Then
			; Multiple dragged elements
			Local $aInsertData[$iMultipleItems + 1]
			For $i = 0 To $iMultipleItems
				Local $aItemData[UBound($aGLVEx_SrcArray, 2)]
				For $j = 0 To UBound($aGLVEx_SrcArray, 2) - 1
					$aItemData[$j] = $aGLVEx_SrcArray[$iGLVEx_DraggedIndex + 1 + $i][$j]
				Next
				$aInsertData[$i] = $aItemData
			Next
		Else
			; Single dragged element
			Local $aInsertData[1]
			Local $aItemData[UBound($aGLVEx_SrcArray, 2)]
			For $i = 0 To UBound($aGLVEx_SrcArray, 2) - 1
				$aItemData[$i] = $aGLVEx_SrcArray[$iGLVEx_DraggedIndex + 1][$i]
			Next
			$aInsertData[0] = $aItemData
		EndIf

		; Delete dragged element(s) from source array
		If Not BitAnd($aGLVEx_Data[$iGLVEx_SrcIndex][12], 4) Then
			For $i = 0 To $iMultipleItems
				_GUIListViewEx_Array_Delete($aGLVEx_SrcArray, $iGLVEx_DraggedIndex + 1)
			Next
		EndIf
		; Check if insert index is valid
		If $iGLVEx_InsertIndex  < 0 Then
			$iGLVEx_InsertIndex = _GUICtrlListView_GetItemCount($hGLVEx_TgtHandle)
		EndIf
		; Insert dragged element(s) into target array
		For $i = $iMultipleItems To 0 Step -1
			_GUIListViewEx_Array_Insert($aGLVEx_TgtArray, $iGLVEx_InsertIndex + 1, $aInsertData[$i])
			;$aGLVEx_TgtArray[0][0] += 1
		Next

		; Rewrite ListViews to match arrays
		_GUIListViewEx_ReWriteLV($hGLVEx_SrcHandle, $aGLVEx_SrcArray, $aGLVEx_SrcArray, $iGLVEx_SrcIndex, False)
		_GUIListViewEx_ReWriteLV($hGLVEx_TgtHandle, $aGLVEx_TgtArray, $aGLVEx_TgtArray, $iGLVEx_TgtIndex, False)
		; Note no checkbox array needed ListViews with them are not interdraggable, so repass normal array and set final parameter

		; Set highlight to inserted item(s)
		_GUIListViewEx_SetActive($iGLVEx_TgtIndex)
		For $i = 0 To $iMultipleItems
			_GUIListViewEx_Highlight($hGLVEx_TgtHandle, $cGLVEx_TgtID, $iGLVEx_InsertIndex + $i)
		Next

		; Store amended arrays
		$aGLVEx_Data[$iGLVEx_SrcIndex][2] = $aGLVEx_SrcArray
		$aGLVEx_Data[$iGLVEx_TgtIndex][2] = $aGLVEx_TgtArray

	EndIf

	; Delete copied arrays
	$aGLVEx_SrcArray = 0
	$aGLVEx_TgtArray = 0

EndFunc   ;==>_GUIListViewEx_WM_LBUTTONUP_Handler

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_ExpandCols
; Description ...: Expands column ranges to list each column separately
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_ExpandCols($sCols)

	Local $iNumber

	; Strip any whitespace
	$sCols = StringStripWS($sCols, 8)
	; Check if "all cols"
	If $sCols <> "*" Then
		; Check if ranges to be expanded
		If StringInStr($sCols, "-") Then
			; Parse string
			Local $aSplit_1, $aSplit_2
			; Split on ";"
			$aSplit_1 = StringSplit($sCols, ";")
			$sCols = ""
			; Check each element
			For $i = 1 To $aSplit_1[0]
				; Try and split on "-"
				$aSplit_2 = StringSplit($aSplit_1[$i], "-")
				; Add first value in all cases
				$sCols &= $aSplit_2[1] & ";"
				; If a valid range and limit values are in ascending order
				If ($aSplit_2[0]) > 1 And (Number($aSplit_2[2]) > Number($aSplit_2[1])) Then
					; Add the full range
					$iNumber = $aSplit_2[1]
					Do
						$iNumber += 1
						$sCols &= $iNumber & ";"
					Until $iNumber = $aSplit_2[2]
				EndIf
			Next
		EndIf
	EndIf
	; Return expanded string
	Return $sCols

EndFunc   ;==>_GUIListViewEx_ExpandCols

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_HighLight
; Description ...: Highlights first item and ensures visible, second item has highlight removed
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Highlight($hLVHandle, $cLV_CID, $iIndexA, $iIndexB = -1)

	; Check if Native or UDF and set focus
	If $cLV_CID Then
		GUICtrlSetState($cLV_CID, 256) ; $GUI_FOCUS
	Else
		_WinAPI_SetFocus($hLVHandle)
	EndIf
	; Cancel highlight on other item - needed for multisel listviews
	If $iIndexB <> -1 Then _GUICtrlListView_SetItemSelected($hLVHandle, $iIndexB, False)
	; Set highlight to inserted item and ensure in view
	_GUICtrlListView_SetItemState($hLVHandle, $iIndexA, $LVIS_SELECTED, $LVIS_SELECTED)
	_GUICtrlListView_EnsureVisible($hLVHandle, $iIndexA)

EndFunc   ;==>_GUIListViewEx_Highlight

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_GetLVFont
; Description ...: Gets font details for ListView to be edited
; Author ........: Based on _GUICtrlGetFont by KaFu & Prog@ndy
; Modified ......: Melba23
; ===============================================================================================================================
Func _GUIListViewEx_GetLVFont($hLVHandle)

	Local $iError = 0, $aFontDetails[2] = [Default, Default]

	; Check handle
	If Not IsHWnd($hLVHandle) Then
		$hLVHandle = GUICtrlGetHandle($hLVHandle)
	EndIf
	If Not IsHWnd($hLVHandle) Then
		$iError = 1
	Else
		Local $hFONT = _SendMessage($hLVHandle, 0x0031) ; WM_GETFONT
		If Not $hFONT Then
			$iError = 2
		Else
			Local $hDC = _WinAPI_GetDC($hLVHandle)
			Local $hObjOrg = _WinAPI_SelectObject($hDC, $hFONT)
			Local $tFONT = DllStructCreate($tagLOGFONT)
			Local $aRet = DllCall('gdi32.dll', 'int', 'GetObjectW', 'ptr', $hFONT, 'int', DllStructGetSize($tFONT), 'ptr', DllStructGetPtr($tFONT))
			If @error Or $aRet[0] = 0 Then
				$iError = 3
			Else
				; Get font size
				$aFontDetails[0] = Round((-1 * DllStructGetData($tFONT, 'Height')) * 72 / _WinAPI_GetDeviceCaps($hDC, 90), 1) ; $LOGPIXELSY = 90 => DPI aware
				; Now look for font name
				$aRet = DllCall("gdi32.dll", "int", "GetTextFaceW", "handle", $hDC, "int", 0, "ptr", 0)
				Local $iCount = $aRet[0]
				Local $tBuffer = DllStructCreate("wchar[" & $iCount & "]")
				Local $pBuffer = DllStructGetPtr($tBuffer)
				$aRet = DllCall("Gdi32.dll", "int", "GetTextFaceW", "handle", $hDC, "int", $iCount, "ptr", $pBuffer)
				If @error Then
					$iError = 4
				Else
					$aFontDetails[1] = DllStructGetData($tBuffer, 1) ; FontFacename
				EndIf
			EndIf
			_WinAPI_SelectObject($hDC, $hObjOrg)
			_WinAPI_ReleaseDC($hLVHandle, $hDC)
		EndIf
	EndIf

	Return SetError($iError, 0, $aFontDetails)

EndFunc   ;==>_GUIListViewEx_GetLVFont

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_EditProcess
; Description ...: Runs ListView editing process
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_EditProcess($iLV_Index, $aLocation, $sCols, $iDelta_X, $iDelta_Y, $iEditMode)

	Local $hTemp_Combo = 9999, $hTemp_Edit = 9999, $hTemp_List = 9999, $iKey_Code, $iCombo_State, $aSplit, $sInsert, $fClick_Move = False, $fCursor_Move = True

	; Unselect item
	_GUICtrlListView_SetItemSelected($hGLVEx_SrcHandle, $aLocation[0], False)

	; Declare return array - note second dimension [3] but only [2] returned if successful
	Local $aEdited[1][3] = [[0]] ; [Number of edited items][blank][blank]

	; Load active ListView details
	$hGLVEx_SrcHandle = $aGLVEx_Data[$iLV_Index][0]
	$cGLVEx_SrcID = $aGLVEx_Data[$iLV_Index][1]

	; Store handle of ListView concerned
	$hGLVEx_Editing = $hGLVEx_SrcHandle
	Local $cEditingID = $cGLVEx_SrcID

	; Valid keys to action
	; ENTER, ESC
	Local $aKeys_Combo[2] = [0x0D, 0x1B]
	; TAB, ENTER, ESC, up/down arrows
	Local $aKeys_Edit[5] = [0x09, 0x0D, 0x1B, 0x26, 0x28]
	; Left/right arrows
	Local $aKeys_LR[2] = [0x25, 0x27]

	; Set Reset-on-ESC mode
	Local $fReset_Edits = False
	If $iEditMode < 0 Then
		$fReset_Edits = True
		$iEditMode = Abs($iEditMode)
	EndIf

	; Set row/col edit mode - default single edit
	Local $iEditRow = 0, $iEditCol = 0
	If $iEditMode Then
		; Separate axis settings
		$aSplit = StringSplit($iEditMode, "")
		$iEditRow = $aSplit[1]
		$iEditCol = $aSplit[2]
	EndIf

	; Check if edit to move on click
	If StringInStr($aGLVEx_Data[$iLV_Index][7], ";#") Then
		$fClick_Move = True
	EndIf

	; Check if cursor to move in edit
	If $aGLVEx_Data[$iLV_Index][9] Then
		$fCursor_Move = False
	EndIf

	; Check if combo
	Local $fCombo = False
	Local $fRead_Only = False
	If IsArray($aGLVEx_Data[$iLV_Index][11]) Then
		; Extract combo data for ListView
		Local $aComboData_Array = $aGLVEx_Data[$iLV_Index][11]
		; And then for this column
		Local $sCombo_Data = $aComboData_Array[$aLocation[1]]
		If $sCombo_Data Then
			$fCombo = True
			If StringLeft($sCombo_Data, 1) = "#" Then
				$fRead_Only = True
				$sCombo_Data = StringTrimLeft($sCombo_Data, 1)
			EndIf
		Else
			; No combo data available
			Return
		EndIf
	EndIf

	Local $tLVPos = DllStructCreate("struct;long X;long Y;endstruct")
	; Get position of ListView within GUI client area
	_GUIListViewEx_GetLVCoords($hGLVEx_Editing, $tLVPos)
	; Get ListView client area to allow for scrollbars
	Local $aLVClient = WinGetClientSize($hGLVEx_Editing)
	; Get ListView font details
	Local $aLV_FontDetails = _GUIListViewEx_GetLVFont($hGLVEx_Editing)
	; Disable ListView
	WinSetState($hGLVEx_Editing, "", @SW_DISABLE)

	Local $fExitLoop, $tMouseClick = DllStructCreate($tagPOINT)

	; Start the edit loop
	While 1
		; Read current text of clicked item
		Local $sItemOrgText = _GUICtrlListView_GetItemText($hGLVEx_Editing, $aLocation[0], $aLocation[1])
		; Ensure item is visible and get required edit coords
		Local $aEdit_Pos = _GUIListViewEx_EditCoords($hGLVEx_Editing, $cEditingID, $aLocation, $tLVPos, $aLVClient[0] - 5, $iDelta_X, $iDelta_Y)

		If $fCombo Then
			; Create temporary combo - get handle, set font size, give keyboard focus
			If $fRead_Only Then
				$cGLVEx_EditID = GUICtrlCreateCombo("", $aEdit_Pos[0], $aEdit_Pos[1], $aEdit_Pos[2], $aEdit_Pos[3], 0x03) ; $CBS_DROPDOWNLIST
			Else
				$cGLVEx_EditID = GUICtrlCreateCombo("", $aEdit_Pos[0], $aEdit_Pos[1], $aEdit_Pos[2], $aEdit_Pos[3], 0x42) ; $CBS_DROPDOWN, $CBS_AUTOHSCROLL
			EndIf
			GUICtrlSetFont($cGLVEx_EditID, $aLV_FontDetails[0], Default, Default, $aLV_FontDetails[1])
			GUICtrlSetData($cGLVEx_EditID, $sCombo_Data, $sItemOrgText)
			Local $tInfo = DllStructCreate("dword Size;struct;long EditLeft;long EditTop;long EditRight;long EditBottom;endstruct;" & _
			"struct;long BtnLeft;long BtnTop;long BtnRight;long BtnBottom;endstruct;dword BtnState;hwnd hCombo;hwnd hEdit;hwnd hList")
			Local $iInfo = DllStructGetSize($tInfo)
			DllStructSetData($tInfo, "Size", $iInfo)
			Local $hCombo = GUICtrlGetHandle($cGLVEx_EditID)
			_SendMessage($hCombo, 0x164, 0, $tInfo, 0, "wparam", "struct*") ; $CB_GETCOMBOBOXINFO
			$hTemp_Edit = DllStructGetData($tInfo, "hEdit")
			$hTemp_List = DllStructGetData($tInfo, "hList")
			$hTemp_Combo = DllStructGetData($tInfo, "hCombo")
			Local $aMPos = MouseGetPos()
			MouseMove($aMPos[0], $aMPos[1] + 20, 0)
			Sleep(10)
			MouseMove($aMPos[0], $aMPos[1], 0)
			_WinAPI_SetFocus($hTemp_Edit)

		Else
			; Create temporary edit - get handle, set font size, give keyboard focus and select all text
			$cGLVEx_EditID = GUICtrlCreateEdit($sItemOrgText, $aEdit_Pos[0], $aEdit_Pos[1], $aEdit_Pos[2], $aEdit_Pos[3], 128) ; $ES_AUTOHSCROLL
			$hTemp_Edit = GUICtrlGetHandle($cGLVEx_EditID)
			GUICtrlSetFont($cGLVEx_EditID, $aLV_FontDetails[0], Default, Default, $aLV_FontDetails[1])
			GUICtrlSetState($cGLVEx_EditID, 256) ; $GUI_FOCUS
			GUICtrlSendMsg($cGLVEx_EditID, 0xB1, 0, -1) ; $EM_SETSEL
		EndIf

		; Copy array for manipulation
		$aGLVEx_SrcArray = $aGLVEx_Data[$iLV_Index][2]
		; Clear key code flag
		$iKey_Code = 0
		; Clear combo down/up flag
		$iCombo_State = False
		; Wait for a key press or combo down/up
		While 1
			; Clear flag
			$fExitLoop = False

			; Mouse pressed
			If _WinAPI_GetAsyncKeyState(0x01) Then
				; Look for clicks outside edit/combo control
				DllStructSetData($tMouseClick, "x", MouseGetPos(0))
				DllStructSetData($tMouseClick, "y", MouseGetPos(1))
				Switch _WinAPI_WindowFromPoint($tMouseClick)
					Case $hTemp_Combo, $hTemp_Edit, $hTemp_List
						; Over edit/combo
					Case Else
						$fExitLoop = True
				EndSwitch
			EndIf
			; Exit loop
			If $fExitLoop Then
				If Not $fCombo Then
					; If quitting edit then set appropriate behaviour
					If $fClick_Move Then
						$iKey_Code = 0x02 ; Confirm edit and end process
					Else
						$iKey_Code = 0x01 ; Abandon editing
					EndIf
				EndIf
				ExitLoop
			EndIf

			If $fCombo Then
				; Check for dropdown open and close
				Switch _SendMessage($hCombo, 0x157) ; $CB_GETDROPPEDSTATE
					Case 0
						; If opened and closed act as if Enter pressed
						If $iCombo_State = True Then
							$iKey_Code = 0x0D
							ExitLoop
						EndIf
					Case 1
						; Set flag if opened
						If Not $iCombo_State Then
							$iCombo_State = True
						EndIf
				EndSwitch
				; Check for valid key pressed
				For $i = 0 To 1
					If _WinAPI_GetAsyncKeyState($aKeys_Combo[$i]) Then
						; Set key pressed flag
						$iKey_Code = $aKeys_Combo[$i]
						ExitLoop 2
					EndIf
				Next
			Else
				; Check for valid key pressed
				For $i = 0 To 4
					If _WinAPI_GetAsyncKeyState($aKeys_Edit[$i]) Then
						; Set key pressed flag
						$iKey_Code = $aKeys_Edit[$i]
						ExitLoop 2
					EndIf
				Next
				; Check for left/right keys
				For $i = 0 To 1
					If _WinAPI_GetAsyncKeyState($aKeys_LR[$i]) Then
						; Check if left/right move edit
						If $fCursor_Move Then
							; Set key pressed flag
							$iKey_Code = $aKeys_LR[$i]
							ExitLoop 2
						Else
							; See if Ctrl pressed
							If _WinAPI_GetAsyncKeyState(0x11) Then
								; Set key pressed flag
								$iKey_Code = $aKeys_LR[$i]
								ExitLoop 2
							EndIf
						EndIf
					EndIf
				Next
			EndIf

			; Temp input lost focus
			If _WinAPI_GetFocus() <> $hTemp_Edit Then
				ExitLoop
			EndIf

			; Save CPU
			Sleep(10)
		WEnd
		; Check if edit to be confirmed
		Switch $iKey_Code
			Case 0x02, 0x09, 0x0D, 0x25, 0x26, 0x27, 0x28 ; Mouse (with Click=Move), TAB, ENTER, arrow keys
				; Read edit content
				Local $sItemNewText = GUICtrlRead($cGLVEx_EditID)

				; Check replacement required
				If $sItemNewText <> $sItemOrgText Then
					; Amend item text
					_GUICtrlListView_SetItemText($hGLVEx_Editing, $aLocation[0], $sItemNewText, $aLocation[1])
					; Amend array element
					$aGLVEx_SrcArray[$aLocation[0] + 1][$aLocation[1]] = $sItemNewText
					; Store amended array
					$aGLVEx_Data[$iLV_Index][2] = $aGLVEx_SrcArray
					; Add item data to return array
					$aEdited[0][0] += 1
					ReDim $aEdited[$aEdited[0][0] + 1][3]
					; Save location & original content
					$aEdited[$aEdited[0][0]][0] = $aLocation[0]
					$aEdited[$aEdited[0][0]][1] = $aLocation[1]
					$aEdited[$aEdited[0][0]][2] = $sItemOrgText
				EndIf
		EndSwitch
		; Delete temporary edit and set place holder
		GUICtrlDelete($cGLVEx_EditID)
		$cGLVEx_EditID = 9999
		; Check edit mode
		If $iEditMode = 0 Then ; Single edit
			; Exit edit process
			ExitLoop
		Else
			Switch $iKey_Code
				Case 0x00, 0x01, 0x02, 0x0D ; Edit lost focus, mouse button outside edit, ENTER pressed
					; Wait until key/button no longer pressed
					While _WinAPI_GetAsyncKeyState($iKey_Code)
						Sleep(10)
					WEnd
					; Exit Edit process
					ExitLoop
				Case 0x1B ; ESC pressed
					; Check Reset-on-ESC mode
					If $fReset_Edits Then
						; Reset previous confirmed edits starting with most recent
						For $i = $aEdited[0][0] To 1 Step -1
							_GUICtrlListView_SetItemText($hGLVEx_Editing, $aEdited[$i][0], $aEdited[$i][2], $aEdited[$i][1])
							Switch UBound($aGLVEx_SrcArray, 0)
								Case 1
									$aSplit = StringSplit($aGLVEx_SrcArray[$aEdited[$i][0] + 1], $sGLVEx_SepChar)
									$aSplit[$aEdited[$i][1] + 1] = $aEdited[$i][2]
									$sInsert = ""
									For $j = 1 To $aSplit[0]
										$sInsert &= $aSplit[$j] & $sGLVEx_SepChar
									Next
									$aGLVEx_SrcArray[$aEdited[$i][0] + 1] = StringTrimRight($sInsert, 1)
								Case 2
									$aGLVEx_SrcArray[$aEdited[$i][0] + 1][$aEdited[$i][1]] = $aEdited[$i][2]
							EndSwitch
						Next
						; Store amended array
						$aGLVEx_Data[$iLV_Index][2] = $aGLVEx_SrcArray
						; Empty return array as no edits made
						ReDim $aEdited[1][2]
						$aEdited[0][0] = 0
					EndIf
					; Wait until key no longer pressed
					While _WinAPI_GetAsyncKeyState(0x1B)
						Sleep(10)
					WEnd
					; Exit Edit process
					ExitLoop
				Case 0x09, 0x27 ; TAB or right arrow
					While 1
						; Set next column
						$aLocation[1] += 1
						; Check column exists
						If $aLocation[1] = _GUICtrlListView_GetColumnCount($hGLVEx_Editing) Then
							; Does not exist so check required action
							Switch $iEditCol
								Case 1
									; Exit edit process
									ExitLoop 2
								Case 2
									; Stay on same location
									$aLocation[1] -= 1
									ExitLoop
								Case 3
									; Loop
									$aLocation[1] = 0
							EndSwitch
						EndIf
						; Check this column is editable
						If Not StringInStr($sCols, "*") Then
							If StringInStr(";" & $sCols, ";" & $aLocation[1]) Then
								; Editable column
								ExitLoop
							EndIf
						Else
							; Editable column
							ExitLoop
						EndIf
					WEnd
				Case 0x25 ; Left arrow
					While 1
						$aLocation[1] -= 1
						If $aLocation[1] < 0 Then
							Switch $iEditCol
								Case 1
									ExitLoop 2
								Case 2
									$aLocation[1] += 1
									ExitLoop
								Case 3
									$aLocation[1] = _GUICtrlListView_GetColumnCount($hGLVEx_Editing) - 1
							EndSwitch
						EndIf
						If Not StringInStr($sCols, "*") Then
							If StringInStr(";" & $sCols, ";" & $aLocation[1]) Then
								ExitLoop
							EndIf
						Else
							ExitLoop
						EndIf
					WEnd
				Case 0x28 ; Down key
					While 1
						; Set next row
						$aLocation[0] += 1
						; Check column exists
						If $aLocation[0] = _GUICtrlListView_GetItemCount($hGLVEx_Editing) Then
							; Does not exist so check required action
							Switch $iEditRow
								Case 1
									; Exit edit process
									ExitLoop 2
								Case 2
									; Stay on same location
									$aLocation[0] -= 1
									ExitLoop
								Case 3
									; Loop
									$aLocation[0] = -1
							EndSwitch
						Else
							; All rows editable
							ExitLoop
						EndIf
					WEnd
				Case 0x26 ; Up key
					While 1
						$aLocation[0] -= 1
						If $aLocation[0] < 0 Then
							Switch $iEditRow
								Case 1
									ExitLoop 2
								Case 2
									$aLocation[0] += 1
									ExitLoop
								Case 3
									$aLocation[0] = _GUICtrlListView_GetItemCount($hGLVEx_Editing)
							EndSwitch
						Else
							ExitLoop
						EndIf
					WEnd
			EndSwitch
			; Wait until key no longer pressed
			While _WinAPI_GetAsyncKeyState($iKey_Code)
				Sleep(10)
			WEnd
			; Continue edit loop on next item
		EndIf
	WEnd
	; Delete copied array
	$aGLVEx_SrcArray = 0
	; Remove original text column from return array
	ReDim $aEdited[$aEdited[0][0] + 1][2]
	; Reenable ListView
	WinSetState($hGLVEx_Editing, "", @SW_ENABLE)
	; Reselect item
	_GUICtrlListView_SetItemState($hGLVEx_SrcHandle, $aLocation[0], $LVIS_SELECTED, $LVIS_SELECTED)

	Return $aEdited

EndFunc   ;==>_GUIListViewEx_EditProcess

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_EditCoords
; Description ...: Ensures item in view then locates and sizes edit control
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_EditCoords($hLV_Handle, $cLV_CID, $aLocation, $tLVPos, $iLVWidth, $iDelta_X, $iDelta_Y)

	; Declare array to hold return data
	Local $aEdit_Data[4]
	; Ensure row visible
	_GUICtrlListView_EnsureVisible($hLV_Handle, $aLocation[0])
	; Get size of item
	Local $aRect = _GUICtrlListView_GetSubItemRect($hLV_Handle, $aLocation[0], $aLocation[1])
	; Set required edit height
	$aEdit_Data[3] = $aRect[3] - $aRect[1] + 1
	; Set required edit width
	$aEdit_Data[2] = _GUICtrlListView_GetColumnWidth($hLV_Handle, $aLocation[1])
	; Ensure column visible - scroll to left edge if all column not in view
	If $aRect[0] < 0 Or $aRect[2] > $iLVWidth Then
		_GUICtrlListView_Scroll($hLV_Handle, $aRect[0], 0)
		; Redetermine item coords
		$aRect = _GUICtrlListView_GetSubItemRect($hLV_Handle, $aLocation[0], $aLocation[1])
		; Check available column width and limit if required
		If $aRect[0] + $aEdit_Data[2] > $iLVWidth Then
			$aEdit_Data[2] = $iLVWidth - $aRect[0]
		EndIf
	EndIf
	; Adjust Y coord if Native ListView
	If $cLV_CID Then
		$iDelta_Y += 1
	EndIf
	; Determine screen coords for edit control
	$aEdit_Data[0] = DllStructGetData($tLVPos, "X") + $aRect[0] + $iDelta_X + 2
	$aEdit_Data[1] = DllStructGetData($tLVPos, "Y") + $aRect[1] + $iDelta_Y

	; Return edit data
	Return $aEdit_Data

EndFunc   ;==>_GUIListViewEx_EditCoords

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_ReWriteLV
; Description ...: Deletes all ListView content and refills to match array
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_ReWriteLV($hLVHandle, ByRef $aLV_Array, ByRef $aCheck_Array, $iLV_Index, $fCheckBox = True)

	Local $iVertScroll

	; Get item depth
	If $aGLVEx_Data[$iLV_Index][10] Then
		$iVertScroll = $aGLVEx_Data[$iLV_Index][10]
	Else
		; If not already set then ListView was empty so determine
		Local $aRect = _GUICtrlListView_GetItemRect($hLVHandle, 0)
		$aGLVEx_Data[$iLV_Index][10] = $aRect[3] - $aRect[1]
		; If still empty set a placeholder for this instance
		If $iVertScroll = 0 Then
			; And make sure scroll is likely to be enough to get next item into view
			$iVertScroll = 20
		EndIf
	EndIf

	; Get top item
	Local $iTopIndex_Org = _GUICtrlListView_GetTopIndex($hLVHandle)

	_GUICtrlListView_BeginUpdate($hLVHandle)

	; Empty ListView
	_GUICtrlListView_DeleteAllItems($hLVHandle)
	; Reset begin update
	_GUICtrlListView_BeginUpdate($hLVHandle)
	; Remove count line from stored array
	Local $aArray = $aLV_Array
	_ArrayDelete($aArray, 0)
	; And add to ListView
	_GUICtrlListView_AddArray($hLVHandle, $aArray)

	; Reset checkbox if required
	For $i = 1 To $aLV_Array[0][0]
		If $fCheckBox And $aCheck_Array[$i] Then
			_GUICtrlListView_SetItemChecked($hLVHandle, $i - 1)
		EndIf
	Next

	; Now scroll to same place or max possible
	Local $iTopIndex_Curr = _GUICtrlListView_GetTopIndex($hLVHandle)
	While $iTopIndex_Curr < $iTopIndex_Org
		_GUICtrlListView_Scroll($hLVHandle, 0, $iVertScroll)
		; If scroll had no effect then max scroll up
		If _GUICtrlListView_GetTopIndex($hLVHandle) = $iTopIndex_Curr Then
			ExitLoop
		Else
			; Reset current top index
			$iTopIndex_Curr = _GUICtrlListView_GetTopIndex($hLVHandle)
		EndIf
	WEnd

	_GUICtrlListView_EndUpdate($hLVHandle)
	setModified() ; set isModified to 1 so we know there's a change - ZAG addition
EndFunc   ;==>_GUIListViewEx_ReWriteLV

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_GetLVCoords
; Description ...: Gets screen coords for ListView
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_GetLVCoords($hLV_Handle, ByRef $tLVPos)

	; Get handle of ListView parent
	Local $aWnd = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $hLV_Handle)
	Local $hWnd = $aWnd[0]
	; Get position of ListView within GUI client area
	Local $aLVPos = WinGetPos($hLV_Handle)
	DllStructSetData($tLVPos, "X", $aLVPos[0])
	DllStructSetData($tLVPos, "Y", $aLVPos[1])
	_WinAPI_ScreenToClient($hWnd, $tLVPos)

EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_GetCursorWnd
; Description ...: Gets handle of control under the mouse cursor
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_GetCursorWnd()

	Local $tMPos = DllStructCreate("struct;long X;long Y;endstruct")
	DllStructSetData($tMPos, "X", MouseGetPos(0))
	DllStructSetData($tMPos, "Y", MouseGetPos(1))
	Return _WinAPI_WindowFromPoint($tMPos)

EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Add
; Description ...: Adds a specified value at the end of an existing 1D or 2D array.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Add(ByRef $avArray, $vAdd, $fMultiRow = False)

	; Get size of the Array to modify
	Local $iIndex_Max = UBound($avArray)
	Local $iAdd_Dim

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1 ; Checkbox array

			If UBound($vAdd, 0) = 2 Or $fMultiRow Then ; 2D or 1D as rows
				$iAdd_Dim = UBound($vAdd, 1)
				ReDim $avArray[$iIndex_Max + $iAdd_Dim]
			Else ; 1D as columns
				ReDim $avArray[$iIndex_Max + 1]
			EndIf

		Case 2 ; Data array

			; Get column count of data array
			Local $iDim2 = UBound($avArray, 2)

			If UBound($vAdd, 0) = 2 Then ; 2D add
				; Redim the Array
				$iAdd_Dim = UBound($vAdd, 1)
				ReDim $avArray[$iIndex_Max + $iAdd_Dim][$iDim2]
				$avArray[0][0] += $iAdd_Dim
				; Add new elements
				Local $iAdd_Max = UBound($vAdd, 2)
				For $i = 0 To $iAdd_Dim - 1
					For $j = 0 To $iDim2 -1
						; If Insert array is too small to fill Array then continue with blanks
						If $j > $iAdd_Max - 1 Then
							$avArray[$iIndex_Max + $i][$j] = ""
						Else
							$avArray[$iIndex_Max + $i][$j] = $vAdd[$i][$j]
						EndIf
					Next
				Next

			ElseIf $fMultiRow Then ; 1D add as rows
				; Redim the Array
				$iAdd_Dim = UBound($vAdd, 1)
				ReDim $avArray[$iIndex_Max + $iAdd_Dim][$iDim2]
				$avArray[0][0] += $iAdd_Dim
				; Add new elements
				For $i = 0 To $iAdd_Dim - 1
					$avArray[$iIndex_Max + $i][0] = $vAdd[$i]
				Next

			Else ; 1D add as columns
				; Redim the Array
				ReDim $avArray[$iIndex_Max + 1][$iDim2]
				$avArray[0][0] += 1
				; Add new elements
				If IsArray($vAdd) Then
					; Get size of Insert array
					Local $vAdd_Max = UBound($vAdd)
					For $j = 0 To $iDim2 - 1
						; If Insert array is too small to fill Array then continue with blanks
						If $j > $vAdd_Max - 1 Then
							$avArray[$iIndex_Max][$j] = ""
						Else
							$avArray[$iIndex_Max][$j] = $vAdd[$j]
						EndIf
					Next
				Else
					; Fill Array with variable
					For $j = 0 To $iDim2 - 1
						$avArray[$iIndex_Max][$j] = $vAdd
					Next
				EndIf
			EndIf

	EndSwitch

EndFunc   ;==>_GUIListViewEx_Array_Add

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Insert
; Description ...: Adds a value at the specified index of a 1D or 2D array.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Insert(ByRef $avArray, $iIndex, $vInsert, $fMultiRow = False)

	; Get size of the Array to modify
	Local $iIndex_Max = UBound($avArray)
	Local $iInsert_Dim

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1 ; Checkbox array

			If UBound($vInsert, 0) = 2 Or $fMultiRow Then ; 2D or 1D as rows
				; Resize array
				$iInsert_Dim = UBound($vInsert, 1)
				ReDim $avArray[$iIndex_Max + $iInsert_Dim]

				; Move down all elements below the new index
				For $i = $iIndex_Max + $iInsert_Dim - 1 To $iIndex + 1 Step -1
					$avArray[$i] = $avArray[$i - 1]
				Next

			Else ; 1D as columns
				; Resize array
				ReDim $avArray[$iIndex_Max + 1]

				; Move down all elements below the new index
				For $i = $iIndex_Max To $iIndex + 1 Step -1
					$avArray[$i] = $avArray[$i - 1]
				Next

			EndIf

		Case 2 ; Data array

			; If at end of array
			If $iIndex > $iIndex_Max - 1 Then
				_GUIListViewEx_Array_Add($avArray, $vInsert, $fMultiRow)
				Return
			EndIf

			; Get column count of data array
			Local $iDim2 = UBound($avArray, 2)

			If UBound($vInsert, 0) = 2 Then ; 2D insert
				; Redim the Array
				$iInsert_Dim = UBound($vInsert, 1)
				ReDim $avArray[$iIndex_Max + $iInsert_Dim][$iDim2]
				$avArray[0][0] += $iInsert_Dim

				; Move down all elements below the new index
				For $i = $iIndex_Max + $iInsert_Dim - 1 To $iIndex + $iInsert_Dim Step -1
					For $j = 0 To $iDim2 - 1
						$avArray[$i][$j] = $avArray[$i - $iInsert_Dim][$j]
					Next
				Next

				; Add new elements
				Local $iInsert_Max = UBound($vInsert, 2)
				For $i = 0 To $iInsert_Dim - 1
					For $j = 0 To $iDim2 -1
						; If Insert array is too small to fill Array then continue with blanks
						If $j > $iInsert_Max - 1 Then
							$avArray[$iIndex + $i][$j] = ""
						Else
							$avArray[$iIndex + $i][$j] = $vInsert[$i][$j]
						EndIf
					Next
				Next

			ElseIf $fMultiRow Then ; 1D insert as rows
				; Redim the Array
				$iInsert_Dim = UBound($vInsert, 1)
				ReDim $avArray[$iIndex_Max + $iInsert_Dim][$iDim2]
				$avArray[0][0] += $iInsert_Dim

				; Move down all elements below the new index
				For $i = $iIndex_Max + $iInsert_Dim - 1 To $iIndex + $iInsert_Dim Step -1
					For $j = 0 To $iDim2 - 1
						$avArray[$i][$j] = $avArray[$i - $iInsert_Dim][$j]
					Next
				Next

				; Add new items
				For $i = 0 To $iInsert_Dim - 1
					$avArray[$iIndex + $i][0] = $vInsert[$i]
				Next

			Else ; 1D insert as columns

				; Redim the Array
				ReDim $avArray[$iIndex_Max + 1][$iDim2]
				$avArray[0][0] += 1

				; Move down all elements below the new index
				For $i = $iIndex_Max To $iIndex + 1 Step -1
					For $j = 0 To $iDim2 - 1
						$avArray[$i][$j] = $avArray[$i - 1][$j]
					Next
				Next

				; Insert new elements
				If IsArray($vInsert) Then
					; Get size of Insert array
					Local $vInsert_Max = UBound($vInsert)
					For $j = 0 To $iDim2 - 1
						; If Insert array is too small to fill Array then continue with blanks
						If $j > $vInsert_Max - 1 Then
							$avArray[$iIndex][$j] = ""
						Else
							$avArray[$iIndex][$j] = $vInsert[$j]
						EndIf
					Next
				Else
					; Fill Array with variable
					For $j = 0 To $iDim2 - 1
						$avArray[$iIndex][$j] = $vInsert
					Next
				EndIf
			EndIf

	EndSwitch

EndFunc   ;==>_GUIListViewEx_Array_Insert

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Delete
; Description ...: Deletes a specified index from an existing 1D or 2D array.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Delete(ByRef $avArray, $iIndex, $bDelCount = False)

	; Get size of the Array to modify
	Local $iIndex_Max = UBound($avArray)

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1 ; Checkbox array

			; Move up all elements below the new index
			For $i = $iIndex To $iIndex_Max - 2
				$avArray[$i] = $avArray[$i + 1]
			Next

			; Redim the Array
			ReDim $avArray[$iIndex_Max - 1]

		Case 2 ; Data array

			; Get size of second dimension
			Local $iDim2 = UBound($avArray, 2)

			; Move up all elements below the new index
			For $i = $iIndex To $iIndex_Max - 2
				For $j = 0 To $iDim2 - 1
					$avArray[$i][$j] = $avArray[$i + 1][$j]
				Next
			Next

			; Redim the Array
			ReDim $avArray[$iIndex_Max - 1][$iDim2]
			; If count element not being deleted
			If Not $bDelCount Then
				$avArray[0][0] -= 1
			EndIf

	EndSwitch

EndFunc   ;==>_GUIListViewEx_Array_Delete

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Swap
; Description ...: Swaps specified elements within a 1D or 2D array
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Swap(ByRef $avArray, $iIndex1, $iIndex2)

	Local $vTemp

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1
			; Swap the elements via a temp variable
			$vTemp = $avArray[$iIndex1]
			$avArray[$iIndex1] = $avArray[$iIndex2]
			$avArray[$iIndex2] = $vTemp

		Case 2

			; Get size of second dimension
			Local $iDim2 = UBound($avArray, 2)
			; Swap the elements via a temp variable
			For $i = 0 To $iDim2 - 1
				$vTemp = $avArray[$iIndex1][$i]
				$avArray[$iIndex1][$i] = $avArray[$iIndex2][$i]
				$avArray[$iIndex2][$i] = $vTemp
			Next
	EndSwitch

	Return 0

EndFunc   ;==>_GUIListViewEx_Array_Swap

