#echo "Hello from cfg_common/.bashrc"

shopt -s no_empty_cmd_completion
shopt -s histappend

ulimit -c 0

umask 027

if [ -n "$PS1" ]; then
    stty -ixon
fi

alias ..="cd .."
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cp='cp -i'
alias gv="gvim -geometry 98x24"
alias gvi="gvim -geometry 98x24"
alias la='ls -altrh --color=yes --group-directories-first'
alias le='ls -XBoh --color=yes --group-directories-first'
alias lg='ls -Blh --color=yes --group-directories-first'
alias ll='ls -Boh --color=yes --group-directories-first'
alias lv="vim -c \"normal '0\""
alias lx='ls -lXBoh --color=yes --group-directories-first'
alias lz='ls -Boh --reverse --sort=size --color=yes --group-directories-first'
alias mountt="mount | column -t | egrep '^/dev'"
alias mv="mv -i"
alias o="open"
alias pg="less"
alias ports='netstat -tulanp'
alias rsync="rsync -a --no-inc-recursive --info=progress2 "
alias vi="vim"
alias web="newgrp www-data"
alias web2='cd "$(ls -dtr1 * | grep -v 'logs' | tail -1)" ; scr'

alias naut="nautilus --no-desktop"

alias en="vim +BlogList"
alias nn="vim +BlogNew"

function ol () {
    latest_file="$(ls -atr | egrep -v '^\.' | tail -1)"
    xdg-open "$latest_file"
}

# For dialog box passwords
export SSH_ASKPASS=/usr/bin/ssh-askpass

# For Lynx
export WWW_HOME=www.google.com

# For many programs
export EDITOR=vim
export CVSEDITOR=vim
export VISUAL=vim
export BROWSER=firefox

# Subversion
SVN_MERGE=meld

# For less
export LESS="-g -I -F -X -R"

# For Rox?
export CHOICESPATH=$HOME/cfg/Choices

# For KDE - turn off crash dialog that always happens
export KDE_DEBUG=0

# For ls
export LS_COLORS="no=00:fi=00:di=00;36:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.cpio=00;31:*.JPG=00;35:*.jpg=00;35:*.xcf=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.svg=00;35:*.png=00;35:*.PNG=00;35:*.tif=00;35:*.txt=00;96:*.md=00;96:*.pdf=00;96:*.odt=00;96:*.doc=00;96:*.docx=00;96"

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
  find . -type f -iname \*$1\* -exec grep -Hi $2 {} \; ;
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

function dpkgl() {
  dpkg-query -L $1;
}

function vix() {
  if [ $1 ]; then
    fn=$1
  else 
   fn=tmp.$$
  fi
  if [ ! -e $fn ]; then
    echo "#!/" > $fn
  fi
  chmod +x $fn
  vim $fn
}

# Pull local settings
[ -e ~/.myconfigs/local/.bashrc ] && . ~/.myconfigs/local/.bashrc


export PROMPT_COMMAND='DIR=`pwd|sed -e "s!/data/!/!"|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'

case $TERM in
    screen*)
        #SCREENTITLEPROGRAM='\[\ek\e\\\]'
        #SCREENTITLE='\[\ek\w\e\\\]'
        USERHOST="\[\e[32m\]\u@\h\[\e[0m\]"
        CURDIR="\$CurDir"
    ;;
    xterm*|cygwin*|rxvt*)
        TITLEBAR_START="\e]0;"
        TITLEBAR_END="\007"
        XTERM_TITLEBAR="\[${TITLEBAR_START}\$CurDir${TITLEBAR_END}\]"
        USERHOST="\[\e[32m\]\u@\h\[\e[0m\]"
        CURDIR="\$CurDir"
        ;;
    *)
        USERHOST="\u@\h"
        CURDIR="\w"
        
        ;;
esac

if [ "$TERM" == "xterm" ]; then
    TERM=xterm-256color
fi

if [ $UID == 0 ]; then
    USERSYMBOL="#"
else
    USERSYMBOL="\$"
fi

ESCAPES="${XTERM_TITLEBAR}${SCREENTITLE}${SCREENTITLEPROGRAM}"
PS1="${ESCAPES}${USERHOST}[${CURDIR}]${USERSYMBOL} "

export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# Run/enable the 'z' directory changer
[ -e /opt/z/z.sh ] && . /opt/z/z.sh

if [[ $- == *i* ]]; then
    if [ $(groups | awk '{print $1}') == www-data ]; then
        if ! pwd | grep 'www' &> /dev/null ; then 
            cd /www
        fi
    fi
fi

[ -e /etc/profile.d/bash_completion.sh ] && . /etc/profile.d/bash_completion.sh
