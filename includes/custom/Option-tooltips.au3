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

GUICtrlSetTip($dontForceLooperModeonOpen, "If you enable this checkbox, loading new files will not switch" & @CRLF & "Looper back to Loop Mode once they open." & @CRLF & @CRLF & "For example, if you switch to Playlist mode and open" & @CRLF & "another .looper file, that file will also then open in Playlist mode.")
GUICtrlSetTip($disableToolTips, "If you enable this checkbox, tool tips will not display on" & @CRLF & "the main Looper panel when you hover over different things - " & @CRLF & "tool tips will always display in the Options panel")
GUICtrlSetTip($autoloadCheck, "If you enable this checkbox, the last open .looper file" & @CRLF & "when you quit out of Looper will load automatically" & @CRLF & "when you start a new session")
GUICtrlSetTip($allowMICheck, "If you enable this checkbox, you can run multiple" & @CRLF & "instances of Looper if MPC-HC allows multiple" & @CRLF & "instances of itself")
GUICtrlSetTip($MI_desc_2, "If you enable this checkbox, you can run multiple" & @CRLF & "instances of Looper if MPC-HC allows multiple" & @CRLF & "instances of itself")
GUICtrlSetTip($autoPlayDialogsCheck, "If you enable this checkbox, Looper will not" & @CRLF & "automatically start playing when exiting out" & @CRLF & "of Looper dialogs")
GUICtrlSetTip($autoPlayCheck, "If you enable this checkbox, Looper will not" & @CRLF & "automatically start playing the first event" & @CRLF & "when opening a new .looper file")
GUICtrlSetTip($askConfCheck, "If you enable this checkbox, Looper disables the" & @CRLF & "confirmation to re-open MPC-HC if it closes during a Looper session")

GUICtrlSetTip($looperAssociateButton, "Associate .looper files with Windows Explorer, so" & @CRLF & "double-clicking on a .looper file will open it" & @CRLF & "in MPC-HC Looper")