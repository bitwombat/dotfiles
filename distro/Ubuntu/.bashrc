function dpkgl() {
  dpkg-query -L $1;
}

function dpkgw() {
  dpkg-query -S $(which $1) | cut --delimiter=':' --fields=1;
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
