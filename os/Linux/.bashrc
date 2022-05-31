# Shell settings
# ##############
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
shopt -s histappend
shopt -s histverify
shopt -s histreedit
shopt -s no_empty_cmd_completion
shopt -s autocd
ulimit -c 0
umask 027

# Turn on line editing, even though .inputrc does this, so later binds work
set -o vi

# Key bindings
# Ctrl-g s will open a new terminal window in the same dir
bind -x '"\C-gs":"term same"'

if [ -n "$PS1" ]; then
    stty -ixon
fi

# Tell non-interactive shells where to go
#export BASH_ENV=$HOME/.bashrc


# Functions and aliases
#######################

# "makedir and cd to it"
function mcd() {
  mkdir $1;
  cd $1;
}

# cd down
function cdd() {
    cd "$(find . -name "*$1*" -type d -print -quit)"
}

# cd and list
function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
		ls -Boh --color=yes --group-directories-first
}

# "cd there"
function cdt() {
    path=$_
    dirname=$(dirname "$path")
    if [ -d "$path" ]; then
        cd "$path"
    elif [ -d "$dirname" ]; then
        cd "$dirname"
    else
        echo "Can't see directory to cd to in that command."
    fi
}

# find file
function ff() {
  find . -iname \*$1\* ;
}

# find in files
function fif() {
  find . -iname \*$1\* -exec grep -Hi $2 {} \; ;
}

# cat which
function catw() {
  cat `which $1`;
}

# vim which
function viw() {
  vim `which $1`;
}

# gvim which
function gviw() {
  gvim `which $1`;
}

# vi a new executable
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

# open latest modified file
function ol () {
    latest_file="$(ls -atr $1 | egrep -v '^\.' | tail -1)"
    xdg-open "$latest_file"
}

# Aliases
alias ..="cd .. ; ls -Boh --color=yes --group-directories-first"
alias cg='cd `git rev-parse --show-toplevel`'
alias cp='cp -i'
alias cpv='rsync -ah --info=progress2'
alias df="df -h --exclude=tmpfs --exclude=squashfs --exclude=devtmpfs --exclude=overlay -T"
alias dig="dig +nostat +nocmd +nocomments"
alias gst='git status'
alias gv="gvim -geometry 98x24"
alias gvi="gvim -geometry 98x24"
alias mkdir="mkdir -vp"
alias mountt="mount | column -t | sort | egrep '^/dev'"
alias mv="mv -i"
alias o="xdg-open"
alias ports='netstat -tulanp'
alias rsync="rsync -a --no-inc-recursive --info=progress2 "
alias vi="vim"
alias wget="wget --progress=dot:mega"

alias cdr='cd "$(cat ~/.pwdremember)"'
alias pwdr='pwd > ~/.pwdremember'

# list l(a)test
alias la='ls -ltrh --color=yes --group-directories-first'
# list (r)ecently modified
alias lr='find . -mtime -1'
# list by (e)xtension
alias le='ls -XBoh --color=yes --group-directories-first'
# list (l)ong
alias ll='ls -Boh --color=yes --group-directories-first'
# list by si(z)e
alias lz='ls -Boh --reverse --sort=size --color=yes --group-directories-first'

# For many apps
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox

# App-specific
export ACK_PAGER=less
export SVN_MERGE=meld
export LESS="-g -I -F -X -R"
export PAGER="less -Xi"
export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod norelativenumber nonumber nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

if [ "$(id -u)" -eq 0 ]; then
    PS1="\u@\h:[\w]# "
else
    PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
fi


# Run/enable bash completion
[ -e /etc/profile.d/bash_completion.sh ] && . /etc/profile.d/bash_completion.sh

# Enable stack completion
#eval "$(stack --bash-completion-script stack)"
