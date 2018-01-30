; UDF to use custom colors and fonts in listviews
; https://www.autoitscript.com/forum/index.php?showtopic=181346

#include-once
#include <GuiListView.au3>
#include <FontConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIShellEx.au3>

Global Const $iFontStyleNormal = 0, $iFontStyleBold = 1, $iFontStyleItalic = 2, $iFontStyleUnderline = 3 ; Font style values


; Array to store information about listviews and parent windows
Global $aListViewColorsFontsInfo[100][26], $iListViewColorsFontsInfo = 1, $iListViewColorsFontsInfo_Index = 0 ; Max 99 listviews
; Col  Variable       Description
; ---  -----------    --------------------------------
;  0   $idListView  - Listview control ID
;  1   $hListView   - Listview handle
;  2   $hHeader     - Listview header                  ; Listview header is used to calculate number of columns if $fSelected is set
;  3   $bImages     - Subitem images?                  ; Used to calculate left/top position of subitem label rectangle for selected items
;  4   $bCheckboxes - Checkboxes?                      ; Used to calculate top position of subitem label rectangle for selected items
;  5   $hParent     - Parent window handle
;  6   $hGui        - Main GUI window handle           ; $hGui is the main GUI window handle. Calculated if $fSelected is set.
;  7   $sClassNN    - CLASSNN listview name            ; $hGui and $sClassNN is used to determine whether the listview has focus
;  8   $bNative     - Native listview items?
;  9   $iColumns    - Number of listview columns
; 10   $tLogFont    - LOGFONT data structure
; 11   $hFont       - Default listview font
; 12   $iBackColor  - Default listview back color
; 13   $iForeColor  - Default listview fore color
; 14   $fOptions    - $fColorsFonts flag               ; Colors/fonts options: Item/subitem colors/fonts, column colors/font, alternating colors, colors for selected items, custom default colors/font
; 15   $fSelected   - Flag for selected items          ; Custom colors for selected items in focused and unfocused listview
; 16   $fDefaults   - Custom default colors/font flag  ; Bit 8 is set if custom default colors/font is enabled in ListViewColorsFonts_Init, bits 0-6 tells which of the values in $aDefaults are set
; 17   $aDefaults   - Current default font and colors  ; $aDefaults[7] = [ $hFont, $iBackColor, $iForeColor, $iBackSelect, $iForeSelect, $iBackUnfocus, $iForeUnfocus ]
; 18   $bSubitems   - Info for subitems: true/false?   ; Columns 18 - 25 are related to $aListViewColorsFonts array below
; 19   $aIndex      - Index array for native items
; 20   $iIndex      - Number of used rows in array
; 21   $iMaxIndex   - Max number of rows in array
; 22   $aArray      - Array to store color/font info
; 23   $iArray      - Number of used rows in array
; 24   $iMaxRows    - Max number of rows in array
; 25   $iAddRows    - Rows to add on ReDim


; Arrays to store information about colors/fonts
Global $aListViewColorsFonts, $iListViewColorsFonts, $aListViewColorsFonts_Index, $iListViewColorsFonts_Index                         ; Two arrays per listview
Global $bListViewColorsFonts_Subitems, $iListViewColorsFonts_MaxRows, $iListViewColorsFonts_Index_MaxRows, $bListViewColorsFonts_Save ; Additional variables


; $fColorsFonts = 7 ; Custom colors/fonts for items/subitems <<<<<<<<<<<<<<<<<<<
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Array to store information about listview colors/fonts, one array per listview
;Global $aListViewColorsFonts, $iListViewColorsFonts ; Initially 100 rows, 4 columns
; Column    Description
; --------  -----------
;  0        Status - Value 0:       No colors/fonts
;                    Bit 0 (1) set: Color/font for entire item
;                    Bit 1 (2) set: Colors/fonts for one or more subitems
;  1, 2, 3  Back color, fore color and font for entire listview item        ; Initially 4 columns.
;  4, 5, 6  Back color, fore color and font for subitem 0, first column     ; if colors/fonts are specified for listview subitems,
;  7, 8, 9  Back color, fore color and font for subitem 1, second column    ; 3 * _GUICtrlListView_GetColumnCount columns are added.
; 10,11,12  Back color, fore color and font for subitem 2, third column
; Etc.

; Column index in $aListViewColorsFonts
; -------------------------------------
; Back color: 3 + 3 * $iSubItem + 1 ; $iSubItem is the zero based index of subitems
; Fore color: 3 + 3 * $iSubItem + 2
; Font:       3 + 3 * $iSubItem + 3

; Row index in $aListViewColorsFonts
; ----------------------------------
; ItemParam in the listview is used to store the zero based row index in $aListViewColorsFonts for a given listview item.
;
; For NATIVE listview items created with GUICtrlCreateListViewItem the existing value of ItemParam (control ID) is used as index in
; an intermediate array $aListViewColorsFonts_Index. $aListViewColorsFonts_Index holds the index in $aListViewColorsFonts stored as
; index+1.
;
; For NON-NATIVE listview items the index in $aListViewColorsFonts is stored in ItemParam as -index-20. For non-native listview items
; an existing value of ItemParam is overwritten.


; $fColorsFonts = 7+128 ; Custom colors for selected items <<<<<<<<<<<<<<<<<<<<<
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Array to store information about listview colors/fonts, one array per listview
;Global $aListViewColorsFonts, $iListViewColorsFonts ; Initially 100 rows, 6 columns
; Column          Description
; --------------  -----------
;  0              Status - Value 0:       No colors/fonts
;                          Bit 0 (1) set: Color/font for entire item
;                          Bit 1 (2) set: Colors/fonts for one or more subitems
;                          Bit 2 (4) set: Selected color for entire item
;                          Bit 3 (8) set: Selected colors for one or more subitems
;  1, 2, 3, 4, 5  Back color, fore color, selected back color, selected fore color and font for entire listview item        ; Initially 6 columns.
;  6, 7, 8, 9,10  Back color, fore color, selected back color, selected fore color and font for subitem 0, first column     ; if colors/fonts are specified for listview subitems,
; 11,12,13,14,15  Back color, fore color, selected back color, selected fore color and font for subitem 1, second column    ; 5 * _GUICtrlListView_GetColumnCount columns are added.
; 16,17,18,19,20  Back color, fore color, selected back color, selected fore color and font for subitem 2, third column
; Etc.

; Column index in $aListViewColorsFonts
; -------------------------------------
; Back color:          5 + 5 * $iSubItem + 1 ; $iSubItem is the zero based index of subitems
; Fore color:          5 + 5 * $iSubItem + 2
; Selected back color: 5 + 5 * $iSubItem + 3
; Selected fore color: 5 + 5 * $iSubItem + 4
; Font:                5 + 5 * $iSubItem + 5

; Row index in $aListViewColorsFonts
; ----------------------------------
; ItemParam in the listview is used to store the zero based row index in $aListViewColorsFonts for a given listview item.
;
; For NATIVE listview items created with GUICtrlCreateListViewItem the existing value of ItemParam (control ID) is used as index in
; an intermediate array $aListViewColorsFonts_Index. $aListViewColorsFonts_Index holds the index in $aListViewColorsFonts stored as
; index+1.
;
; For NON-NATIVE listview items the index in $aListViewColorsFonts is stored in ItemParam as -index-20. For non-native listview items
; an existing value of ItemParam is overwritten.


; $fColorsFonts = 7+128+256 ; Custom colors for unfocused selected items <<<<<<<
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Array to store information about listview colors/fonts, one array per listview
;Global $aListViewColorsFonts, $iListViewColorsFonts ; Initially 100 rows, 8 columns
; Column                Description
; --------------------  -----------
;  0                    Status - Value 0:        No colors/fonts
;                                Bit 0 ( 1) set: Color/font for entire item
;                                Bit 1 ( 2) set: Colors/fonts for one or more subitems
;                                Bit 2 ( 4) set: Selected color for entire item
;                                Bit 3 ( 8) set: Selected colors for one or more subitems
;                                Bit 4 (16) set: Unfocused selected color for entire item
;                                Bit 5 (32) set: Unfocused selected colors for one or more subitems
;  1, 2, 3, 4, 5, 6, 7  Back color, fore color, selected back color, selected fore color, unfocused back color, unfocused fore color and font for entire listview item        ; Initially 8 columns.
;  8, 9,10,11,12,13,14  Back color, fore color, selected back color, selected fore color, unfocused back color, unfocused fore color and font for subitem 0, first column     ; if colors/fonts are specified for listview subitems,
; 15,16,17,18,19,20,21  Back color, fore color, selected back color, selected fore color, unfocused back color, unfocused fore color and font for subitem 1, second column    ; 7 * _GUICtrlListView_GetColumnCount columns are added.
; 22,23,24,25,26,27,28  Back color, fore color, selected back color, selected fore color, unfocused back color, unfocused fore color and font for subitem 2, third column
; Etc.

; Column index in $aListViewColorsFonts
; -------------------------------------
; Back color:                    7 + 7 * $iSubItem + 1 ; $iSubItem is the zero based index of subitems
; Fore color:                    7 + 7 * $iSubItem + 2
; Selected back color:           7 + 7 * $iSubItem + 3
; Selected fore color:           7 + 7 * $iSubItem + 4
; Unfocused selected back color: 7 + 7 * $iSubItem + 5
; Unfocused selected fore color: 7 + 7 * $iSubItem + 6
; Font:                          7 + 7 * $iSubItem + 7

; Row index in $aListViewColorsFonts
; ----------------------------------
; ItemParam in the listview is used to store the zero based row index in $aListViewColorsFonts for a given listview item.
;
; For NATIVE listview items created with GUICtrlCreateListViewItem the existing value of ItemParam (control ID) is used as index in
; an intermediate array $aListViewColorsFonts_Index. $aListViewColorsFonts_Index holds the index in $aListViewColorsFonts stored as
; index+1.
;
; For NON-NATIVE listview items the index in $aListViewColorsFonts is stored in ItemParam as -index-20. For non-native listview items
; an existing value of ItemParam is overwritten.


; Pointers to subclass callback functions (message handlers)
Global $pListViewColorsFontsSC_Normal        = 0 ; Subclass callback (SC) function for normal listview items with custom colors and fonts ($fColorsFonts = 1/2/4)
Global $pListViewColorsFontsSC_Selected      = 0 ; Subclass callback (SC) function for selected items in a focused or unfocused listview  ($fColorsFonts = 1/2/4 + 128/256)
Global $pListViewColorsFontsSC_Columns       = 0 ; Subclass callback (SC) function for colors and font in entire listview columns         ($fColorsFonts = 8)
Global $pListViewColorsFontsSC_AlterRows     = 0 ; Subclass callback (SC) function for alternating row colors in entire listview          ($fColorsFonts = 16)
Global $pListViewColorsFontsSC_AlterCols     = 0 ; Subclass callback (SC) function for alternating column colors in entire listview       ($fColorsFonts = 32)
Global $pListViewColorsFontsSC_AlterRowsCols = 0 ; Subclass callback (SC) function for alternating row/column colors in entire listview   ($fColorsFonts = 48)
Global $pListViewColorsFontsSC_Defaults      = 0 ; Subclass callback (SC) function for custom default colors and font in entire listview  ($fColorsFonts = 64)


; If a subclass callback function is created for a window with _WinAPI_SetWindowSubclass, the function must
; be removed from the window with _WinAPI_RemoveWindowSubclass before the program exits. If not, there is a
; high risk that the program will hang on exit with the callback function running in an infinite loop using
; an entire core in the CPU. ListViewColorsFonts_ExitAllOnExit removes all subclass callback functions,
; that are not already removed, immediately before the program exits.
OnAutoItExitRegister( "ListViewColorsFonts_ExitAllOnExit" )


; Functions
; =========
; Initiating and exiting
; ----------------------
; ListViewColorsFonts_Init
; ListViewColorsFonts_Exit
;
; Set colors/fonts for items/subitems
; -----------------------------------
; ListViewColorsFonts_SetItemColors
; ListViewColorsFonts_SetItemFonts
; ListViewColorsFonts_SetItemColorsFonts
;
; Get colors/fonts for items and subitems
; ---------------------------------------
; ListViewColorsFonts_GetItemColors         ; Next version
; ListViewColorsFonts_GetItemFonts          ; Next version
; ListViewColorsFonts_GetItemColorsFonts    ; Next version
;
; Set colors/fonts for entire listview
; ------------------------------------
; ListViewColorsFonts_SetColumnColorsFonts
; ListViewColorsFonts_SetAlternatingColors
; ListViewColorsFonts_SetDefaultColorsFonts
;
; Get colors/fonts for entire listview
; ------------------------------------
; ListViewColorsFonts_GetColumnColorsFonts  ; Next version
; ListViewColorsFonts_GetAlternatingColors  ; Next version
; ListViewColorsFonts_GetDefaultColorsFonts ; Next version
;
; Get state values
; ----------------
; ListViewColorsFonts_GetFeatureState       ; Next version
; ListViewColorsFonts_GetSelectedState      ; Next version
; ListViewColorsFonts_GetDefaultState       ; Next version
; ListViewColorsFonts_GetNativeState        ; Next version
;
; Maintenance functions
; ---------------------
; ListViewColorsFonts_SetColumns            ; Next version
; ListViewColorsFonts_GetColumns            ; Next version
; ListViewColorsFonts_Redraw
;
; Utility functions
; -----------------
; ListViewColorsFonts_SetItemParam          ; Next version
; ListViewColorsFonts_GetItemParam          ; Next version


; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_Init
; Description ...: Creates array to store color/font info and subclasses parent window
; Syntax ........: ListViewColorsFonts_Init( $idListView, $fColorsFonts = 7, $iAddRows = 100, $bNative = False )
; Parameters ....: $idListView   - Listview control ID or handle
;                  $fColorsFonts - Specifies options for usage of colors and fonts in the listview. Add required options together.
;                                    1: Back colors for items/subitems          ; Can not be specified separately in this version
;                                    2: Fore colors for items/subitems          ; Can not be specified separately in this version
;                                    4: Fonts and styles for items/subitems     ; Can not be specified separately in this version
;                                    7: Back and fore colors, fonts and styles  ; Flags 1/2/4 are combined in flag 7 in this version
;
;                                    8: Colors/fonts for entire columns
;
;                                   16: Alternating row colors (for entire listview)
;                                   32: Alternating column colors (for entire listview)
;
;                                   64: Custom default colors and font (for entire listview)
;                                       Custom default back and fore colors can be set for
;                                       - Normal listview items (instead of white and black)
;                                       - Selected listview items (instead of dark blue and white)
;                                       - Unfocused selected listview items (instead of button face and black)
;
;                                  128: Colors for selected items when listview has focus
;                                  256: Colors for selected items when listview has not focus
;
;                  The parameters $iAddRows and $bNative are used for $fColorsFonts = 1/2/4 to store information about colors/fonts
;                  in an array: $aListViewColorsFonts. ItemParam is used to store the index in $aListViewColorsFonts.
;
;                  $iAddRows     - Number of rows to add to $aListViewColorsFonts array when it's ReDim'ed
;                                  Increase the number to avoid too many ReDims when $aListViewColorsFonts is filled with colors/fonts.
;                  $bNative      - Specifies if listview items should be treated as native or non-native listview items. Set $bNative
;                                  - True if listview ITEMS are created with GUICtrlCreateListViewItem and control ID stored in Item-
;                                    Param is used in code. Control ID in ItemParam will be retained.
;                                  - False if listview ITEMS are created with functions in GuiListView UDF, or listview items are cre-
;                                    ated with GUICtrlCreateListViewItem but control ID is not used in code. Control ID in ItemParam
;                                    will be overwritten.
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - $idListView is not a valid listview control ID or handle
;                            2 - $fColorsFonts is invalid or an invalid combination of otherwise valid flags
;                            3 - Main GUI window handle or CLASSNN listview name cannot be determined (if flags 128/256 are set)
;                            4 - The listview exists
;                            5 - Too many listviews
; Remarks .......: Creates an entry in $aListViewColorsFontsInfo to store information about the listview, the parent window and the
;                  usage of colors/fonts in the listview. Creates $aListViewColorsFonts to store color/font information if necessary.
;                  Subclasses the parent window to be able to respond to NM_CUSTOMDRAW notifications and apply custom colors and fonts.
;                  Other notifications and other messages are forwarded to main GUI. You can respond to other notifications in a usual
;                  WM_NOTIFY message handler. You can respond to other messages in usual WM_MESSAGE handlers.
;
;                  $fColorsFonts flags:
;                  - Flags 1/2/4 can be combined in a total of seven different ways
;                  - Flags 1/2/4 (items/subitems), flag 8 (columns) and flags 16/32 (listview) cannot be combined
;                  - Flag 64 is used to replace the standard default colors/font by custom default colors/font
;                    Flag 64 can be used alone or in combination with flags 1-32
;                    Custom default colors/font must be set before all other colors/fonts
;                    Flag 64 leads to some restrictions on the features for items/subitems (flags 1/2/4)
;                  - Flags 128/256 extends the functionality of flags 1-64 by adding colors to selected items
;                    Flags 128/256 cannot be used alone
;
;                  Note that back color, fore color and font is initially extracted from the listview. If you want to change any of
;                  these values, you should do it before ListViewColorsFonts_Init is called. In this way the UDF is able to extract
;                  and display the new colors and the new font.
;
;                  A native listview created with GUICtrlCreateListView is slightly more efficient than a non-native listview created
;                  with _GUICtrlListView_Create in terms of colors and fonts.
;
;                  Non-native ($bNative = False) listview items are slightly more efficient than native in terms of colors and fonts.
;                  $bNative is used only for $fColorsFonts = 1/2/4.
;
;                  The best way to add colors and fonts to listviews is to put each listview in its own child window. The child win-
;                  dow should not contain any other controls, and it should have the same size as the listview. However, this is not
;                  a requirement.
;
;                  Invalid optional parameters will be set to default values if possible.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_Init\
;
; Example 1 .....: Perform initializations to add colors/fonts to single items/subitems
;                  ListViewColorsFonts_Init( $idListView, 7 ) ; $fColorsFonts = 7, ( $iAddRows = 100, $bNative = False )
;
; Example 2 .....: Perform initializations to add colors/fonts to entire columns
;                  ListViewColorsFonts_Init( $idListView, 8 ) ; $fColorsFonts = 8, ( $iAddRows not used, $bNative not used )
;
; Example 3 .....: Perform initializations to add alternating column colors to entire listview
;                  ListViewColorsFonts_Init( $idListView, 32 ) ; $fColorsFonts = 32, ( $iAddRows not used, $bNative not used )
;
; Example 4 .....: Perform initializations to add custom default colors/font to entire listview
;                  ListViewColorsFonts_Init( $idListView, 64 ) ; $fColorsFonts = 64, ( $iAddRows not used, $bNative not used )
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_Init( $idListView, $fColorsFonts = 7, $iAddRows = 100, $bNative = False )
	If $fColorsFonts = Default Then $fColorsFonts = 7
	If $iAddRows     = Default Then $iAddRows     = 100
	If $bNative      = Default Then $bNative      = False

	; Check $idListView
	Local $hListView = $idListView
	If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
	If Not $hListView Or Not _WinAPI_GetClassName( $hListView ) = "SysListView32" Then Return SetError(1, 0, -1)
	If Not _GUICtrlListView_GetViewDetails( $idListView ) Then Return SetError(1, 0, -1)
	Local $iColumns = _GUICtrlListView_GetColumnCount( $idListView )
	If Not $iColumns Then Return SetError(1, 0, -1)
	Local $hParent = _WinAPI_GetParent( $hListView )

	; Is listview created with GUICtrlCreateListView?
	Local $i = _WinAPI_GetDlgCtrlID( $hListView ), $h = GUICtrlGetHandle( $i )
	$idListView = $h = $hListView ? $i : 0 ; $idListView = 0 => Listview created with _GUICtrlListView_Create
	                                       ; $idListView > 0 => Listview created with GUICtrlCreateListView
	; Check $fColorsFonts
	If Not IsInt( $fColorsFonts ) Or $fColorsFonts < 1 Or $fColorsFonts > 511 Then Return SetError(2, 0, -1) ; Invalid value
	If BitAND( $fColorsFonts, 7 ) Then $fColorsFonts = BitOR( $fColorsFonts, 7 )                 ; 1/2/4 cannot be specified separately in this version
	If BitAND( $fColorsFonts, 7 ) And BitAND( $fColorsFonts,  8 ) Then Return SetError(2, 0, -1) ; 1/2/4 cannot be combined with 8
	If BitAND( $fColorsFonts, 7 ) And BitAND( $fColorsFonts, 48 ) Then Return SetError(2, 0, -1) ; 1/2/4 cannot be combined with 16/32
	If BitAND( $fColorsFonts, 8 ) And BitAND( $fColorsFonts, 48 ) Then Return SetError(2, 0, -1) ; 8 cannot be combined with 16/32
	If BitAND( $fColorsFonts, 16 ) And BitAND( $fColorsFonts, 32 ) And $iColumns = 1 Then $fColorsFonts -= 32           ; Alternating row and column colors => $iColumns > 1
	If Not BitAND( $fColorsFonts, 16 ) And BitAND( $fColorsFonts, 32 ) And $iColumns = 1 Then Return SetError(2, 0, -1) ; Alternating column colors         => $iColumns > 1
	If $fColorsFonts - BitAND( $fColorsFonts, 384 ) = 0 Then Return SetError(2, 0, -1)           ; 128/256 cannot be used alone

	; Check $iAddRows and $bNative
	; $iAddRows and $bNative are used to store colors/fonts for single
	; items/subitems ($fColorsFonts = 1/2/4) in $aListViewColorsFonts.
	If BitAND( $fColorsFonts, 7 ) Then
		If Not IsInt( $iAddRows ) Or $iAddRows < 10 Then $iAddRows = 100
		$bNative = $bNative ? True : False                    ; Convert to boolean
		If Not $idListView And $bNative Then $bNative = False ; Items in a listview created with _GUICtrlListView_Create are non-native
	Else
		$iAddRows = 100
		$bNative = False
	EndIf

	; If flags 128/256 are set for selected items, main GUI window handle and
	; CLASSNN listview name are used to determine whether listview has focus.
	Local $fSelected = BitAND( $fColorsFonts, 384 ) / 128, $hGui = 0, $sClassNN = ""
	If $fSelected Then
		If $fSelected = 3 Then $fSelected = 2
		; Calculate main GUI window handle
		$h = $hParent
		While $h
			$hGui = $h
			$h = _WinAPI_GetParent( $h )
		WEnd
		; Get CLASSNN listview name in main GUI
		$i = 1
		While $i < 100 And $hListView <> ControlGetHandle( $hGui, "", "[CLASS:SysListView32;INSTANCE:" & $i & "]" )
			$i += 1
		Wend
		If $i = 100 Then Return SetError(3, 0, -1)
		$sClassNN = "SysListView32" & $i
	EndIf

	; Check if the listview already exists in $aListViewColorsFontsInfo
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
	Next
	If $iIndex < $iListViewColorsFontsInfo Then Return SetError(4, 0, -1) ; The listview exists
	; If the listview is already initialized the function fails and returns with @error = 4
	; But the previous initialization is still valid

	; Find first available row in $aListViewColorsFontsInfo to store listview information
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If Not $aListViewColorsFontsInfo[$iIndex][1] Then ExitLoop
	Next
	If $iIndex = $iListViewColorsFontsInfo Then
		If $iListViewColorsFontsInfo = 100 Then Return SetError(5, 0, -1) ; Too many ListViews
		$iListViewColorsFontsInfo += 1
	EndIf

	; $iIndex is index in $aListViewColorsFontsInfo
	; Store information in $aListViewColorsFontsInfo
	Local $iExtendedStyle = _GUICtrlListView_GetExtendedListViewStyle( $hListView )
	$aListViewColorsFontsInfo[$iIndex][0] = $idListView ; Listview control ID
	$aListViewColorsFontsInfo[$iIndex][1] = $hListView  ; Listview handle
	$aListViewColorsFontsInfo[$iIndex][2] = _GUICtrlListView_GetHeader( $hListView ) ; Listview header
	$aListViewColorsFontsInfo[$iIndex][3] = BitAND( $iExtendedStyle, $LVS_EX_SUBITEMIMAGES ) ? True : False ; Subitem images
	$aListViewColorsFontsInfo[$iIndex][4] = BitAND( $iExtendedStyle, $LVS_EX_CHECKBOXES ) ? True : False    ; Checkboxes
	$aListViewColorsFontsInfo[$iIndex][5] = $hParent    ; Listview parent
	$aListViewColorsFontsInfo[$iIndex][6] = $hGui       ; Main GUI window
	$aListViewColorsFontsInfo[$iIndex][7] = $sClassNN   ; CLASSNN listview name
	$aListViewColorsFontsInfo[$iIndex][8] = $bNative    ; Native or non-native items
	$aListViewColorsFontsInfo[$iIndex][9] = $iColumns   ; Number of listview columns

	; Get the font of the listview control
	; Copied from _GUICtrlGetFont example by KaFu
	; See https://www.autoitscript.com/forum/index.php?showtopic=124526
	$aListViewColorsFontsInfo[$iIndex][10] = DllStructCreate( $tagLOGFONT ) ; Used to set font name and font style
	Local $hDC = _WinAPI_GetDC( $hListView ), $hFont = _SendMessage( $hListView, $WM_GETFONT ), $hObject = _WinAPI_SelectObject( $hDC, $hFont ), $tLogFont = $aListViewColorsFontsInfo[$iIndex][10]
	_WinAPI_GetObject( $hFont, DllStructGetSize( $tLogFont ), $tLogFont )
	_WinAPI_SelectObject( $hDC, $hObject )
	_WinAPI_ReleaseDC( $hListView, $hDC )

	; Default listview font and colors
	$aListViewColorsFontsInfo[$iIndex][11] = Ptr( $hFont )                               ; Default listview font
	$aListViewColorsFontsInfo[$iIndex][12] = _GUICtrlListView_GetBkColor( $hListView )   ; Default listview back color
	$aListViewColorsFontsInfo[$iIndex][13] = _GUICtrlListView_GetTextColor( $hListView ) ; Default listview fore color
	Local $aDefaults[7] = [ _                    ; Current default font and colors for the listview
		$aListViewColorsFontsInfo[$iIndex][11], _  ; 0: Default font
		$aListViewColorsFontsInfo[$iIndex][12], _  ; 1: Default back color
		$aListViewColorsFontsInfo[$iIndex][13], _  ; 2: Default fore color
		_WinAPI_GetSysColor( $COLOR_HIGHLIGHT ), _ ; 3: Default back color for selected items when listview has focus
		0xFFFFFF, _                                ; 4: Default fore color for selected items when listview has focus (white)
		_WinAPI_GetSysColor( $COLOR_BTNFACE ), _   ; 5: Default back color for selected items when listview has not focus
		0x000000 ]                                 ; 6: Default fore color for selected items when listview has not focus (black)

	; Colors/fonts options
	$aListViewColorsFontsInfo[$iIndex][14] = $fColorsFonts                   ; Colors/fonts options
	$aListViewColorsFontsInfo[$iIndex][15] = $fSelected                      ; Flag for selected items
	$aListViewColorsFontsInfo[$iIndex][16] = BitAND( $fColorsFonts, 64 ) * 4 ; Custom default colors/font  ; $fDefaults
	$aListViewColorsFontsInfo[$iIndex][17] = $aDefaults                      ; Current default colors/font ; $aDefaults

	; Columns 18 - 25 in $aListViewColorsFontsInfo are used
	; to store information about custom colors and fonts.
	Select
		Case BitAND( $fColorsFonts, 7 ) ; Colors/fonts for items/subitems
			; Information related to $aListViewColorsFonts array
			Local $aIndex[1], $aArray[1][($fSelected=0?4:$fSelected=1?6:8)]
			$aListViewColorsFontsInfo[$iIndex][18] = False     ; Info for subitems: true/false   ; $bListViewColorsFonts_Subitems
			$aListViewColorsFontsInfo[$iIndex][19] = $aIndex   ; Index array for native items    ; $aListViewColorsFonts_Index
			$aListViewColorsFontsInfo[$iIndex][20] = 0         ; Number of rows in the array     ; $iListViewColorsFonts_Index
			$aListViewColorsFontsInfo[$iIndex][21] = 0         ; Max rows in the array           ; $iListViewColorsFonts_Index_MaxRows
			$aListViewColorsFontsInfo[$iIndex][22] = $aArray   ; Array to store color/font info  ; $aListViewColorsFonts
			$aListViewColorsFontsInfo[$iIndex][23] = 0         ; Number of rows in the array     ; $iListViewColorsFonts
			$aListViewColorsFontsInfo[$iIndex][24] = 0         ; Max rows in the array           ; $iListViewColorsFonts_MaxRows
			$aListViewColorsFontsInfo[$iIndex][25] = $iAddRows ; Rows to add on ReDim
			; Index in $aListViewColorsFonts_Index or $aListViewColorsFonts is stored in ItemParam

		Case BitAND( $fColorsFonts, 8 ) ; Colors/fonts for entire columns
			; Information related to $aColumnColorsFonts array
			Local $aColumns[10][8] ; Status, font, back and fore color as well as selected and unfocused colors for each column
			$aListViewColorsFontsInfo[$iIndex][22] = $aColumns ; Array to store color/font info  ; $aColumnColorsFonts
			$aListViewColorsFontsInfo[$iIndex][23] = 0         ; Number of rows in the array     ; $iColumnColorsFonts
			$aListViewColorsFontsInfo[$iIndex][24] = 10        ; Max rows in the array           ; $iColumnColorsFonts_MaxRows
			$aListViewColorsFontsInfo[$iIndex][25] = 10        ; Rows to add on ReDim

		Case BitAND( $fColorsFonts, 48 ) ; Alternating row/column colors
			; Information related to $aAlternatingColors array
			Local $aAlter = $aDefaults ; $aAlter[1-6]: Back/fore color, selected back/fore color, unfocused back/fore color
			$aListViewColorsFontsInfo[$iIndex][22] = 0         ; Rows between color change       ; $iRows
			$aListViewColorsFontsInfo[$iIndex][23] = 0         ; Columns between color change    ; $iColumns
			$aListViewColorsFontsInfo[$iIndex][24] = 0         ; Flags for alternating colors    ; $fAlternatingColors
			$aListViewColorsFontsInfo[$iIndex][25] = $aAlter   ; Alternating colors              ; $aAlternatingColors
	EndSelect

	; Register callback function
	; Subclass listview parent window
	Select
		Case BitAND( $fColorsFonts, 7 ) ; Colors/fonts for items/subitems
			If $fSelected Then ; Selected items
				If Not $pListViewColorsFontsSC_Selected Then $pListViewColorsFontsSC_Selected = DllCallbackGetPtr( DllCallbackRegister( "ListViewColorsFontsSC_Selected", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
				_WinAPI_SetWindowSubclass( $hParent, $pListViewColorsFontsSC_Selected, $iIndex, $hListView ) ; $iSubclassId = $iIndex, $pData = $hListView
			Else ; Normal items
				If Not $pListViewColorsFontsSC_Normal Then $pListViewColorsFontsSC_Normal = DllCallbackGetPtr( DllCallbackRegister( "ListViewColorsFontsSC_Normal", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
				_WinAPI_SetWindowSubclass( $hParent, $pListViewColorsFontsSC_Normal, $iIndex, $hListView ) ; $iSubclassId = $iIndex, $pData = $hListView
			EndIf

		Case BitAND( $fColorsFonts, 8 ) ; Colors/fonts for entire columns
			If Not $pListViewColorsFontsSC_Columns Then $pListViewColorsFontsSC_Columns = DllCallbackGetPtr( DllCallbackRegister( "ListViewColorsFontsSC_Columns", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
			_WinAPI_SetWindowSubclass( $hParent, $pListViewColorsFontsSC_Columns, $iIndex, $hListView ) ; $iSubclassId = $iIndex, $pData = $hListView

		Case BitAND( $fColorsFonts, 16 ) And Not BitAND( $fColorsFonts, 32 ) ; Alternating row colors
			If Not $pListViewColorsFontsSC_AlterRows Then $pListViewColorsFontsSC_AlterRows = DllCallbackGetPtr( DllCallbackRegister( "ListViewColorsFontsSC_AlterRows", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
			_WinAPI_SetWindowSubclass( $hParent, $pListViewColorsFontsSC_AlterRows, $iIndex, $hListView ) ; $iSubclassId = $iIndex, $pData = $hListView

		Case BitAND( $fColorsFonts, 32 ) And Not BitAND( $fColorsFonts, 16 ) ; Alternating column colors
			If Not $pListViewColorsFontsSC_AlterCols Then $pListViewColorsFontsSC_AlterCols = DllCallbackGetPtr( DllCallbackRegister( "ListViewColorsFontsSC_AlterCols", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
			_WinAPI_SetWindowSubclass( $hParent, $pListViewColorsFontsSC_AlterCols, $iIndex, $hListView ) ; $iSubclassId = $iIndex, $pData = $hListView

		Case BitAND( $fColorsFonts, 48 ) ; Alternating row/column colors
			If Not $pListViewColorsFontsSC_AlterRowsCols Then $pListViewColorsFontsSC_AlterRowsCols = DllCallbackGetPtr( DllCallbackRegister( "ListViewColorsFontsSC_AlterRowsCols", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
			_WinAPI_SetWindowSubclass( $hParent, $pListViewColorsFontsSC_AlterRowsCols, $iIndex, $hListView ) ; $iSubclassId = $iIndex, $pData = $hListView

		Case BitAND( $fColorsFonts, 64 ) ; Custom default colors/font
			If Not $pListViewColorsFontsSC_Defaults Then $pListViewColorsFontsSC_Defaults = DllCallbackGetPtr( DllCallbackRegister( "ListViewColorsFontsSC_Defaults", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
			_WinAPI_SetWindowSubclass( $hParent, $pListViewColorsFontsSC_Defaults, $iIndex, $hListView ) ; $iSubclassId = $iIndex, $pData = $hListView
	EndSelect
	; $iSubclassId = $iIndex is used to switch between different listviews. Because $iIndex is the index in $aListViewColorsFontsInfo, the time
	; required to switch between 2 listviews (less than 50 microseconds on an old Windows XP) and switch between 99 listviews is the same.
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_SetItemColors
; Description ...: Sets back and fore color for listview items and subitems
; Syntax ........: ListViewColorsFonts_SetItemColors( $idListView, $iItem, $iSubItem = -1, $iBackColor = 0, $iForeColor = 0, $iBackSelect = 0, $iForeSelect = 0, $iBackUnfocus = 0, $iForeUnfocus = 0 )
; Parameters ....: $idListView   - Listview control ID or handle
;                  $iItem        - Zero based item (row) index
;                  $iSubItem     - Zero based subitem (column) index
;                  $iBackColor   - Background color of item or subitem
;                                  Default value 0 results in a white background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeColor   - Fore (text) color of item or subitem
;                                  Default value 0 is a black fore color
;                  $iBackSelect  - Background color of selected item or subitem when listview has focus
;                                  Default value 0 results in a dark blue ($COLOR_HIGHLIGHT) background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeSelect  - Fore (text) color of selected item or subitem when listview has focus
;                                  Default value 0 results in a white fore color
;                                  Because 0 is also the value of the black color a black fore color cannot be specified
;                  $iBackUnfocus - Background color of selected item or subitem when listview has not focus
;                                  Default value 0 results in a button face ($COLOR_BTNFACE) background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeUnfocus - Fore (text) color of selected item or subitem when listview has not focus
;                                  Default value 0 is a black fore color
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - This function requires that $fColorsFonts includes 1/2/4
;                            2 - Listview not found
;                            3 - Invalid listview item
;                            4 - Invalid listview subitem
;                            5 - Too many color parameters
;                            6 - Invalid color value
; Remarks .......: Because ItemParam is used as index in $aListViewColorsFonts or $aListViewColorsFonts_Index, items must be
;                  created before information about colors/fonts is added to the items.
;
;                  $iBackSelect and $iForeSelect requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 128/256.
;                  $iBackUnfocus and $iForeUnfocus requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 256.
;
;                  Note that the possibility to define colors/font for an entire item and then define another color/font for a single
;                  subitem, is not available if flag 64 is specified in ListViewColorsFonts_Init. If flag 64 is specified colors/fonts
;                  must be defined for all subitems.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_SetItemColors\
;
; Example 1 .....: Set a green back color for an entire item and a yellow back color for a single cell
;                  ListViewColorsFonts_SetItemColors( $idListView, $iItem, -1, 0xCCFFCC ) ; Green back color for entire item
;                  ListViewColorsFonts_SetItemColors( $idListView, $iItem,  2, 0xFFFFCC ) ; Yellow back color for cell 2 in item
;
; Example 2 .....: Set a red fore color for an entire item and a blue fore color for a single cell
;                  ListViewColorsFonts_SetItemColors( $idListView, $iItem, -1, 0, 0xFF0000 ) ; Red fore color for entire item
;                  ListViewColorsFonts_SetItemColors( $idListView, $iItem,  2, 0, 0x0000FF ) ; Blue fore color for cell 2 in item
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_SetItemColors( $idListView, $iItem, $iSubItem = -1, $iBackColor = 0, $iForeColor = 0, $iBackSelect = 0, $iForeSelect = 0, $iBackUnfocus = 0, $iForeUnfocus = 0 )
	Local Static $bNative, $fOptions, $fSelected, $iColumns = 0, $fDefaults, $aDefaults, $iColOffset ; Keep these variables between function calls to avoid recalculation
	Local Static $idListViewPrev = 0, $iListViewIndex = 0, $hListView, $idLV  ; Variables to check if $aListViewColorsFonts must be stored and replaced
	Local $iIndex, $iCols

	If $iSubItem     = Default Then $iSubItem     = -1
	If $iBackColor   = Default Then $iBackColor   = 0
	If $iForeColor   = Default Then $iForeColor   = 0
	If $iBackSelect  = Default Then $iBackSelect  = 0
	If $iForeSelect  = Default Then $iForeSelect  = 0
	If $iBackUnfocus = Default Then $iBackUnfocus = 0
	If $iForeUnfocus = Default Then $iForeUnfocus = 0

	; $aListViewColorsFonts is a global array to store information about colors/fonts. An array per listview.
	; If the previous listview is replaced with a new listview, the global array must also be replaced with a new array.
	If $idListViewPrev <> $idListView _                        ; New listview? $aListViewColorsFonts must be stored and replaced.
	Or $iListViewIndex <> $iListViewColorsFontsInfo_Index Then ; Is the global array replaced with a new array in ListViewColorsFonts_SetItemColors/Fonts functions?
		If $bListViewColorsFonts_Save And $iListViewColorsFontsInfo_Index Then
			; Store previous $aListViewColorsFonts in $aListViewColorsFontsInfo
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][18] = $bListViewColorsFonts_Subitems
			If $aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][8] Then
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][19] = $aListViewColorsFonts_Index
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][20] = $iListViewColorsFonts_Index
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][21] = $iListViewColorsFonts_Index_MaxRows
			EndIf
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][22] = $aListViewColorsFonts
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][23] = $iListViewColorsFonts
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][24] = $iListViewColorsFonts_MaxRows
			$bListViewColorsFonts_Save = False
		EndIf

		; Find listview
		$hListView = $idListView
		If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
		For $iIndex = 1 To $iListViewColorsFontsInfo - 1
			If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
		Next
		If $iIndex = $iListViewColorsFontsInfo Then Return SetError(2, 0, -1) ; Listview not found
		$idListViewPrev = $idListView

		; $fColorsFonts must include 1/2/4
		If Not BitAND( $aListViewColorsFontsInfo[$iIndex][14], 7 ) Then Return SetError(1, 0, -1)

		; Get $aListViewColorsFonts for current listview
		$bListViewColorsFonts_Subitems = $aListViewColorsFontsInfo[$iIndex][18] ; Info for subitems: true/false
		If $aListViewColorsFontsInfo[$iIndex][8] Then
			$aListViewColorsFonts_Index         = $aListViewColorsFontsInfo[$iIndex][19] ; Index array for native items
			$iListViewColorsFonts_Index         = $aListViewColorsFontsInfo[$iIndex][20] ; Number of used rows in array
			$iListViewColorsFonts_Index_MaxRows = $aListViewColorsFontsInfo[$iIndex][21] ; Max number of rows in array
		EndIf
		$aListViewColorsFonts          = $aListViewColorsFontsInfo[$iIndex][22] ; Array to store color/font info
		$iListViewColorsFonts          = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
		$iListViewColorsFonts_MaxRows  = $aListViewColorsFontsInfo[$iIndex][24] ; Max number of rows in array

		; Static variables
		$idLV       = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$bNative    = $aListViewColorsFontsInfo[$iIndex][8]  ; Native listview items
		$iColumns   = $aListViewColorsFontsInfo[$iIndex][9]  ; Number of listview columns
		$fOptions   = $aListViewColorsFontsInfo[$iIndex][14] ; Colors/fonts options
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors
		$iColOffset = $fSelected=0?3:$fSelected=1?5:7
		$iListViewColorsFontsInfo_Index = $iIndex
		$iListViewIndex = $iIndex
	EndIf

	; Number of parameters
	Switch $fSelected
		Case 0
			If @NumParams > 5 Then Return SetError(5, 0, -1) ; Too many color parameters
		Case 1
			If @NumParams > 7 Then Return SetError(5, 0, -1) ; Too many color parameters
	EndSwitch

	; Valid color values?
	If BitAND( $iBackColor, 0xFF000000 ) Or BitAND( $iForeColor, 0xFF000000 ) Or BitAND( $iBackSelect, 0xFF000000 ) Or BitAND( $iForeSelect, 0xFF000000 ) Or BitAND( $iBackUnfocus, 0xFF000000 ) Or BitAND( $iForeUnfocus, 0xFF000000 ) Then Return SetError(6, 0, -1) ; Invalid color value

	If Not ( IsInt( $iSubItem ) And $iSubItem < $iColumns ) Then Return SetError(4, 0, -1) ; Invalid listview subitem

	Local Static $tItem = DllStructCreate( $tagLVITEM ), $pItem = 0
	If Not $pItem Then
		DllStructSetData( $tItem, "Mask", $LVIF_PARAM )
		$pItem = DllStructGetPtr( $tItem )
	EndIf

	; Index in $aListViewColorsFonts is stored in ItemParam
	;$iIndex = _GUICtrlListView_GetItemParam( $idListView, $iItem )
	DllStructSetData( $tItem, "Item", $iItem )
	Local $i = $idLV ? GUICtrlSendMsg( $idLV, $LVM_GETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pItem )[0]
	$iIndex = DllStructGetData( $tItem, "Param" )

	; Colors/fonts for subitems? Default ($iSubItem = -1) is to set colors/fonts for the entire item.
	If Not $bListViewColorsFonts_Subitems And $iSubItem > -1 And $iSubItem < $iColumns Then
		ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iColumns]
		$bListViewColorsFonts_Subitems = True
	EndIf

	; Check whether there is room for more rows in $aListViewColorsFonts_Index and $aListViewColorsFonts
	; Store control ID in $aListViewColorsFonts_Index for native listview items
	; Store -$iIndex - 20 in listview ItemParam for non-native listview items
	If $bNative Then ; Native listview items
		; For native items control ID in ItemParam is used as index in $aListViewColorsFonts_Index
		Local $iIndex2 = $iIndex
		If $iIndex2 < 1 Then Return SetError(3, 0, -1) ; Invalid listview item
		If $iIndex2 >= $iListViewColorsFonts_Index Then $iListViewColorsFonts_Index = $iIndex2 + 1
		; Room for more rows in $aListViewColorsFonts_Index?
		If $iListViewColorsFonts_Index >= $iListViewColorsFonts_Index_MaxRows Then
			$iListViewColorsFonts_Index_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
			While $iListViewColorsFonts_Index >= $iListViewColorsFonts_Index_MaxRows
				$iListViewColorsFonts_Index_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
			WEnd
			ReDim $aListViewColorsFonts_Index[$iListViewColorsFonts_Index_MaxRows]
		EndIf
		If $aListViewColorsFonts_Index[$iIndex2] Then         ; Update existing colors/fonts
			$iIndex = $aListViewColorsFonts_Index[$iIndex2] - 1 ; $iIndex = $aListViewColorsFonts_Index[$iIndex2] - 1
		Else                                                  ; New colors/fonts info
			; Store new $iIndex + 1 in $aListViewColorsFonts_Index
			$iIndex = $iListViewColorsFonts
			$aListViewColorsFonts_Index[$iIndex2] = $iIndex + 1
			$iListViewColorsFonts += 1
			; Room for more rows in $aListViewColorsFonts?
			If $iListViewColorsFonts > $iListViewColorsFonts_MaxRows Then
				$iListViewColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
				$iCols = $bListViewColorsFonts_Subitems ? $iColumns : 0
				ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iCols]
			EndIf
		EndIf
	Else ; Non-native listview items
		If $iIndex < 0 And -$iIndex - 20 < $iListViewColorsFonts Then ; Update existing colors/fonts
			$iIndex = -$iIndex - 20 ; $iIndex = -ItemParam - 20
		Else                     ; New colors/fonts info
			; Store new -$iIndex - 20 in ItemParam
			$iIndex = $iListViewColorsFonts
			;If Not _GUICtrlListView_SetItemParam( $idListView, $iItem, -$iIndex - 20 ) Then Return SetError(3, 0, -1) ; Invalid listview item
			DllStructSetData( $tItem, "Param", -$iIndex - 20 )
			If Not ( $idLV ? GUICtrlSendMsg( $idLV, $LVM_SETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_SETITEMW, "wparam", 0, "lparam", $pItem )[0] ) Then Return SetError(3, 0, -1) ; Invalid listview item
			$iListViewColorsFonts += 1
			; Room for more rows in $aListViewColorsFonts?
			If $iListViewColorsFonts > $iListViewColorsFonts_MaxRows Then
				$iListViewColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
				$iCols = $bListViewColorsFonts_Subitems ? $iColumns : 0
				ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iCols]
			EndIf
		EndIf
	EndIf

	Local $iCol0, $n
	If BitAND( $fOptions, 64 ) Then
		; Store colors in $aListViewColorsFonts
		$iCol0 = ( $iSubItem > -1 And $iSubItem < $iColumns ) ? $iColOffset + $iColOffset * $iSubItem : 0 ; Column offset
		Switch $fSelected
			Case 0
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor ? BitOR( BitAND( $iBackColor, 0x00FF00 ), BitShift( BitAND( $iBackColor, 0x0000FF ), -16 ), BitShift( BitAND( $iBackColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 ) : $aListViewColorsFonts[$iIndex][1]         ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor ? BitOR( BitAND( $iForeColor, 0x00FF00 ), BitShift( BitAND( $iForeColor, 0x0000FF ), -16 ), BitShift( BitAND( $iForeColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 ) : $aListViewColorsFonts[$iIndex][2]         ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
			Case 1
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor  ? BitOR( BitAND( $iBackColor,  0x00FF00 ), BitShift( BitAND( $iBackColor,  0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 ) : $aListViewColorsFonts[$iIndex][1]     ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor  ? BitOR( BitAND( $iForeColor,  0x00FF00 ), BitShift( BitAND( $iForeColor,  0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 ) : $aListViewColorsFonts[$iIndex][2]     ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect ? BitOR( BitAND( $iBackSelect, 0x00FF00 ), BitShift( BitAND( $iBackSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  8 ) ? $aDefaults[3] : 0 ) : $aListViewColorsFonts[$iIndex][3]     ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect ? BitOR( BitAND( $iForeSelect, 0x00FF00 ), BitShift( BitAND( $iForeSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 16 ) ? $aDefaults[4] : 0 ) : $aListViewColorsFonts[$iIndex][4]     ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
			Case 2
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor   ? BitOR( BitAND( $iBackColor,   0x00FF00 ), BitShift( BitAND( $iBackColor,   0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 ) : $aListViewColorsFonts[$iIndex][1] ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor   ? BitOR( BitAND( $iForeColor,   0x00FF00 ), BitShift( BitAND( $iForeColor,   0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 ) : $aListViewColorsFonts[$iIndex][2] ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect  ? BitOR( BitAND( $iBackSelect,  0x00FF00 ), BitShift( BitAND( $iBackSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  8 ) ? $aDefaults[3] : 0 ) : $aListViewColorsFonts[$iIndex][3] ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect  ? BitOR( BitAND( $iForeSelect,  0x00FF00 ), BitShift( BitAND( $iForeSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 16 ) ? $aDefaults[4] : 0 ) : $aListViewColorsFonts[$iIndex][4] ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $iBackUnfocus ? BitOR( BitAND( $iBackUnfocus, 0x00FF00 ), BitShift( BitAND( $iBackUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iBackUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 32 ) ? $aDefaults[5] : 0 ) : $aListViewColorsFonts[$iIndex][5] ; Store unfocused back color in offset + 5 ; ListViewColorsFonts_ColorConvert( $iBackUnfocus )
				$aListViewColorsFonts[$iIndex][$iCol0+6] = $iForeUnfocus ? BitOR( BitAND( $iForeUnfocus, 0x00FF00 ), BitShift( BitAND( $iForeUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iForeUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 64 ) ? $aDefaults[6] : 0 ) : $aListViewColorsFonts[$iIndex][6] ; Store unfocused fore color in offset + 6 ; ListViewColorsFonts_ColorConvert( $iForeUnfocus )
		EndSwitch
		$aListViewColorsFonts[$iIndex][0] = BitOR( $aListViewColorsFonts[$iIndex][0], $iCol0 ? ($fSelected=0?2:$fSelected=1?2+8:2+8+32) : ($fSelected=0?1:$fSelected=1?1+4:1+4+16) ) ; Set status in column 0

		; Reset $aListViewColorsFonts[$iIndex][0]?
		If Not ( $iBackColor Or $iForeColor Or $iBackSelect Or $iForeSelect Or $iBackUnfocus Or $iForeUnfocus ) Then
			If $iSubItem < 0 Then ; Item
				; Reset default item colors
				For $i = 1 To $iColOffset - 1
					If $aListViewColorsFonts[$iIndex][$i] = $aDefaults[$i] Then $aListViewColorsFonts[$iIndex][$i] = 0
				Next
				; Reset item info only if font is default font
				If Not $aListViewColorsFonts[$iIndex][$iColOffset] Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?1:$fSelected=1?1+4:1+4+16)
			Else ; Subitem
				$n = $iColOffset + 1 + $iColOffset * $iColumns
				For $i = $iColOffset + 1 To $n - 1
					; Reset default subitem colors
					If Mod($i,7) And $aListViewColorsFonts[$iIndex][$i] = $aDefaults[Mod($i,7)] Then $aListViewColorsFonts[$iIndex][$i] = 0
					; Reset subitem info only if all subitem values are default values
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $n Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?2:$fSelected=1?2+8:2+8+32)
				; Reset default item colors
				For $i = 1 To $iColOffset - 1
					If $aListViewColorsFonts[$iIndex][$i] = $aDefaults[$i] Then $aListViewColorsFonts[$iIndex][$i] = 0
				Next
			EndIf
		EndIf

	Else ; Not BitAND( $fOptions, 64 )
		; Store colors in $aListViewColorsFonts
		$iCol0 = ( $iSubItem > -1 And $iSubItem < $iColumns ) ? $iColOffset + $iColOffset * $iSubItem : 0 ; Column offset
		Switch $fSelected
			Case 0
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor ? BitOR( BitAND( $iBackColor, 0x00FF00 ), BitShift( BitAND( $iBackColor, 0x0000FF ), -16 ), BitShift( BitAND( $iBackColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[1] : $aListViewColorsFonts[$iIndex][1]         ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor ? BitOR( BitAND( $iForeColor, 0x00FF00 ), BitShift( BitAND( $iForeColor, 0x0000FF ), -16 ), BitShift( BitAND( $iForeColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[2] : $aListViewColorsFonts[$iIndex][2]         ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
			Case 1
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor  ? BitOR( BitAND( $iBackColor,  0x00FF00 ), BitShift( BitAND( $iBackColor,  0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[1] : $aListViewColorsFonts[$iIndex][1]     ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor  ? BitOR( BitAND( $iForeColor,  0x00FF00 ), BitShift( BitAND( $iForeColor,  0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[2] : $aListViewColorsFonts[$iIndex][2]     ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect ? BitOR( BitAND( $iBackSelect, 0x00FF00 ), BitShift( BitAND( $iBackSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[3] : $aListViewColorsFonts[$iIndex][3]     ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect ? BitOR( BitAND( $iForeSelect, 0x00FF00 ), BitShift( BitAND( $iForeSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[4] : $aListViewColorsFonts[$iIndex][4]     ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
			Case 2
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor   ? BitOR( BitAND( $iBackColor,   0x00FF00 ), BitShift( BitAND( $iBackColor,   0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[1] : $aListViewColorsFonts[$iIndex][1] ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor   ? BitOR( BitAND( $iForeColor,   0x00FF00 ), BitShift( BitAND( $iForeColor,   0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[2] : $aListViewColorsFonts[$iIndex][2] ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect  ? BitOR( BitAND( $iBackSelect,  0x00FF00 ), BitShift( BitAND( $iBackSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[3] : $aListViewColorsFonts[$iIndex][3] ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect  ? BitOR( BitAND( $iForeSelect,  0x00FF00 ), BitShift( BitAND( $iForeSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[4] : $aListViewColorsFonts[$iIndex][4] ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $iBackUnfocus ? BitOR( BitAND( $iBackUnfocus, 0x00FF00 ), BitShift( BitAND( $iBackUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iBackUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[5] : $aListViewColorsFonts[$iIndex][5] ; Store unfocused back color in offset + 5 ; ListViewColorsFonts_ColorConvert( $iBackUnfocus )
				$aListViewColorsFonts[$iIndex][$iCol0+6] = $iForeUnfocus ? BitOR( BitAND( $iForeUnfocus, 0x00FF00 ), BitShift( BitAND( $iForeUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iForeUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[6] : $aListViewColorsFonts[$iIndex][6] ; Store unfocused fore color in offset + 6 ; ListViewColorsFonts_ColorConvert( $iForeUnfocus )
		EndSwitch
		$aListViewColorsFonts[$iIndex][0] = BitOR( $aListViewColorsFonts[$iIndex][0], $iCol0 ? ($fSelected=0?2:$fSelected=1?2+8:2+8+32) : ($fSelected=0?1:$fSelected=1?1+4:1+4+16) ) ; Set status in column 0

		If Not ( $iBackColor Or $iForeColor Or $iBackSelect Or $iForeSelect Or $iBackUnfocus Or $iForeUnfocus ) Then
			; Reset $aListViewColorsFonts[$iIndex][0]?
			If $iSubItem < 0 Then ; Reset item info only if font is default font
				If Not $aListViewColorsFonts[$iIndex][$iColOffset] Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?1:$fSelected=1?1+4:1+4+16)
			Else ; Reset subitem info only if all subitem values are default values
				$n = $iColOffset + 1 + $iColOffset * $iColumns
				For $i = $iColOffset + 1 To $n - 1
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $n Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?2:$fSelected=1?2+8:2+8+32)
			EndIf
		EndIf
	EndIf

	$bListViewColorsFonts_Save = True
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_SetItemFonts
; Description ...: Sets font name and font style for listview items and subitems
; Syntax ........: ListViewColorsFonts_SetItemFonts( $idListView, $iItem, $iSubItem = -1, $sFontName = "", $iFontStyle = 0 )
; Parameters ....: $idListView - Listview control ID or handle
;                  $iItem      - Zero based item (row) index
;                  $iSubItem   - Zero based subitem (column) index
;                  $sFontName  - Font face name of item or subitem
;                                Or a valid font handle (pointer)
;                  $iFontStyle - Text style of item or subitem
;                                Use the following values for $iFontStyle
;                                    0: Normal text style (default)
;                                    1: Bold text style
;                                    2: Italic text style
;                                    3: Underline text style
;                                These predefined constants can also be used:
;                                $iFontStyleNormal, $iFontStyleBold, $iFontStyleItalic, $iFontStyleUnderline
;                                If $sFontName is a font handle $iFontStyle is ignored
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - This function requires that $fColorsFonts includes 1/2/4
;                            2 - Listview not found
;                            3 - Invalid listview item
;                            4 - Invalid listview subitem
;                            5 - Invalid font or style
; Remarks .......: Because ItemParam is used as index in $aListViewColorsFonts or $aListViewColorsFonts_Index, items must be
;                  created before information about colors/fonts is added to the items.
;
;                  Note that the possibility to define a font for an entire item and then define another font for a single subitem,
;                  is not available if flag 64 is specified in ListViewColorsFonts_Init. If flag 64 is specified fonts must be de-
;                  fined for all subitems.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_SetItemFonts\
;                  See Examples\7) Original examples\lvCustDrawFonts.au3 for an example where $sFontName is a valid font handle
;
; Example 1 .....: Set a bold style for an entire item and an underline style for a single cell
;                  ListViewColorsFonts_SetItemFonts( $idListView, $iItem, -1, "", $iFontStyleBold )      ; Bold style for entire item
;                  ListViewColorsFonts_SetItemFonts( $idListView, $iItem,  2, "", $iFontStyleUnderline ) ; Underline style for cell 2 in item
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_SetItemFonts( $idListView, $iItem, $iSubItem = -1, $sFontName = "", $iFontStyle = 0 )
	Local Static $bNative, $fOptions, $fSelected, $iColumns = 0, $fDefaults, $aDefaults, $iColOffset ; Keep these variables between function calls to avoid recalculation
	Local Static $idListViewPrev = 0, $iListViewIndex = 0, $hListView, $idLV  ; Variables to check if $aListViewColorsFonts must be stored and replaced
	Local Static $tLogFont, $hDefFont, $sFaceName, $iWeight                   ; Keep these variables between function calls to avoid recalculation
	Local $iIndex, $iCols

	If $iSubItem   = Default Then $iSubItem   = -1
	If $sFontName  = Default Then $sFontName  = ""
	If $iFontStyle = Default Then $iFontStyle = 0

	; $aListViewColorsFonts is a global array to store information about colors/fonts. An array per listview.
	; If the previous listview is replaced with a new listview, the global array must also be replaced with a new array.
	If $idListViewPrev <> $idListView _                        ; New listview? $aListViewColorsFonts must be stored and replaced.
	Or $iListViewIndex <> $iListViewColorsFontsInfo_Index Then ; Is the global array replaced with a new array in ListViewColorsFonts_SetItemColors/Fonts functions?
		If $bListViewColorsFonts_Save And $iListViewColorsFontsInfo_Index Then
			; Store previous $aListViewColorsFonts in $aListViewColorsFontsInfo
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][18] = $bListViewColorsFonts_Subitems
			If $aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][8] Then
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][19] = $aListViewColorsFonts_Index
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][20] = $iListViewColorsFonts_Index
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][21] = $iListViewColorsFonts_Index_MaxRows
			EndIf
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][22] = $aListViewColorsFonts
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][23] = $iListViewColorsFonts
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][24] = $iListViewColorsFonts_MaxRows
			$bListViewColorsFonts_Save = False
		EndIf

		; Find listview
		$hListView = $idListView
		If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
		For $iIndex = 1 To $iListViewColorsFontsInfo - 1
			If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
		Next
		If $iIndex = $iListViewColorsFontsInfo Then Return SetError(2, 0, -1) ; Listview not found
		$idListViewPrev = $idListView

		; $fColorsFonts must include 1/2/4
		If Not BitAND( $aListViewColorsFontsInfo[$iIndex][14], 7 ) Then Return SetError(1, 0, -1)

		; Get $aListViewColorsFonts for current listview
		$bListViewColorsFonts_Subitems = $aListViewColorsFontsInfo[$iIndex][18] ; Info for subitems: true/false
		If $aListViewColorsFontsInfo[$iIndex][8] Then
			$aListViewColorsFonts_Index         = $aListViewColorsFontsInfo[$iIndex][19] ; Index array for native items
			$iListViewColorsFonts_Index         = $aListViewColorsFontsInfo[$iIndex][20] ; Number of used rows in array
			$iListViewColorsFonts_Index_MaxRows = $aListViewColorsFontsInfo[$iIndex][21] ; Max number of rows in array
		EndIf
		$aListViewColorsFonts          = $aListViewColorsFontsInfo[$iIndex][22] ; Array to store color/font info
		$iListViewColorsFonts          = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
		$iListViewColorsFonts_MaxRows  = $aListViewColorsFontsInfo[$iIndex][24] ; Max number of rows in array

		; Static variables
		$idLV       = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$bNative    = $aListViewColorsFontsInfo[$iIndex][8]  ; Native listview items
		$iColumns   = $aListViewColorsFontsInfo[$iIndex][9]  ; Number of listview columns
		$fOptions   = $aListViewColorsFontsInfo[$iIndex][14] ; Colors/fonts options
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors
		$iColOffset = $fSelected=0?3:$fSelected=1?5:7
		$iListViewColorsFontsInfo_Index = $iIndex
		$iListViewIndex = $iIndex

		; Static font variables
		$tLogFont  = $aListViewColorsFontsInfo[$iIndex][10]    ; LOGFONT data structure
		$hDefFont  = $aListViewColorsFontsInfo[$iIndex][11]    ; Default listview font
		$sFaceName = DllStructGetData( $tLogFont, "FaceName" ) ; Default listview font face name
		$iWeight   = DllStructGetData( $tLogFont, "Weight" )   ; Default listview font weight
	EndIf

	; Font and style
	Local $hFont = 0
	If IsPtr( $sFontName ) Then
		; Font handle
		Local $tstLOGFONT = DllStructCreate( $tagLOGFONT )
		If Not DllCall( "gdi32.dll", "int", "GetObjectW", "handle", $sFontName, "int", DllStructGetSize( $tstLOGFONT ), "struct*", $tstLOGFONT )[0] Then Return SetError(5, 0, -1) ; Invalid font ; _WinAPI_GetObject
		$hFont = $sFontName
	ElseIf $sFontName Or $iFontStyle Then
		; Font name
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFontName )

		; Font style
		Switch $iFontStyle
			Case 0 ; Normal
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", BitOR( $iWeight, $FW_BOLD ) )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", True )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", True )
			Case Else
				If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName ) ; Reset $tLogFont on error
				Return SetError(5, 0, -1)                                                ; Invalid font style
		EndSwitch

		$hFont = _WinAPI_CreateFontIndirect( $tLogFont )

		; Reset $tLogFont
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName )
		Switch $iFontStyle
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", $iWeight )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", False )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", False )
		EndSwitch

		If Not $hFont Then Return SetError(5, 0, -1) ; Invalid font name
	ElseIf $iSubItem < 0 Then
		$hFont = $hDefFont
	EndIf

	If Not ( IsInt( $iSubItem ) And $iSubItem < $iColumns ) Then Return SetError(4, 0, -1) ; Invalid listview subitem

	Local Static $tItem = DllStructCreate( $tagLVITEM ), $pItem = 0
	If Not $pItem Then
		DllStructSetData( $tItem, "Mask", $LVIF_PARAM )
		$pItem = DllStructGetPtr( $tItem )
	EndIf

	; Index in $aListViewColorsFonts is stored in ItemParam
	;$iIndex = _GUICtrlListView_GetItemParam( $idListView, $iItem )
	DllStructSetData( $tItem, "Item", $iItem )
	Local $i = $idLV ? GUICtrlSendMsg( $idLV, $LVM_GETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pItem )[0]
	$iIndex = DllStructGetData( $tItem, "Param" )

	; Colors/fonts for subitems? Default ($iSubItem = -1) is to set colors/fonts for the entire item.
	If Not $bListViewColorsFonts_Subitems And $iSubItem > -1 And $iSubItem < $iColumns Then
		ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iColumns]
		$bListViewColorsFonts_Subitems = True
	EndIf

	; Check whether there is room for more rows in $aListViewColorsFonts_Index and $aListViewColorsFonts
	; Store control ID in $aListViewColorsFonts_Index for native listview items
	; Store -$iIndex - 20 in listview ItemParam for non-native listview items
	If $bNative Then ; Native listview items
		; For native items control ID in ItemParam is used as index in $aListViewColorsFonts_Index
		Local $iIndex2 = $iIndex
		If $iIndex2 < 1 Then Return SetError(3, 0, -1) ; Invalid listview item
		If $iIndex2 >= $iListViewColorsFonts_Index Then $iListViewColorsFonts_Index = $iIndex2 + 1
		; Room for more rows in $aListViewColorsFonts_Index?
		If $iListViewColorsFonts_Index >= $iListViewColorsFonts_Index_MaxRows Then
			$iListViewColorsFonts_Index_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
			While $iListViewColorsFonts_Index >= $iListViewColorsFonts_Index_MaxRows
				$iListViewColorsFonts_Index_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
			WEnd
			ReDim $aListViewColorsFonts_Index[$iListViewColorsFonts_Index_MaxRows]
		EndIf
		If $aListViewColorsFonts_Index[$iIndex2] Then         ; Update existing colors/fonts
			$iIndex = $aListViewColorsFonts_Index[$iIndex2] - 1 ; $iIndex = $aListViewColorsFonts_Index[$iIndex2] - 1
		Else                                                  ; New colors/fonts info
			; Store new $iIndex + 1 in $aListViewColorsFonts_Index
			$iIndex = $iListViewColorsFonts
			$aListViewColorsFonts_Index[$iIndex2] = $iIndex + 1
			$iListViewColorsFonts += 1
			; Room for more rows in $aListViewColorsFonts?
			If $iListViewColorsFonts > $iListViewColorsFonts_MaxRows Then
				$iListViewColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
				$iCols = $bListViewColorsFonts_Subitems ? $iColumns : 0
				ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iCols]
			EndIf
		EndIf
	Else ; Non-native listview items
		If $iIndex < 0 And -$iIndex - 20 < $iListViewColorsFonts Then ; Update existing colors/fonts
			$iIndex = -$iIndex - 20 ; $iIndex = -ItemParam - 20
		Else                     ; New colors/fonts info
			; Store new -$iIndex - 20 in ItemParam
			$iIndex = $iListViewColorsFonts
			;If Not _GUICtrlListView_SetItemParam( $idListView, $iItem, -$iIndex - 20 ) Then Return SetError(3, 0, -1) ; Invalid listview item
			DllStructSetData( $tItem, "Param", -$iIndex - 20 )
			If Not ( $idLV ? GUICtrlSendMsg( $idLV, $LVM_SETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_SETITEMW, "wparam", 0, "lparam", $pItem )[0] ) Then Return SetError(3, 0, -1) ; Invalid listview item
			$iListViewColorsFonts += 1
			; Room for more rows in $aListViewColorsFonts?
			If $iListViewColorsFonts > $iListViewColorsFonts_MaxRows Then
				$iListViewColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
				$iCols = $bListViewColorsFonts_Subitems ? $iColumns : 0
				ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iCols]
			EndIf
		EndIf
	EndIf

	Local $iCol0, $n
	If BitAND( $fOptions, 64 ) Then
		; Store font in $aListViewColorsFonts
		$iCol0 = ( $iSubItem > -1 And $iSubItem < $iColumns ) ? $iColOffset + $iColOffset * $iSubItem : 0 ; Column offset
		Switch $fSelected
			Case 0
				If $aListViewColorsFonts[$iIndex][$iCol0+3] And $aListViewColorsFonts[$iIndex][$iCol0+3] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+3] )                        ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 ) : $aListViewColorsFonts[$iIndex][3] ; Store font in offset + 3
			Case 1
				If $aListViewColorsFonts[$iIndex][$iCol0+5] And $aListViewColorsFonts[$iIndex][$iCol0+5] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+5] )                        ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 ) : $aListViewColorsFonts[$iIndex][5] ; Store font in offset + 5
			Case 2
				If $aListViewColorsFonts[$iIndex][$iCol0+7] And $aListViewColorsFonts[$iIndex][$iCol0+7] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+7] )                        ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+7] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 ) : $aListViewColorsFonts[$iIndex][7] ; Store font in offset + 7
		EndSwitch
		$aListViewColorsFonts[$iIndex][0] = BitOR( $aListViewColorsFonts[$iIndex][0], $iCol0 ? ($fSelected=0?2:$fSelected=1?2+8:2+8+32) : ($fSelected=0?1:$fSelected=1?1+4:1+4+16) )                           ; Set status in column 0

		; Reset $aListViewColorsFonts[$iIndex][0]?
		If Not $hFont Then
			If $iSubItem < 0 Then
				; Reset default item font
				If $aListViewColorsFonts[$iIndex][$iColOffset] = $aDefaults[0] Then $aListViewColorsFonts[$iIndex][$iColOffset] = 0
				; Reset item info only if colors are default colors
				For $i = 1 To $iColOffset - 1
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $iColOffset Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?1:$fSelected=1?1+4:1+4+16)
			Else
				$n = $iColOffset + 1 + $iColOffset * $iColumns
				For $i = $iColOffset + 1 To $n - 1
					; Reset default subitem fonts
					If Not Mod($i,7) And $aListViewColorsFonts[$iIndex][$i] = $aDefaults[0] Then $aListViewColorsFonts[$iIndex][$i] = 0
					; Reset subitem info only if all subitem values are default values
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $n Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?2:$fSelected=1?2+8:2+8+32)
			EndIf
		EndIf

	Else ; Not BitAND( $fOptions, 64 )
		; Store font in $aListViewColorsFonts
		$iCol0 = ( $iSubItem > -1 And $iSubItem < $iColumns ) ? $iColOffset + $iColOffset * $iSubItem : 0 ; Column offset
		Switch $fSelected
			Case 0
				If $aListViewColorsFonts[$iIndex][$iCol0+3] And $aListViewColorsFonts[$iIndex][$iCol0+3] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+3] ) ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[0] : $aListViewColorsFonts[$iIndex][3]             ; Store font in offset + 3
			Case 1
				If $aListViewColorsFonts[$iIndex][$iCol0+5] And $aListViewColorsFonts[$iIndex][$iCol0+5] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+5] ) ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[0] : $aListViewColorsFonts[$iIndex][5]             ; Store font in offset + 5
			Case 2
				If $aListViewColorsFonts[$iIndex][$iCol0+7] And $aListViewColorsFonts[$iIndex][$iCol0+7] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+7] ) ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+7] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[0] : $aListViewColorsFonts[$iIndex][7]             ; Store font in offset + 7
		EndSwitch
		$aListViewColorsFonts[$iIndex][0] = BitOR( $aListViewColorsFonts[$iIndex][0], $iCol0 ? ($fSelected=0?2:$fSelected=1?2+8:2+8+32) : ($fSelected=0?1:$fSelected=1?1+4:1+4+16) )    ; Set status in column 0

		If Not $hFont Then
			; Reset $aListViewColorsFonts[$iIndex][0]?
			If $iSubItem < 0 Then ; Reset item info only if colors are default colors
				For $i = 1 To $iColOffset - 1
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $iColOffset Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?1:$fSelected=1?1+4:1+4+16)
			Else ; Reset subitem info only if all subitem values are default values
				$n = $iColOffset + 1 + $iColOffset * $iColumns
				For $i = $iColOffset + 1 To $n - 1
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $n Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?2:$fSelected=1?2+8:2+8+32)
			EndIf
		EndIf
	EndIf

	$bListViewColorsFonts_Save = True
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_SetItemColorsFonts
; Description ...: Sets font name and font style as well as back and fore colors for listview items and subitems
; Syntax ........: ListViewColorsFonts_SetItemColorsFonts( $idListView, $iItem, $iSubItem = -1, $sFontName = "", $iFontStyle = 0, $iBackColor = 0, $iForeColor = 0, $iBackSelect = 0, $iForeSelect = 0, $iBackUnfocus = 0, $iForeUnfocus = 0 )
; Parameters ....: $idListView   - Listview control ID or handle
;                  $iItem        - Zero based item (row) index
;                  $iSubItem     - Zero based subitem (column) index
;                  $sFontName    - Font face name of item or subitem
;                                  Or a valid font handle (pointer)
;                  $iFontStyle   - Text style of item or subitem
;                                  Use the following values for $iFontStyle
;                                      0: Normal text style (default)
;                                      1: Bold text style
;                                      2: Italic text style
;                                      3: Underline text style
;                                  These predefined constants can also be used:
;                                  $iFontStyleNormal, $iFontStyleBold, $iFontStyleItalic, $iFontStyleUnderline
;                                  If $sFontName is a font handle $iFontStyle is ignored
;                  $iBackColor   - Background color of item or subitem
;                                  Default value 0 results in a white background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeColor   - Fore (text) color of item or subitem
;                                  Default value 0 is a black fore color
;                  $iBackSelect  - Background color of selected item or subitem when listview has focus
;                                  Default value 0 results in a dark blue ($COLOR_HIGHLIGHT) background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeSelect  - Fore (text) color of selected item or subitem when listview has focus
;                                  Default value 0 results in a white fore color
;                                  Because 0 is also the value of the black color a black fore color cannot be specified
;                  $iBackUnfocus - Background color of selected item or subitem when listview has not focus
;                                  Default value 0 results in a button face ($COLOR_BTNFACE) background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeUnfocus - Fore (text) color of selected item or subitem when listview has not focus
;                                  Default value 0 is a black fore color
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - This function requires that $fColorsFonts includes 1/2/4
;                            2 - Listview not found
;                            3 - Invalid listview item
;                            4 - Invalid listview subitem
;                            5 - Invalid font or style
;                            6 - Too many color parameters
;                            7 - Invalid color value
; Remarks .......: ListViewColorsFonts_SetItemColorsFonts is a combination of the functions ListViewColorsFonts_SetItemColors and
;                  ListViewColorsFonts_SetItemFonts. Then you don't have to call two functions if you want to add both colors and
;                  fonts to an item or a subitem.
;
;                  Because ItemParam is used as index in $aListViewColorsFonts or $aListViewColorsFonts_Index, items must be
;                  created before information about colors/fonts is added to the items.
;
;                  $iBackSelect and $iForeSelect requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 128/256.
;                  $iBackUnfocus and $iForeUnfocus requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 256.
;
;                  Note that the possibility to define colors/font for an entire item and then define another color/font for a single
;                  subitem, is not available if flag 64 is specified in ListViewColorsFonts_Init. If flag 64 is specified colors/fonts
;                  must be defined for all subitems.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_SetItemColorsFonts\
;                  See Examples\7) Original examples\lvCustDrawFonts.au3 for an example where $sFontName is a valid font handle
;
; Example 1 .....: Set a bold style and a red fore color for an entire item as well as a bold style and a blue fore color for a single cell
;                  ListViewColorsFonts_SetItemColorsFonts( $idListView, $iItem, -1, "", $iFontStyleBold, 0, 0xFF0000 ) ; Bold style and red fore color for entire item
;                  ListViewColorsFonts_SetItemColorsFonts( $idListView, $iItem,  2, "", $iFontStyleBold, 0, 0x0000FF ) ; Bold style and blue fore color for cell 2 in item
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_SetItemColorsFonts( $idListView, $iItem, $iSubItem = -1, $sFontName = "", $iFontStyle = 0, $iBackColor = 0, $iForeColor = 0, $iBackSelect = 0, $iForeSelect = 0, $iBackUnfocus = 0, $iForeUnfocus = 0 )
	Local Static $bNative, $fOptions, $fSelected, $iColumns = 0, $fDefaults, $aDefaults, $iColOffset ; Keep these variables between function calls to avoid recalculation
	Local Static $idListViewPrev = 0, $iListViewIndex = 0, $hListView, $idLV  ; Variables to check if $aListViewColorsFonts must be stored and replaced
	Local Static $tLogFont, $hDefFont, $sFaceName, $iWeight                   ; Keep these variables between function calls to avoid recalculation
	Local $iIndex, $iCols

	If $iSubItem     = Default Then $iSubItem     = -1
	If $sFontName    = Default Then $sFontName    = ""
	If $iFontStyle   = Default Then $iFontStyle   = 0
	If $iBackColor   = Default Then $iBackColor   = 0
	If $iForeColor   = Default Then $iForeColor   = 0
	If $iBackSelect  = Default Then $iBackSelect  = 0
	If $iForeSelect  = Default Then $iForeSelect  = 0
	If $iBackUnfocus = Default Then $iBackUnfocus = 0
	If $iForeUnfocus = Default Then $iForeUnfocus = 0

	; $aListViewColorsFonts is a global array to store information about colors/fonts. An array per listview.
	; If the previous listview is replaced with a new listview, the global array must also be replaced with a new array.
	If $idListViewPrev <> $idListView _                        ; New listview? $aListViewColorsFonts must be stored and replaced.
	Or $iListViewIndex <> $iListViewColorsFontsInfo_Index Then ; Is the global array replaced with a new array in ListViewColorsFonts_SetItemColors/Fonts functions?
		If $bListViewColorsFonts_Save And $iListViewColorsFontsInfo_Index Then
			; Store previous $aListViewColorsFonts in $aListViewColorsFontsInfo
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][18] = $bListViewColorsFonts_Subitems
			If $aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][8] Then
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][19] = $aListViewColorsFonts_Index
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][20] = $iListViewColorsFonts_Index
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][21] = $iListViewColorsFonts_Index_MaxRows
			EndIf
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][22] = $aListViewColorsFonts
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][23] = $iListViewColorsFonts
			$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][24] = $iListViewColorsFonts_MaxRows
			$bListViewColorsFonts_Save = False
		EndIf

		; Find listview
		$hListView = $idListView
		If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
		For $iIndex = 1 To $iListViewColorsFontsInfo - 1
			If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
		Next
		If $iIndex = $iListViewColorsFontsInfo Then Return SetError(2, 0, -1) ; Listview not found
		$idListViewPrev = $idListView

		; $fColorsFonts must include 1/2/4
		If Not BitAND( $aListViewColorsFontsInfo[$iIndex][14], 7 ) Then Return SetError(1, 0, -1)

		; Get $aListViewColorsFonts for current listview
		$bListViewColorsFonts_Subitems = $aListViewColorsFontsInfo[$iIndex][18] ; Info for subitems: true/false
		If $aListViewColorsFontsInfo[$iIndex][8] Then
			$aListViewColorsFonts_Index         = $aListViewColorsFontsInfo[$iIndex][19] ; Index array for native items
			$iListViewColorsFonts_Index         = $aListViewColorsFontsInfo[$iIndex][20] ; Number of used rows in array
			$iListViewColorsFonts_Index_MaxRows = $aListViewColorsFontsInfo[$iIndex][21] ; Max number of rows in array
		EndIf
		$aListViewColorsFonts          = $aListViewColorsFontsInfo[$iIndex][22] ; Array to store color/font info
		$iListViewColorsFonts          = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
		$iListViewColorsFonts_MaxRows  = $aListViewColorsFontsInfo[$iIndex][24] ; Max number of rows in array

		; Static variables
		$idLV       = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$bNative    = $aListViewColorsFontsInfo[$iIndex][8]  ; Native listview items
		$iColumns   = $aListViewColorsFontsInfo[$iIndex][9]  ; Number of listview columns
		$fOptions   = $aListViewColorsFontsInfo[$iIndex][14] ; Colors/fonts options
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors
		$iColOffset = $fSelected=0?3:$fSelected=1?5:7
		$iListViewColorsFontsInfo_Index = $iIndex
		$iListViewIndex = $iIndex

		; Static font variables
		$tLogFont  = $aListViewColorsFontsInfo[$iIndex][10]    ; LOGFONT data structure
		$hDefFont  = $aListViewColorsFontsInfo[$iIndex][11]    ; Default listview font
		$sFaceName = DllStructGetData( $tLogFont, "FaceName" ) ; Default listview font face name
		$iWeight   = DllStructGetData( $tLogFont, "Weight" )   ; Default listview font weight
	EndIf

	; Font and style
	Local $hFont = 0
	If IsPtr( $sFontName ) Then
		; Font handle
		Local $tstLOGFONT = DllStructCreate( $tagLOGFONT )
		If Not DllCall( "gdi32.dll", "int", "GetObjectW", "handle", $sFontName, "int", DllStructGetSize( $tstLOGFONT ), "struct*", $tstLOGFONT )[0] Then Return SetError(5, 0, -1) ; Invalid font ; _WinAPI_GetObject
		$hFont = $sFontName
	ElseIf $sFontName Or $iFontStyle Then
		; Font name
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFontName )

		; Font style
		Switch $iFontStyle
			Case 0 ; Normal
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", BitOR( $iWeight, $FW_BOLD ) )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", True )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", True )
			Case Else
				If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName ) ; Reset $tLogFont on error
				Return SetError(5, 0, -1)                                                ; Invalid font style
		EndSwitch

		$hFont = _WinAPI_CreateFontIndirect( $tLogFont )

		; Reset $tLogFont
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName )
		Switch $iFontStyle
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", $iWeight )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", False )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", False )
		EndSwitch

		If Not $hFont Then Return SetError(5, 0, -1) ; Invalid font name
	ElseIf $iSubItem < 0 Then
		$hFont = $hDefFont
	EndIf

	; Number of parameters
	Switch $fSelected
		Case 0
			If @NumParams > 7 Then Return SetError(6, 0, -1) ; Too many color parameters
		Case 1
			If @NumParams > 9 Then Return SetError(6, 0, -1) ; Too many color parameters
	EndSwitch

	; Valid color values?
	If BitAND( $iBackColor, 0xFF000000 ) Or BitAND( $iForeColor, 0xFF000000 ) Or BitAND( $iBackSelect, 0xFF000000 ) Or BitAND( $iForeSelect, 0xFF000000 ) Or BitAND( $iBackUnfocus, 0xFF000000 ) Or BitAND( $iForeUnfocus, 0xFF000000 ) Then Return SetError(7, 0, -1) ; Invalid color value

	If Not ( IsInt( $iSubItem ) And $iSubItem < $iColumns ) Then Return SetError(4, 0, -1) ; Invalid listview subitem

	Local Static $tItem = DllStructCreate( $tagLVITEM ), $pItem = 0
	If Not $pItem Then
		DllStructSetData( $tItem, "Mask", $LVIF_PARAM )
		$pItem = DllStructGetPtr( $tItem )
	EndIf

	; Index in $aListViewColorsFonts is stored in ItemParam
	;$iIndex = _GUICtrlListView_GetItemParam( $idListView, $iItem )
	DllStructSetData( $tItem, "Item", $iItem )
	Local $i = $idLV ? GUICtrlSendMsg( $idLV, $LVM_GETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pItem )[0]
	$iIndex = DllStructGetData( $tItem, "Param" )

	; Colors/fonts for subitems? Default ($iSubItem = -1) is to set colors/fonts for the entire item.
	If Not $bListViewColorsFonts_Subitems And $iSubItem > -1 And $iSubItem < $iColumns Then
		ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iColumns]
		$bListViewColorsFonts_Subitems = True
	EndIf

	; Check whether there is room for more rows in $aListViewColorsFonts_Index and $aListViewColorsFonts
	; Store control ID in $aListViewColorsFonts_Index for native listview items
	; Store -$iIndex - 20 in listview ItemParam for non-native listview items
	If $bNative Then ; Native listview items
		; For native items control ID in ItemParam is used as index in $aListViewColorsFonts_Index
		Local $iIndex2 = $iIndex
		If $iIndex2 < 1 Then Return SetError(3, 0, -1) ; Invalid listview item
		If $iIndex2 >= $iListViewColorsFonts_Index Then $iListViewColorsFonts_Index = $iIndex2 + 1
		; Room for more rows in $aListViewColorsFonts_Index?
		If $iListViewColorsFonts_Index >= $iListViewColorsFonts_Index_MaxRows Then
			$iListViewColorsFonts_Index_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
			While $iListViewColorsFonts_Index >= $iListViewColorsFonts_Index_MaxRows
				$iListViewColorsFonts_Index_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
			WEnd
			ReDim $aListViewColorsFonts_Index[$iListViewColorsFonts_Index_MaxRows]
		EndIf
		If $aListViewColorsFonts_Index[$iIndex2] Then         ; Update existing colors/fonts
			$iIndex = $aListViewColorsFonts_Index[$iIndex2] - 1 ; $iIndex = $aListViewColorsFonts_Index[$iIndex2] - 1
		Else                                                  ; New colors/fonts info
			; Store new $iIndex + 1 in $aListViewColorsFonts_Index
			$iIndex = $iListViewColorsFonts
			$aListViewColorsFonts_Index[$iIndex2] = $iIndex + 1
			$iListViewColorsFonts += 1
			; Room for more rows in $aListViewColorsFonts?
			If $iListViewColorsFonts > $iListViewColorsFonts_MaxRows Then
				$iListViewColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
				$iCols = $bListViewColorsFonts_Subitems ? $iColumns : 0
				ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iCols]
			EndIf
		EndIf
	Else ; Non-native listview items
		If $iIndex < 0 And -$iIndex - 20 < $iListViewColorsFonts Then ; Update existing colors/fonts
			$iIndex = -$iIndex - 20 ; $iIndex = -ItemParam - 20
		Else                     ; New colors/fonts info
			; Store new -$iIndex - 20 in ItemParam
			$iIndex = $iListViewColorsFonts
			;If Not _GUICtrlListView_SetItemParam( $idListView, $iItem, -$iIndex - 20 ) Then Return SetError(3, 0, -1) ; Invalid listview item
			DllStructSetData( $tItem, "Param", -$iIndex - 20 )
			If Not ( $idLV ? GUICtrlSendMsg( $idLV, $LVM_SETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_SETITEMW, "wparam", 0, "lparam", $pItem )[0] ) Then Return SetError(3, 0, -1) ; Invalid listview item
			$iListViewColorsFonts += 1
			; Room for more rows in $aListViewColorsFonts?
			If $iListViewColorsFonts > $iListViewColorsFonts_MaxRows Then
				$iListViewColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iListViewIndex][25]
				$iCols = $bListViewColorsFonts_Subitems ? $iColumns : 0
				ReDim $aListViewColorsFonts[$iListViewColorsFonts_MaxRows][$iColOffset+1+$iColOffset*$iCols]
			EndIf
		EndIf
	EndIf

	Local $iCol0, $n
	If BitAND( $fOptions, 64 ) Then
		; Store colors and font in $aListViewColorsFonts
		$iCol0 = ( $iSubItem > -1 And $iSubItem < $iColumns ) ? $iColOffset + $iColOffset * $iSubItem : 0 ; Column offset
		Switch $fSelected
			Case 0
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor ? BitOR( BitAND( $iBackColor, 0x00FF00 ), BitShift( BitAND( $iBackColor, 0x0000FF ), -16 ), BitShift( BitAND( $iBackColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 ) : $aListViewColorsFonts[$iIndex][1]         ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor ? BitOR( BitAND( $iForeColor, 0x00FF00 ), BitShift( BitAND( $iForeColor, 0x0000FF ), -16 ), BitShift( BitAND( $iForeColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 ) : $aListViewColorsFonts[$iIndex][2]         ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				If $aListViewColorsFonts[$iIndex][$iCol0+3] And $aListViewColorsFonts[$iIndex][$iCol0+3] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+3] )                                                                                                                                                                          ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 ) : $aListViewColorsFonts[$iIndex][3]                                                                                                                                                   ; Store font in offset + 3
			Case 1
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor  ? BitOR( BitAND( $iBackColor,  0x00FF00 ), BitShift( BitAND( $iBackColor,  0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 ) : $aListViewColorsFonts[$iIndex][1]     ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor  ? BitOR( BitAND( $iForeColor,  0x00FF00 ), BitShift( BitAND( $iForeColor,  0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 ) : $aListViewColorsFonts[$iIndex][2]     ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect ? BitOR( BitAND( $iBackSelect, 0x00FF00 ), BitShift( BitAND( $iBackSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  8 ) ? $aDefaults[3] : 0 ) : $aListViewColorsFonts[$iIndex][3]     ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect ? BitOR( BitAND( $iForeSelect, 0x00FF00 ), BitShift( BitAND( $iForeSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 16 ) ? $aDefaults[4] : 0 ) : $aListViewColorsFonts[$iIndex][4]     ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
				If $aListViewColorsFonts[$iIndex][$iCol0+5] And $aListViewColorsFonts[$iIndex][$iCol0+5] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+5] )                                                                                                                                                                          ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 ) : $aListViewColorsFonts[$iIndex][5]                                                                                                                                                   ; Store font in offset + 5
			Case 2
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor   ? BitOR( BitAND( $iBackColor,   0x00FF00 ), BitShift( BitAND( $iBackColor,   0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 ) : $aListViewColorsFonts[$iIndex][1] ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor   ? BitOR( BitAND( $iForeColor,   0x00FF00 ), BitShift( BitAND( $iForeColor,   0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 ) : $aListViewColorsFonts[$iIndex][2] ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect  ? BitOR( BitAND( $iBackSelect,  0x00FF00 ), BitShift( BitAND( $iBackSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  8 ) ? $aDefaults[3] : 0 ) : $aListViewColorsFonts[$iIndex][3] ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect  ? BitOR( BitAND( $iForeSelect,  0x00FF00 ), BitShift( BitAND( $iForeSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 16 ) ? $aDefaults[4] : 0 ) : $aListViewColorsFonts[$iIndex][4] ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $iBackUnfocus ? BitOR( BitAND( $iBackUnfocus, 0x00FF00 ), BitShift( BitAND( $iBackUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iBackUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 32 ) ? $aDefaults[5] : 0 ) : $aListViewColorsFonts[$iIndex][5] ; Store unfocused back color in offset + 5 ; ListViewColorsFonts_ColorConvert( $iBackUnfocus )
				$aListViewColorsFonts[$iIndex][$iCol0+6] = $iForeUnfocus ? BitOR( BitAND( $iForeUnfocus, 0x00FF00 ), BitShift( BitAND( $iForeUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iForeUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults, 64 ) ? $aDefaults[6] : 0 ) : $aListViewColorsFonts[$iIndex][6] ; Store unfocused fore color in offset + 6 ; ListViewColorsFonts_ColorConvert( $iForeUnfocus )
				If $aListViewColorsFonts[$iIndex][$iCol0+7] And $aListViewColorsFonts[$iIndex][$iCol0+7] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+7] )                                                                                                                                                                          ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+7] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 ) : $aListViewColorsFonts[$iIndex][7]                                                                                                                                                   ; Store font in offset + 7
		EndSwitch
		$aListViewColorsFonts[$iIndex][0] = BitOR( $aListViewColorsFonts[$iIndex][0], $iCol0 ? ($fSelected=0?2:$fSelected=1?2+8:2+8+32) : ($fSelected=0?1:$fSelected=1?1+4:1+4+16) ) ; Set status in column 0

		; Reset $aListViewColorsFonts[$iIndex][0]?
		If Not $hFont And Not ( $iBackColor Or $iForeColor Or $iBackSelect Or $iForeSelect Or $iBackUnfocus Or $iForeUnfocus ) Then
			If $iSubItem < 0 Then ; Item
				; Reset default item colors
				For $i = 1 To $iColOffset - 1
					If $aListViewColorsFonts[$iIndex][$i] = $aDefaults[$i] Then $aListViewColorsFonts[$iIndex][$i] = 0
				Next
				; Reset default item font
				If $aListViewColorsFonts[$iIndex][$iColOffset] = $aDefaults[0] Then $aListViewColorsFonts[$iIndex][$iColOffset] = 0
				; Reset item info only if colors are default colors and font is default font
				For $i = 1 To $iColOffset
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $iColOffset + 1 Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?1:$fSelected=1?1+4:1+4+16)
			Else ; Subitem
				$n = $iColOffset + 1 + $iColOffset * $iColumns
				For $i = $iColOffset + 1 To $n - 1
					; Reset default subitem colors
					If Mod($i,7) And $aListViewColorsFonts[$iIndex][$i] = $aDefaults[Mod($i,7)] Then $aListViewColorsFonts[$iIndex][$i] = 0
					; Reset default subitem fonts
					If Not Mod($i,7) And $aListViewColorsFonts[$iIndex][$i] = $aDefaults[0] Then $aListViewColorsFonts[$iIndex][$i] = 0
					; Reset subitem info only if all subitem values are default values
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $n Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?2:$fSelected=1?2+8:2+8+32)
				; Reset default item colors and font
				For $i = 1 To $iColOffset
					If $aListViewColorsFonts[$iIndex][$i] = $aDefaults[$i] Then $aListViewColorsFonts[$iIndex][$i] = 0
				Next
			EndIf
		EndIf

	Else ; Not BitAND( $fOptions, 64 )
		; Store colors and font in $aListViewColorsFonts
		$iCol0 = ( $iSubItem > -1 And $iSubItem < $iColumns ) ? $iColOffset + $iColOffset * $iSubItem : 0 ; Column offset
		Switch $fSelected
			Case 0
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor ? BitOR( BitAND( $iBackColor, 0x00FF00 ), BitShift( BitAND( $iBackColor, 0x0000FF ), -16 ), BitShift( BitAND( $iBackColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[1] : $aListViewColorsFonts[$iIndex][1]         ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor ? BitOR( BitAND( $iForeColor, 0x00FF00 ), BitShift( BitAND( $iForeColor, 0x0000FF ), -16 ), BitShift( BitAND( $iForeColor, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[2] : $aListViewColorsFonts[$iIndex][2]         ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				If $aListViewColorsFonts[$iIndex][$iCol0+3] And $aListViewColorsFonts[$iIndex][$iCol0+3] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+3] )                                                                                                                                       ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[0] : $aListViewColorsFonts[$iIndex][3]                                                                                                                                                   ; Store font in offset + 3
			Case 1
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor  ? BitOR( BitAND( $iBackColor,  0x00FF00 ), BitShift( BitAND( $iBackColor,  0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[1] : $aListViewColorsFonts[$iIndex][1]     ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor  ? BitOR( BitAND( $iForeColor,  0x00FF00 ), BitShift( BitAND( $iForeColor,  0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[2] : $aListViewColorsFonts[$iIndex][2]     ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect ? BitOR( BitAND( $iBackSelect, 0x00FF00 ), BitShift( BitAND( $iBackSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[3] : $aListViewColorsFonts[$iIndex][3]     ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect ? BitOR( BitAND( $iForeSelect, 0x00FF00 ), BitShift( BitAND( $iForeSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[4] : $aListViewColorsFonts[$iIndex][4]     ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
				If $aListViewColorsFonts[$iIndex][$iCol0+5] And $aListViewColorsFonts[$iIndex][$iCol0+5] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+5] )                                                                                                                                       ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[0] : $aListViewColorsFonts[$iIndex][5]                                                                                                                                                   ; Store font in offset + 5
			Case 2
				$aListViewColorsFonts[$iIndex][$iCol0+1] = $iBackColor   ? BitOR( BitAND( $iBackColor,   0x00FF00 ), BitShift( BitAND( $iBackColor,   0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[1] : $aListViewColorsFonts[$iIndex][1] ; Store back color in offset + 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
				$aListViewColorsFonts[$iIndex][$iCol0+2] = $iForeColor   ? BitOR( BitAND( $iForeColor,   0x00FF00 ), BitShift( BitAND( $iForeColor,   0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,   0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[2] : $aListViewColorsFonts[$iIndex][2] ; Store fore color in offset + 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
				$aListViewColorsFonts[$iIndex][$iCol0+3] = $iBackSelect  ? BitOR( BitAND( $iBackSelect,  0x00FF00 ), BitShift( BitAND( $iBackSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[3] : $aListViewColorsFonts[$iIndex][3] ; Store selected back color in offset + 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+4] = $iForeSelect  ? BitOR( BitAND( $iForeSelect,  0x00FF00 ), BitShift( BitAND( $iForeSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect,  0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[4] : $aListViewColorsFonts[$iIndex][4] ; Store selected fore color in offset + 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
				$aListViewColorsFonts[$iIndex][$iCol0+5] = $iBackUnfocus ? BitOR( BitAND( $iBackUnfocus, 0x00FF00 ), BitShift( BitAND( $iBackUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iBackUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[5] : $aListViewColorsFonts[$iIndex][5] ; Store unfocused back color in offset + 5 ; ListViewColorsFonts_ColorConvert( $iBackUnfocus )
				$aListViewColorsFonts[$iIndex][$iCol0+6] = $iForeUnfocus ? BitOR( BitAND( $iForeUnfocus, 0x00FF00 ), BitShift( BitAND( $iForeUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iForeUnfocus, 0xFF0000 ), 16 ) ) : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[6] : $aListViewColorsFonts[$iIndex][6] ; Store unfocused fore color in offset + 6 ; ListViewColorsFonts_ColorConvert( $iForeUnfocus )
				If $aListViewColorsFonts[$iIndex][$iCol0+7] And $aListViewColorsFonts[$iIndex][$iCol0+7] <> $hDefFont Then _WinAPI_DeleteObject( $aListViewColorsFonts[$iIndex][$iCol0+7] )                                                                                                                                       ; Delete previous font (but not the default font)
				$aListViewColorsFonts[$iIndex][$iCol0+7] = $hFont ? $hFont : BitAND( $aListViewColorsFonts[$iIndex][0], 1 ) ? $aDefaults[0] : $aListViewColorsFonts[$iIndex][7]                                                                                                                                                   ; Store font in offset + 7
		EndSwitch
		$aListViewColorsFonts[$iIndex][0] = BitOR( $aListViewColorsFonts[$iIndex][0], $iCol0 ? ($fSelected=0?2:$fSelected=1?2+8:2+8+32) : ($fSelected=0?1:$fSelected=1?1+4:1+4+16) ) ; Set status in column 0

		If Not $hFont And Not ( $iBackColor Or $iForeColor Or $iBackSelect Or $iForeSelect Or $iBackUnfocus Or $iForeUnfocus ) Then
			; Reset $aListViewColorsFonts[$iIndex][0]?
			If $iSubItem < 0 Then ; Reset item info only if colors are default colors and font is default font
				For $i = 1 To $iColOffset
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $iColOffset + 1 Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?1:$fSelected=1?1+4:1+4+16)
			Else ; Reset subitem info only if all subitem values are default values
				$n = $iColOffset + 1 + $iColOffset * $iColumns
				For $i = $iColOffset + 1 To $n - 1
					If $aListViewColorsFonts[$iIndex][$i] Then ExitLoop
				Next
				If $i = $n Then $aListViewColorsFonts[$iIndex][0] -= ($fSelected=0?2:$fSelected=1?2+8:2+8+32)
			EndIf
		EndIf
	EndIf

	$bListViewColorsFonts_Save = True
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_SetColumnColorsFonts
; Description ...: Sets font name and font style as well as back and fore colors for entire listview columns
; Syntax ........: ListViewColorsFonts_SetColumnColorsFonts( $idListView, $iColumn, $sFontName = "", $iFontStyle = 0, $iBackColor = 0, $iForeColor = 0, $iBackSelect = 0, $iForeSelect = 0, $iBackUnfocus = 0, $iForeUnfocus = 0 )
; Parameters ....: $idListView   - Listview control ID or handle
;                  $iColumn      - Zero based column index
;                  $sFontName    - Font face name of column item
;                                  Or a valid font handle (pointer)
;                  $iFontStyle   - Text style of column item
;                                  Use the following values for $iFontStyle
;                                      0: Normal text style (default)
;                                      1: Bold text style
;                                      2: Italic text style
;                                      3: Underline text style
;                                  These predefined constants can also be used:
;                                  $iFontStyleNormal, $iFontStyleBold, $iFontStyleItalic, $iFontStyleUnderline
;                                  If $sFontName is a font handle $iFontStyle is ignored
;                  $iBackColor   - Background color of column item
;                                  Default value 0 results in a white background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeColor   - Fore (text) color of column item
;                                  Default value 0 is a black fore color
;                  $iBackSelect  - Background color of selected column item when listview has focus
;                                  Default value 0 results in a dark blue ($COLOR_HIGHLIGHT) background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeSelect  - Fore (text) color of selected column item when listview has focus
;                                  Default value 0 results in a white fore color
;                                  Because 0 is also the value of the black color a black fore color cannot be specified
;                  $iBackUnfocus - Background color of selected column item when listview has not focus
;                                  Default value 0 results in a button face ($COLOR_BTNFACE) background
;                                  Because 0 is also the value of the black color a black background color cannot be specified
;                  $iForeUnfocus - Fore (text) color of selected column item when listview has not focus
;                                  Default value 0 is a black fore color
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - This function requires that $fColorsFonts includes 8
;                            2 - Listview not found
;                            3 - Invalid column index
;                            4 - Invalid font or style
;                            5 - Too many color parameters
;                            6 - Invalid color value
; Remarks .......: $iBackSelect and $iForeSelect requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 128/256.
;                  $iBackUnfocus and $iForeUnfocus requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 256.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_SetColumnColorsFonts\
;
; Example 1 .....: Set blue back color for column 0 and red back color for column 2
;                  ListViewColorsFonts_SetColumnColorsFonts( $idListView, 0, "", 0, 0xCCCCFF ) ; Column 0: Back color = Blue
;                  ListViewColorsFonts_SetColumnColorsFonts( $idListView, 2, "", 0, 0xFFCCCC ) ; Column 2: Back color = Red
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_SetColumnColorsFonts( $idListView, $iColumn, $sFontName = "", $iFontStyle = 0, $iBackColor = 0, $iForeColor = 0, $iBackSelect = 0, $iForeSelect = 0, $iBackUnfocus = 0, $iForeUnfocus = 0 )
	If $sFontName    = Default Then $sFontName    = ""
	If $iFontStyle   = Default Then $iFontStyle   = 0
	If $iBackColor   = Default Then $iBackColor   = 0
	If $iForeColor   = Default Then $iForeColor   = 0
	If $iBackSelect  = Default Then $iBackSelect  = 0
	If $iForeSelect  = Default Then $iForeSelect  = 0
	If $iBackUnfocus = Default Then $iBackUnfocus = 0
	If $iForeUnfocus = Default Then $iForeUnfocus = 0

	; Find listview
	Local $hListView = $idListView
	If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
	Next
	If $iIndex = $iListViewColorsFontsInfo Then Return SetError(2, 0, -1) ; Listview not found

	; $fColorsFonts must include 8
	If Not BitAND( $aListViewColorsFontsInfo[$iIndex][14], 8 ) Then Return SetError(1, 0, -1)

	; Get $aColumnColorsFonts for current listview
	Local $aColumnColorsFonts          = $aListViewColorsFontsInfo[$iIndex][22] ; Array to store color/font info
	Local $iColumnColorsFonts          = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
	Local $iColumnColorsFonts_MaxRows  = $aListViewColorsFontsInfo[$iIndex][24] ; Max number of rows in array

	; Local variables
	Local $iColumns  = $aListViewColorsFontsInfo[$iIndex][9]  ; Number of listview columns
	Local $fSelected = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
	Local $fDefaults = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
	Local $aDefaults = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors

	; Local font variables
	Local $tLogFont  = $aListViewColorsFontsInfo[$iIndex][10]
	Local $sFaceName = DllStructGetData( $tLogFont, "FaceName" ) ; Default listview font face name
	Local $iWeight   = DllStructGetData( $tLogFont, "Weight" )   ; Default listview font weight

	; Font and style
	Local $hFont = 0
	If IsPtr( $sFontName ) Then
		; Font handle
		Local $tstLOGFONT = DllStructCreate( $tagLOGFONT )
		If Not DllCall( "gdi32.dll", "int", "GetObjectW", "handle", $sFontName, "int", DllStructGetSize( $tstLOGFONT ), "struct*", $tstLOGFONT )[0] Then Return SetError(4, 0, -1) ; Invalid font ; _WinAPI_GetObject
		$hFont = $sFontName
	ElseIf $sFontName Or $iFontStyle Then
		; Font name
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFontName )

		; Font style
		Switch $iFontStyle
			Case 0 ; Normal
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", BitOR( $iWeight, $FW_BOLD ) )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", True )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", True )
			Case Else
				If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName ) ; Reset $tLogFont on error
				Return SetError(4, 0, -1)                                                ; Invalid font style
		EndSwitch

		$hFont = _WinAPI_CreateFontIndirect( $tLogFont )

		; Reset $tLogFont
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName )
		Switch $iFontStyle
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", $iWeight )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", False )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", False )
		EndSwitch

		If Not $hFont Then Return SetError(4, 0, -1) ; Invalid font name
	EndIf

	; Number of parameters
	Switch $fSelected
		Case 0
			If @NumParams > 6 Then Return SetError(5, 0, -1) ; Too many color parameters
		Case 1
			If @NumParams > 8 Then Return SetError(5, 0, -1) ; Too many color parameters
	EndSwitch

	; Valid color values?
	If BitAND( $iBackColor, 0xFF000000 ) Or BitAND( $iForeColor, 0xFF000000 ) Or BitAND( $iBackSelect, 0xFF000000 ) Or BitAND( $iForeSelect, 0xFF000000 ) Or BitAND( $iBackUnfocus, 0xFF000000 ) Or BitAND( $iForeUnfocus, 0xFF000000 ) Then Return SetError(6, 0, -1) ; Invalid color value

	If Not ( IsInt( $iColumn ) And $iColumn >= 0 And $iColumn < $iColumns ) Then Return SetError(3, 0, -1) ; Invalid column index

	; Check whether there is room for more columns in $aColumnColorsFonts
	If $iColumn >= $iColumnColorsFonts_MaxRows Then
		$iColumnColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iIndex][25]
		While $iColumn >= $iColumnColorsFonts_MaxRows
			$iColumnColorsFonts_MaxRows += $aListViewColorsFontsInfo[$iIndex][25]
		WEnd
		ReDim $aColumnColorsFonts[$iColumnColorsFonts_MaxRows][8]
	EndIf

	; Increase number of rows in $aColumnColorsFonts
	If $iColumn >= $iColumnColorsFonts Then $iColumnColorsFonts = $iColumn + 1

	; Store font and colors in $aColumnColorsFonts
	Switch $fSelected
		Case 0
			$aColumnColorsFonts[$iColumn][1] = $iBackColor ? BitOR( BitAND( $iBackColor, 0x00FF00 ), BitShift( BitAND( $iBackColor, 0x0000FF ), -16 ), BitShift( BitAND( $iBackColor, 0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 )         ; Store back color in column 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
			$aColumnColorsFonts[$iColumn][2] = $iForeColor ? BitOR( BitAND( $iForeColor, 0x00FF00 ), BitShift( BitAND( $iForeColor, 0x0000FF ), -16 ), BitShift( BitAND( $iForeColor, 0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 )         ; Store fore color in column 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
			$aColumnColorsFonts[$iColumn][3] = $hFont ? $hFont : ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 )                                                                                                                                                   ; Store font in column 3
		Case 1
			$aColumnColorsFonts[$iColumn][1] = $iBackColor  ? BitOR( BitAND( $iBackColor,  0x00FF00 ), BitShift( BitAND( $iBackColor,  0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,  0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 )     ; Store back color in column 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
			$aColumnColorsFonts[$iColumn][2] = $iForeColor  ? BitOR( BitAND( $iForeColor,  0x00FF00 ), BitShift( BitAND( $iForeColor,  0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,  0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 )     ; Store fore color in column 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
			$aColumnColorsFonts[$iColumn][3] = $iBackSelect ? BitOR( BitAND( $iBackSelect, 0x00FF00 ), BitShift( BitAND( $iBackSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect, 0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  8 ) ? $aDefaults[3] : 0 )     ; Store selected back color in column 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
			$aColumnColorsFonts[$iColumn][4] = $iForeSelect ? BitOR( BitAND( $iForeSelect, 0x00FF00 ), BitShift( BitAND( $iForeSelect, 0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect, 0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults, 16 ) ? $aDefaults[4] : 0 )     ; Store selected fore color in column 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
			$aColumnColorsFonts[$iColumn][5] = $hFont ? $hFont : ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 )                                                                                                                                                   ; Store font in column 5
		Case 2
			$aColumnColorsFonts[$iColumn][1] = $iBackColor   ? BitOR( BitAND( $iBackColor,   0x00FF00 ), BitShift( BitAND( $iBackColor,   0x0000FF ), -16 ), BitShift( BitAND( $iBackColor,   0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  2 ) ? $aDefaults[1] : 0 ) ; Store back color in column 1           ; ListViewColorsFonts_ColorConvert( $iBackColor )
			$aColumnColorsFonts[$iColumn][2] = $iForeColor   ? BitOR( BitAND( $iForeColor,   0x00FF00 ), BitShift( BitAND( $iForeColor,   0x0000FF ), -16 ), BitShift( BitAND( $iForeColor,   0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  4 ) ? $aDefaults[2] : 0 ) ; Store fore color in column 2           ; ListViewColorsFonts_ColorConvert( $iForeColor )
			$aColumnColorsFonts[$iColumn][3] = $iBackSelect  ? BitOR( BitAND( $iBackSelect,  0x00FF00 ), BitShift( BitAND( $iBackSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iBackSelect,  0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults,  8 ) ? $aDefaults[3] : 0 ) ; Store selected back color in column 3  ; ListViewColorsFonts_ColorConvert( $iBackSelect )
			$aColumnColorsFonts[$iColumn][4] = $iForeSelect  ? BitOR( BitAND( $iForeSelect,  0x00FF00 ), BitShift( BitAND( $iForeSelect,  0x0000FF ), -16 ), BitShift( BitAND( $iForeSelect,  0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults, 16 ) ? $aDefaults[4] : 0 ) ; Store selected fore color in column 4  ; ListViewColorsFonts_ColorConvert( $iForeSelect )
			$aColumnColorsFonts[$iColumn][5] = $iBackUnfocus ? BitOR( BitAND( $iBackUnfocus, 0x00FF00 ), BitShift( BitAND( $iBackUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iBackUnfocus, 0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults, 32 ) ? $aDefaults[5] : 0 ) ; Store unfocused back color in column 5 ; ListViewColorsFonts_ColorConvert( $iBackUnfocus )
			$aColumnColorsFonts[$iColumn][6] = $iForeUnfocus ? BitOR( BitAND( $iForeUnfocus, 0x00FF00 ), BitShift( BitAND( $iForeUnfocus, 0x0000FF ), -16 ), BitShift( BitAND( $iForeUnfocus, 0xFF0000 ), 16 ) ) : ( BitAND( $fDefaults, 64 ) ? $aDefaults[6] : 0 ) ; Store unfocused fore color in column 6 ; ListViewColorsFonts_ColorConvert( $iForeUnfocus )
			$aColumnColorsFonts[$iColumn][7] = $hFont ? $hFont : ( BitAND( $fDefaults,  1 ) ? $aDefaults[0] : 0 )                                                                                                                                                   ; Store font in column 7
	EndSwitch
	If $hFont Or $iBackColor Or $iForeColor Or $iBackSelect Or $iForeSelect Or $iBackUnfocus Or $iForeUnfocus Then
		$aColumnColorsFonts[$iColumn][0] = 1 ; Set status in column 0
	Else
		$aColumnColorsFonts[$iColumn][0] = 0 ; Clear status in column 0
	EndIf

	; Store $aColumnColorsFonts for current listview
	$aListViewColorsFontsInfo[$iIndex][22] = $aColumnColorsFonts         ; Array with color/font info
	$aListViewColorsFontsInfo[$iIndex][23] = $iColumnColorsFonts         ; Number of used rows in array
	$aListViewColorsFontsInfo[$iIndex][24] = $iColumnColorsFonts_MaxRows ; Max number of rows in array
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_SetAlternatingColors
; Description ...: Sets alternating colors for rows, columns or both. Sets the number of rows and columns between color change.
; Syntax ........: ListViewColorsFonts_SetAlternatingColors( $idListView, $iRows = 1, $iCols = 1, $iBackColor = -1, $iForeColor = -1, $iBackSelect = -1, $iForeSelect = -1, $iBackUnfocus = -1, $iForeUnfocus = -1 )
; Parameters ....: $idListView   - Listview control ID or handle
;                  $iRows        - Number of rows between color change, 1 <= $iRows <= 9
;                  $iCols        - Number of columns between color change, 1 <= $iCols <= 9
;                  $iBackColor   - Alternating background color of normal listview items
;                                  Default value -1 results in the back color that was initially extracted from the listview
;                  $iForeColor   - Alternating fore (text) color of normal listview items
;                                  Default value -1 results in the fore color that was initially extracted from the listview
;                  $iBackSelect  - Alternating background color of selected items when listview has focus
;                                  Default value -1 results in a dark blue ($COLOR_HIGHLIGHT) background
;                  $iForeSelect  - Alternating fore (text) color of selected items when listview has focus
;                                  Default value -1 results in a white fore color
;                  $iBackUnfocus - Alternating background color of selected items when listview has not focus
;                                  Default value -1 results in a button face ($COLOR_BTNFACE) background
;                  $iForeUnfocus - Alternating fore (text) color of selected items when listview has not focus
;                                  Default value -1 is a black fore color
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - This function requires that $fColorsFonts includes 16/32
;                            2 - Listview not found
;                            3 - Too many color parameters
;                            4 - Invalid color value
; Remarks .......: To set alternating row colors $fColorsFonts flag must include the value 16.
;                  To set alternating column colors $fColorsFonts flag must include the value 32.
;
;                  To set alternating row and column colors $fColorsFonts flag must include the values 16 and 32 (or just 48).
;                  Because only one set of colors can be specified, different row and column colors cannot be set.
;
;                  $iBackSelect and $iForeSelect requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 128/256.
;                  $iBackUnfocus and $iForeUnfocus requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 256.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_SetAlternatingColors\
;
; Example 1 .....: Set cyan as alternating column color with two columns between color change
;                  ListViewColorsFonts_SetAlternatingColors( $idListView, _
;                      1,               2, _           ; $iRows        = 1,        $iCols        = 2
;                      0xCCFFFF,       -1 )            ; $iBackColor   = Cyan,     $iForeColor   = Default (black)
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_SetAlternatingColors( $idListView, $iRows = 1, $iCols = 1, $iBackColor = -1, $iForeColor = -1, $iBackSelect = -1, $iForeSelect = -1, $iBackUnfocus = -1, $iForeUnfocus = -1 )
	If $iRows = Default Then $iRows = 1
	If $iCols = Default Then $iCols = 1
	If $iBackColor   = Default Then $iBackColor   = -1
	If $iBackColor   = Default Then $iBackColor   = -1
	If $iForeColor   = Default Then $iForeColor   = -1
	If $iBackSelect  = Default Then $iBackSelect  = -1
	If $iForeSelect  = Default Then $iForeSelect  = -1
	If $iBackUnfocus = Default Then $iBackUnfocus = -1
	If $iForeUnfocus = Default Then $iForeUnfocus = -1

	; Find listview
	Local $hListView = $idListView
	If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
	Next
	If $iIndex = $iListViewColorsFontsInfo Then Return SetError(2, 0, -1) ; Listview not found

	; $fColorsFonts must include 16/32
	If Not BitAND( $aListViewColorsFontsInfo[$iIndex][14], 48 ) Then Return SetError(1, 0, -1)

	; Check $iRows and $iCols
	If Not IsInt( $iRows ) Or $iRows < 1  Or $iRows > 9 Then $iRows = 1
	If Not IsInt( $iCols ) Or $iCols < 1  Or $iCols > 9 Then $iCols = 1

	; Flag for selected items
	Local $fSelected  = $aListViewColorsFontsInfo[$iIndex][15]

	; Number of parameters
	Switch $fSelected
		Case 0
			If @NumParams > 5 Then Return SetError(3, 0, -1) ; Too many color parameters
		Case 1
			If @NumParams > 7 Then Return SetError(3, 0, -1) ; Too many color parameters
	EndSwitch

	; Initialize alternating colors to default colors
	Local $fAlter = 0, $aAlter = $aListViewColorsFontsInfo[$iIndex][17] ; $aDefaults

	; Alternating back color
	If $iBackColor > -1 Then
		If BitAND( $iBackColor, 0xFF000000 ) Then Return SetError(4, 0, -1) ; Invalid color value
		$aAlter[1] = ListViewColorsFonts_ColorConvert( $iBackColor )
		$fAlter += 2 ; Bit 1 set => Alternating back color set
	EndIf

	; Alternating fore color
	If $iForeColor > -1 Then
		If BitAND( $iForeColor, 0xFF000000 ) Then Return SetError(4, 0, -1) ; Invalid color value
		$aAlter[2] = ListViewColorsFonts_ColorConvert( $iForeColor )
		$fAlter += 4 ; Bit 2 set => Alternating fore color set
	EndIf

	If $fSelected Then
		; Alternating selected back color
		If $iBackSelect > -1 Then
			If BitAND( $iBackSelect, 0xFF000000 ) Then Return SetError(4, 0, -1) ; Invalid color value
			$aAlter[3] = ListViewColorsFonts_ColorConvert( $iBackSelect )
			$fAlter += 8 ; Bit 3 set => Alternating selected back color set
		EndIf

		; Alternating selected fore color
		If $iForeSelect > -1 Then
			If BitAND( $iForeSelect, 0xFF000000 ) Then Return SetError(4, 0, -1) ; Invalid color value
			$aAlter[4] = ListViewColorsFonts_ColorConvert( $iForeSelect )
			$fAlter += 16 ; Bit 4 set => Alternating selected fore color set
		EndIf
	EndIf

	If $fSelected = 2 Then
		; Alternating unfocused back color
		If $iBackUnfocus > -1 Then
			If BitAND( $iBackUnfocus, 0xFF000000 ) Then Return SetError(4, 0, -1) ; Invalid color value
			$aAlter[5] = ListViewColorsFonts_ColorConvert( $iBackUnfocus )
			$fAlter += 32 ; Bit 5 set => Alternating unfocused back color set
		EndIf

		; Alternating unfocused fore color
		If $iForeUnfocus > -1 Then
			If BitAND( $iForeUnfocus, 0xFF000000 ) Then Return SetError(4, 0, -1) ; Invalid color value
			$aAlter[6] = ListViewColorsFonts_ColorConvert( $iForeUnfocus )
			$fAlter += 64 ; Bit 6 set => Alternating unfocused fore color set
		EndIf
	EndIf

	; Store alternating colors
	$aListViewColorsFontsInfo[$iIndex][22] = $iRows
	$aListViewColorsFontsInfo[$iIndex][23] = $iCols
	$aListViewColorsFontsInfo[$iIndex][24] = $fAlter
	$aListViewColorsFontsInfo[$iIndex][25] = $aAlter
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_SetDefaultColorsFonts
; Description ...: Sets custom default font name and font style as well as custom default back and fore colors for listview items
; Syntax ........: ListViewColorsFonts_SetDefaultColorsFonts( $idListView, $sFontName = "", $iFontStyle = 0, $iBackColor = -1, $iForeColor = -1, $iBackSelect = -1, $iForeSelect = -1, $iBackUnfocus = -1, $iForeUnfocus = -1 )
; Parameters ....: $idListView   - Listview control ID or handle
;                  $sFontName    - Font face name of listview item
;                                  Or a valid font handle (pointer)
;                  $iFontStyle   - Text style of listview item
;                                  Use the following values for $iFontStyle
;                                      0: Normal text style (default)
;                                      1: Bold text style
;                                      2: Italic text style
;                                      3: Underline text style
;                                  These predefined constants can also be used:
;                                  $iFontStyleNormal, $iFontStyleBold, $iFontStyleItalic, $iFontStyleUnderline
;                                  Default font/style values ""/0 results in the font that was initially extracted from the listview
;                                  If $sFontName is a font handle $iFontStyle is ignored
;                  $iBackColor   - Background color of listview item
;                                  Default value -1 results in the back color that was initially extracted from the listview
;                  $iForeColor   - Fore (text) color of listview item
;                                  Default value -1 results in the fore color that was initially extracted from the listview
;                  $iBackSelect  - Background color of selected item when listview has focus
;                                  Default value -1 results in a dark blue ($COLOR_HIGHLIGHT) background
;                  $iForeSelect  - Fore (text) color of selected item when listview has focus
;                                  Default value -1 results in a white fore color
;                  $iBackUnfocus - Background color of selected item when listview has not focus
;                                  Default value -1 results in a button face ($COLOR_BTNFACE) background
;                  $iForeUnfocus - Fore (text) color of selected item when listview has not focus
;                                  Default value -1 is a black fore color
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - This function requires that $fColorsFonts includes 64
;                            2 - Listview not found
;                            3 - Invalid font or style
;                            4 - Too many color parameters
;                            5 - Invalid color value
; Remarks .......: Since -1 which is not a valid color is used to specify the default color, all color values can be set as a
;                  custom default color value. In all other functions 0 is used to specify the default color. As 0 is also the
;                  value of the black color, this means that the black color cannot be specified (because 0 results in default
;                  color which is not always black).
;
;                  $iBackSelect and $iForeSelect requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 128/256.
;                  $iBackUnfocus and $iForeUnfocus requires that $fColorsFonts flag in ListViewColorsFonts_Init includes 256.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_SetDefaultColorsFonts\
;
; Example 1 .....: Set green as custom default back color for normal items
;                  ListViewColorsFonts_SetDefaultColorsFonts( $idListView, _
;                      "",             0, _               ; $sFontName    = "",              $iFontStyle   = 0
;                      0xCCFFCC,      -1 )                ; $iBackColor   = Green,           $iForeColor   = Default (black)
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_SetDefaultColorsFonts( $idListView, $sFontName = "", $iFontStyle = 0, $iBackColor = -1, $iForeColor = -1, $iBackSelect = -1, $iForeSelect = -1, $iBackUnfocus = -1, $iForeUnfocus = -1 )
	If $sFontName    = Default Then $sFontName    = ""
	If $iFontStyle   = Default Then $iFontStyle   =  0
	If $iBackColor   = Default Then $iBackColor   = -1
	If $iForeColor   = Default Then $iForeColor   = -1
	If $iBackSelect  = Default Then $iBackSelect  = -1
	If $iForeSelect  = Default Then $iForeSelect  = -1
	If $iBackUnfocus = Default Then $iBackUnfocus = -1
	If $iForeUnfocus = Default Then $iForeUnfocus = -1

	; Find listview
	Local $hListView = $idListView
	If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
	Next
	If $iIndex = $iListViewColorsFontsInfo Then Return SetError(2, 0, -1) ; Listview not found

	; $fColorsFonts must include 64
	If Not BitAND( $aListViewColorsFontsInfo[$iIndex][14], 64 ) Then Return SetError(1, 0, -1)

	; Selected items, current default colors and font
	Local $fSelected = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
	Local $fDefaults = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
	Local $aDefaults = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors

	; Reset default font to original default font?
	If BitAND( $fDefaults, 1 ) Then ; Bit 0 set => Default font set
		$aDefaults[0] = $aListViewColorsFontsInfo[$iIndex][11] ; Reset default font to original default font
		$fDefaults -= 1
	EndIf

	; Set new default font?
	If IsPtr( $sFontName ) Then
		; Font handle
		Local $tstLOGFONT = DllStructCreate( $tagLOGFONT )
		If Not DllCall( "gdi32.dll", "int", "GetObjectW", "handle", $sFontName, "int", DllStructGetSize( $tstLOGFONT ), "struct*", $tstLOGFONT )[0] Then Return SetError(3, 0, -1) ; Invalid font ; _WinAPI_GetObject
		$aDefaults[0] = $sFontName ; Set new default font
		$fDefaults += 1
	ElseIf $sFontName Or $iFontStyle Then
		; Set new default font
		Local $tLogFont  = $aListViewColorsFontsInfo[$iIndex][10], $hFont = 0
		Local $sFaceName = DllStructGetData( $tLogFont, "FaceName" ) ; Default font face name
		Local $iWeight   = DllStructGetData( $tLogFont, "Weight" )   ; Default font weight

		; Font name
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFontName )

		; Font style
		Switch $iFontStyle
			Case 0 ; Normal
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", BitOR( $iWeight, $FW_BOLD ) )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", True )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", True )
			Case Else
				If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName ) ; Reset $tLogFont on error
				Return SetError(3, 0, -1)                                                ; Invalid font style
		EndSwitch

		$hFont = _WinAPI_CreateFontIndirect( $tLogFont )

		; Reset $tLogFont
		If $sFontName Then DllStructSetData( $tLogFont, "FaceName", $sFaceName )
		Switch $iFontStyle
			Case 1 ; Bold
				DllStructSetData( $tLogFont, "Weight", $iWeight )
			Case 2 ; Italic
				DllStructSetData( $tLogFont, "Italic", False )
			Case 3 ; Underline
				DllStructSetData( $tLogFont, "Underline", False )
		EndSwitch

		If Not $hFont Then Return SetError(3, 0, -1) ; Invalid font name

		$aDefaults[0] = $hFont ; Set new default font
		$fDefaults += 1
	EndIf

	; Number of parameters
	Switch $fSelected
		Case 0
			If @NumParams > 5 Then Return SetError(4, 0, -1) ; Too many color parameters
		Case 1
			If @NumParams > 7 Then Return SetError(4, 0, -1) ; Too many color parameters
	EndSwitch

	; Default back color
	If BitAND( $fDefaults, 2 ) Then ; Bit 1 set => Default back color set
		$aDefaults[1] = $aListViewColorsFontsInfo[$iIndex][12] ; Reset default back color to original default back color
		$fDefaults -= 2
	EndIf
	If $iBackColor > -1 Then
		If BitAND( $iBackColor, 0xFF000000 ) Then Return SetError(5, 0, -1) ; Invalid color value
		$aDefaults[1] = ListViewColorsFonts_ColorConvert( $iBackColor )
		$fDefaults += 2
	EndIf

	; Default fore color
	If BitAND( $fDefaults, 4 ) Then ; Bit 2 set => Default fore color set
		$aDefaults[2] = $aListViewColorsFontsInfo[$iIndex][13] ; Reset default fore color to original default fore color
		$fDefaults -= 4
	EndIf
	If $iForeColor > -1 Then
		If BitAND( $iForeColor, 0xFF000000 ) Then Return SetError(5, 0, -1) ; Invalid color value
		$aDefaults[2] = ListViewColorsFonts_ColorConvert( $iForeColor )
		$fDefaults += 4
	EndIf

	If $fSelected Then
		; Default selected back color
		If BitAND( $fDefaults, 8 ) Then ; Bit 3 set => Default selected back color set
			$aDefaults[3] = _WinAPI_GetSysColor( $COLOR_HIGHLIGHT ) ; Reset default selected back color to original default selected back color
			$fDefaults -= 8
		EndIf
		If $iBackSelect > -1 Then
			If BitAND( $iBackSelect, 0xFF000000 ) Then Return SetError(5, 0, -1) ; Invalid color value
			$aDefaults[3] = ListViewColorsFonts_ColorConvert( $iBackSelect )
			$fDefaults += 8
		EndIf

		; Default selected fore color
		If BitAND( $fDefaults, 16 ) Then ; Bit 4 set => Default selected fore color set
			$aDefaults[4] = 0xFFFFFF ; Reset default selected fore color to original default selected fore color
			$fDefaults -= 16
		EndIf
		If $iForeSelect > -1 Then
			If BitAND( $iForeSelect, 0xFF000000 ) Then Return SetError(5, 0, -1) ; Invalid color value
			$aDefaults[4] = ListViewColorsFonts_ColorConvert( $iForeSelect )
			$fDefaults += 16
		EndIf
	EndIf

	If $fSelected = 2 Then
		; Default unfocused back color
		If BitAND( $fDefaults, 32 ) Then ; Bit 5 set => Default unfocused back color set
			$aDefaults[5] = _WinAPI_GetSysColor( $COLOR_BTNFACE ) ; Reset default unfocused back color to original default unfocused back color
			$fDefaults -= 32
		EndIf
		If $iBackUnfocus > -1 Then
			If BitAND( $iBackUnfocus, 0xFF000000 ) Then Return SetError(5, 0, -1) ; Invalid color value
			$aDefaults[5] = ListViewColorsFonts_ColorConvert( $iBackUnfocus )
			$fDefaults += 32
		EndIf

		; Default unfocused fore color
		If BitAND( $fDefaults, 64 ) Then ; Bit 6 set => Default unfocused fore color set
			$aDefaults[6] = 0x000000 ; Reset default unfocused fore color to original default unfocused fore color
			$fDefaults -= 64
		EndIf
		If $iForeUnfocus > -1 Then
			If BitAND( $iForeUnfocus, 0xFF000000 ) Then Return SetError(5, 0, -1) ; Invalid color value
			$aDefaults[6] = ListViewColorsFonts_ColorConvert( $iForeUnfocus )
			$fDefaults += 64
		EndIf
	EndIf

	; Set current default colors and font for the listview
	$aListViewColorsFontsInfo[$iIndex][16] = $fDefaults
	$aListViewColorsFontsInfo[$iIndex][17] = $aDefaults
	; The local static copies of $aDefaults in ListViewColorsFonts_SetItemColors/Fonts
	; functions must be updated. This is done through ListViewColorsFonts_Redraw.
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_SetColumns
; Description ...: Update the number of columns in $aListViewColorsFontsInfo and ReDim $aListViewColorsFonts
; Syntax ........: ListViewColorsFonts_SetColumns( $idListView )
; Parameters ....: $idListView - Listview control ID or handle
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - Listview not found
; Remarks .......: If you add more columns to the listview and wants to specifically add colors/fonts to these columns, you
;                  must call ListViewColorsFonts_SetColumns to update the number of columns in $aListViewColorsFontsInfo and
;                  ReDim $aListViewColorsFonts.
; -------------------------------------------------------------------------------------------------------------------------------
;Func ListViewColorsFonts_SetColumns( $idListView )
;EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_Redraw
; Description ...: Saves $aListViewColorsFonts if necessary, forces an update of static variables in subclass callback function,
;                  and repaints the visible rows in the listview.
; Syntax ........: ListViewColorsFonts_Redraw( $idListView )
; Parameters ....: $idListView - Listview control ID or handle
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - Listview not found
; Remarks .......: If colors/fonts are updated in $aListViewColorsFonts array, ListViewColorsFonts_Redraw stores the array in
;                  $aListViewColorsFontsInfo, forces the subclass callback function to reread the array, and redraws the visible
;                  rows in the listview.
;
;                  If other color/font variables are updated, ListViewColorsFonts_Redraw forces the subclass callback function to
;                  reread the variables, and redraws the visible rows in the listview.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_Redraw\
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_Redraw( $idListView )
	; Find listview
	Local $hListView = $idListView
	If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
	Next
	If $iIndex = $iListViewColorsFontsInfo Then Return SetError(1, 0, -1) ; Listview not found

	Local $fColorsFonts = $aListViewColorsFontsInfo[$iIndex][14]

	Select
		Case BitAND( $fColorsFonts, 7 ) ; Colors/fonts for items/subitems
			; Save $aListViewColorsFonts if necessary
			If $bListViewColorsFonts_Save And $iListViewColorsFontsInfo_Index Then
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][18] = $bListViewColorsFonts_Subitems
				If $aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][8] Then
					$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][19] = $aListViewColorsFonts_Index
					$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][20] = $iListViewColorsFonts_Index
					$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][21] = $iListViewColorsFonts_Index_MaxRows
				EndIf
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][22] = $aListViewColorsFonts
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][23] = $iListViewColorsFonts
				$aListViewColorsFontsInfo[$iListViewColorsFontsInfo_Index][24] = $iListViewColorsFonts_MaxRows
				$iListViewColorsFontsInfo_Index = 0 ; Force update of local statics in ListViewColorsFonts_SetItemColors/Fonts functions
				$bListViewColorsFonts_Save = False
			EndIf
			If $aListViewColorsFontsInfo[$iIndex][15] Then ; Selected items
				ListViewColorsFontsSC_Selected( 0, $WM_NOTIFY, 0, 0, -$iIndex, 0 )        ; Force update of static variables in subclass callback function
			Else ; Normal items
				ListViewColorsFontsSC_Normal( 0, $WM_NOTIFY, 0, 0, -$iIndex, 0 )          ; Force update of static variables in subclass callback function
			EndIf

		Case BitAND( $fColorsFonts, 8 ) ; Colors/fonts for entire columns
			ListViewColorsFontsSC_Columns( 0, $WM_NOTIFY, 0, 0, -$iIndex, 0 )           ; Force update of static variables in subclass callback function

		Case BitAND( $fColorsFonts, 48 ) ; Alternating row/column colors
			Switch BitAND( $fColorsFonts, 48 )
				Case 16 ; Alternating row colors
					ListViewColorsFontsSC_AlterRows( 0, $WM_NOTIFY, 0, 0, -$iIndex, 0 )     ; Force update of static variables in subclass callback function
				Case 32 ; Alternating column colors
					ListViewColorsFontsSC_AlterCols( 0, $WM_NOTIFY, 0, 0, -$iIndex, 0 )     ; Force update of static variables in subclass callback function
				Case 48 ; Alternating row and column colors
					ListViewColorsFontsSC_AlterRowsCols( 0, $WM_NOTIFY, 0, 0, -$iIndex, 0 ) ; Force update of static variables in subclass callback function
			EndSwitch

		Case BitAND( $fColorsFonts, 64 ) ; Custom default colors/font
			ListViewColorsFontsSC_Defaults( 0, $WM_NOTIFY, 0, 0, -$iIndex, 0 )          ; Force update of static variables in subclass callback function
	EndSelect

		; Force redraw of visible listview items and subitems
	_GUICtrlListView_RedrawItems( $idListView, 0, _GUICtrlListView_GetItemCount( $idListView ) )
EndFunc

; Function ----------------------------------------------------------------------------------------------------------------------
; Name ..........: ListViewColorsFonts_Exit
; Description ...: Delete resources and cleanup
; Syntax ........: ListViewColorsFonts_Exit( $idListView, $bCleanup = False )
; Parameters ....: $idListView - Listview control ID or handle
;                  $bCleanup   - True:  Reset ItemParam for non-native listview items and delete font resources
;                                       If you are excuting ListViewColorsFonts_Exit in the middle of a program, and want to add
;                                       colors/fonts to the same listview at a later point in the program, you must reset ItemParam
;                                       for non-native listview items.
;                                False: Perform no cleanup
;                                       If you are excuting ListViewColorsFonts_Exit at the end of a program, you can leave it to
;                                       AutoIt to do the cleanup.
;                                $bCleanup is only relevant for $fColorsFonts = 1/2/4 (colors and fonts for items/subitems)
; Return values .: Failure - Returns -1 and sets @error:
;                            1 - Listview not found
; Remarks .......: Deletes the listview handle in $aListViewColorsFontsInfo and the array that stores color/font info. Removes sub-
;                  classing from listview parent window.
;
;                  Note that ListViewColorsFonts_Exit must be called before the script exits to remove subclassing from listview
;                  parent window.
;
; Examples ......: Examples\0) UDF-examples\ListViewColorsFonts_Exit\
; -------------------------------------------------------------------------------------------------------------------------------
Func ListViewColorsFonts_Exit( $idListView, $bCleanup = False )
	If $bCleanup = Default Then $bCleanup = False
	$bCleanup = $bCleanup ? True : False ; Convert to boolean

	; Find listview
	Local $hListView = $idListView
	If Not IsHWnd( $hListView ) Then $hListView = GUICtrlGetHandle( $hListView )
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If $aListViewColorsFontsInfo[$iIndex][1] = $hListView Then ExitLoop
	Next
	If $iIndex = $iListViewColorsFontsInfo Then Return SetError(1, 0, -1) ; Listview not found

	Local $fColorsFonts = $aListViewColorsFontsInfo[$iIndex][14]

	; Remove subclassing from listview parent window
	Select
		Case BitAND( $fColorsFonts, 7 ) ; Colors/fonts for items/subitems
			If $aListViewColorsFontsInfo[$iIndex][15] Then ; Selected items
				_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Selected, $iIndex )
			Else ; Normal items
				_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Normal, $iIndex )
			EndIf

		Case BitAND( $fColorsFonts, 8 ) ; Colors/fonts for entire columns
			_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Columns, $iIndex )

		Case BitAND( $fColorsFonts, 48 ) ; Alternating row/column colors
			Switch BitAND( $fColorsFonts, 48 )
				Case 16 ; Alternating row colors
					_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_AlterRows, $iIndex )
				Case 32 ; Alternating column colors
					_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_AlterCols, $iIndex )
				Case 48 ; Alternating row and column colors
					_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_AlterRowsCols, $iIndex )
			EndSwitch

		Case BitAND( $fColorsFonts, 64 ) ; Custom default colors/font
			_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Defaults, $iIndex )
	EndSelect

	; Reset ItemParam for non-native listview items and delete font resources
	If BitAND( $fColorsFonts, 7 ) And $bCleanup Then ; Colors and fonts for items/subitems
		$idListView      = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		Local $bNative   = $aListViewColorsFontsInfo[$iIndex][8]  ; Native listview items
		Local $iColumns  = $aListViewColorsFontsInfo[$iIndex][9]  ; Number of listview columns
		Local $hDefFont  = $aListViewColorsFontsInfo[$iIndex][11] ; Default listview font
		Local $fSelected = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		Local $aArray    = $aListViewColorsFontsInfo[$iIndex][22] ; Array with color/font info
		Local $iArray    = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
		Local $iColOffset = $fSelected=0?3:$fSelected=1?5:7
		Local $bFonts = BitAND( $fColorsFonts, 4 )
		; Reset ItemParam for non-native listview items
		If Not $bNative Then ; Non-native listview item
			Local $tItem = DllStructCreate( $tagLVITEM ), $pItem = DllStructGetPtr( $tItem ), $j
			DllStructSetData( $tItem, "Mask", $LVIF_PARAM )
			For $i = 0 To _GUICtrlListView_GetItemCount( $hListView ) - 1
				DllStructSetData( $tItem, "Item", $i ) ;If _GUICtrlListView_GetItemParam( $idListView, $i ) < 0 Then _GUICtrlListView_SetItemParam( $idListView, $i, 0 ) ; Reset ItemParam
				$j = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pItem )[0]
				If DllStructGetData( $tItem, "Param" ) < 0 Then
					DllStructSetData( $tItem, "Param", 0 )
					$j = $idListView ? GUICtrlSendMsg( $idListView, $LVM_SETITEMW, 0, $pItem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_SETITEMW, "wparam", 0, "lparam", $pItem )[0]
				EndIf
			Next
		EndIf
		; Delete font resources
		If $bFonts Then ; Listview provided with fonts
			For $i = 0 To $iArray - 1
				If $aArray[$i][0] Then ; Item provided with fonts
					For $j = 1 To BitAnd( $aArray[$i][0], 2 ) ? $iColumns + 1 : 1 ; Delete font (but not the default font) for item and all subitems
						If $aArray[$i][$iColOffset*$j] And $aArray[$i][$iColOffset*$j] <> $hDefFont Then DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $aArray[$i][$iColOffset*$j] ) ; _WinAPI_DeleteObject
					Next
				EndIf
			Next
		EndIf
	EndIf

	; Delete listview in info array
	$aListViewColorsFontsInfo[$iIndex][1]  = 0 ; Delete listview
	$aListViewColorsFontsInfo[$iIndex][19] = 0 ; Delete indices for native items
	$aListViewColorsFontsInfo[$iIndex][22] = 0 ; Delete $aListViewColorsFonts array

	; If last row in $aListViewColorsFontsInfo then decrease $iListViewColorsFontsInfo by one
	If $iIndex = $iListViewColorsFontsInfo - 1 Then $iListViewColorsFontsInfo -= 1

	; Force reread of $aListViewColorsFonts in ListViewColorsFonts_SetItemColors and ListViewColorsFonts_SetItemFonts
	If $iIndex = $iListViewColorsFontsInfo_Index Then $iListViewColorsFontsInfo_Index = 0
EndFunc


; Internal functions
; ==================
; Subclass callback (SC) functions
; --------------------------------
; ListViewColorsFontsSC_Normal       ( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView ) ; Normal listview items with custom colors and fonts ($fColorsFonts = 1/2/4)
; ListViewColorsFontsSC_Selected     ( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView ) ; Selected items in a focused or unfocused listview  ($fColorsFonts = 1/2/4 + 128/256)
; ListViewColorsFontsSC_Columns      ( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView ) ; Colors and font in entire listview columns         ($fColorsFonts = 8)
; ListViewColorsFontsSC_AlterRows    ( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView ) ; Alternating row colors in entire listview          ($fColorsFonts = 16)
; ListViewColorsFontsSC_AlterCols    ( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView ) ; Alternating column colors in entire listview       ($fColorsFonts = 32)
; ListViewColorsFontsSC_AlterRowsCols( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView ) ; Alternating row/column colors in entire listview   ($fColorsFonts = 48)
; ListViewColorsFontsSC_Defaults     ( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView ) ; Custom default colors and font in entire listview  ($fColorsFonts = 64)

; Utility functions
; -----------------
; ListViewColorsFonts_ColorConvert( $iColor ) ; RGB to BGR or BGR to RGB
; ListViewColorsFonts_ExitAllOnExit()         ; Remove subclass callback functions


Func ListViewColorsFontsSC_Normal( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView )
	If $iMsg <> $WM_NOTIFY Or $hListView <> HWnd( DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "hWndFrom" ) ) Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local Static $hDC, $iItemParam

	; Static variables used for a specific listview. These variables are updated when the current listview is replaced with another listview.
	Local Static $iIndexPrev = 0, $bNative, $fDefaults, $aDefaults, $aColorsFonts_Index, $iColorsFonts_Index, $aColorsFonts, $iColorsFonts
	If $iIndexPrev <> $iIndex Then ; $iIndex is used to switch between different listviews
		$iIndexPrev = $iIndex        ; $iIndex <= 0 is used to force a re-
		If $iIndex <= 0 Then Return  ; read of $aListViewColorsFontsInfo.
		$bNative      = $aListViewColorsFontsInfo[$iIndex][8]  ; Native listview items
		$fDefaults    = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults    = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors
		If $bNative Then
			$aColorsFonts_Index = $aListViewColorsFontsInfo[$iIndex][19] ; Index array for native items
			$iColorsFonts_Index = $aListViewColorsFontsInfo[$iIndex][20] ; Number of used rows in array
		EndIf
		$aColorsFonts = $aListViewColorsFontsInfo[$iIndex][22] ; Array with color/font info, $iItemParam is row index
		$iColorsFonts = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
	EndIf

	Switch DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "Code" ) ; $iCode
		Case $NM_CUSTOMDRAW
			Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
			Local $dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
			Switch $dwDrawStage                               ; Specifies the drawing stage
				; Stage 1
				Case $CDDS_PREPAINT                             ; Before the paint cycle begins
					$hDC = DllStructGetData( $tNMLVCUSTOMDRAW, "hdc" ) ; Device context
					Return $CDRF_NOTIFYITEMDRAW                   ; Notify the parent window before an item is painted

				; Stage 2
				Case $CDDS_ITEMPREPAINT                         ; Before an item is painted
					$iItemParam = DllStructGetData( $tNMLVCUSTOMDRAW, "lItemlParam" ) ; Item param

					If $bNative Then                                                                 ; Native listview items
						If $iItemParam < $iColorsFonts_Index And $aColorsFonts_Index[$iItemParam] Then ; Custom drawing of this item
							$iItemParam = $aColorsFonts_Index[$iItemParam] - 1                           ; Index for native listview items
						Else                                                                           ; No custom colors/fonts for this item
							If Not $fDefaults Then Return $CDRF_NEWFONT ; Default drawing
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Default back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Default fore color
							DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Default font, _WinAPI_SelectObject
							Return $CDRF_NEWFONT                      ; $CDRF_NEWFONT must be returned after changing font or colors
						EndIf
					Else                                                            ; Non-native listview items
						If $iItemParam < 0 And -$iItemParam - 20 < $iColorsFonts Then ; Custom drawing of this item
							$iItemParam = -$iItemParam - 20                             ; Index for non-native listview items
						Else                                                          ; No custom colors/fonts for this item
							If Not $fDefaults Then Return $CDRF_NEWFONT ; Default drawing
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Default back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Default fore color
							DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Default font, _WinAPI_SelectObject
							Return $CDRF_NEWFONT                      ; $CDRF_NEWFONT must be returned after changing font or colors
						EndIf
					EndIf

					Select
						Case $aColorsFonts[$iItemParam][0] = 0          ; No custom drawing of item
							If Not $fDefaults Then Return $CDRF_NEWFONT ; Default drawing
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Default back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Default fore color
							DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Default font, _WinAPI_SelectObject
							Return $CDRF_NEWFONT                      ; $CDRF_NEWFONT must be returned after changing font or colors
						Case BitAND( $aColorsFonts[$iItemParam][0], 2 ) ; Custom drawing of subitems
							Return $CDRF_NOTIFYSUBITEMDRAW            ; Notify the parent window of any subitem-related drawing operations
						Case BitAND( $aColorsFonts[$iItemParam][0], 1 ) ; Custom drawing of entire item
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aColorsFonts[$iItemParam][1] ? $aColorsFonts[$iItemParam][1] : $aDefaults[1] )                          ; Back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aColorsFonts[$iItemParam][2] ? $aColorsFonts[$iItemParam][2] : $aDefaults[2] )                          ; Fore color
							DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iItemParam][3] ? $aColorsFonts[$iItemParam][3] : $aDefaults[0] ) ; Font, _WinAPI_SelectObject
							Return $CDRF_NEWFONT                      ; $CDRF_NEWFONT must be returned after changing font or colors
					EndSelect

				; Stage 3
				Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM ) ; Before a subitem is painted
					Local $iCol0 = 3 + 3 * DllStructGetData( $tNMLVCUSTOMDRAW, "iSubItem" ) ; Subitem index
					DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aColorsFonts[$iItemParam][$iCol0+1] ? $aColorsFonts[$iItemParam][$iCol0+1] : BitAND( $aColorsFonts[$iItemParam][0], 1 ) ? ( $aColorsFonts[$iItemParam][1] ? $aColorsFonts[$iItemParam][1] : $aDefaults[1] ) : $aDefaults[1] ) ; Back color
					DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aColorsFonts[$iItemParam][$iCol0+2] ? $aColorsFonts[$iItemParam][$iCol0+2] : BitAND( $aColorsFonts[$iItemParam][0], 1 ) ? $aColorsFonts[$iItemParam][2] : $aDefaults[2] )                                                     ; Fore color
					DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iItemParam][$iCol0+3] ? $aColorsFonts[$iItemParam][$iCol0+3] : BitAND( $aColorsFonts[$iItemParam][0], 1 ) ? $aColorsFonts[$iItemParam][3] : $aDefaults[0] )                            ; Font, _WinAPI_SelectObject
					Return $CDRF_NEWFONT                          ; $CDRF_NEWFONT must be returned after changing font or colors
			EndSwitch
	EndSwitch
	Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	; Call next function in subclass chain (this forwards messages to main GUI)
EndFunc

Func ListViewColorsFontsSC_Selected( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView )
	If ( $iMsg <> $WM_NOTIFY And $iMsg <> $WM_PARENTNOTIFY ) Or ( $iMsg = $WM_NOTIFY And $hListView <> HWnd( DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "hWndFrom" ) ) ) Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local Static $tLVitem = DllStructCreate( $tagLVITEM ), $pLVitem = DllStructGetPtr( $tLVitem ), $tBuffer = DllStructCreate( "wchar Text[4096]" ), $pBuffer = DllStructGetPtr( $tBuffer ), $bNotXP = Not ( @OSVersion = "WIN_XP" )
	Local Static $bLVHasFocus, $hDC, $bHasFocus, $iColumns, $iItem, $iItemParam, $iSelFocus, $bDrawCustomDefaultColors, $tRect = DllStructCreate( $tagRECT ), $pRect = DllStructGetPtr( $tRect )
	Local $iSubItem, $iCol0, $hBrush, $i, $iImageWidth

	; Static variables used for a specific listview. These variables are updated when the current listview is replaced with another listview.
	Local Static $iIndexPrev = 0, $idListView, $hHeader, $bImages, $bChkboxes, $hGui, $sClassNN, $bNative, $fSelected, $fDefaults, $aDefaults, $aColorsFonts_Index, $iColorsFonts_Index, $aColorsFonts, $iColorsFonts, $iColOffset, $iImgWidth0
	If $iIndexPrev <> $iIndex Then ; $iIndex is used to switch between different listviews
		$iIndexPrev = $iIndex        ; $iIndex <= 0 is used to force a re-
		If $iIndex <= 0 Then Return  ; read of $aListViewColorsFontsInfo.
		$idListView = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$hHeader    = $aListViewColorsFontsInfo[$iIndex][2]  ; Listview header
		$bImages    = $aListViewColorsFontsInfo[$iIndex][3]  ; Subitem images
		$bChkboxes  = $aListViewColorsFontsInfo[$iIndex][4]  ; Checkboxes
		$hGui       = $aListViewColorsFontsInfo[$iIndex][6]  ; Main GUI window handle
		$sClassNN   = $aListViewColorsFontsInfo[$iIndex][7]  ; CLASSNN listview name
		$bNative    = $aListViewColorsFontsInfo[$iIndex][8]  ; Native listview items
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors
		If $bNative Then
			$aColorsFonts_Index = $aListViewColorsFontsInfo[$iIndex][19] ; Index array for native items
			$iColorsFonts_Index = $aListViewColorsFontsInfo[$iIndex][20] ; Number of used rows in array
		EndIf
		$aColorsFonts = $aListViewColorsFontsInfo[$iIndex][22] ; Array with color/font info, $iItemParam is row index
		$iColorsFonts = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
		$iColOffset = $fSelected=0?3:$fSelected=1?5:7
		$iImgWidth0 = 0
	EndIf

	If $iMsg = $WM_PARENTNOTIFY Then
		If Not $bLVHasFocus Then DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
		Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	EndIf

	Switch DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "Code" ) ; $iCode
		Case $NM_CUSTOMDRAW
			Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
			Local $dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
			Switch $dwDrawStage                                ; Specifies the drawing stage
				; Stage 1
				Case $CDDS_PREPAINT                              ; Before the paint cycle begins
					$hDC = DllStructGetData( $tNMLVCUSTOMDRAW, "hdc" )                              ; Device context
					DllCall( "gdi32.dll", "int", "SetBkMode", "handle", $hDC, "int", $TRANSPARENT ) ; Transparent background, _WinAPI_SetBkMode
					$bHasFocus = ( $sClassNN = ControlGetFocus( $hGui ) )                           ; Has listview focus?
					$iColumns = DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hHeader, "uint", 0x1200, "wparam", 0, "lparam", 0 )[0] ; 0x1200 = $HDM_GETITEMCOUNT, _GUICtrlHeader_GetItemCount
					Return $CDRF_NOTIFYITEMDRAW                    ; Notify the parent window before an item is painted

				; Stage 2
				Case $CDDS_ITEMPREPAINT                          ; Before an item is painted
					$iItem      = DllStructGetData( $tNMLVCUSTOMDRAW, "dwItemSpec" )  ; Item index
					$iItemParam = DllStructGetData( $tNMLVCUSTOMDRAW, "lItemlParam" ) ; Item param
					$iSelFocus  = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMSTATE, $iItem, $LVIS_FOCUSED+$LVIS_SELECTED ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMSTATE, "wparam", $iItem, "lparam", $LVIS_FOCUSED+$LVIS_SELECTED )[0] ; Selected state
					$bDrawCustomDefaultColors = False

					If $bNative Then                                                                 ; Native listview items
						If $iItemParam < $iColorsFonts_Index And $aColorsFonts_Index[$iItemParam] Then ; Custom drawing of this item
							$iItemParam = $aColorsFonts_Index[$iItemParam] - 1                           ; Index for native listview items
						Else                                                                           ; No custom colors/fonts for this item
							If Not $fDefaults Then Return $CDRF_NEWFONT ; Because $iItemParam >= 0 this is only a matter of custom default colors, not custom item/subitem colors
							If $iSelFocus Then ; Selected item
								$bDrawCustomDefaultColors = True
								If BitAND( $iSelFocus, $LVIS_FOCUSED ) And $bHasFocus And $fSelected And BitAND( $fDefaults, 25 ) Then Return $CDRF_NOTIFYSUBITEMDRAW              ; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one. Stage 3 and 4.
								If ( $bHasFocus And $fSelected And BitAND( $fDefaults, 25 ) ) Or ( $fSelected = 2 And BitAND( $fDefaults, 97 ) ) Then Return $CDRF_NOTIFYPOSTPAINT ; Custom drawing of Selected item. Custom default colors for selected item must be drawn in CDDS_ITEMPOSTPAINT stage, stage 5.
								If Not BitAND( $fDefaults, 7 ) Then Return $CDRF_NEWFONT ; No custom default colors for normal items => Default drawing
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Custom default back color
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Custom default fore color
								DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font, _WinAPI_SelectObject
								Return $CDRF_NEWFONT ; Default drawing of selected item

							Else ; Unselected item
								If Not BitAND( $fDefaults, 7 ) Then Return $CDRF_NEWFONT ; No custom default colors for normal items => Default drawing
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Custom default back color
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Custom default fore color
								DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font, _WinAPI_SelectObject
								Return $CDRF_NEWFONT                     ; $CDRF_NEWFONT must be returned after changing font or colors
							EndIf
						EndIf
					Else                                                            ; Non-native listview items
						If $iItemParam < 0 And -$iItemParam - 20 < $iColorsFonts Then ; Custom drawing of this item
							$iItemParam = -$iItemParam - 20                             ; Index for non-native listview items
						Else                                                          ; No custom colors/fonts for this item
							If Not $fDefaults Then Return $CDRF_NEWFONT ; Because $iItemParam >= 0 this is only a matter of custom default colors, not custom item/subitem colors
							If $iSelFocus Then ; Selected item
								$bDrawCustomDefaultColors = True
								If BitAND( $iSelFocus, $LVIS_FOCUSED ) And $bHasFocus And $fSelected And BitAND( $fDefaults, 25 ) Then Return $CDRF_NOTIFYSUBITEMDRAW              ; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one. Stage 3 and 4.
								If ( $bHasFocus And $fSelected And BitAND( $fDefaults, 25 ) ) Or ( $fSelected = 2 And BitAND( $fDefaults, 97 ) ) Then Return $CDRF_NOTIFYPOSTPAINT ; Custom drawing of Selected item. Custom default colors for selected item must be drawn in CDDS_ITEMPOSTPAINT stage, stage 5.
								If Not BitAND( $fDefaults, 7 ) Then Return $CDRF_NEWFONT ; No custom default colors for normal items => Default drawing
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Custom default back color
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Custom default fore color
								DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font, _WinAPI_SelectObject
								Return $CDRF_NEWFONT ; Default drawing of selected item

							Else ; Unselected item
								If Not BitAND( $fDefaults, 7 ) Then Return $CDRF_NEWFONT ; No custom default colors for normal items => Default drawing
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Custom default back color
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Custom default fore color
								DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font, _WinAPI_SelectObject
								Return $CDRF_NEWFONT                     ; $CDRF_NEWFONT must be returned after changing font or colors
							EndIf
						EndIf
					EndIf

					If $iSelFocus Then ; Selected item
						Select
							Case $aColorsFonts[$iItemParam][0] = 0          ; No custom drawing of selected item (default drawing)
								$bDrawCustomDefaultColors = True
								If BitAND( $iSelFocus, $LVIS_FOCUSED ) And $bHasFocus And $fSelected And BitAND( $fDefaults, 25 ) Then Return $CDRF_NOTIFYSUBITEMDRAW              ; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one. Stage 3 and 4.
								If ( $bHasFocus And $fSelected And BitAND( $fDefaults, 25 ) ) Or ( $fSelected = 2 And BitAND( $fDefaults, 97 ) ) Then Return $CDRF_NOTIFYPOSTPAINT ; Custom drawing of Selected item. Custom default colors for selected item must be drawn in CDDS_ITEMPOSTPAINT stage, stage 5.
								Return $CDRF_NEWFONT                     ; Default drawing of selected item
							Case BitAND( $aColorsFonts[$iItemParam][0], 8 ) ; Custom drawing of selected subitems
								Return $CDRF_NOTIFYSUBITEMDRAW           ; Notify the parent window before a subitem is painted
							Case BitAND( $aColorsFonts[$iItemParam][0], 4 ) ; Custom drawing of entire selected item
								; Custom drawing of selected item must be done in post paint stage
								If BitAND( $iSelFocus, $LVIS_FOCUSED ) And $bHasFocus And $fSelected Then Return $CDRF_NOTIFYSUBITEMDRAW ; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one.
								If ( $bHasFocus And $fSelected ) Or $fSelected = 2 Then Return $CDRF_NOTIFYPOSTPAINT ; Notify the parent window after an item is painted
								; Default drawing of selected item when listview has not focus ($bHasFocus = False, $fSelected = 1)
								Return $CDRF_NEWFONT                     ; Default drawing of selected item
						EndSelect

					Else ; Unselected item
						Select
							Case $aColorsFonts[$iItemParam][0] = 0          ; No custom drawing of item
								If Not BitAND( $fDefaults, 7 ) Then Return $CDRF_NEWFONT ; No custom default colors for normal items => Default drawing
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Custom default back color
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Custom default fore color
								DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font, _WinAPI_SelectObject
								Return $CDRF_NEWFONT                     ; $CDRF_NEWFONT must be returned after changing font or colors
							Case BitAND( $aColorsFonts[$iItemParam][0], 2 ) ; Custom drawing of subitems
								Return $CDRF_NOTIFYSUBITEMDRAW           ; Notify the parent window before a subitem is painted
							Case BitAND( $aColorsFonts[$iItemParam][0], 1 ) ; Custom drawing of entire item
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aColorsFonts[$iItemParam][1] ? $aColorsFonts[$iItemParam][1] : $aDefaults[1] )                                              ; Back color
								DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aColorsFonts[$iItemParam][2] ? $aColorsFonts[$iItemParam][2] : $aDefaults[2] )                                              ; Fore color
								DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iItemParam][$iColOffset] ? $aColorsFonts[$iItemParam][$iColOffset] : $aDefaults[0] ) ; Font, _WinAPI_SelectObject
								Return $CDRF_NEWFONT                     ; $CDRF_NEWFONT must be returned after changing font or colors
						EndSelect
					EndIf

				; Stage 3
				Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM )  ; Before a subitem is painted
					If $iSelFocus Then ; Selected subitem
						; Custom drawing of selected subitem must be done in post paint stage
						If $bHasFocus Or $fSelected = 2 Then Return $CDRF_NOTIFYPOSTPAINT ; Notify the parent window after a subitem is painted
						; Default drawing of selected subitem when listview has not focus ($bHasFocus = False, $fSelected = 1)
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors

					Else ; Unselected subitem
						$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index
						$iCol0 = $iColOffset + $iColOffset * $iSubItem               ; Column offset
						DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aColorsFonts[$iItemParam][$iCol0+1] ? $aColorsFonts[$iItemParam][$iCol0+1] : BitAND( $aColorsFonts[$iItemParam][0], 1 ) ? ( $aColorsFonts[$iItemParam][1] ? $aColorsFonts[$iItemParam][1] : $aDefaults[1] ) : $aDefaults[1] )    ; Back color
						DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aColorsFonts[$iItemParam][$iCol0+2] ? $aColorsFonts[$iItemParam][$iCol0+2] : BitAND( $aColorsFonts[$iItemParam][0], 1 ) ? $aColorsFonts[$iItemParam][2] : $aDefaults[2] )                                                        ; Fore color
						DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iItemParam][$iCol0+$iColOffset] ? $aColorsFonts[$iItemParam][$iCol0+$iColOffset] : BitAND( $aColorsFonts[$iItemParam][0], 1 ) ? $aColorsFonts[$iItemParam][$iColOffset] : $aDefaults[0] ) ; Font, _WinAPI_SelectObject
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors
					EndIf

				; Stage 4
				Case BitOR( $CDDS_ITEMPOSTPAINT, $CDDS_SUBITEM ) ; After a subitem has been painted
					; Custom drawing of selected subitem must be done in post paint stage
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					; Selected back color, selected fore color, selected text font
					If $bDrawCustomDefaultColors Then
						If $bHasFocus Then    ; Custom drawing of selected subitem when listview has focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[3] : $aDefaults[1] )[0] ; Default selected back color,  _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[4] : $aDefaults[2]  )   ; Default selected fore color,  _WinAPI_SetTextColor
						Else ; $fSelected = 2 ; Custom drawing of selected subitem when listview has not focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aDefaults[5] )[0]                                                        ; Default unfocused back color, _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aDefaults[6] )                                                           ; Default unfocused fore color, _WinAPI_SetTextColor
						EndIf
					Else
						$iCol0 = $iColOffset + $iColOffset * $iSubItem ; Column offset
						If $bHasFocus Then    ; Custom drawing of selected subitem when listview has focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aColorsFonts[$iItemParam][$iCol0+3] ? $aColorsFonts[$iItemParam][$iCol0+3] : BitAND( $aColorsFonts[$iItemParam][0],  4 ) ? ( $aColorsFonts[$iItemParam][3] ? $aColorsFonts[$iItemParam][3] : $aDefaults[3] ) : $aDefaults[3] )[0] ; Selected back color,  _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aColorsFonts[$iItemParam][$iCol0+4] ? $aColorsFonts[$iItemParam][$iCol0+4] : BitAND( $aColorsFonts[$iItemParam][0],  4 ) ? ( $aColorsFonts[$iItemParam][4] ? $aColorsFonts[$iItemParam][4] : $aDefaults[4] ) : $aDefaults[4] )    ; Selected fore color,  _WinAPI_SetTextColor
						Else ; $fSelected = 2 ; Custom drawing of selected subitem when listview has not focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aColorsFonts[$iItemParam][$iCol0+5] ? $aColorsFonts[$iItemParam][$iCol0+5] : BitAND( $aColorsFonts[$iItemParam][0], 16 ) ? ( $aColorsFonts[$iItemParam][5] ? $aColorsFonts[$iItemParam][5] : $aDefaults[5] ) : $aDefaults[5] )[0] ; Unfocused back color, _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aColorsFonts[$iItemParam][$iCol0+6] ? $aColorsFonts[$iItemParam][$iCol0+6] : BitAND( $aColorsFonts[$iItemParam][0], 16 ) ?   $aColorsFonts[$iItemParam][6] : $aDefaults[6] )                                                      ; Unfocused fore color, _WinAPI_SetTextColor
						EndIf
						DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iItemParam][$iCol0+$iColOffset] ? $aColorsFonts[$iItemParam][$iCol0+$iColOffset] : BitAND( $aColorsFonts[$iItemParam][0], 1 ) ? $aColorsFonts[$iItemParam][$iColOffset] : $aDefaults[0] )                        ; Selected text font,   _WinAPI_SelectObject
					EndIf

					; Subitem rectangle
					$iImageWidth = 0
					If $bImages And $iSubItem Then
						; Extract subitem image index from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
						DllStructSetData( $tLVitem, "Item", $iItem )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
						If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
							If $iImgWidth0 Then
								$iImageWidth = $iImgWidth0
							Else
								; Calculate width of subitem image
								DllStructSetData( $tRect, "Top", $iSubItem )
								DllStructSetData( $tRect, "Left", $LVIR_ICON )
								$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
								$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
								$iImageWidth = $iImgWidth0
							EndIf
						EndIf
					EndIf
					DllStructSetData( $tRect, "Top", $iSubItem )
					DllStructSetData( $tRect, "Left", $LVIR_LABEL )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

					; Selected back color
					DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hBrush ) ; _WinAPI_FillRect

					; Left margin of subitem text
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
					If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

					; Extract subitem text from listview
					DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
					DllStructSetData( $tLVitem, "SubItem", $iSubItem )
					DllStructSetData( $tLVitem, "Text", $pBuffer )
					DllStructSetData( $tLVitem, "TextMax", 4096 )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

					; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
					DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText

					; Delete the back color brush
					DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hBrush ) ; _WinAPI_DeleteObject
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors

				; Stage 5
				Case $CDDS_ITEMPOSTPAINT                         ; After an item has been painted
					; Custom drawing of selected item must be done in post paint stage

					; Selected back color, selected fore color, selected text font
					If $bDrawCustomDefaultColors Then
						If $bHasFocus Then    ; Custom drawing of selected item when listview has focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aDefaults[3] )[0]                                                       ; Default selected back color,   _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aDefaults[4] )                                                          ; Default selected fore color,   _WinAPI_SetTextColor
						Else ; $fSelected = 2 ; Custom drawing of selected item when listview has not focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", BitAND( $iSelFocus, $LVIS_FOCUSED ) ? $aDefaults[1] : $aDefaults[5] )[0] ; Default unfocused back color,  _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  BitAND( $iSelFocus, $LVIS_FOCUSED ) ? $aDefaults[2] : $aDefaults[6]  )   ; Default unfocused fore color,  _WinAPI_SetTextColor
						EndIf
					Else
						If $bHasFocus Then    ; Custom drawing of selected item when listview has focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aColorsFonts[$iItemParam][3] ? $aColorsFonts[$iItemParam][3] : $aDefaults[3] )[0]                     ; Selected back color, _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aColorsFonts[$iItemParam][4] ? $aColorsFonts[$iItemParam][4] : $aDefaults[4] )                        ; Selected fore color, _WinAPI_SetTextColor
						Else ; $fSelected = 2 ; Custom drawing of selected item when listview has not focus
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aColorsFonts[$iItemParam][5] ? $aColorsFonts[$iItemParam][5] : $aDefaults[5] )[0]                     ; Unfocused back color, _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aColorsFonts[$iItemParam][6] ? $aColorsFonts[$iItemParam][6] : $aDefaults[6] )                        ; Unfocused fore color, _WinAPI_SetTextColor
						EndIf
						DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iItemParam][$iColOffset] ? $aColorsFonts[$iItemParam][$iColOffset] : $aDefaults[0] ) ; Selected text font,   _WinAPI_SelectObject
					EndIf

					; For each subitem
					For $iSubItem = 0 To $iColumns - 1
						; Subitem rectangle
						$iImageWidth = 0
						If $bImages And $iSubItem Then
							; Extract subitem image index from listview
							DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
							DllStructSetData( $tLVitem, "Item", $iItem )
							DllStructSetData( $tLVitem, "SubItem", $iSubItem )
							$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
							If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
								If $iImgWidth0 Then
									$iImageWidth = $iImgWidth0
								Else
									; Calculate width of subitem image
									DllStructSetData( $tRect, "Top", $iSubItem )
									DllStructSetData( $tRect, "Left", $LVIR_ICON )
									$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
									$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
									$iImageWidth = $iImgWidth0
								EndIf
							EndIf
						EndIf
						DllStructSetData( $tRect, "Top", $iSubItem )
						DllStructSetData( $tRect, "Left", $LVIR_LABEL )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
						DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

						; Selected back color
						DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hBrush ) ; _WinAPI_FillRect

						; Left margin of subitem text
						DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
						If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

						; Extract subitem text from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						DllStructSetData( $tLVitem, "Text", $pBuffer )
						DllStructSetData( $tLVitem, "TextMax", 4096 )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

						; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
						DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText
					Next

					; Delete the back color brush
					DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hBrush ) ; _WinAPI_DeleteObject
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors
			EndSwitch
		Case $NM_KILLFOCUS
			$bLVHasFocus = False
		Case $NM_SETFOCUS
			If Not $bLVHasFocus Then
				DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
				$bLVHasFocus = True
			EndIf
	EndSwitch
	Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	; Call next function in subclass chain (this forwards messages to main GUI)
	#forceref $i
