#!/bin/bash

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"

[[ "$XDG_CURRENT_DESKTOP" == "KDE" ]] || export QT_QPA_PLATFORMTHEME="qt5ct"

function autorun {
   if [ -x "$(command -v $1)" ]; then
      echo "autorun: $@"
      $("$@") &
   fi
}

echo "XDG_SESSION_DESKTOP: $XDG_SESSION_DESKTOP"
wms="i3 bspwm qtile"
for session in $wms; do
   echo "session: $session"
   if [[ "$XDG_SESSION_DESKTOP" == "$session" ]]; then
      #autorun autorandr --change
      autorun pulseaudio
      autorun picom -b
      autorun /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
      autorun nm-applet
      autorun pamac-tray
      autorun pa-applet
      autorun caffeine
      autorun xset s 600
      autorun xss-lock -l -- $HOME/bin/betterlockscreen_mm -l dimblur
      autorun xfce4-power-manager
      autorun clipit
      autorun sxhkd
      #trayer --edge bottom --align right --monitor primary --width 6 --padding 10 --iconspacing 7 --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x1f2430 &

      exit

   fi
done

echo "autorun.d"
if [ -d $HOME/.config/autorun.d ] ; then
    for f in $HOME/.config/autorun.d/?*.sh ; do
       echo "autorun.d: $f"
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
