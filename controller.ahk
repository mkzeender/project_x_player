
; Gui
gui, add, Checkbox, vActivate gToggleActivate, Activate
gui, show, AutoSize, Center

; handler for checkbox event
ToggleActivate() {
	Critical
	; get the value from the checkboxs
	GuiControlGet, Activate,, Activate
	
	;change .activate file 
	FileDelete, %A_ScriptDir%\.activate
	FileAppend, % Activate, %A_ScriptDir%\.activate
	
	; attempt to push the .activate file to github.com for remote activation
	RunWait, git commit --only .activate -m "Activation Updated using Script",,hide
	RunWait, git push,, hide
}

; handler for GuiClose event
GuiClose() {
	ExitApp
}