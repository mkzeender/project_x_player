
gui, add, Checkbox, vActivate gToggleActivate, Activate


ToggleActivate(a, b, c, d) {
	global Activate
	FileDelete, %A_ScriptDir%\.activate
	FileAppend, % Activate, %A_ScriptDir%\.activate
	RunWait, git add .activate,,hide
	RunWait, git commit --only .activate -m "Activation Updated using Script",,hide
	RunWait, git push,, hide
}