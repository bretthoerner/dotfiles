# keyboard delay
xset r rate 200 50

# caps lock = control
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"

# set the cursor
xsetroot -cursor_name left_ptr

# gnome keyring
eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID
export SSH_AUTH_SOCK="$GNOME_KEYRING_CONTROL/ssh"

# sound
start-pulseaudio-x11

# screensaver
gnome-screensaver --no-daemon &

# hide mouse
unclutter &

# ssh agent
# eval `ssh-agent`

# start xmonad!
exec xmonad
