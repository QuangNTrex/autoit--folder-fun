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
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <File.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 617, 439, 192, 124)
$LabelFrom = GUICtrlCreateLabel("From", 24, 24, 41, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$InputPathFrom = GUICtrlCreateInput("", 96, 24, 361, 29)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$ButtonPathFrom = GUICtrlCreateButton("Choosen", 488, 24, 83, 33)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$LabelTo = GUICtrlCreateLabel("To", 24, 80, 21, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$InputPathTo = GUICtrlCreateInput("", 96, 72, 361, 29)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$ButtonPathTo = GUICtrlCreateButton("Choosen", 488, 72, 83, 33)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$LabelOption = GUICtrlCreateLabel("Option", 24, 136, 52, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$RadioEscape = GUICtrlCreateRadio("Escape", 72, 224, 81, 17)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$RadioFilter = GUICtrlCreateRadio("Filter", 72, 256, 89, 17)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$Edit = GUICtrlCreateEdit("", 176, 192, 393, 129)
GUICtrlSetData(-1, "")
$LabelProcess = GUICtrlCreateLabel("Process: 0%. 0/0", 1, 329, 609, 25, $SS_CENTER)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$ButtonStart = GUICtrlCreateButton("Start", 256, 384, 83, 33)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
$RadioNone = GUICtrlCreateRadio("None", 72, 192, 89, 17)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; Retrieve the handle of the active window.
;Local $hWnd = WinGetHandle("[ACTIVE]")
;WinSetOnTop($hWnd, "", 1)

; defalut
GUICtrlSetState($LabelProcess, 32)
GUICtrlSetState($RadioNone, 1);
GUICtrlSetState($Edit, $GUI_DISABLE)

;variable
Global $pastRadio = 0
Global $ValueEdit[4]
Global $pathFrom = ""
Global $pathTo = ""
Global $total = 0
Global $isSuccess = 0;

Global $arrFileError[0]

Func FormatPath ($path)
	return StringReplace($path, "//", "/");
EndFunc

Func GetPathFrom ()
	$path = StringReplace(FileSelectFolder("Select a folder", ""), "\", "/")
	GUICtrlSetData($InputPathFrom, $path)
EndFunc

Func GetPathTo ()
	$path = StringReplace(FileSelectFolder("Select a folder", ""), "\", "/")
	GUICtrlSetData($InputPathTo, $path)
EndFunc

Func SettingRadio ($value)
	If $value <> $pastRadio Then
		; save past edit
		$ValueEdit[$pastRadio] = GUICtrlRead($Edit)
		; add present edit
		GUICtrlSetData($Edit, $ValueEdit[$value])
		$pastRadio = $value;
	EndIf

	If $value == 0 Then
		GUICtrlSetState($Edit, $GUI_DISABLE)
	Else
		GUICtrlSetState($Edit, $GUI_ENABLE)
	EndIf
EndFunc

Func FindFileAndSave($path, $relatePath)


	GUICtrlSetState($LabelProcess, 16);

	Switch $pastRadio
        Case 0
            Local $arrayPathFolder = _FileListToArray($path, "*", $FLTA_FOLDERS)
			If @error <> 1 Then
				For $i = 1 To UBound($arrayPathFolder) - 1 Step 1
					DirCreate ($pathTo & "/" & $relatePath & "/" & $arrayPathFolder[$i])
					FindFileAndSave($path & "/" & $arrayPathFolder[$i] & "/", $relatePath & "/" & $arrayPathFolder[$i] & "/")
				Next
			EndIf

			Local $arrayPathFile = _FileListToArray($path, "*", $FLTA_FILES)
			If @error <> 4 Then
				For $i = 1 To $arrayPathFile[0] Step 1
					; is file
					$state = FileCopy(FormatPath($path & "/" & $arrayPathFile[$i]), FormatPath($pathTo & "/" & $relatePath & "/" & $arrayPathFile[$i]), $FC_CREATEPATH)
					$total += 1
					$isSuccess += $state
					GUICtrlSetData($LabelProcess, "Process: " & $isSuccess & "/" & $total)
					GUICtrlSetData($Edit, FormatPath("/" & $relatePath & "/" & $arrayPathFile[$i]))
					If Not $state Then
						;MsgBox(0, 0, FormatPath($path & "/" & $arrayPathFile[$i]) & " To:" & FormatPath($pathTo & "/" & $relatePath & "/" & $arrayPathFile[$i]))
						_ArrayAdd($arrFileError, FormatPath("/" & $relatePath & "/" & $arrayPathFile[$i]) & "	 To:" & FormatPath("/" & $relatePath & "/" & $arrayPathFile[$i]))
					EndIf
				Next
			EndIf
        Case 1
                Local $arrayPathFolder = _FileListToArray($path, "*", $FLTA_FOLDERS)
			If @error <> 1 Then
				For $i = 1 To UBound($arrayPathFolder) - 1 Step 1
					If Not StringInStr($ValueEdit[1], $arrayPathFolder[$i]) Then
						DirCreate ($pathTo & "/" & $relatePath & "/" & $arrayPathFolder[$i])
						FindFileAndSave($path & "/" & $arrayPathFolder[$i] & "/", $relatePath & "/" & $arrayPathFolder[$i] & "/")
					EndIf
				Next
			EndIf

			Local $arrayPathFile = _FileListToArray($path, "*", $FLTA_FILES)
			If @error <> 4 Then
				For $i = 1 To $arrayPathFile[0] Step 1
					; is file
					If Not StringInStr($ValueEdit[1], $arrayPathFile[$i]) Then
						$state = FileCopy(FormatPath($path & "/" & $arrayPathFile[$i]), FormatPath($pathTo & "/" & $relatePath & "/" & $arrayPathFile[$i]), $FC_CREATEPATH)
						$total += 1
						$isSuccess += $state
						GUICtrlSetData($LabelProcess, "Process: " & $isSuccess & "/" & $total)
						GUICtrlSetData($Edit, FormatPath("/" & $relatePath & "/" & $arrayPathFile[$i]))
						If Not $state Then
							;MsgBox(0, 0, FormatPath($path & "/" & $arrayPathFile[$i]) & " To:" & FormatPath($pathTo & "/" & $relatePath & "/" & $arrayPathFile[$i]))
							_ArrayAdd($arrFileError, FormatPath("/" & $relatePath & "/" & $arrayPathFile[$i]) & "	 To:" & FormatPath("/" & $relatePath & "/" & $arrayPathFile[$i]))
						EndIf
					EndIf
				Next
			EndIf
	EndSwitch



EndFunc

Func startProcess ()
	$pathFrom = GUICtrlRead($InputPathFrom);
	$pathto = GUICtrlRead($InputPathto);
	If Not ($pathFrom And $pathTo) Then
		MsgBox(0, 0, "Input Path is Invalid!")
		Return
	EndIf
	$isSuccess = 0;
	$total = 0;
	$ValueEdit[$pastRadio] = GUICtrlRead($Edit)
	FindFileAndSave($pathFrom, "");
	_ArrayDisplay($arrFileError)
	GUICtrlSetData($Edit, _ArrayToString($arrFileError, @CRLF))
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ButtonPathFrom
			GetPathFrom()
		Case $ButtonPathTo
			GetPathTo()
		Case $RadioNone
			SettingRadio(0)
		Case $RadioEscape
			SettingRadio(1)
		Case $RadioFilter
			SettingRadio(2)
		Case $ButtonStart
			startProcess()
	EndSwitch
WEnd