EndFunc

Func ListViewColorsFontsSC_Columns( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView )
	If ( $iMsg <> $WM_NOTIFY And $iMsg <> $WM_PARENTNOTIFY ) Or ( $iMsg = $WM_NOTIFY And $hListView <> HWnd( DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "hWndFrom" ) ) ) Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local Static $tLVitem = DllStructCreate( $tagLVITEM ), $pLVitem = DllStructGetPtr( $tLVitem ), $tBuffer = DllStructCreate( "wchar Text[4096]" ), $pBuffer = DllStructGetPtr( $tBuffer )
	Local Static $bLVHasFocus, $hDC, $bHasFocus, $iItem, $iSelected, $tRect = DllStructCreate( $tagRECT ), $pRect = DllStructGetPtr( $tRect ), $bNotXP = Not ( @OSVersion = "WIN_XP" )
	Local $iSubItem, $hBrush, $i, $iImageWidth

	; Static variables used for a specific listview. These variables are updated when the current listview is replaced with another listview.
	Local Static $iIndexPrev = 0, $idListView, $bImages, $bChkboxes, $hGui, $sClassNN, $fSelected, $bNotSelected, $aDefaults, $aColorsFonts, $iColorsFonts, $iImgWidth0
	If $iIndexPrev <> $iIndex Then ; $iIndex is used to switch between different listviews
		$iIndexPrev = $iIndex        ; $iIndex <= 0 is used to force a re-
		If $iIndex <= 0 Then Return  ; read of $aListViewColorsFontsInfo.
		$idListView   = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$bImages      = $aListViewColorsFontsInfo[$iIndex][3]  ; Subitem images
		$bChkboxes    = $aListViewColorsFontsInfo[$iIndex][4]  ; Checkboxes
		$hGui         = $aListViewColorsFontsInfo[$iIndex][6]  ; Main GUI window handle
		$sClassNN     = $aListViewColorsFontsInfo[$iIndex][7]  ; CLASSNN listview name
		$fSelected    = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$aDefaults    = $aListViewColorsFontsInfo[$iIndex][17] ; Current default colors and font
		$aColorsFonts = $aListViewColorsFontsInfo[$iIndex][22] ; Array with color/font info, $iSubItem is row index
		$iColorsFonts = $aListViewColorsFontsInfo[$iIndex][23] ; Number of used rows in array
		$bNotSelected = $fSelected ? False : True ; Convert to boolean
		$iImgWidth0   = 0
	EndIf

	If $iMsg = $WM_PARENTNOTIFY Then
		If Not $bLVHasFocus Then DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
		Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	EndIf

	Switch DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "Code" ) ; $iCode
		Case $NM_CUSTOMDRAW
			Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
			Local $dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
			Switch $dwDrawStage                                ; Specifies the drawing stage
				; Stage 1
				Case $CDDS_PREPAINT                              ; Before the paint cycle begins
					$hDC = DllStructGetData( $tNMLVCUSTOMDRAW, "hdc" )                              ; Device context
					DllCall( "gdi32.dll", "int", "SetBkMode", "handle", $hDC, "int", $TRANSPARENT ) ; Transparent background, _WinAPI_SetBkMode
					$bHasFocus = ( $sClassNN = ControlGetFocus( $hGui ) )                           ; Has listview focus?
					Return $CDRF_NOTIFYITEMDRAW                    ; Notify the parent window before an item is painted

				; Stage 2
				Case $CDDS_ITEMPREPAINT                          ; Before an item is painted
					$iItem = DllStructGetData( $tNMLVCUSTOMDRAW, "dwItemSpec" ) ; Item index
					$iSelected = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMSTATE, $iItem, $LVIS_SELECTED ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMSTATE, "wparam", $iItem, "lparam", $LVIS_SELECTED )[0] ; Selected state

					If $iSelected And $bNotSelected Then Return $CDRF_NEWFONT ; Default drawing of selected item
					Return $CDRF_NOTIFYSUBITEMDRAW                 ; Notify the parent window of any subitem-related drawing operations

				; Stage 3
				Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM )  ; Before a subitem is painted
					If $iSelected Then ; Selected item ; Custom drawing of selected item must be done in post paint stage
						If $bHasFocus Or $fSelected = 2 Then Return $CDRF_NOTIFYPOSTPAINT ; Notify the parent window after an item is painted
						Return $CDRF_NEWFONT                         ; Default drawing of unfocused selected item ($bHasFocus = False, $fSelected = 1)

					Else ; Unselected item
						$iSubItem = DllStructGetData( $tNMLVCUSTOMDRAW, "iSubItem" ) ; Subitem index
						If $iSubItem < $iColorsFonts And $aColorsFonts[$iSubItem][0] Then
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aColorsFonts[$iSubItem][1] ? $aColorsFonts[$iSubItem][1] : $aDefaults[1] )                          ; Back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aColorsFonts[$iSubItem][2] ? $aColorsFonts[$iSubItem][2] : $aDefaults[2] )                          ; Fore color
							DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iSubItem][3] ? $aColorsFonts[$iSubItem][3] : $aDefaults[0] ) ; Font, _WinAPI_SelectObject
							Return $CDRF_NEWFONT                       ; $CDRF_NEWFONT must be returned after changing font or colors
						Else
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Default back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Default fore color
							DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Default font, _WinAPI_SelectObject
							Return $CDRF_NEWFONT                       ; $CDRF_NEWFONT must be returned after changing font or colors
						EndIf
					EndIf

				; Stage 4
				Case BitOR( $CDDS_ITEMPOSTPAINT, $CDDS_SUBITEM ) ; After a subitem has been painted
					; Custom drawing of selected subitem must be done in post paint stage
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					; Selected back color, selected fore color, selected text font
					If $bHasFocus Then    ; Custom drawing of selected subitem when listview has focus
						$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aColorsFonts[$iSubItem][3] ? $aColorsFonts[$iSubItem][3] : $aDefaults[3] )[0] ; Selected back color,  _WinAPI_CreateSolidBrush
						DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aColorsFonts[$iSubItem][4] ? $aColorsFonts[$iSubItem][4] : $aDefaults[4] )    ; Selected fore color,  _WinAPI_SetTextColor
					Else ; $fSelected = 2 ; Custom drawing of selected subitem when listview has not focus
						$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aColorsFonts[$iSubItem][5] ? $aColorsFonts[$iSubItem][5] : $aDefaults[5] )[0] ; Unfocused back color, _WinAPI_CreateSolidBrush
						DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aColorsFonts[$iSubItem][6] ? $aColorsFonts[$iSubItem][6] : $aDefaults[6] )    ; Unfocused fore color, _WinAPI_SetTextColor
					EndIf
					DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aColorsFonts[$iSubItem][0] ? $aColorsFonts[$iSubItem][0] : $aDefaults[0] ) ; Selected text font,   _WinAPI_SelectObject

					; Subitem rectangle
					$iImageWidth = 0
					If $bImages And $iSubItem Then
						; Extract subitem image index from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
						DllStructSetData( $tLVitem, "Item", $iItem )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
						If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
							If $iImgWidth0 Then
								$iImageWidth = $iImgWidth0
							Else
								; Calculate width of subitem image
								DllStructSetData( $tRect, "Top", $iSubItem )
								DllStructSetData( $tRect, "Left", $LVIR_ICON )
								$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
								$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
								$iImageWidth = $iImgWidth0
							EndIf
						EndIf
					EndIf
					DllStructSetData( $tRect, "Top", $iSubItem )
					DllStructSetData( $tRect, "Left", $LVIR_LABEL )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

					; Selected back color
					DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hBrush ) ; _WinAPI_FillRect

					; Left margin of subitem text
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
					If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

					; Extract subitem text from listview
					DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
					DllStructSetData( $tLVitem, "SubItem", $iSubItem )
					DllStructSetData( $tLVitem, "Text", $pBuffer )
					DllStructSetData( $tLVitem, "TextMax", 4096 )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

					; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
					DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText

					; Delete the back color brush
					DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hBrush ) ; _WinAPI_DeleteObject
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors
			EndSwitch
		Case $NM_KILLFOCUS
			$bLVHasFocus = False
		Case $NM_SETFOCUS
			If Not $bLVHasFocus Then
				DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
				$bLVHasFocus = True
			EndIf
	EndSwitch
	Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	; Call next function in subclass chain (this forwards messages to main GUI)
	#forceref $i
