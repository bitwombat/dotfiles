# Compose the sets of settings that we need for this platform

. $HOME/.myconfigs/common/.bashrc.basics
. $HOME/.myconfigs/common/.bashrc.linux
. $HOME/.myconfigs/common/.bashrc.ubuntu
[ -e $HOME/.myconfigs/common/.bashrc.sensitive ] && . $HOME/.myconfigs/common/.bashrc.sensitive
. $HOME/.myconfigs/this_platform/.bashrc.extras
[ -e $HOME/.bashrc.overrides ] && . $HOME/.bashrc.overrides

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--preview 'head -100 {}'"
_fzf_compgen_path() { ag -g . "$1"; }
complete -F _fzf_path_completion -o default -o bashdefault o

if [[ $PWD == "/data/www/aquasafe/app" ]]; then
  . ../setup.sh
fi

if [[ $PWD == "/data/www/koala/public_html" ]]; then
  . ../setup.sh
fi
