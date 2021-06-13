xmodmap -e "pointer = 1 2 3 4 5 6 7 8 9 10 11 12 13"
xinput set-int-prop "Logitech USB Trackball" "Evdev Wheel Emulation Button" 8 9
xinput set-int-prop "Logitech USB Trackball" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "Logitech USB Trackball" "Evdev Middle Button Emulation" 8 1
xinput --set-prop "Logitech USB Trackball" "libinput Scroll Method Enabled" 0 0 1
xinput --set-prop "Logitech USB Trackball" "libinput Button Scrolling Button" 8
