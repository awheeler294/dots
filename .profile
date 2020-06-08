#
# ~/.profile
#
#

[[ "$XDG_CURRENT_DESKTOP" == "KDE" ]] || export QT_QPA_PLATFORMTHEME="qt5ct"

[[ -f ~/.extend.profile ]] && . ~/.extend.profile

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"

function autorun {
   if [ -x "$(command -v $1)" ]; then
      $("$@") &
   fi
}

autorun autorandr --change
autorun picom -b
autorun /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
autorun nm-applet
autorun pamac-tray
autorun pa-applet
autorun caffeine
#trayer --edge bottom --align right --monitor primary --width 6 --padding 10 --iconspacing 7 --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x1f2430 &

