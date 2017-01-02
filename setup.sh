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
for i in .myconfigs/.*; do
    ln -s $i
done
