#!/bin/bash

# Multimonitor note:
# xrandr -q
# xrandr --output eDP1 --mode 1920x1080 --output DP1 --mode 2560x1600 --above eDP1
# xrandr --output eDP1 --mode 1920x1080 --output DP1 --off

# source Arch defaults
for _ in /etc/X11/xinit/xinitrc.d/*; do
  [[ -f $_ ]] && . "$_"
done

# launch a dbus session bus and write the location to file
read machine_id </etc/machine-id
dbus-launch --autolaunch="$machine_id" --binary-syntax --close-stderr --exit-with-session
if [ -f "$HOME/.dbus/session-bus/$machine_id-${DISPLAY#:}" ]; then
  . "$HOME/.dbus/session-bus/$machine_id-${DISPLAY#:}"
  unset machine_id
  printf '%s\n' "$DBUS_SESSION_BUS_ADDRESS" > "$HOME/.dbus_address"
fi

# xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# keyboard delay
xset r rate 200 50

# caps lock = control
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"

# middle click = left click
# xinput set-button-map "SynPS/2 Synaptics TouchPad" 1 1 3 4 5 6 7 8 9 10 11 12

# background
# feh --bg-center ~/.bg.jpg

# set the cursor
xsetroot -cursor_name left_ptr

# screensaver
xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &

# hide mouse
unclutter &

# redshift
redshift -l geoclue2 -g .75:.75:.75 &

# notifications
dunst -conf ~/.dunstrc &

# ssh agent
# (handled by systemd user service now)
#eval $(ssh-agent)

# start xmonad!
exec xmonad

