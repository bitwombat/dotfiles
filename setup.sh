#!/bin/bash

cd ~
mv -f .bashrc dotbashrc_old
ln -s .myconfigs/local/.bashrc
ln -s .myconfigs/.inputrc
ln -s .myconfigs/local/.vimrc