EndFunc

Func ListViewColorsFontsSC_AlterRows( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView )
	If ( $iMsg <> $WM_NOTIFY And $iMsg <> $WM_PARENTNOTIFY ) Or ( $iMsg = $WM_NOTIFY And $hListView <> HWnd( DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "hWndFrom" ) ) ) Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local Static $tLVitem = DllStructCreate( $tagLVITEM ), $pLVitem = DllStructGetPtr( $tLVitem ), $tBuffer = DllStructCreate( "wchar Text[4096]" ), $pBuffer = DllStructGetPtr( $tBuffer ), $bNotXP = Not ( @OSVersion = "WIN_XP" )
	Local Static $bLVHasFocus, $hDC, $bHasFocus, $iColumns, $iItem, $iItemPrev = -1, $iSelFocus, $hSubBrush, $tRect = DllStructCreate( $tagRECT ), $pRect = DllStructGetPtr( $tRect )
	Local $iSubItem, $hBrush, $i, $iImageWidth

	; Static variables used for a specific listview. These variables are updated when the current listview is replaced with another listview.
	Local Static $iIndexPrev = 0, $idListView, $hHeader, $bImages, $bChkboxes, $hGui, $sClassNN, $fSelected, $fNotSelected, $fDefaults, $aDefaults, $iRows, $iRows2, $fAlter, $aAlter, $iImgWidth0
	If $iIndexPrev <> $iIndex Then ; $iIndex is used to switch between different listviews
		$iIndexPrev = $iIndex        ; $iIndex <= 0 is used to force a re-
		If $iIndex <= 0 Then Return  ; read of $aListViewColorsFontsInfo.
		$idListView = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$hHeader    = $aListViewColorsFontsInfo[$iIndex][2]  ; Listview header
		$bImages    = $aListViewColorsFontsInfo[$iIndex][3]  ; Subitem images
		$bChkboxes  = $aListViewColorsFontsInfo[$iIndex][4]  ; Checkboxes
		$hGui       = $aListViewColorsFontsInfo[$iIndex][6]  ; Main GUI window handle
		$sClassNN   = $aListViewColorsFontsInfo[$iIndex][7]  ; CLASSNN listview name
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default colors and font
		$iRows      = $aListViewColorsFontsInfo[$iIndex][22] ; Rows between color change
		$fAlter     = $aListViewColorsFontsInfo[$iIndex][24] ; Flags for alternating colors
		$aAlter     = $aListViewColorsFontsInfo[$iIndex][25] ; Alternating colors
		$fNotSelected = $fSelected ? False : True ; Convert to boolean
		$iRows2 = 2 * $iRows
		$iImgWidth0 = 0
	EndIf

	If $iMsg = $WM_PARENTNOTIFY Then
		If Not $bLVHasFocus Then DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
		Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	EndIf

	Switch DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "Code" ) ; $iCode
		Case $NM_CUSTOMDRAW
			Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
			Local $dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
			Switch $dwDrawStage                                ; Specifies the drawing stage
				; Stage 1
				Case $CDDS_PREPAINT                              ; Before the paint cycle begins
					$hDC = DllStructGetData( $tNMLVCUSTOMDRAW, "hdc" )                              ; Device context
					DllCall( "gdi32.dll", "int", "SetBkMode", "handle", $hDC, "int", $TRANSPARENT ) ; Transparent background, _WinAPI_SetBkMode
					$bHasFocus = ( $sClassNN = ControlGetFocus( $hGui ) )                           ; Has listview focus?
					$iColumns = DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hHeader, "uint", 0x1200, "wparam", 0, "lparam", 0 )[0] ; 0x1200 = $HDM_GETITEMCOUNT, _GUICtrlHeader_GetItemCount
					Return $CDRF_NOTIFYITEMDRAW                    ; Notify the parent window before an item is painted

				; Stage 2
				Case $CDDS_ITEMPREPAINT                          ; Before an item is painted
					$iItemPrev = -1
					$iItem     = DllStructGetData( $tNMLVCUSTOMDRAW, "dwItemSpec" ) ; Item index
					$iSelFocus = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMSTATE, $iItem, $LVIS_FOCUSED+$LVIS_SELECTED ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMSTATE, "wparam", $iItem, "lparam", $LVIS_FOCUSED+$LVIS_SELECTED )[0] ; Selected state
					If BitAND( $fDefaults, 1 ) Then DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font/style, _WinAPI_SelectObject

					If Not $iSelFocus Then ; Normal item
						If Not ( BitAND( $fAlter, 6 ) Or BitAND( $fDefaults, 7 ) ) Then Return $CDRF_NEWFONT ; Default drawing of normal item
						; Custom drawing of normal item. Alternating colors for selected item can be drawn in CDDS_ITEMPREPAINT stage 2, this stage.
						If Mod( $iItem, $iRows2 ) >= $iRows Then ; Alternating color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aAlter[1] )    ; Alternating back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aAlter[2] )    ; Alternating fore color
						Else ; Default color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] ) ; Default back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] ) ; Default fore color
						EndIf
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors

					ElseIf BitAND( $iSelFocus, $LVIS_FOCUSED ) Then ; Focused item
						If $fNotSelected Then Return $CDRF_NEWFONT   ; Default drawing of focused item
						; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one. Stage 3 and 4.
						If BitAND( $fAlter, 24 ) Or BitAND( $fAlter, 96 ) Or BitAND( $fDefaults, 7 ) Or BitAND( $fDefaults, 24 ) Or BitAND( $fDefaults, 96 ) Then Return $CDRF_NOTIFYSUBITEMDRAW
						Return $CDRF_NEWFONT                         ; Default drawing of focused item

					ElseIf $iSelFocus Then ; Selected item
						If $fNotSelected Then Return $CDRF_NEWFONT   ; Default drawing of selected item
						; Custom drawing of Selected item. Alternating colors for selected item must be drawn in CDDS_ITEMPOSTPAINT stage, stage 5.
						If BitAND( $fAlter, 24 ) Or BitAND( $fAlter, 96 ) Or BitAND( $fDefaults, 25 ) Or BitAND( $fDefaults, 97 ) Then Return $CDRF_NOTIFYPOSTPAINT
						Return $CDRF_NEWFONT                         ; Default drawing of selected item
					EndIf

				; Stage 3
				Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM )  ; Before a subitem is painted
					; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one. Stage 3 and 4.
					Return $CDRF_NOTIFYPOSTPAINT                   ; Notify the parent window after a subitem is painted

				; Stage 4
				Case BitOR( $CDDS_ITEMPOSTPAINT, $CDDS_SUBITEM ) ; After a subitem has been painted
					; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one.
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					; Focused back color, focused fore color
					If $iItemPrev <> $iItem Then
						$iItemPrev = $iItem
						; Delete the back color brush
						DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hSubBrush ) ; _WinAPI_DeleteObject
						$hSubBrush = Mod( $iItem, $iRows2 ) >= $iRows ? ( DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $bHasFocus ? $aAlter[3] : $aAlter[5] )[0] ) : ( DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $bHasFocus ? ( BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[3] : $aDefaults[1] ) : ( BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[5] : $aDefaults[1] ) )[0] )
					EndIf
					$i = Mod( $iItem, $iRows2 ) >= $iRows ? ( DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int", $bHasFocus ? $aAlter[4] : $aAlter[6] ) ) : ( DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int", $bHasFocus ? ( BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[4] : $aDefaults[2] ) : ( BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[6] : $aDefaults[2] ) ) )

					; Subitem rectangle
					$iImageWidth = 0
					If $bImages And $iSubItem Then
						; Extract subitem image index from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
						DllStructSetData( $tLVitem, "Item", $iItem )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
						If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
							If $iImgWidth0 Then
								$iImageWidth = $iImgWidth0
							Else
								; Calculate width of subitem image
								DllStructSetData( $tRect, "Top", $iSubItem )
								DllStructSetData( $tRect, "Left", $LVIR_ICON )
								$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
								$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
								$iImageWidth = $iImgWidth0
							EndIf
						EndIf
					EndIf
					DllStructSetData( $tRect, "Top", $iSubItem )
					DllStructSetData( $tRect, "Left", $LVIR_LABEL )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

					; Focused back color
					DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hSubBrush ) ; _WinAPI_FillRect

					; Left margin of subitem text
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
					If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

					; Extract subitem text from listview
					DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
					DllStructSetData( $tLVitem, "SubItem", $iSubItem )
					DllStructSetData( $tLVitem, "Text", $pBuffer )
					DllStructSetData( $tLVitem, "TextMax", 4096 )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

					; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
					DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors

				; Stage 5
				Case $CDDS_ITEMPOSTPAINT                         ; After an item has been painted
					; Selected back color, selected fore color
					If Mod( $iItem, $iRows2 ) >= $iRows Then ; Alternating color
						If $bHasFocus Then
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aAlter[3] )[0]    ; Selected back color,  _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aAlter[4] )       ; Selected fore color,  _WinAPI_SetTextColor
						Else ; $fSelected = 2
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aAlter[5] )[0]    ; Unfocused back color, _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aAlter[6] )       ; Unfocused fore color, _WinAPI_SetTextColor
						EndIf
					Else ; Default color
						If $bHasFocus Then
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aDefaults[3] )[0] ; Selected back color,  _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aDefaults[4] )    ; Selected fore color,  _WinAPI_SetTextColor
						Else ; $fSelected = 2
							$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aDefaults[5] )[0] ; Unfocused back color, _WinAPI_CreateSolidBrush
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aDefaults[6] )    ; Unfocused fore color, _WinAPI_SetTextColor
						EndIf
					EndIf

					; For each subitem
					For $iSubItem = 0 To $iColumns - 1
						; Subitem rectangle
						$iImageWidth = 0
						If $bImages And $iSubItem Then
							; Extract subitem image index from listview
							DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
							DllStructSetData( $tLVitem, "Item", $iItem )
							DllStructSetData( $tLVitem, "SubItem", $iSubItem )
							$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
							If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
								If $iImgWidth0 Then
									$iImageWidth = $iImgWidth0
								Else
									; Calculate width of subitem image
									DllStructSetData( $tRect, "Top", $iSubItem )
									DllStructSetData( $tRect, "Left", $LVIR_ICON )
									$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
									$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
									$iImageWidth = $iImgWidth0
								EndIf
							EndIf
						EndIf
						DllStructSetData( $tRect, "Top", $iSubItem )
						DllStructSetData( $tRect, "Left", $LVIR_LABEL )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
						DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

						; Selected back color
						DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hBrush ) ; _WinAPI_FillRect

						; Left margin of subitem text
						DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
						If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

						; Extract subitem text from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						DllStructSetData( $tLVitem, "Text", $pBuffer )
						DllStructSetData( $tLVitem, "TextMax", 4096 )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

						; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
						DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText
					Next

					; Delete the back color brush
					DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hBrush ) ; _WinAPI_DeleteObject
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors
			EndSwitch
		Case $NM_KILLFOCUS
			$bLVHasFocus = False
		Case $NM_SETFOCUS
			If Not $bLVHasFocus Then
				DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
				$bLVHasFocus = True
			EndIf
	EndSwitch
	Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	; Call next function in subclass chain (this forwards messages to main GUI)
	#forceref $i
