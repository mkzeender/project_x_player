
gui, add, Checkbox, vActivate gToggleActivate, Activate
gui, show, AutoSize, Center

ToggleActivate(a := "", b := "", c := "", d := "") {
	Critical
	GuiControlGet, Activate,, Activate
	FileDelete, %A_ScriptDir%\.activate
	FileAppend, % Activate, %A_ScriptDir%\.activate
	RunWait, git commit --only .activate -m "Activation Updated using Script",,hide
	RunWait, git push,, hide
	Critical, Off
}

GuiClose() {
	ExitApp
}