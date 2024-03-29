#echo "Hi from machine .bashrc"
# Put homebrew back at the beginning of the path, because letting asdf launch
# go completely breaks :GoPath and :GoInstallBinaries in vim/vim-go.
#PATH=/opt/homebrew/bin:$PATH

alias tmux="TERM=xterm-256color tmux"

alias edgenode="sudo /Library/PaperCut\ Hive/pc-edgenode-service"
alias ag="ag --skip-vcs-ignores --color"
alias fd="fd --no-ignore"
alias vscode="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
alias kube="kubectl"
alias fd="fd --no-ignore-vcs"
alias watchtest='find . -name "*.go" | entr -s "clear ; go test -v"'
alias myip="ifconfig | grep 'inet '"

export DIRENV_LOG_FORMAT=''

# This one is common to server - what to do? Is the app "fzf" or bash? How do we compose?
# fuzzy find with preview then open vim
function fvi() {
    FILE=$(fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}') && vim $FILE
}

__git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [[ $- =~ i ]]; then  # interactive
PS1="\
\[\033[37;46m\]\
\$(__git_branch)\
\[\033[37;44m\]\
[\w]\
\[$(tput sgr0)\]$ "
fi

myGoAlias() {
  if [[ $1 == "test" ]]; then
    shift
    gotestsum --format testname -- -race "$@"
  else
    command go "$@"
  fi
}
alias go=myGoAlias

gh() { go help $1 | less; }
compl() {
    source <(kubectl completion bash)
    source /opt/homebrew/etc/bash_completion.d/docker.bak
    source /opt/homebrew/etc/bash_completion.d/kubectl.bak
}

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
#source <(kubectl completion bash)

