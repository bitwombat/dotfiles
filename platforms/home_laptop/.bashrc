# Basics not needed here - system wide in /etc
#. $HOME/.myconfigs/.bashrc.basics
. $HOME/.myconfigs/common/.bashrc.linux
. $HOME/.myconfigs/common/.bashrc.ubuntu
[ -e $HOME/.myconfigs/common/.bashrc.sensitive ] && . $HOME/.myconfigs/common/.bashrc.sensitive
. $HOME/.myconfigs/this_platform/.bashrc.extras
[ -e $HOME/.bashrc.overrides ] && . $HOME/.bashrc.overrides
