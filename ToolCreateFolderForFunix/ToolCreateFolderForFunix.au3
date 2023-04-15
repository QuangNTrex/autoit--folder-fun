#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 507, 235, 208, 127)
$InputPath = GUICtrlCreateInput("E:\Project\NodeJS\Lab", 104, 24, 249, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$LabelPath = GUICtrlCreateLabel("Path", 32, 24, 42, 29)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$ButtonSelectPath = GUICtrlCreateButton("select...", 392, 24, 83, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$LabelNum = GUICtrlCreateLabel("Num", 32, 120, 45, 29)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$InputNum = GUICtrlCreateInput("", 104, 120, 57, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$Label = GUICtrlCreateLabel("Nums", 256, 120, 53, 29)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$InputNums = GUICtrlCreateInput("", 328, 120, 57, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
$ButtonStart = GUICtrlCreateButton("Start", 200, 176, 83, 33)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func Checked()
    Return (GUICtrlRead($LabelNum) And GUICtrlRead($LabelNum) And GUICtrlRead($LabelNum) );
EndFunc

Func CreateFolder()
	$numFolder = GUICtrlRead($InputNum);
	$cntFolder = GUICtrlRead($inputNums);
	$path = GUICtrlRead($InputPath);
	$name = "Lab " & $numFolder;
	DirCreate ($path & '\' & $name );
	For $i = 1 To $cntFolder Step 1
		DirCreate ($path & '\' & $name & '\' & $name & "." & $i );
	Next
	$Path = $path & '\' & $name
	Run("C:\WINDOWS\EXPLORER.EXE /n,/e," & $Path)
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ButtonSelectPath
			$pathFolder = FileSelectFolder('Open', 'E:\');
			GUICtrlSetData($InputPath, $pathFolder);
		Case $ButtonStart
			If Checked() Then
				CreateFolder();
				Exit
			Else
				MsgBox(0, 0, "Error");
			EndIf
	EndSwitch
WEnd
