#### AUTOSTART ####
#gnome-keyring-daemon --daemonize --login
#gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
.screenlayout/home-layout.sh
nitrogen --restore
compton &
wal -R &
start-pulseaudio-x11 &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
#xfce4-power-manager &
#xfsettingsd &
#synclient TapButton1=1 TapButton2=3 TapButton3=2 & #For laptop touchpad
xset -b & #For annoying beeping sounds
light-locker &
thunar --daemon &
nm-applet &
pa-applet &
#blueman-applet &
pamac-tray &
#msm_notifier &


