#!/bin/bash

cd ~
mv -f .bashrc dotbashrc_old
ln -s unix_configs/.bashrc
ln -s unix_configs/.inputrc
ln -s unix_configs/.vimrc
