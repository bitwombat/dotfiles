" $Id: .vimrc,v 1.8 2006/11/29 03:39:55 gbell2 Exp $

" Features
set ic
set ai
set foldmethod=syntax

" Pathogen
call pathogen#infect()

" Syntax
filetype on
filetype plugin on

" Without the following, folding doesn't work on php .inc files
set nocompatible
let g:php_folding=2
"let g:javaScript_fold=1

syntax on
hi Search ctermbg=4
hi Search ctermfg=7
hi Search cterm=bold
hi IncSearch ctermbg=4
hi IncSearch ctermfg=7
hi IncSearch cterm=NONE
colorscheme darkblue

set makeprg=make\ --always-make\ %<
set autowrite



" Feature-related Variables
"set autoindent
set backup
set backupdir=~/tmp,~/
set complete+=k
"set dictionary=/usr/share/dict/words
set dictionary=/home/gbell/strategies
set noerrorbells
set expandtab
"set foldcolumn=4
set fileformat=unix
set hlsearch
set ignorecase
set incsearch
set modeline
set ruler
set showmatch
set tabstop=4
set title
set titlestring=%t
set formatoptions+=ron
:inoremap # X#
set shiftwidth=4
set smartcase
set vb t_vb=
set wrap
set wildmenu
set wildmode=list:longest,full

syn region myFold start="{" end="}" transparent fold
syn sync fromstart


" Key mappings
map F !}fmt -80<CR>
map L @l
map M nz<CR>
map Q :w<CR>:!clear;python %<CR>;pause
map T :%s/  *$//g
map U zA
map <F1> :w<CR>
map <F2> :emenu Buffers.
map <F6> :set invnumber<CR>
map <F7> :if exists("syntax_on") <Bar> syntax off <Bar> <CR> else <Bar> syntax on <Bar> endif <CR>
map <F8> :if &ignorecase <Bar> set noic <Bar> <CR> else <Bar> set ic <Bar> endif <CR>
map <F9> :make<CR>
map <F11> :cn<CR>
map <F10> :cN<CR>
map n :bnext<CR>
map p :bprevious<CR>
map , zA
map <C-D> :q<CR>
map ;e :w<cr>:!python %<cr>

"if &term == "ansi"


" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
    au!
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
    autocmd BufWritePre,FileWritePre    *.gpg set bin
    autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --symmetric 2>>/dev/null
    autocmd BufWritePost,FileWritePost  *.gpg u
    autocmd BufWritePost,FileWritePost  *.gpg set nobin
augroup END

autocmd BufReadPost,FileReadPost *.cpp  syn region myFold start="{" end="}" transparent fold
autocmd BufReadPost,FileReadPost *.cpp  syn sync fromstart
autocmd BufReadPost,FileReadPost *.cpp  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.py  set foldmethod=indent
autocmd BufReadPost,FileReadPost *.css  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.c  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.h  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.html  set foldmethod=syntax

" vim -b : edit binary using xxd-format!
augroup binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" Drupal *.module and *.install files.
augroup module
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
  autocmd BufRead,BufNewFile *.inc set filetype=php
  autocmd BufRead,BufNewFile *.module set foldmethod=syntax
  autocmd BufRead,BufNewFile *.install set foldmethod=syntax
  autocmd BufRead,BufNewFile *.inc set foldmethod=syntax
augroup END

if filereadable( $HOME."/cfg/.vimrc" ) 
  so $HOME/cfg/.vimrc
endif

"so /home/gbell/server/4_Greg/configs/vim_abbreviations.vim





