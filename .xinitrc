export _JAVA_AWT_WM_NONREPARENTING=1

setxkbmap -option ctrl:nocaps -option compose:rwin
# Now handled directly by DWM.
#xbindkeys
wmname dwm
keynav &

xsetroot -solid '#7f7f7f'

xset fp+ /usr/share/fonts/local
xset fp rehash

# Set date, time, and remaining battery in DWM toolbar.
while true; do
	xsetroot -name "$(date) | $(acpi -b | cut -d ' ' -f 5-)"
	sleep 1
done &

exec /usr/local/bin/dwm
