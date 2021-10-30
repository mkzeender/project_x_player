# Project X Video Player

Setup:
------

1. Only works on Windows.
2. Install Git and Google Chrome in order for this to work.
3. Both git.exe and chrome.exe have to be available via the command line. Change the "path" environment variable to accomplish this if needed.
4. "Fork" this repository to your own github account.
5. On the remote control computer, run "controller.exe." On first use, it may prompt you to sign in to github.
6. On the main computer, run "project_x_app.exe"
7. Make sure to test before use!!!


Instructions:
-------------

1. Check the "activate" checkbox on the remote control computer, or press X on the main computer to show a notification.
2. It may take 10 seconds to send the signal over the internet
3. Click on the notification to play video.mp4 (you can replace this with any video you want!!!)


Customization:
-------------

1. You can replace the video with any .mp4 file, as long as it's called video.mp4.
2. To change the notification message, edit the project_x_app.ahk file at the top.
3. Edit the code in project_x_app.ahk, controller.ahk, and home.html as much as you like. Nothing difficult, no compiling necessary!


Troubleshooting:
----------------

Windows is picky about when it's allowed to interrupt you with notifications. Press the Action Center button (right-most button on taskbar) and see if the notifications are there?

If remote control doesn't work, check your github page to see if the .activate file contains a 0 or a 1 (1 for activated, 0 for not activated) to see if it's a controller or receiver problem.