EndFunc

Func ListViewColorsFontsSC_AlterCols( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView )
	If ( $iMsg <> $WM_NOTIFY And $iMsg <> $WM_PARENTNOTIFY ) Or ( $iMsg = $WM_NOTIFY And $hListView <> HWnd( DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "hWndFrom" ) ) ) Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local Static $tLVitem = DllStructCreate( $tagLVITEM ), $pLVitem = DllStructGetPtr( $tLVitem ), $tBuffer = DllStructCreate( "wchar Text[4096]" ), $pBuffer = DllStructGetPtr( $tBuffer )
	Local Static $bLVHasFocus, $hDC, $bHasFocus, $iItem, $iSelected, $tRect = DllStructCreate( $tagRECT ), $pRect = DllStructGetPtr( $tRect ), $bNotXP = Not ( @OSVersion = "WIN_XP" )
	Local $iSubItem, $hBrush, $i, $iImageWidth

	; Static variables used for a specific listview. These variables are updated when the current listview is replaced with another listview.
	Local Static $iIndexPrev = 0, $idListView, $bImages, $bChkboxes, $hGui, $sClassNN, $fSelected, $fNotSelected, $fDefaults, $aDefaults, $iCols, $iCols2, $fAlter, $aAlter, $iImgWidth0
	If $iIndexPrev <> $iIndex Then ; $iIndex is used to switch between different listviews
		$iIndexPrev = $iIndex        ; $iIndex <= 0 is used to force a re-
		If $iIndex <= 0 Then Return  ; read of $aListViewColorsFontsInfo.
		$idListView = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$bImages    = $aListViewColorsFontsInfo[$iIndex][3]  ; Subitem images
		$bChkboxes  = $aListViewColorsFontsInfo[$iIndex][4]  ; Checkboxes
		$hGui       = $aListViewColorsFontsInfo[$iIndex][6]  ; Main GUI window handle
		$sClassNN   = $aListViewColorsFontsInfo[$iIndex][7]  ; CLASSNN listview name
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default colors and font
		$iCols      = $aListViewColorsFontsInfo[$iIndex][23] ; Columns between color change
		$fAlter     = $aListViewColorsFontsInfo[$iIndex][24] ; Flags for alternating colors
		$aAlter     = $aListViewColorsFontsInfo[$iIndex][25] ; Alternating colors
		$fNotSelected = $fSelected ? False : True ; Convert to boolean
		$iCols2 = 2 * $iCols
		$iImgWidth0 = 0
	EndIf

	If $iMsg = $WM_PARENTNOTIFY Then
		If Not $bLVHasFocus Then DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
		Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	EndIf

	Switch DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "Code" ) ; $iCode
		Case $NM_CUSTOMDRAW
			Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
			Local $dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
			Switch $dwDrawStage                                ; Specifies the drawing stage
				; Stage 1
				Case $CDDS_PREPAINT                              ; Before the paint cycle begins
					$hDC = DllStructGetData( $tNMLVCUSTOMDRAW, "hdc" )                              ; Device context
					DllCall( "gdi32.dll", "int", "SetBkMode", "handle", $hDC, "int", $TRANSPARENT ) ; Transparent background, _WinAPI_SetBkMode
					$bHasFocus = ( $sClassNN = ControlGetFocus( $hGui ) )                           ; Has listview focus?
					Return $CDRF_NOTIFYITEMDRAW                    ; Notify the parent window before an item is painted

				; Stage 2
				Case $CDDS_ITEMPREPAINT                          ; Before an item is painted
					$iItem = DllStructGetData( $tNMLVCUSTOMDRAW, "dwItemSpec" ) ; Item index
					$iSelected = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMSTATE, $iItem, $LVIS_SELECTED ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMSTATE, "wparam", $iItem, "lparam", $LVIS_SELECTED )[0] ; Selected state
					If BitAND( $fDefaults, 1 ) Then DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font/style, _WinAPI_SelectObject

					If $iSelected Then
						If $fNotSelected Then Return $CDRF_NEWFONT   ; Default drawing of selected item
						If BitAND( $fAlter, 24 ) Or BitAND( $fAlter, 96 ) Then Return $CDRF_NOTIFYSUBITEMDRAW
						If BitAND( $fDefaults, 24 ) Or BitAND( $fDefaults, 96 ) Then Return $CDRF_NOTIFYSUBITEMDRAW
						Return $CDRF_NEWFONT                         ; Default drawing of selected item
					EndIf
					Return $CDRF_NOTIFYSUBITEMDRAW                 ; Notify the parent window of any subitem-related drawing operations

				; Stage 3
				Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM )  ; Before a subitem is painted
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					If $iSelected Then ; Selected item ; Custom drawing of selected item must be done in post paint stage
						If Mod( $iSubItem, $iCols2 ) >= $iCols And ( ( $bHasFocus And $fSelected And BitAND( $fAlter, 24 ) ) Or ( $fSelected = 2 And BitAND( $fAlter, 96 ) ) ) Then Return $CDRF_NOTIFYPOSTPAINT ; Post paint stage 4
						If ( $bHasFocus And $fSelected And BitAND( $fDefaults, 24 ) ) Or ( $fSelected = 2 And BitAND( $fDefaults, 96 ) ) Then Return $CDRF_NOTIFYPOSTPAINT ; Post paint stage 4
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors

					Else ; Unselected item
						If Mod( $iSubItem, $iCols2 ) < $iCols Then ; Default color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] ) ; Default back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] ) ; Default fore color
						Else ; Alternating color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aAlter[1] )    ; Alternating back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aAlter[2] )    ; Alternating fore color
						EndIf
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors
					EndIf

				; Stage 4
				Case BitOR( $CDDS_ITEMPOSTPAINT, $CDDS_SUBITEM ) ; After a subitem has been painted
					; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one.
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					; Selected back color, selected fore color
					$hBrush = Mod( $iSubItem, $iCols2 ) < $iCols ? ( DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $bHasFocus ? $aDefaults[3] : $aDefaults[5] )[0] ) : ( DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $bHasFocus ? $aAlter[3] : $aAlter[5] )[0] )
					$i = Mod( $iSubItem, $iCols2 ) < $iCols ? ( DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int", $bHasFocus ? $aDefaults[4] : $aDefaults[6] ) ) : ( DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int", $bHasFocus ? $aAlter[4] : $aAlter[6] ) )

					; Subitem rectangle
					$iImageWidth = 0
					If $bImages And $iSubItem Then
						; Extract subitem image index from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
						DllStructSetData( $tLVitem, "Item", $iItem )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
						If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
							If $iImgWidth0 Then
								$iImageWidth = $iImgWidth0
							Else
								; Calculate width of subitem image
								DllStructSetData( $tRect, "Top", $iSubItem )
								DllStructSetData( $tRect, "Left", $LVIR_ICON )
								$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
								$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
								$iImageWidth = $iImgWidth0
							EndIf
						EndIf
					EndIf
					DllStructSetData( $tRect, "Top", $iSubItem )
					DllStructSetData( $tRect, "Left", $LVIR_LABEL )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

					; Selected back color
					DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hBrush ) ; _WinAPI_FillRect

					; Left margin of subitem text
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
					If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

					; Extract subitem text from listview
					DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
					DllStructSetData( $tLVitem, "SubItem", $iSubItem )
					DllStructSetData( $tLVitem, "Text", $pBuffer )
					DllStructSetData( $tLVitem, "TextMax", 4096 )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

					; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
					DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText

					; Delete the back color brush
					DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hBrush ) ; _WinAPI_DeleteObject
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors
			EndSwitch
		Case $NM_KILLFOCUS
			$bLVHasFocus = False
		Case $NM_SETFOCUS
			If Not $bLVHasFocus Then
				DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
				$bLVHasFocus = True
			EndIf
	EndSwitch
	Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	; Call next function in subclass chain (this forwards messages to main GUI)
	#forceref $i
