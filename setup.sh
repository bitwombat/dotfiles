#!/bin/bash

cd $(dirname $0)

echo $PWD

if [ ! -e local ]; then
    echo "ERROR: Make a symlink from $PWD/locals/{platform} to $PWD/local first"
    exit 1
fi

cd ~
mv -f .bashrc dotbashrc_old
ln -s .myconfigs/local/.bashrc
ln -s .myconfigs/local/.vimrc

find .myconfigs/ -maxdepth 1 -type f -name '.*' | while read -d $'\0' dotfile
do
    ln -s $i
done
