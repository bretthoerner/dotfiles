#!/bin/bash

# Multimonitor note:
# xrandr -q
# xrandr --output LVDS1 --mode 1366x768 --output DP1 --mode 2560x1440 --right-of LVDS1

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
xinput set-button-map 11 1 1 3 4 5 6 7 8 9 10 11 12

# background
feh --bg-tile ~/.background.jpg

# set the cursor
xsetroot -cursor_name left_ptr

# gnome keyring
eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID
export SSH_AUTH_SOCK="$GNOME_KEYRING_CONTROL/ssh"

# clipboard
parcellite &

# screensaver
gnome-screensaver --no-daemon &

# nautilus
nautilus -n --no-desktop &

# hide mouse
unclutter &

# ssh agent
# eval `ssh-agent`

# start xmonad!
exec xmonad

