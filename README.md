unix_configs
============

Unix configs

# Setup

git clone http://github.com/bitwombat/unix_configs
mv unix_configs .myconfigs
cd .myconfigs
ln -s locals/some_appropriate_configuration local
. setup.sh
sudo cp .bashrc.basics /etc
sudo chmod 644 /etc/.bashrc.basics 
sudo vi /etc/bash.bashrc 
add . /etc/.bashrc.basics as the last line

## Goals

* Uncomplicated - easy to understand in 6 months.  Easy control flow.
* Fully customisable per machine and per user (e.g. gbell2, root)
  (or logic inside can make choices)
* Easy to deploy and set up
* Support for just the basics (for all the shell accounts)

