#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("Filter", 466, 416, 372, 78)
$LabelFrom = GUICtrlCreateLabel("From", 16, 16, 41, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$LabelTo = GUICtrlCreateLabel("To", 16, 56, 21, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$InputFrom = GUICtrlCreateInput("", 88, 16, 233, 29)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$InputTo = GUICtrlCreateInput("", 88, 56, 233, 29)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$ButtonChooseFrom = GUICtrlCreateButton("Choosen...", 344, 16, 91, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$ButtonChooseTo = GUICtrlCreateButton("Choosen...", 344, 56, 91, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")

$GroupOption = GUICtrlCreateGroup("", 0, 120, 465, 177)
$LabelOption = GUICtrlCreateLabel("Option", 16, 136, 52, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$CheckboxEscape = GUICtrlCreateCheckbox("Escape", 40, 184, 97, 17)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$EditText = GUICtrlCreateEdit("", 160, 184, 265, 89)
$Checkbox2 = GUICtrlCreateCheckbox("Allow", 40, 224, 97, 17)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ButtonStart = GUICtrlCreateButton("Start", 184, 367, 91, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")

$GroupCmd = GUICtrlCreateGroup("", 0, 128, 465, 233)
$EditCmdFrom = GUICtrlCreateEdit("", 24, 176, 201, 121)
$EditCmdTo = GUICtrlCreateEdit("", 240, 176, 201, 121)
$Label1 = GUICtrlCreateLabel("From", 24, 144, 41, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$Label2 = GUICtrlCreateLabel("To", 240, 144, 21, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$LabelProcess = GUICtrlCreateLabel("Process: 0%. 0/0", 8, 320, 449, 25, $SS_CENTER)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func setStateElementGroup ($value)
	GUICtrlSetState($EditCmdFrom, $value)
	GUICtrlSetState($EditCmdTo, $value)
	GUICtrlSetState($Label1, $value)
	GUICtrlSetState($LabelProcess, $value)

	GUICtrlSetState($LabelOption, 32 + 16 - $value)
	GUICtrlSetState($CheckboxEscape, 32 + 16 - $value)
	GUICtrlSetState($EditText, 32 + 16 - $value)
	GUICtrlSetState($Checkbox2, 32 + 16 - $value)
	GUICtrlSetState($ButtonStart, 32 + 16 - $value)

	GUICtrlSetState($GroupCmd, 32)
	GUICtrlSetState($GroupOption, 32)
EndFunc


setStateElementGroup(32); 32 is show option

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd
