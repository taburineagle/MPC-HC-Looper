#include <GuiMenu.au3>

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUIRegisterMsg($WM_CONTEXTMENU, "WM_CONTEXTMENU")

Global $contextMenu_combineEvents = 0

; Handle WM_CONTEXTMENU messages
Func WM_CONTEXTMENU($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam

	$currentlySelected = _GUICtrlListView_GetSelectedIndices($eventList, 1)

	If $wParam = ControlGetHandle($mainWindow, "", $eventList) And $currentlySelected[0] > 1 Then
		If $currentlySearching = 0 Then
			Local $contextMenu

			$contextMenu = _GUICtrlMenu_CreatePopup()
			_GUICtrlMenu_AddMenuItem($contextMenu, "Combine these events", $contextMenu_combineEvents)

			_GUICtrlMenu_TrackPopupMenu($contextMenu, $mainWindow) ; show the popup menu
			_GUICtrlMenu_DestroyMenu($contextMenu) ; destroy the popup menu
		Else
			MsgBox(48, "In Search Mode!", "You can't combine multiple events when you're in search mode." & @CRLF & "Clear the search bar and try again.");
		EndIf
	EndIf

	Return True
EndFunc

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam

    Switch $wParam
		Case $contextMenu_combineEvents
			$currentlySelected = _GUICtrlListView_GetSelectedIndices($eventList, 1)

			If $currentlySelected[0] <> 0 Then
				$newName = "[Events " & _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 0) & "-" & _GUICtrlListView_GetItemText($eventList, $currentlySelected[UBound($currentlySelected) - 1], 0) &"]"
				$newINPoint =  _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 2)
				$newOUTPoint = _GUICtrlListView_GetItemText($eventList, $currentlySelected[UBound($currentlySelected) - 1], 3)
				$newDur = NumberToTimeString(getEventDur($newINPoint, $newOUTPoint))
				$currentFile = _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 5)

				$combineEvents = MsgBox(4, "Combine events?", "Are you sure you want to combine these " & $currentlySelected[0] & " events into one event?" & @CRLF & @CRLF & _
				"New Name: " & $newName & @CRLF & @CRLF & _
				"New IN Point: " & $newINPoint & @CRLF & _
				"New OUT Point: " & $newOUTPoint & @CRLF & @CRLF & _
				"New Duration: " & $newDur)

				If $combineEvents = 6 Then ; you clicked on "Yes" to combining files
					;          The current event's ID  The event's proper order in the event list (the leftmost column)    Name      IN Point     Out Point     Filename      Event to start delete  Event to stop delete (the last item of the array)
					modifyEvent($currentlySelected[1], _GUICtrlListView_GetItemText($eventList, $currentlySelected[1], 0), $newName, $newINPoint, $newOUTPoint, $currentFile, $currentlySelected[1], $currentlySelected[UBound($currentlySelected) -1])
				EndIf
			EndIf
	EndSwitch
EndFunc