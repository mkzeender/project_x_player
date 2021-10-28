

; notification constants
TITLE = Dwight Whitaker
TEXT_ = URGENT MESSAGE

HTML_FILE = home.html



; register notification event handler
OnMessage(0x404, Func("AHK_NOTIFYICON"))

; a fullscreen gui for the fade transition
gui, GUITransition:new,	-caption +alwaysontop -sysmenu
gui, color, 0, 0


; variables
global Activate := False
global waiting := False

; main loop
Loop
{
	; check for changes in activation from the internet
	RunWait, git pull,,hide
	FileRead, Activate, %A_ScriptDir%\.activate
	
	
	If Activate and not waiting {
		waiting := True
		show_notification()
	}
	Sleep, 200
	
	; simulate the F13 keypress to keep the computer awake
	Send, {F13}
}





show_notification() {
	static messages := 1
	global TITLE, TEXT_
	TrayTip, % TITLE . " (" . messages . ")", % TEXT_, 30
	messages ++
}


; notification click
on_click() {
	; fade screen to black
	Gui, GUITransition:default
	Gui, +LastFound
	WinSet, Transparent, 0
	Gui, show, NA x0 y0 H%A_ScreenHeight% W%A_ScreenWidth%
	GUIFadeTransition(0, 255, "GUITransition", 5.4, True)
	
	;open google chrome fullscreen
	StartChrome()
	Sleep, 1000
	
	;Send a keypress to the video to cause it to play
	ControlSend, , {Space}, ahk_class Chrome_WidgetWin_1
	ShowChrome()
	
	;last resort keypress to cause it to play
	ControlSend, , {Space}, ahk_class Chrome_WidgetWin_1
	
	ExitApp
}

on_missed_notification() {
	waiting := False
	
}











ShowChrome() {
	Gui, GUITransition:default
	Gui, +LastFound
	WinSet, Transparent, 255
	Gui, show, NA x0 y0 H%A_ScreenHeight% W%A_ScreenWidth%
	GUIFadeTransition(255, 0, "GUITransition", 5.4, True)
	WinHide
}


StartChrome() {
	global HTML_FILE
	Gui, GUITransition:default
	Gui, show, NA x0 y0 H%A_ScreenHeight% W%A_ScreenWidth%
	
	IfWinExist, ahk_class Chrome_WidgetWin_1
	{
		winclose, ahk_class Chrome_WidgetWin_1
		winwaitclose, ahk_class Chrome_WidgetWin_1
		sleep, 1000
	}
	
	run,chrome.exe --kiosk "%A_ScriptDir%\%HTML_FILE%"
	winwait, ahk_class Chrome_WidgetWin_1,, 2
	Sleep, 200
}

GUIFadeTransition(InitialTrans, FinalTrans, WinTitle := "", dt := 2.2, IsGUI := 0)
{	
	if IsGUI
	{
	Gui, %WinTitle%:default
	Gui, +LastFound
	}
	Else if not WinExist(WinTitle)
	{
	return, 1
	}
		
	TransiTranspA := InitialTrans
	TransiTranspB := Round(TransiTranspA)
	if (InitialTrans == FinalTrans)
	{
		return, 1
	}
	else if (InitialTrans > FinalTrans)
	{
		loop,
		{
			WinSet, Transparent, %TransiTranspB%
			TransiTranspA := TransiTranspA - dt
			TransiTranspB := Round(TransiTranspA)
			sleep, 5
		} until, (TransiTranspA < FinalTrans)
	}
	else
	{
		loop,
		{
			WinSet, Transparent, %TransiTranspB%
			TransiTranspA := TransiTranspA + dt
			TransiTranspB := Round(TransiTranspA)
			sleep, 5
		} until, (TransiTranspA > FinalTrans)
	}
	WinSet, Transparent, %FinalTrans%
	return
}






; runs when the user interacts with the notification
AHK_NOTIFYICON(wParam, lParam, msg, hwnd) {
	global waiting
	if (hwnd != A_ScriptHwnd)
		return
	if (lParam = 1029) ; NIN_BALLOONUSERCLICK
		on_click()
	if (lParam = 1028) ; NIN_BALLOONTIMEOUT
		on_missed_notification()
}

