#!/bin/bash
set -e
cd
git clone https://github.com/bitwombat/dotfiles.git
cp dotfiles/templates/.vimrc .
cp dotfiles/templates/.bashrc .

[ -f .inputrc ] || ln -s dotfiles/apps/.inputrc
[ -f .tmux.conf ] || ln -s dotfiles/apps/.tmux.conf
[ -f .gitconfig ] || ln -s dotfiles/apps/.gitconfig
[ -f .fzf ] || ln -s dotfiles/apps/.fzf
[ -f .toprc ] || ln -s dotfiles/apps/.toprc


PACKAGES="fd-find silversearcher-ag autojump git bat"

read -r -p "Install ${PACKAGES} [y/N]?: " ANS

if [[ "$ANS" == 'y' || "$ANS" == 'Y' ]]; then
    sudo apt update
    sudo apt install -y fd-find silversearcher-ag autojump git bat vim
    sudo ln -s /usr/bin/fdfind /usr/bin/fd
    sudo ln -s /usr/bin/batcat /usr/bin/bat
fi

mkdir dotfiles/machine/$(uname -n)
echo "Done."
echo "Reminder: Make .bashrc (or .vimrc) files in dotfiles/machine/$(uname -n) for settings specific to this machine"
