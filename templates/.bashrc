RC_HOME=$HOME/.myconfigs

THIS_OS=$(uname -s)
THIS_DISTRO=$(lsb_release -i -s)
THIS_MACHINE=$(uname -n)

function source_if_exists() {
[ -e $1 ] && . $1

}
source_if_exists $RC_HOME/os/$THIS_OS/.bashrc
source_if_exists $RC_HOME/distro/$THIS_DISTRO/.bashrc
source_if_exists $RC_HOME/machine/$THIS_MACHINE/.bashrc
