# Compose the sets of settings that we need for this platform
. $HOME/.myconfigs/common/.bashrc.basics
. $HOME/.myconfigs/common/.bashrc.linux
. $HOME/.myconfigs/common/.fzf
. $HOME/.myconfigs/common/.bashrc.ubuntu
[ -e $HOME/.myconfigs/common/.bashrc.sensitive ] && . $HOME/.myconfigs/common/.bashrc.sensitive
. $HOME/.myconfigs/this_platform/.bashrc.extras
[ -e $HOME/.bashrc.overrides ] && . $HOME/.bashrc.overrides

. /usr/share/autojump/autojump.bash

# Workaround for bash/readline bug. Without this, Ctrl-E doesn't work. Line has been left in .inputrc
# for when it works someday.
bind -m vi-command ' "\C-e": end-of-line '

export PATH=/root/bin:$PATH

export XAUTHORITY=/run/user/1000/gdm/Xauthority
export DISPLAY=:0
