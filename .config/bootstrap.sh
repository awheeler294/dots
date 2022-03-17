#!/bin/bash

set -e

function arch_install {
   yay -S --needed --sudoloop --save - < $HOME/.config/bootstrap-pkglist-pacman.txt
}

function arch_install_arm {
   sudo pacman -S --needed - < $HOME/.config/arch_base_devel.pkglist
   yay -S --needed --sudoloop --save - < $HOME/.config/bootstrap-pkglist-pacman-arm.pkglist
}

function ubuntu_install {
   git clone https://github.com/zsh-users/zsh-history-substring-search ${HOME}/.config/zsh-plugins/zsh-history-substring-search
   git clone https://github.com/zsh-users/zsh-autosuggestions          ${HOME}/.config/zsh-plugins/zsh-autosuggestions

   sudo apt update
   sudo apt upgrade

   sudo apt-get install software-properties-common

   xargs -a <(awk '! /^ *(#|$)/' "$HOME/.config/bootstrap-pkglist-deb.txt") -r -- sudo apt-get install
}

function global_setup {
   read -r -p "Extend .bashrc? [Y/n]" response
   response=${response,,} # tolower
   if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
      echo "[[ -f ~/.config/extend-rc/extendrc ]] && . ~/.config/extend-rc/extendrc --bashrc" >> $HOME/.bashrc 
   fi

   read -r -p "Extend .profile? [Y/n]" response
   response=${response,,} # tolower
   if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
      echo "[[ -f ~/.config/extend-rc/extendrc ]] && . ~/.config/extend-rc/extendrc --profile" >> $HOME/.profile 
   fi

   read -r -p "set Vivaldi as default browser? [Y/n]" response
   response=${response,,} # tolower
   if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
      xdg-mime default vivaldi-stable.desktop x-scheme-handler/http
      xdg-mime default vivaldi-stable.desktop x-scheme-handler/https
   fi

   pip install --user jedi

   chsh -s $(which zsh)

   echo 'SSH_AUTH_SOCK DEFAULT="${XDG_RUNTIME_DIR}/ssh-agent.socket"' >> $HOME/.pam_environment
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
echo
echo "OS:" "$OS"
echo "VER:" "$VER"
echo
echo "Please choose bootstrap type:"
echo "[A] Arch Linux"
echo "[R] Arch Linux Arm"
echo "[U] Ubuntu"

while true; do
   read -r -p " " response
   response=${response,,} # tolower
   case $response in   
      [Aa]* ) arch_install; global_setup; break;;
      [Rr]* ) arch_install_arm; global_setup; break;;
      [Uu]* ) ubuntu_install; global_setup; break;;
      * ) echo "Please answer A, U, R.";;
   esac
done
