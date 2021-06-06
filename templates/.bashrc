RC_HOME=$HOME/.myconfigs

THIS_OS=$(uname -s)
THIS_DISTRO=$(lsb_release -i -s)
THIS_MACHINE=$(uname -n)

. $RC_HOME/os/$THIS_OS/.bashrc
. $RC_HOME/distro/$THIS_DISTRO/.bashrc
. $RC_HOME/machine/$THIS_MACHINE/.bashrc
