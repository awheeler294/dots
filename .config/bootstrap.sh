#!/bin/bash

function item_in_array {
   local item="$1"
   local arr="$2"

   #echo "item_in_array"
   #echo "item: $item"
   #echo "arr: $arr"

   for ((i = 0; i < ${#arr[@]}; i++))
   do
      e="${arr[$i]}"
      #echo "e: $e"
      if [ "$item" == "$e" ]; then
         #echo "Found $e"
         # found
         return 0
      fi
   done

   return 1
}

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
#elif [ -f /etc/SuSe-release ]; then
#    # Older SuSE/etc.
#    ...
#elif [ -f /etc/redhat-release ]; then
#    # Older Red Hat, CentOS, etc.
#    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

#echo "$OS"
#echo "$VER"

manjaro=("Manjaro Linux" ManjaroLinux) 
if item_in_array "$OS" "$manjaro"; then
   echo "Found Manjaro Linux"
   yay -S --needed - < $HOME/.config/bootstrap-pkglist-pacman.txt
fi

pop=("Pop!_OS" Pop)
if item_in_array "$OS" "$pop"; then
   echo "Found Pop OS"
   git clone https://github.com/zsh-users/zsh-history-substring-search ${HOME}/.config/zsh-plugins/zsh-history-substring-search
   git clone https://github.com/zsh-users/zsh-autosuggestions          ${HOME}/.config/zsh-plugins/zsh-autosuggestions

   sudo apt update
   sudo apt upgrade

   sudo apt-get install software-properties-common

   xargs -a <(awk '! /^ *(#|$)/' "$HOME/.config/bootstrap-pkglist-deb.txt") -r -- sudo apt-get install
   pip3 install --user jedi

fi

read -r -p "Extend .bashrc? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   echo "[[ -f ~/.config/extend-rc/extendrc ]] && . ~/.config/extend-rc/extendrc --bashrc" >> $HOME/.bashrc 
fi

read -r -p "Extend .profile? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   echo "[[ -f ~/.config/extend-rc/extendrc ]] && . ~/.config/extend-rc/extendrc --profile" >> $HOME/.bashrc 
fi

read -r -p "set Vivaldi as default browser? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   xdg-mime default vivaldi-stable.desktop x-scheme-handler/http
   xdg-mime default vivaldi-stable.desktop x-scheme-handler/https
fi

pip install --user jedi

wget https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo -P /tmp/
tic -x /tmp/termite.terminfo
chsh -s $(which zsh)

echo 'SSH_AUTH_SOCK DEFAULT="${XDG_RUNTIME_DIR}/ssh-agent.socket"' >> $HOME/.pam_environment
