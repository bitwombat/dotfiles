#echo "Hi from machine .bashrc"
# Put homebrew back at the beginning of the path, because letting asdf launch
# go completely breaks :GoPath and :GoInstallBinaries in vim/vim-go.
#PATH=/opt/homebrew/bin:$PATH

alias tmux="TERM=xterm-256color tmux"

alias edgenode="sudo /Library/PaperCut\ Hive/pc-edgenode-service"
alias ag="ag --color"
alias cdc="cd ~/code/pmitc/coordinator"
alias vscode="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
alias kube="kubectl"

__git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\[\e[33m\e[31m\]\$(__git_branch)\[\e[0m\][\w]\$ "

gh() { go help $1 | less; }

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
source <(kubectl completion bash)

