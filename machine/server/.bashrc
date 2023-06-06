pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

# Fuzzy find
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPS="--extended"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
_fzf_compgen_path() { ag -g . "$1"; }
complete -F _fzf_path_completion -o default -o bashdefault o
complete -F _fzf_path_completion -o default -o bashdefault audacious
complete -F _fzf_path_completion -o default -o bashdefault aud

export PATH
pathadd /root/bin

export XAUTHORITY=/run/user/$(id -u)/gdm/Xauthority
export DISPLAY=:0

#if [ "$TERM" == "xterm" ]; then
#    TERM=xterm-256color
#fi

#if [ "$TERM" == "screen" ]; then
#    TERM=screen-256color
#fi

alias momvnc="remote_vnc margaret moms"
alias dadvnc="remote_vnc chris dads"
alias jillvnc="remote_vnc jbell jills"

alias editfeed="vi scp://bitwomba@bitwombat.com.au/public_html/pods/feed.xml"

# vim last
alias vl="nvim -c \"normal '0\""

# fuzzy find with preview then open vim
function fvi() {
    FILE=$(fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}') && nvim "$FILE"
}


# abbreviations for apps and preferred apps
alias naut="nautilus --no-desktop"
alias aud="audacious"
alias aedit="audacity"
alias aplay="audacious"

alias su='term root ; su'

# For composer (3x speedup)
alias xdebug_off='sudo phpdismod -v ALL -s cli xdebug'
alias xdebug_on='sudo phpenmod -v ALL -s cli xdebug'

# For dialog box passwords
export SSH_ASKPASS=/usr/bin/ssh-askpass

# GPG agent
export GPG_TTY=$(tty)

# Wine
export WINEPREFIX="$HOME/.wine-32"
export WINEARCH=win32

# Pip
pathadd $HOME/.local/bin

# Node
pathadd /opt/node/bin
MANPATH="/opt/node/share/man:$MANPATH"

# Composer packages
pathadd $HOME/.composer/vendor/bin

# Haskell tools
#PATH=~/.stack/compiler-tools/x86_64-linux/ghc-8.6.5/bin:$PATH
#pathadd $HOME/.cabal
pathadd $HOME/.ghcup/bin

#export ENSCRIPT="-d Brother-HLL2375DW-series"
export ENSCRIPT="-d HLL2375DW-Try3"

function scr() {
    if [ $1 ]; then
        screen -c $1
    else
        CONF=screen.conf
        if [ ! -e $CONF ]; then
            echo "ERROR: Can't find $CONF"
        else
            session_name=$(cat $CONF | grep 'sessionname' | sed -e 's/sessionname//')
            set_title $session_name
            screen -c $CONF
        fi
    fi
}

function go_camera() {
    cd $(find /pics/camera -maxdepth 1 -type d -name '20*' | sort | tail -1)
}

function ssh() {
    # Detect when ssh is called by scp completion
    if [[ "$*" == *"Batchmode"* ]]; then
        /usr/bin/ssh "$@"
    else
        term ssh
        command ssh "$@"
        term
    fi
}

alias plocate="locate -d /var/lib/mlocate/personal.db"

alias cduf="cl /www/uf/checkout/trunk/resource/platform"

# xdebug from the cli won't reliably read the xdebug.ini
# PHP 7.0, just requires this var to exist,
export XDEBUG_CONFIG=

eval $(dircolors -b /opt/dircolors-zenburn/dircolors)

# Bash now has PROMPT_DIRTRIM which trims \w to that many path elements,
# But then we couldn't do the $HOME and /data/ substitutions.
# SO, do it The Hard Way still:
X='DIR='                       # Set temporary variable DIR to
X=${X}'$(pwd'                  # the output of pwd
X=${X}'|sed -e "s!/data/!/!"'  # piped into sed to remove the data prefix
X=${X}'|sed -e "s!$HOME!~!"'   # piped into sed to replace the home dir with tilde
X=${X}');'                     # end command
# Create the alternate path, to compare lengths and maybe use
X=${X}'IFS="/" read -ra PathElements <<< "${DIR}";'
X=${X}'LEN=${#PathElements};'
X=${X}'AltDir="/${PathElements[1]}/${PathElements[2]}/…/${PathElements[LEN-2]}/${PathElements[LEN-1]}";'
X=${X}'Alt2Dir="${PathElements[LEN-2]}/${PathElements[LEN-1]}";'
# See if we really want to use it
X=${X}'if [[ ${#DIR} -lt 30 || ${#AltDir} > ${#DIR} ]]; ' # if the original dir was short enough, or the new one is longer
X=${X}'then '
X=${X}'  AltDir=$DIR; '        # use the original
X=${X}'  Alt2Dir=$DIR; '       # use the original
X=${X}'fi;'

if [ -n "$STY" ]; then  # we're inside of screen
    X=${X}'pwd=$(pwd);' # get the pwd
    X=${X}'LAST_COMPONENT=${pwd##*/};'  # and pull off the string after the last slash
    X=${X}'printf "\033k%s\033\\" $LAST_COMPONENT;'  # print that out using the screen escape sequence
fi
export PROMPT_COMMAND=$X

case $TERM in
    screen*)
        CURDIR="\$AltDir"
    ;;
    xterm*|cygwin*|rxvt*)
        TITLEBAR_START="\e]0;"
        TITLEBAR_END="\007"
        XTERM_TITLEBAR="\[${TITLEBAR_START}\$Alt2Dir${TITLEBAR_END}\]"
        CURDIR="\$AltDir"
        ;;
    *)
        CURDIR="\w"
        ;;
esac


. /etc/bash_completion.d/git-prompt
. /usr/share/autojump/autojump.bash
. $HOME/.config/exercism/exercism_completion.bash

ESCAPES="${XTERM_TITLEBAR}${SCREENTITLE}${SCREENTITLEPROGRAM}"
PS1="${ESCAPES}\[\e[33m\e[31m\]\$(__git_ps1)\[\e[0m\][\[\e[38;5;202m\]${CURDIR}\[\e[0m\]]\$ "
