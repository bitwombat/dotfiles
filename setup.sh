#!/bin/bash

cd $(dirname $0)

echo $PWD

if [ ! -e this_platform ]; then
    echo "ERROR: Make a symlink from $PWD/platforms/{platform} to $PWD/this_platform first"
    exit 1
fi

cd ~
mv -f .bashrc dotbashrc_old
ln -s .myconfigs/this_platform/.bashrc
ln -s .myconfigs/this_platform/.vimrc

find .myconfigs/ -maxdepth 1 -type f -name '.*' | while read -d $'\0' dotfile
do
    ln -s $i
done
