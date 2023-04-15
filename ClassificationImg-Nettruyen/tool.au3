#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add #include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 616, 92, 192, 124)
$LabelPath = GUICtrlCreateLabel("Path", 24, 16, 35, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$InputPath = GUICtrlCreateInput("", 80, 16, 385, 29)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$ButtonStart = GUICtrlCreateButton("Start", 504, 16, 75, 33)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$LabelProcess = GUICtrlCreateLabel("", 0, 56, 611, 25, $SS_CENTER)
GUICtrlSetState($LabelProcess, 32)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Local Const $sFilePathPath = @ScriptDir & "/path.txt"
If Not FileOpen($sFilePathPath) Then
	_FileCreate($sFilePathPath);
EndIf

$hFileOpen = FileOpen($sFilePathPath)
Local $sFileReadPathPath = FileRead($hFileOpen)
GUICtrlSetData($InputPath, $sFileReadPathPath);
FileClose($hFileOpen)
;day-hu-do-de-phan-dien-roi-phai-lam-sao-day_1_1.jpg

Func StartProcess ()
	;show process
	GUICtrlSetState($LabelProcess, 16)
	$path = StringReplace( GUICtrlRead($InputPath), "\", "/");
	$arrayPath = _FileListToArray($path, "*", 1)


	For $i = 1 To UBound($arrayPath) - 1 Step 1
		$data = StringSplit( StringSplit($arrayPath[$i], ".")[1], "_");

		DirCreate($path & "/" & $data[1])
		DirCreate($path & "/" & $data[1] & "/chapter " & $data[2])
		FileMove($path & "/" & $arrayPath[$i], $path & "/" & $data[1] & "/chapter " & $data[2])
		GUICtrlSetData($LabelProcess, "Status " & $i & "/" & $arrayPath[0])
	Next
	GUICtrlSetData($LabelProcess, "Status " & $arrayPath[0] & "/" & $arrayPath[0] & ", Done!")
	FileWrite($sFilePathPath, "")
	FileWrite($sFilePathPath, $path)
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ButtonStart
			StartProcess()
	EndSwitch
WEnd
