# Shell settings
# ##############
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
shopt -s histappend
shopt -s histverify
shopt -s histreedit
shopt -s no_empty_cmd_completion
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
export BASH_ENV=$HOME/.bashrc


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
		gls -Boh --color=yes --group-directories-first
}

# "cd there"
function cdt() {
    path=$_
    dirname=$(dirname $path)
    if [ -d $path ]; then
        cd $path
    elif [ -d $dirname ]; then
        cd $dirname
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

function proc() {
    _columns="pid,ppid,user,command"
    if [ -z $1 ]; then
        # show all
        ps -ahx -o $_columns | less
    else
        # show only matching lines
        # no header on every page (-h) so that we get just one header line with grep
        ps -ax -o $_columns | grep -iE "PID  PPID|$1" | grep -v 'grep' | less
    fi
}

# open latest modified file
function ol () {
    latest_file="$(ls -atr $1 | egrep -v '^\.' | tail -1)"
    open "$latest_file"
}

# Aliases
alias ..="cd .. ; gls -Boh --color=yes --group-directories-first"
alias cg='cd `git rev-parse --show-toplevel`'
alias cp='cp -i'
alias cpv='rsync -ah --info=progress2'
alias df="df -h --exclude=tmpfs --exclude=squashfs --exclude=devtmpfs --exclude=overlay -T"
alias dig="dig +nostat +nocmd +nocomments"
alias gst='git status'
alias glg='git lg'
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
alias la='gls -ltrh --color=yes --group-directories-first'
# list (r)ecently modified
alias lr='find . -mtime -1'
# list by (e)xtension
alias le='gls -XBoh --color=yes'
# list (l)ong
alias ll='gls -Boh --color=yes --group-directories-first'
# list by si(z)e
alias lz='gls -Boh --reverse --sort=size --color=yes'
alias filemerge='/Applications/Xcode.app/Contents/Applications/FileMerge.app/Contents/MacOS/FileMerge'

# THIS REALLY NEEDS TO BE IN A "unix" .bashrc
function ping() {
    command ping $(echo $1 | sed -E -e 's#https?://##' | sed -e 's#/##g')
}
alias listpath="echo \$PATH | sed -e 's/:/\n/g'"
alias flatpath=listpath

alias gitdiffgo="git diff -- . ':!go.mod' ':!go.sum' ':!*.pb.go'"

# For many apps
export EDITOR=vim
export VISUAL=vim
export BROWSER=chrome

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


LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

# Run/enable bash completion
[ -e /etc/profile.d/bash_completion.sh ] && . /etc/profile.d/bash_completion.sh
