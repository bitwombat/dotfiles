function dpkgl() {
  dpkg-query -L $1;
}

function better_readlink() {
    local path
    path=$(which "$1")
    if [ -z "$path" ]; then
        echo "No such command" >&2
        echo "Maybe $(ls /usr/bin/$1* /bin/$1* /usr/sbin/$1* /sbin/$1* /opt/bin/$1* 2>/dev/null)?" >&2
        return
    fi

    echo "$path"
    if result=$(readlink "$path") ; then
        better_readlink "$result"
    fi
    # readlink echos nothing if passed a real file, so $result will be empty
    # here... no need to echo.
}

function dpkgw() {
    path=$(better_readlink $1)
    if [ -n "$path" ]; then
      echo "All you need is one good package name:"
      dpkg-query -S $path | cut --delimiter=':' --fields=1;
    fi
}

function dpkgwi() {
  dpkg-query -p $(dpkgw $1);
}

function dpkgwl() {
  dpkg-query -L $(dpkgw $1);
}

function dpkgwhy() {
    apt-cache rdepends --installed $1
}

function dpkgwwhy() {
    apt-cache rdepends --installed $(dpkgw $1)
}
