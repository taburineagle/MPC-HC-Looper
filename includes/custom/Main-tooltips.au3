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
		GUICtrlSetTip($loopButton, "Click*** on this to change between looping modes - " & @CRLF & @CRLF & "'Loop Mode' - will loop the current IN and OUT points as a loop" & @CRLF & "'Playlist Mode' (if you have events in the Event Playlist) - loop through the playlist, one item at a time" & @CRLF & "'OFF' - MPC-HC acts like the Looper program isn't running, but you can still make IN and OUT" & @CRLF & "points and add them to the playlist, which is useful for EDL-like lists of IN and OUT points" & @CRLF & "'Shuffle Mode'*** - If you click this button with both the left and right mouse buttons, you can load Shuffle Mode," & @CRLF & "which acts similar to Playlist Mode, but randomizes the order in which the events play." & @CRLF & @CRLF & "You can also jump right to one of the modes directly by using keyboard shortcuts -" & @CRLF & " CTRL-1 - Jump to the OFF mode directly" & @CRLF & " CTRL-2 - Jump to Loop Mode directly" & @CRLF & " CTRL-3 - Jump to Playlist Mode directly" & @CRLF & " CTRL-4 - Jump to Shuffle Mode directly")

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