" VIM settings that should always be
"

" Features {{{
set nocompatible
set hidden
set lazyredraw
set smartindent
filetype on
filetype plugin indent on
syntax on
" }}}

" Editor behaviour {{{
" When finding or ctrl-x, search entire tree
set path+=**
set backspace=indent,eol,start
set autowrite
set backup
set noerrorbells
set backupdir=/tmp
set complete=.,w,b,t
"set dictionary=/usr/share/dict/words
set spellfile=$HOME/.vim/spell/en.utf-8.add
set fileformat=unix
set vb t_vb=
" }}}

" Editing behaviour {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wrap
set textwidth=79
set formatoptions=jqrocb
set expandtab
"set colorcolumn=85
" }}}

" Default folding settings {{{
set foldmethod=indent
syn region myFold start="{" end="}" transparent fold
syn sync fromstart
" }}}

" Search settings {{{
set ignorecase
set incsearch
set smartcase
set hlsearch
" }}}

" Ctags {{{
set tags=./tags,tags
" }}}

" Visual settings {{{
set listchars=tab:>.,trail:.,extends:#,nbsp:.,eol:$
set scrolloff=2
set laststatus=2
set modeline
set ruler
set showcmd
set showmatch
set noshowmode

" Use a cursor line when navigating around, off when in insert mode
set cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

set fillchars+=vert:│  " Vertical split

let g:gruvbox_italic=1
silent! colorscheme darkblue
silent! colorscheme gruvbox
set background=dark
" }}}

" Load matchit which makes % pay attention to HTML / XML tags
:source $VIMRUNTIME/macros/matchit.vim
:source $VIMRUNTIME/ftplugin/man.vim

" vim:foldmethod=marker