EndFunc

Func ListViewColorsFontsSC_AlterRowsCols( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView )
	If ( $iMsg <> $WM_NOTIFY And $iMsg <> $WM_PARENTNOTIFY ) Or ( $iMsg = $WM_NOTIFY And $hListView <> HWnd( DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "hWndFrom" ) ) ) Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local Static $tLVitem = DllStructCreate( $tagLVITEM ), $pLVitem = DllStructGetPtr( $tLVitem ), $tBuffer = DllStructCreate( "wchar Text[4096]" ), $pBuffer = DllStructGetPtr( $tBuffer )
	Local Static $bLVHasFocus, $hDC, $bHasFocus, $iItem, $iSelected, $tRect = DllStructCreate( $tagRECT ), $pRect = DllStructGetPtr( $tRect ), $bNotXP = Not ( @OSVersion = "WIN_XP" )
	Local $iSubItem, $hBrush, $i, $iImageWidth

	; Static variables used for a specific listview. These variables are updated when the current listview is replaced with another listview.
	Local Static $iIndexPrev = 0, $idListView, $bImages, $bChkboxes, $hGui, $sClassNN, $fSelected, $fNotSelected, $fDefaults, $aDefaults, $iRows, $iRows2, $iCols, $iCols2, $fAlter, $aAlter, $iImgWidth0
	If $iIndexPrev <> $iIndex Then ; $iIndex is used to switch between different listviews
		$iIndexPrev = $iIndex        ; $iIndex <= 0 is used to force a re-
		If $iIndex <= 0 Then Return  ; read of $aListViewColorsFontsInfo.
		$idListView = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$bImages    = $aListViewColorsFontsInfo[$iIndex][3]  ; Subitem images
		$bChkboxes  = $aListViewColorsFontsInfo[$iIndex][4]  ; Checkboxes
		$hGui       = $aListViewColorsFontsInfo[$iIndex][6]  ; Main GUI window handle
		$sClassNN   = $aListViewColorsFontsInfo[$iIndex][7]  ; CLASSNN listview name
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default colors and font
		$iRows      = $aListViewColorsFontsInfo[$iIndex][22] ; Rows between color change
		$iCols      = $aListViewColorsFontsInfo[$iIndex][23] ; Columns between color change
		$fAlter     = $aListViewColorsFontsInfo[$iIndex][24] ; Flags for alternating colors
		$aAlter     = $aListViewColorsFontsInfo[$iIndex][25] ; Alternating colors
		$fNotSelected = $fSelected ? False : True ; Convert to boolean
		$iRows2 = 2 * $iRows
		$iCols2 = 2 * $iCols
		$iImgWidth0 = 0
	EndIf

	If $iMsg = $WM_PARENTNOTIFY Then
		If Not $bLVHasFocus Then DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
		Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	EndIf

	Switch DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "Code" ) ; $iCode
		Case $NM_CUSTOMDRAW
			Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
			Local $dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
			Switch $dwDrawStage                                ; Specifies the drawing stage
				; Stage 1
				Case $CDDS_PREPAINT                              ; Before the paint cycle begins
					$hDC = DllStructGetData( $tNMLVCUSTOMDRAW, "hdc" )                              ; Device context
					DllCall( "gdi32.dll", "int", "SetBkMode", "handle", $hDC, "int", $TRANSPARENT ) ; Transparent background, _WinAPI_SetBkMode
					$bHasFocus = ( $sClassNN = ControlGetFocus( $hGui ) )                           ; Has listview focus?
					Return $CDRF_NOTIFYITEMDRAW                    ; Notify the parent window before an item is painted

				; Stage 2
				Case $CDDS_ITEMPREPAINT                          ; Before an item is painted
					$iItem = DllStructGetData( $tNMLVCUSTOMDRAW, "dwItemSpec" ) ; Item index
					$iSelected = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMSTATE, $iItem, $LVIS_SELECTED ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMSTATE, "wparam", $iItem, "lparam", $LVIS_SELECTED )[0] ; Selected state
					If BitAND( $fDefaults, 1 ) Then DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font/style, _WinAPI_SelectObject

					If $iSelected Then
						If $fNotSelected Then Return $CDRF_NEWFONT   ; Default drawing of selected item
						If BitAND( $fAlter, 24 ) Or BitAND( $fAlter, 96 ) Then Return $CDRF_NOTIFYSUBITEMDRAW
						If BitAND( $fDefaults, 24 ) Or BitAND( $fDefaults, 96 ) Then Return $CDRF_NOTIFYSUBITEMDRAW
						Return $CDRF_NEWFONT                         ; Default drawing of selected item
					EndIf
					Return $CDRF_NOTIFYSUBITEMDRAW                 ; Notify the parent window of any subitem-related drawing operations

				; Stage 3
				Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM )  ; Before a subitem is painted
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					If $iSelected Then ; Selected item ; Custom drawing of selected item must be done in post paint stage
						If ( Mod( $iItem, $iRows2 ) >= $iRows Or Mod( $iSubItem, $iCols2 ) >= $iCols ) And ( ( $bHasFocus And $fSelected And BitAND( $fAlter, 24 ) ) Or ( $fSelected = 2 And BitAND( $fAlter, 96 ) ) ) Then Return $CDRF_NOTIFYPOSTPAINT ; Post paint stage 4
						If ( $bHasFocus And $fSelected And BitAND( $fDefaults, 24 ) ) Or ( $fSelected = 2 And BitAND( $fDefaults, 96 ) ) Then Return $CDRF_NOTIFYPOSTPAINT ; Post paint stage 4
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors

					Else ; Unselected item
						If Mod( $iItem, $iRows2 ) >= $iRows Or Mod( $iSubItem, $iCols2 ) >= $iCols Then ; Alternating color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aAlter[1] )    ; Alternating back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aAlter[2] )    ; Alternating fore color
						Else ; Default color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] ) ; Default back color
							DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] ) ; Default fore color
						EndIf
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors
					EndIf

				; Stage 4
				Case BitOR( $CDDS_ITEMPOSTPAINT, $CDDS_SUBITEM ) ; After a subitem has been painted
					; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one.
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					; Selected back color, selected fore color
					$hBrush = ( Mod( $iItem, $iRows2 ) >= $iRows Or Mod( $iSubItem, $iCols2 ) >= $iCols ) ? ( DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $bHasFocus ? $aAlter[3] : $aAlter[5] )[0] ) : ( DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $bHasFocus ? $aDefaults[3] : $aDefaults[5] )[0] )
					$i = ( Mod( $iItem, $iRows2 ) >= $iRows Or Mod( $iSubItem, $iCols2 ) >= $iCols ) ? ( DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int", $bHasFocus ? $aAlter[4] : $aAlter[6] ) ) : ( DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int", $bHasFocus ? $aDefaults[4] : $aDefaults[6] ) )

					; Subitem rectangle
					$iImageWidth = 0
					If $bImages And $iSubItem Then
						; Extract subitem image index from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
						DllStructSetData( $tLVitem, "Item", $iItem )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
						If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
							If $iImgWidth0 Then
								$iImageWidth = $iImgWidth0
							Else
								; Calculate width of subitem image
								DllStructSetData( $tRect, "Top", $iSubItem )
								DllStructSetData( $tRect, "Left", $LVIR_ICON )
								$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
								$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
								$iImageWidth = $iImgWidth0
							EndIf
						EndIf
					EndIf
					DllStructSetData( $tRect, "Top", $iSubItem )
					DllStructSetData( $tRect, "Left", $LVIR_LABEL )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

					; Selected back color
					DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hBrush ) ; _WinAPI_FillRect

					; Left margin of subitem text
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
					If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

					; Extract subitem text from listview
					DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
					DllStructSetData( $tLVitem, "SubItem", $iSubItem )
					DllStructSetData( $tLVitem, "Text", $pBuffer )
					DllStructSetData( $tLVitem, "TextMax", 4096 )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

					; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
					DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText

					; Delete the back color brush
					DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hBrush ) ; _WinAPI_DeleteObject
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors
			EndSwitch
		Case $NM_KILLFOCUS
			$bLVHasFocus = False
		Case $NM_SETFOCUS
			If Not $bLVHasFocus Then
				DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
				$bLVHasFocus = True
			EndIf
	EndSwitch
	Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	; Call next function in subclass chain (this forwards messages to main GUI)
	#forceref $i
