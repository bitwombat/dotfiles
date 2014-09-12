" $Id: .vimrc,v 1.8 2006/11/29 03:39:55 gbell2 Exp $

" Put in for pyflakes/ftplugin
filetype on
filetype plugin on

" Omnifunc
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

inoremap <C-space> <C-x><C-o>

" Make the 81st column of wide lines stand out
" highlight ColorColumn ctermbg=blue
" call matchadd('ColorColumn', '\%81v', 100)

so ~/.vim/plugin/matchit.vim

" Move to match with tab
nnoremap <tab> %
vnoremap <tab> %

" Toggle paste mode
set pastetoggle=<F2>

set showmode
set showcmd
"set cursorline  " slows things down too much in gvim
set backspace=indent,eol,start
set laststatus=2

"set scrolloff=15

"set ai
set foldmethod=indent

" Without the following, folding doesn't work on php .inc files
set nocompatible
let g:php_folding=2
let g:javaScript_fold=1

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
set backupdir=/tmp
set complete+=k
set dictionary=/usr/share/dict/words
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
:inoremap # X#
set shiftwidth=4
set smartcase
set vb t_vb=
set wrap
set wildmenu
set wildmode=list:longest,full

" Escape from insert mode with jj
inoremap jj <ESC>

" Navigate long lines by screen lines, not file lines
"nnoremap j gj
"nnoremap k gk

" Wrapping
set wrap
set textwidth=79
set formatoptions=q
"set colorcolumn=85

" Default to regex searches (not vim expressions)
"nnoremap / /\v
"nnoremap / /\v

syn region myFold start="{" end="}" transparent fold
syn sync fromstart



" Key mappings
"map F !}fmt -80<CR>
map F gq}
map L @l
map M nz<CR>
map Q :w<CR>:!clear;python %<CR>;pause
map T :%s/  *$//g
map U zA
map <F1> :update<CR>
inoremap <F1> <ESC>:update<CR>a
map <C-s> :update<CR>
imap <C-s> <ESC>:update<CR>a
"map <F2> :emenu Buffers.
map <F6> :set invnumber<CR>
map <F7> :if exists("syntax_on") <Bar> syntax off <Bar> <CR> else <Bar> syntax on <Bar> endif <CR>
map <F8> :if &ignorecase <Bar> set noic <Bar> <CR> else <Bar> set ic <Bar> endif <CR>
map <F9> :if &list <Bar> set nolist <Bar> <CR> else <Bar> set list <Bar> endif <CR>
map <F11> :cn<CR>
map <F10> :cN<CR>
map n :bnext<CR>
map p :bprevious<CR>
map , zA
map <C-D> :q<CR>
" Close the tag under the cursor
map <C-P> ly/>/eA</"^

" Execute python on current file
:map ;e :w<cr>:!python %<cr>

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
autocmd BufReadPost,FileReadPost *.py  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.css  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.c  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.h  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.html  set foldmethod=syntax
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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

augroup text
    autocmd BufRead,BufNewFile       *.txt colorscheme zenburn
    autocmd BufRead,BufNewFile       *.txt set norelativenumber
augroup END

augroup Obj-C
    autocmd BufRead,BufNewFile       *.[cmh] colorscheme oceandeep
    autocmd BufRead,BufNewFile       *.[cmh] so ~/.vim/cocoa.vim/plugin/cocoa.vim
augroup END

augroup pptx
    autocmd BufRead,BufNewFile       outline.txt set noexpandtab
    autocmd BufRead,BufNewFile       outline.txt set fileformat=dos
augroup END 


if filereadable( $HOME."/.myconfigs/local/.vimrc" ) 
  so $HOME/.myconfigs/local/.vimrc
endif

set guioptions-=m
set guioptions-=T
"set guifont=Andale\ Mono\ 10
set guifont=Source\ Code\ Pro\ 11
set guioptions-=r

" Fix error highlighting in terminal
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline

" Better list
set listchars=tab:>.,trail:.,extends:#,nbsp:.,eol:$

" Better tabbing / completion
function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\"
    else
        if &omnifunc != ''
            return "\\"
        elseif &dictionary != ''
            return "\"
        else
            return "\"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>

execute pathogen#infect()
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
