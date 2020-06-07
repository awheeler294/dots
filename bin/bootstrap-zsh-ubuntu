#!/bin/sh

git clone https://github.com/zsh-users/zsh-history-substring-search ${HOME}/.config/zsh-plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-autosuggestions          ${HOME}/.config/zsh-plugins/zsh-autosuggestions

if [[ $(lsb_release -rs) == "16.04" ]]; then 
   sudo add-apt-repository ppa:neovim-ppa/stable
fi

sudo apt update
sudo apt install zsh zsh-syntax-highlighting grc neovim nodejs tree
pip install --user jedi

wget https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo -P /tmp/
tic -x /tmp/termite.terminfo
chsh -s $(which zsh)