EndFunc

Func ListViewColorsFontsSC_Defaults( $hWnd, $iMsg, $wParam, $lParam, $iIndex, $hListView )
	If ( $iMsg <> $WM_NOTIFY And $iMsg <> $WM_PARENTNOTIFY ) Or ( $iMsg = $WM_NOTIFY And $hListView <> HWnd( DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "hWndFrom" ) ) ) Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local Static $tLVitem = DllStructCreate( $tagLVITEM ), $pLVitem = DllStructGetPtr( $tLVitem ), $tBuffer = DllStructCreate( "wchar Text[4096]" ), $pBuffer = DllStructGetPtr( $tBuffer ), $bNotXP = Not ( @OSVersion = "WIN_XP" )
	Local Static $bLVHasFocus, $hDC, $bHasFocus, $iColumns, $iItem, $iItemPrev = -1, $iSelFocus, $hSubBrush, $tRect = DllStructCreate( $tagRECT ), $pRect = DllStructGetPtr( $tRect )
	Local $iSubItem, $hBrush, $i, $iImageWidth

	; Static variables used for a specific listview. These variables are updated when the current listview is replaced with another listview.
	Local Static $iIndexPrev = 0, $idListView, $hHeader, $bImages, $bChkboxes, $hGui, $sClassNN, $fSelected, $fNotSelected, $fDefaults, $aDefaults, $iImgWidth0
	If $iIndexPrev <> $iIndex Then ; $iIndex is used to switch between different listviews
		$iIndexPrev = $iIndex        ; $iIndex <= 0 is used to force a re-
		If $iIndex <= 0 Then Return  ; read of $aListViewColorsFontsInfo.
		$idListView = $aListViewColorsFontsInfo[$iIndex][0]  ; Listview control ID
		$hHeader    = $aListViewColorsFontsInfo[$iIndex][2]  ; Listview header
		$bImages    = $aListViewColorsFontsInfo[$iIndex][3]  ; Subitem images
		$bChkboxes  = $aListViewColorsFontsInfo[$iIndex][4]  ; Checkboxes
		$hGui       = $aListViewColorsFontsInfo[$iIndex][6]  ; Main GUI window handle
		$sClassNN   = $aListViewColorsFontsInfo[$iIndex][7]  ; CLASSNN listview name
		$fSelected  = $aListViewColorsFontsInfo[$iIndex][15] ; Flag for selected items
		$fDefaults  = $aListViewColorsFontsInfo[$iIndex][16] ; Custom default colors/font flag
		$aDefaults  = $aListViewColorsFontsInfo[$iIndex][17] ; Current default font and colors
		$fNotSelected = $fSelected ? False : True ; Convert to boolean
		$iImgWidth0 = 0
	EndIf

	If $iMsg = $WM_PARENTNOTIFY Then
		If Not $bLVHasFocus Then DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
		Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	EndIf

	Switch DllStructGetData( DllStructCreate( $tagNMHDR, $lParam ), "Code" ) ; $iCode
		Case $NM_CUSTOMDRAW
			Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
			Local $dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
			Switch $dwDrawStage                                ; Specifies the drawing stage
				; Stage 1
				Case $CDDS_PREPAINT                              ; Before the paint cycle begins
					$hDC = DllStructGetData( $tNMLVCUSTOMDRAW, "hdc" )                              ; Device context
					DllCall( "gdi32.dll", "int", "SetBkMode", "handle", $hDC, "int", $TRANSPARENT ) ; Transparent background, _WinAPI_SetBkMode
					$bHasFocus = ( $sClassNN = ControlGetFocus( $hGui ) )                           ; Has listview focus?
					$iColumns = DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hHeader, "uint", 0x1200, "wparam", 0, "lparam", 0 )[0] ; 0x1200 = $HDM_GETITEMCOUNT, _GUICtrlHeader_GetItemCount
					Return $CDRF_NOTIFYITEMDRAW                    ; Notify the parent window before an item is painted

				; Stage 2
				Case $CDDS_ITEMPREPAINT                          ; Before an item is painted
					$iItemPrev = -1
					$iItem     = DllStructGetData( $tNMLVCUSTOMDRAW, "dwItemSpec" ) ; Item index
					$iSelFocus = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMSTATE, $iItem, $LVIS_FOCUSED+$LVIS_SELECTED ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMSTATE, "wparam", $iItem, "lparam", $LVIS_FOCUSED+$LVIS_SELECTED )[0] ; Selected state

					If Not $iSelFocus Or ( BitAND( $iSelFocus, $LVIS_FOCUSED ) And Not BitAND( $iSelFocus, $LVIS_SELECTED ) ) Then ; Normal item
						If Not BitAND( $fDefaults, 7 ) Then Return $CDRF_NEWFONT ; No custom default colors for normal items => Default drawing
						; Custom drawing of normal item. Drawing of custom default colors/font.
						DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aDefaults[1] )                          ; Custom default back color
						DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText",   $aDefaults[2] )                          ; Custom default fore color
						DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font, _WinAPI_SelectObject
						Return $CDRF_NEWFONT                         ; $CDRF_NEWFONT must be returned after changing font or colors

					ElseIf BitAND( $iSelFocus, $LVIS_FOCUSED ) Then ; Focused item
						If $fNotSelected Then Return $CDRF_NEWFONT   ; Default drawing of focused item
						; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one. Stage 3 and 4.
						If BitAND( $fDefaults, 7 ) Or BitAND( $fDefaults, 24 ) Or BitAND( $fDefaults, 96 ) Then Return $CDRF_NOTIFYSUBITEMDRAW
						Return $CDRF_NEWFONT                         ; Default drawing of focused item

					ElseIf $iSelFocus Then ; Selected item
						If $fNotSelected Then Return $CDRF_NEWFONT   ; Default drawing of selected item
						; Custom drawing of Selected item. Custom default colors for selected item must be drawn in CDDS_ITEMPOSTPAINT stage, stage 5.
						If BitAND( $fDefaults, 25 ) Or BitAND( $fDefaults, 97 ) Then Return $CDRF_NOTIFYPOSTPAINT
						Return $CDRF_NEWFONT                         ; Default drawing of selected item
					EndIf

				; Stage 3
				Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM )  ; Before a subitem is painted
					; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one. Stage 3 and 4.
					Return $CDRF_NOTIFYPOSTPAINT                   ; Notify the parent window after an item is painted

				; Stage 4
				Case BitOR( $CDDS_ITEMPOSTPAINT, $CDDS_SUBITEM ) ; After a subitem has been painted
					; Custom drawing of focused item. To avoid erasing the dotted rectangle each subitem must be drawn one by one.
					$iSubItem = DllStructGetData( $tNMLVCustomDraw, "iSubItem" ) ; Subitem index

					If $iItemPrev <> $iItem Then
						$iItemPrev = $iItem
						; Delete the back color brush
						DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hSubBrush ) ; _WinAPI_DeleteObject
						; $hSubBrush = $bHasFocus ? Selected back color : Unfocused back color ; _WinAPI_CreateSolidBrush
						$hSubBrush = $bHasFocus ? DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[3] : $aDefaults[1] )[0] : DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[5] : $aDefaults[1] )[0]
					EndIf
					; $i = $bHasFocus ? Selected fore color : Unfocused fore color ; _WinAPI_SetTextColor
					$i = $bHasFocus ? DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[4] : $aDefaults[2] ) : DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  BitAND( $iSelFocus, $LVIS_SELECTED ) ? $aDefaults[6] : $aDefaults[2] )
					DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font,  _WinAPI_SelectObject

					; Subitem rectangle
					$iImageWidth = 0
					If $bImages And $iSubItem Then
						; Extract subitem image index from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
						DllStructSetData( $tLVitem, "Item", $iItem )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
						If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
							If $iImgWidth0 Then
								$iImageWidth = $iImgWidth0
							Else
								; Calculate width of subitem image
								DllStructSetData( $tRect, "Top", $iSubItem )
								DllStructSetData( $tRect, "Left", $LVIR_ICON )
								$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
								$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
								$iImageWidth = $iImgWidth0
							EndIf
						EndIf
					EndIf
					DllStructSetData( $tRect, "Top", $iSubItem )
					DllStructSetData( $tRect, "Left", $LVIR_LABEL )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

					; Focused back color
					DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hSubBrush ) ; _WinAPI_FillRect

					; Left margin of subitem text
					DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
					If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

					; Extract subitem text from listview
					DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
					DllStructSetData( $tLVitem, "SubItem", $iSubItem )
					DllStructSetData( $tLVitem, "Text", $pBuffer )
					DllStructSetData( $tLVitem, "TextMax", 4096 )
					$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

					; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
					DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors

				; Stage 5
				Case $CDDS_ITEMPOSTPAINT                         ; After an item has been painted
					; Selected back color, selected fore color, selected text font
					If $bHasFocus Then
						$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aDefaults[3] )[0] ; Selected back color,  _WinAPI_CreateSolidBrush
						DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aDefaults[4] )    ; Selected fore color,  _WinAPI_SetTextColor
					Else ; $fSelected = 2
						$hBrush = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", $aDefaults[5] )[0] ; Unfocused back color, _WinAPI_CreateSolidBrush
						DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int",  $aDefaults[6] )    ; Unfocused fore color, _WinAPI_SetTextColor
					EndIf
					DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $aDefaults[0] ) ; Custom default font,  _WinAPI_SelectObject

					; For each subitem
					For $iSubItem = 0 To $iColumns - 1
						; Subitem rectangle
						$iImageWidth = 0
						If $bImages And $iSubItem Then
							; Extract subitem image index from listview
							DllStructSetData( $tLVitem, "Mask", $LVIF_IMAGE )
							DllStructSetData( $tLVitem, "Item", $iItem )
							DllStructSetData( $tLVitem, "SubItem", $iSubItem )
							$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMW, 0, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMW, "wparam", 0, "lparam", $pLVitem )[0]
							If DllStructGetData( $tLVitem, "Image" ) > -1 Then ; Value of Image field is -1 if no image/icon is specified
								If $iImgWidth0 Then
									$iImageWidth = $iImgWidth0
								Else
									; Calculate width of subitem image
									DllStructSetData( $tRect, "Top", $iSubItem )
									DllStructSetData( $tRect, "Left", $LVIR_ICON )
									$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
									$iImgWidth0 = DllStructGetData( $tRect, "Right" ) - DllStructGetData( $tRect, "Left" ) + 2
									$iImageWidth = $iImgWidth0
								EndIf
							EndIf
						EndIf
						DllStructSetData( $tRect, "Top", $iSubItem )
						DllStructSetData( $tRect, "Left", $LVIR_LABEL )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETSUBITEMRECT, $iItem, $pRect ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETSUBITEMRECT, "wparam", $iItem, "lparam", $pRect )[0]
						DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + $iImageWidth )

						; Selected back color
						DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", $hBrush ) ; _WinAPI_FillRect

						; Left margin of subitem text
						DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + ( $iSubItem ? 6 : 2 ) )
						If $bNotXP Or $bImages Or $bChkboxes Then DllStructSetData( $tRect, "Top", DllStructGetData( $tRect, "Top" ) + 2 )

						; Extract subitem text from listview
						DllStructSetData( $tLVitem, "Mask", $LVIF_TEXT )
						DllStructSetData( $tLVitem, "SubItem", $iSubItem )
						DllStructSetData( $tLVitem, "Text", $pBuffer )
						DllStructSetData( $tLVitem, "TextMax", 4096 )
						$i = $idListView ? GUICtrlSendMsg( $idListView, $LVM_GETITEMTEXTW, $iItem, $pLVitem ) : DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMTEXTW, "wparam", $iItem, "lparam", $pLVitem )[0]

						; Draw subitem text with selected fore color and selected text font (through the device context, $hDC)
						DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", DllStructGetData( $tBuffer, "Text" ), "int", -1, "struct*", $tRect, "uint", $DT_WORD_ELLIPSIS ) ; _WinAPI_DrawText
					Next

					; Delete the back color brush
					DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hBrush ) ; _WinAPI_DeleteObject
					Return $CDRF_NEWFONT                           ; $CDRF_NEWFONT must be returned after changing font or colors
			EndSwitch
		Case $NM_KILLFOCUS
			$bLVHasFocus = False
		Case $NM_SETFOCUS
			If Not $bLVHasFocus Then
				DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_REDRAWITEMS, "wparam", 0, "lparam", DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hListView, "uint", $LVM_GETITEMCOUNT, "wparam", 0, "lparam", 0 )[0] - 1 ) ;_GUICtrlListView_RedrawItems( $hListView, 0, _GUICtrlListView_GetItemCount( $hListView ) - 1 )
				$bLVHasFocus = True
			EndIf
	EndSwitch
	Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	; Call next function in subclass chain (this forwards messages to main GUI)
	#forceref $i
