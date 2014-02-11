#echo "Hello from cfg_common/.bashrc"

shopt -s no_empty_cmd_completion
shopt -s histappend

ulimit -c 0

umask 027

if [ -n "$PS1" ]; then
    stty -ixon
fi

alias ..="cd .."
alias cgrep='egrep --color=always'
alias cp='cp -i'
alias la='ls -altrh --color=yes --group-directories-first'
alias le='ls -XBoh --color=yes --group-directories-first'
alias lg='ls -Blh --color=yes --group-directories-first'
alias ll='ls -Boh --color=yes --group-directories-first'
alias lx='ls -lXBoh --color=yes --group-directories-first'
alias lz='ls -Boh --reverse --sort=size --color=yes --group-directories-first'
alias mv="mv -i"
alias vi="vim"
alias ssh='term_teal; ssh'

# For many programs
export EDITOR=vim
export CVSEDITOR=vim
export VISUAL=vim
export BROWSER=firefox

# Subversion
SVN_MERGE=meld

# For less
export LESS="-g -I -F -X -R"

# For ls
export LS_COLORS="no=00:fi=00:di=00;36:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.xcf=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.svg=00;35:*.png=00;35:*.tif=00;35:*.v=33:*.vhd=30:*.vhdl=30:*.txt=00;33"

# Shell settings
export HISTCONTROL=ignoredups
export PATH=~/bin:~/bin/bin_common:/sbin:/usr/sbin:$PATH

# Functions
function mcd() {
  mkdir $1;
  cd $1;
}

function ff() {
  find . -iname \*$1\* ;
}

function fif() {
  find . -iname \*$1\* -exec grep -Hi $2 {} \; ;
}

function catw() {
  cat `which $1`;
}

function viw() {
  vim `which $1`;
}

function gvw() {
  gvim `which $1`;
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

# Pull local settings
[ -e ~/cfg/.bashrc ] && . ~/cfg/.bashrc


export PROMPT_COMMAND='DIR=`pwd|sed -e "s!/data/!/!"|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'

case $TERM in
    screen*)
        #SCREENTITLEPROGRAM='\[\ek\e\\\]'
        #SCREENTITLE='\[\ek\w\e\\\]'
        USERHOST="\[\e[31m\]\u@\h\[\e[0m\]"
        CURDIR="\$CurDir"
    ;;
    xterm*|cygwin*|rxvt*)
        TITLEBAR_START="\e]0;"
        TITLEBAR_END="\007"
        XTERM_TITLEBAR="\[${TITLEBAR_START}\$CurDir${TITLEBAR_END}\]"
        USERHOST="\[\e[33m\]\u@\h\[\e[0m\]"
        CURDIR="\$CurDir"
        ;;
    *)
        USERHOST="\u@\h"
        CURDIR="\w"
        
        ;;
esac

ESCAPES="${XTERM_TITLEBAR}${SCREENTITLE}${SCREENTITLEPROGRAM}"
PS1="${ESCAPES}${USERHOST}[${CURDIR}]\$ "


