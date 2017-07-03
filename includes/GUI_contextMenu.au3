#include <GuiMenu.au3>

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUIRegisterMsg($WM_CONTEXTMENU, "WM_CONTEXTMENU")

Global $contextMenu_combineEvents = 0

; Handle WM_CONTEXTMENU messages
Func WM_CONTEXTMENU($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam

	$currentlySelected = _GUICtrlListView_GetSelectedIndices($eventList, 1)

	If $wParam = ControlGetHandle($mainWindow, "", $eventList) And $currentlySelected[0] <> 0 Then
		Local $contextMenu

		$contextMenu = _GUICtrlMenu_CreatePopup()
		_GUICtrlMenu_AddMenuItem($contextMenu, "Combine these events", $contextMenu_combineEvents)

		_GUICtrlMenu_TrackPopupMenu($contextMenu, $mainWindow)
		_GUICtrlMenu_DestroyMenu($contextMenu)
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

				MsgBox(0, "Combine events?", "Are you sure you want to combine these " & $currentlySelected[0] & " events into one event?" & @CRLF & @CRLF & _
				"New Name: " & $newName & @CRLF & _
				"New IN Point: " & $newINPoint & @CRLF & _
				"New OUT Point: " & $newOUTPoint & @CRLF & _
				"New Duration: " & $newDur)

				_GUICtrlListView_SetItemSelected($eventList, -1, false, false) ; for Dragging and Dropping items

				For $i = 1 to UBound($currentlySelected) - 1
					_GUICtrlListView_SetItemSelected($eventList, $currentlySelected[$i], True, True) ; for Dragging and Dropping items
				Next

				_GUIListViewEx_Delete()
				_GUIListViewEx_Insert($currentlySelected[1] + 1 & "|" & $newName & "|" & $newINPoint & "|" & $newOUTPoint & "|" & $newDur & "|" & $currentFile)
			EndIf
	EndSwitch
EndFunc