; Sets the font styles for the main buttons
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

; Speed Slider font customizations
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

; Special speed slider initializations
GUICtrlSetLimit($speedSlider, 200, 10)
GUICtrlSetData($speedSlider, 100)

; Search area fonts
GUICtrlSetFont($searchEventTF, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($searchEventButton, 9, 400, 0, "Segoe UI")
GUICtrlSetFont($searchClearButton, 9, 400, 0, "Segoe UI")

; Special Search area initializations
GUICtrlSetState($searchEventButton, $GUI_DEFBUTTON)
GUICtrlSetState($searchClearButton, $GUI_DISABLE)

; Event list fonts
GUICtrlSetFont($eventList, 9, 400, 0, "Segoe UI")

; Special Event list parameters
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 0, 27) ; # column
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 1, 180) ; Event column
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 2, 72) ; In Point column
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 3, 72) ; Out Point column
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 4, 72) ; Duration column
GUICtrlSendMsg($eventList, $LVM_SETCOLUMNWIDTH, 5, 600) ; Filename column

; Bottom Window Fonts
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

; Sets the button colors for the main buttons
GUICtrlSetBkColor($dockRightButton, 0xffffff) ; Sets background color of "Docking Off" button to grey-ish
GUICtrlSetBkColor($dockLeftButton, 0xffffff) ; Sets background color of "Docking Off" button to grey-ish

GUICtrlSetBkColor($OSDButton, 0xbfd1db) ; Sets background color of "OSD Off" button to grey-ish
GUICtrlSetBkColor($onTopButton, 0xb7baf3) ; Sets background color of "Always on Top" button to blue-ish

; Other color options
GUICtrlSetBkColor($topVertLin, 0x3399FF) ; sets the top vertical line to blue
GUICtrlSetBkColor($vertLine, 0x3399FF) ; sets the bottom vertical line to blue

; Extra button settings
GUICtrlSetState($listSaveButton, $GUI_DISABLE) ; Disables Save button when starting the program
GUICtrlSetState($listDeleteButton, $GUI_DISABLE) ; Disables the Delete button when starting the program
GUICtrlSetState($listModifyButton, $GUI_DISABLE) ; Disables the Modify button when starting the program
GUICtrlSetState($listClearButton, $GUI_DISABLE) ; Disables the Modify button when starting the program
GUICtrlSetState($nextEventButton, $GUI_DISABLE) ; Disables the Modify button when starting the program
GUICtrlSetState($previousEventButton, $GUI_DISABLE) ; Disables the Modify button when starting the program

; Mouse pointer settings (for the clickable URL)
GUICtrlSetCursor($progInfo, 0) ; set the URL info mouse cursor to the clickable hand when you mouse over it
