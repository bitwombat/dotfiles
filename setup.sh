#!/bin/bash

cd $(dirname $0)

echo $PWD

if [ ! -e this_platform ]; then
    echo "ERROR: Make a symlink from $PWD/platforms/{platform} to $PWD/this_platform first"
    exit 1
fi

cd ~
[ -r .bashrc ] && mv -f .bashrc dotbashrc_old
if [ -r .bashrc ]; then
    echo "WARNING: .bashrc already exists"
else
    ln -s .myconfigs/this_platform/.bashrc
fi

if [ -r .vimrc ]; then
    echo "WARNING: .vimrc already exists"
else
    ln -s .myconfigs/this_platform/.vimrc
fi

find .myconfigs/ -maxdepth 1 -type f -name '.*' | while read -d $'\0' dotfile
do
    ln -s $i
done
