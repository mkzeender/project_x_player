
TITLE := "wow"
TEXT_ := "damn"

show_tray_tip() {
	global TITLE, TEXT_
	TrayTip, % TITLE, % TEXT_, 30
}
show_tray_tip()
