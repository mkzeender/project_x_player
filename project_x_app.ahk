


TITLE := "Dwight Whitaker"
TEXT_ := "URGENT: [Classified Message]"
HTML_FILE := "home.html"




OnMessage(0x404, Func("AHK_NOTIFYICON"))

gui, GUITransition:new,	-caption +alwaysontop -sysmenu
gui, color, 0, 0

global Activate := False
global waiting := False

Loop
{
	RunWait, git pull,,hide
	FileRead, Activate, %A_ScriptDir%\.activate
	If Activate and not waiting {
		waiting := True
		show_tray_tip()
	}
	Sleep, 200
	Send, {F13}
}


AHK_NOTIFYICON(wParam, lParam, msg, hwnd) {
	global waiting
	if (hwnd != A_ScriptHwnd)
		return
	if (lParam = 1029) ; NIN_BALLOONUSERCLICK
		on_click()
	if (lParam = 1028) ; NIN_BALLOONTIMEOUT
		waiting := False
}



show_tray_tip() {
	static messages := 1
	global TITLE, TEXT_
	TrayTip, % TITLE . " (" . messages . ")", % TEXT_, 30
	messages ++
}



on_click() {
	Gui, GUITransition:default
	Gui, +LastFound
	WinSet, Transparent, 0
	Gui, show, NA x0 y0 H%A_ScreenHeight% W%A_ScreenWidth%
	GUIFadeTransition(0, 255, "GUITransition", 5.4, True)
	StartChrome()
	
	Y := A_ScreenHeight - 50
	X := A_ScreenWidth - 50
	
	CoordMode, Mouse, Screen
	Sleep, 100
	Click, %X% %Y%
	Sleep, 100
	;Click, %X% %Y%
	ExitApp
}











ShowChrome() {
	sleep,2000
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
	winwait, ahk_class Chrome_WidgetWin_1
	winwait, ahk_class Chrome_WidgetWin_1,, 2
	ShowChrome()
	WinActivate, ahk_class Chrome_WidgetWin_1
	sleep,200

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
