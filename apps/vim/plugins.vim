"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "elm,go,haskell,html,javascript,php,python,typescript"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim
let g:vim_bootstrap_theme = "gruvbox"
let g:vim_bootstrap_frams = ""

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
Plug 'morhetz/gruvbox'
Plug 'powerline/powerline-fonts'


if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif


Plug 'cakebaker/scss-syntax.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/csv.vim'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'fruit-in/elm-vim'
Plug 'itchyny/lightline.vim'
Plug 'joonty/vdebug'
Plug 'ludovicchabant/vim-gutentags'
Plug 'maximbaz/lightline-trailing-whitespace'
Plug 'RRethy/vim-illuminate'
Plug 'TaDaa/vimade'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/DrawIt'
Plug 'Yggdroot/indentLine'

" Initialize plugin system
call plug#end()
