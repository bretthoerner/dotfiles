# Multimonitor note:
# xrandr -q
# xrandr --output eDP1 --mode 1920x1080 --output DP1 --mode 2560x1600 --above eDP1
# xrandr --output eDP1 --mode 1920x1080 --output DP1 --off

# source Arch defaults
for _ in /etc/X11/xinit/xinitrc.d/*; do
  [[ -f $_ ]] && . "$_"
done

# launch a dbus session bus and write the location to file
read machine_id < /etc/machine-id
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

# disable beep
xset -b

# caps lock = control
setxkbmap -option caps:ctrl_modifier

# background
#feh --bg-center ~/.bg.jpg

# set the cursor
xsetroot -cursor_name left_ptr

# touchpad
#xinput --set-prop "1A582000:00 06CB:CD73 Touchpad" "libinput Natural Scrolling Enabled" 1
#xinput --set-prop "1A582000:00 06CB:CD73 Touchpad" "libinput Click Method Enabled" {1 1}
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Click Method Enabled" {1 1}

# screensaver
xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &

# hide mouse
unclutter &

# redshift
#redshift -m randr -l geoclue2 -g .75:.75:.75 &

# notifications
dunst -conf ~/.dunstrc &

# fix gnome-control-center
export XDG_CURRENT_DESKTOP=GNOME

# clipboard daemon
/usr/lib/gsd-clipboard &

# keyring
/usr/bin/gnome-keyring-daemon --start --foreground --components=secrets &

# compton
#compton -b --config ~/.config/compton.conf

# ssh agent
# (handled by systemd user service now)
#eval $(ssh-agent)

# exec xmonad
exec i3

