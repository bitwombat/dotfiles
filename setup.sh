#!/bin/bash

cd $(dirname $0)

echo $PWD

if [ ! -e this_platform ]; then
    echo "ERROR: Make a symlink from $PWD/platforms/{platform} to $PWD/this_platform first"
    exit 1
fi

cd ~

# Symlink to all .rc files right under .myconfigs to ~
find .myconfigs/ -maxdepth 1 -type f -name '.*' -print0 | while read -d $'\0' dotfile
do
    ln -s $dotfile
done

# Symlink to all .rc files under 'this_platform' to ~
find .myconfigs/this_platform/ -maxdepth 1 -type f -name '.*' -print0 | while read -d $'\0' dotfile
do
    if [ -f "$dotfile" ]; then
        echo "WARNING: $dotfile already exists. Not linking to it from ~."
    else
        ln -s $dotfile
    fi
done
