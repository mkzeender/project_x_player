
gui, add, Checkbox, vActivate gToggleActivate, Activate


ToggleActivate(a, b, c, d) {
	global Activate
	FileDelete, %A_ScriptDir%\.activate
	FileAppend, % Activate, %A_ScriptDir%\.activate
}