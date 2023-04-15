#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here



#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#Region ### START Koda GUI section ### Form=
$FormMain = GUICreate("FormMain", 561, 362, 227, 160)
$InputPathFolder = GUICtrlCreateInput("", 152, 48, 249, 29)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$LabelPathFolder = GUICtrlCreateLabel("Path Folder", 32, 48, 100, 29)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$ButtonChoosen = GUICtrlCreateButton("Choose..", 433, 48, 95, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$LabelFindText = GUICtrlCreateLabel("Find Text", 32, 112, 80, 29)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$InputFindText = GUICtrlCreateInput("", 152, 104, 249, 29)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$ButtonFilter = GUICtrlCreateButton("Fiter", 432, 104, 99, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$Edit = GUICtrlCreateEdit("", 104, 184, 353, 89)
$ButtonStart = GUICtrlCreateButton("Erases", 224, 304, 91, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$stateFilter = 0;
Global $ArrPathErase[0];

Local $aPos = WinGetPos("[ACTIVE]");

GUICtrlSetState($ButtonStart, 32);
GUICtrlSetState($Edit, 32);
WinMove($FormMain, "111", $aPos[0], $aPos[1], $aPos[2], $aPos[3] - 100);
Func ShowGroup1()
	If Not $stateFilter Then
		$stateFilter = 1;
		Local $aPos = WinGetPos("[ACTIVE]");

		GUICtrlSetState($ButtonStart, 16);
		GUICtrlSetState($Edit, 16);
		WinMove($FormMain, "111", $aPos[0], $aPos[1], $aPos[2], $aPos[3] + 100);
	EndIf
EndFunc

Func FindPathContain()
	Local $text = '';
	Local $str = GUICtrlRead($InputFindText);
	Local $FilesPath = _FileListToArray(GUICtrlRead($InputPathFolder), "*");
	ReDim $ArrPathErase[0];

	For $i = 1 To $FilesPath[0] Step 1
		If StringInStr($FilesPath[$i], $str) Then
			$text &= (@CRLF & $FilesPath[$i]);
			ReDim $ArrPathErase[UBound($ArrPathErase) + 1];
			$ArrPathErase[UBound($ArrPathErase) - 1] = $FilesPath[$i];
		EndIf
	Next

	GUICtrlSetData($Edit, $text);
EndFunc

Func EraseFiles()
	For $i = 0 To UBound($ArrPathErase) - 1 Step 1
		FileRecycle(GUICtrlRead($InputPathFolder) & '\' & $ArrPathErase[$i]);
	Next
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ButtonFilter
			ShowGroup1();
			FindPathContain();
		Case $ButtonStart
			EraseFiles();
			MsgBox(0, 0, "success!");
		Case $ButtonChoosen
			$path = FileSelectFolder("Open", "");
			GUICtrlSetData($InputPathFolder, $path);
	EndSwitch
WEnd
