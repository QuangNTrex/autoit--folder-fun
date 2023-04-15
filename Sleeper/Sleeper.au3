;---------------------------------------------------------
;| Code By T-rex                                         |
;|                                                       |
;|                                                       |
;|  This tool is used to simplify some operations        |
;|	such as shutdown, restart, ... on windows            |
;|                                                       |
;|                                                       |
;|                                                       |
;|                                                       |
;|                                                       |
;|  Thanks for Thanks for visiting!!!                    |
;|                                                       |
;---------------------------------------------------------


#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
$FormMain = GUICreate("Sleeper", 281, 233, -1, -1)
GUISetFont(12, 400, 0, "Segoe UI")
$LabelAction = GUICtrlCreateLabel("Action", 24, 24, 48, 25)
$ComboAction = GUICtrlCreateCombo("", 96, 24, 145, 25, BitOR($GUI_SS_DEFAULT_COMBO,$CBS_SIMPLE))
GUICtrlSetData(-1, "Shutdown|Restart|Sleep|Hibernate|Lock")
$CheckboxForce = GUICtrlCreateCheckbox("Force Action", 96, 136, 129, 17)
$LabelTimeOut = GUICtrlCreateLabel("time-out", 24, 80, 64, 25, $SS_CENTERIMAGE)
$InputTimeOut = GUICtrlCreateInput("0", 96, 80, 65, 29, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$LabelMinutes = GUICtrlCreateLabel("Minutes", 184, 80, 60, 33)
$ButtonStart = GUICtrlCreateButton("Start", 56, 184, 75, 25)
$ButtonAbort = GUICtrlCreateButton("Abort", 160, 184, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $time = 0;

Func runWithTime ($req)
	;GUICtrlSetState($ButtonAbort, $GUI_DISABLE);
	Sleep(5 * 1000);
	Run($req, '', @SW_HIDE);
	;GUICtrlSetState($ButtonAbort, $GUI_ENABLE);
EndFunc


Func start()
	$action = GUICtrlRead($ComboAction);
	$time = GUICtrlRead($InputTimeOut);
	$continue = True;

	If $time = '' Then
		$time = 0;
    EndIf

	If $action = '' Then
		$action = "Shutdown"
    EndIf

	Switch $action
		Case "Shutdown"
			Run('shutdown -s ' & (GUICtrlRead($CheckboxForce) = $GUI_CHECKED ? '-f ' : '') & '-t ' & ($time * 60), '', @SW_HIDE);
		Case "Restart"
			Run('shutdown -r ' & (GUICtrlRead($CheckboxForce) = $GUI_CHECKED ? '-f ' : '') & '-t ' & ($time * 60), '', @SW_HIDE);
		Case "Sleep"
			runWithTime('rundll32.exe powrprof.dll,SetSuspendState 0,1,0');
		Case "Hibernate"
			runWithTime('rundll32.exe powrprof.dll,SetSuspendState');
		Case "Lock"
			runWithTime('Rundll32.exe user32.dll,LockWorkStation');
	EndSwitch
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ButtonStart
			start();
		Case $ButtonAbort
			Run('shutdown -a', '', @SW_HIDE);
		Case $ComboAction
			If (GUICtrlRead($ComboAction) = "Lock" Or GUICtrlRead($ComboAction) = "Hibernate" Or GUICtrlRead($ComboAction) = "Sleep") Then
				GUICtrlSetState($ButtonAbort, $GUI_DISABLE);
				GUICtrlSetState($CheckboxForce, $GUI_DISABLE);
			Else
				GUICtrlSetState($ButtonAbort, $GUI_ENABLE);
				GUICtrlSetState($CheckboxForce, $GUI_ENABLE);
			EndIf
	EndSwitch
WEnd