EndFunc

; RGB to BGR or BGR to RGB
Func ListViewColorsFonts_ColorConvert( $iColor )
	Return BitOR( BitAND( $iColor, 0x00FF00 ), BitShift( BitAND( $iColor, 0x0000FF ), -16 ), BitShift( BitAND( $iColor, 0xFF0000 ), 16 ) )
EndFunc

; Remove subclass callback functions
Func ListViewColorsFonts_ExitAllOnExit()
	Local $fColorsFonts
	For $iIndex = 1 To $iListViewColorsFontsInfo - 1
		If $aListViewColorsFontsInfo[$iIndex][1] Then
			$fColorsFonts = $aListViewColorsFontsInfo[$iIndex][14]
			; Remove subclassing from listview parent window
			Select
				Case BitAND( $fColorsFonts, 7 ) ; Colors/fonts for items/subitems
					If $aListViewColorsFontsInfo[$iIndex][15] Then ; Selected items
						_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Selected, $iIndex )
					Else ; Normal items
						_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Normal, $iIndex )
					EndIf

				Case BitAND( $fColorsFonts, 8 ) ; Colors/fonts for entire columns
					_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Columns, $iIndex )

				Case BitAND( $fColorsFonts, 48 ) ; Alternating row/column colors
					Switch BitAND( $fColorsFonts, 48 )
						Case 16 ; Alternating row colors
							_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_AlterRows, $iIndex )
						Case 32 ; Alternating column colors
							_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_AlterCols, $iIndex )
						Case 48 ; Alternating row and column colors
							_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_AlterRowsCols, $iIndex )
					EndSwitch

				Case BitAND( $fColorsFonts, 64 ) ; Custom default colors/font
					_WinAPI_RemoveWindowSubclass( $aListViewColorsFontsInfo[$iIndex][5], $pListViewColorsFontsSC_Defaults, $iIndex )
			EndSelect
		EndIf
	Next
EndFunc
