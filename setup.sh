#!/bin/bash
set -e
cd
git clone https://github.com/bitwombat/dotfiles.git
cp dotfiles/templates/.vimrc .
cp dotfiles/templates/.bashrc .

ln -s dotfiles/apps/.inputrc
ln -s dotfiles/apps/.tmux.conf
ln -s dotfiles/apps/.gitconfig
ln -s dotfiles/apps/.fzf
ln -s dotfiles/apps/.toprc


PACKAGES="fd-find silversearcher-ag autojump git bat"

read -r -p "Install ${PACKAGES} [y/N]?: " ANS

if [[ "$ANS" == 'y' || "$ANS" == 'Y' ]]; then
    sudo apt update
    sudo apt install -y fd-find silversearcher-ag autojump git bat
    sudo ln -s /usr/bin/fdfind /usr/bin/fd
    sudo ln -s /usr/bin/batcat /usr/bin/bat
fi

mkdir dotfiles/machines/$(uname -n)
echo "Done."
echo "Reminder: Make .bashrc (or .vimrc) files in dotfiles/machines/$(uname -n) for settings specific to this machine"
