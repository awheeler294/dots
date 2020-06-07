#!/bin/sh

git clone https://github.com/zsh-users/zsh-history-substring-search ${HOME}/.config/zsh-plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-autosuggestions          ${HOME}/.config/zsh-plugins/zsh-autosuggestions

sudo apt update
sudo apt upgrade

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt upgrade

sudo apt install zsh zsh-syntax-highlighting grc neovim nodejs npm tree python3-pip
pip3 install --user jedi

wget https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo -P /tmp/
tic -x /tmp/termite.terminfo
chsh -s $(which zsh)
