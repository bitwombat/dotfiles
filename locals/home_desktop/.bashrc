# Basics not needed here - system wide in /etc/.bashrc.basics 
# (called by /etc/bash.bashrc which is called by bash)
#
# Note that /etc/bash.bashrc does not get called by non-interactive shells
# (like bash scripts)
# 
# Bash scripts should be independent of aliases and other .bashrc settings anyway.
# Functions they need are in bin_common/functions

#. $HOME/.myconfigs/.bashrc.basics

alias viewjournal="journalctl | tr -cd '[:space:][:print:]' | vim -"
. $HOME/.myconfigs/common/.bashrc.linux
. $HOME/.myconfigs/common/.bashrc.ubuntu
[ -e $HOME/.myconfigs/common/.bashrc.sensitive ] && [ . $HOME/.myconfigs/common/.bashrc.sensitive ]
. $HOME/.myconfigs/local/.bashrc.extras
