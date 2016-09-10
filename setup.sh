#!/bin/bash

cd ~
mv -f .bashrc dotbashrc_old
ln -s .myconfigs/local/.bashrc
for i in .myconfigs/.*; do
    ln -s $i
done
