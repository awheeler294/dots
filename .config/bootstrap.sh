yay -S --needed - < $HOME/.config/bootstrap-pkglist.txt

xdg-mime default vivaldi-stable.desktop x-scheme-handler/http
xdg-mime default vivaldi-stable.desktop x-scheme-handler/https

pip install --user jedi

wget https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo -P /tmp/
tic -x /tmp/termite.terminfo
chsh -s $(which zsh)
