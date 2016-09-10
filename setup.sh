#!/bin/bash

cd ~
mv -f .bashrc dotbashrc_old
ln -s .myconfigs/local/.bashrc
ln -s .myconfigs/.inputrc
ln -s .myconfigs/local/.vimrc
ln -s .myconfigs/.xprofile
ln -s .myconfigs/.Xmodmap
ln -s .myconfigs/.Xkbmap
ln -s .myconfigs/.conkyrc
