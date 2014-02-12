set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"Features and settings
set autowrite
set complete+=k
set noerrorbells
colorscheme darkblue
set hlsearch
set ignorecase
set incsearch
set modeline
set ruler
set showmatch
set smartcase
set wrap
set expandtab

set noautoindent
set formatoptions=
set indentexpr=
set indentkeys=
set nosmartindent
set indentexpr=
filetype indent off

set ic
syntax on
hi Search ctermbg=4
hi Search ctermfg=7
hi Search cterm=bold
hi IncSearch ctermbg=4
hi IncSearch ctermfg=7
hi IncSearch cterm=NONE

colorscheme peachpuff

set backupdir=c:\\vim_backups


" Key mappings
map F gq}
map L @l
map <F1> :w<CR>
map <F7> :if exists("syntax_on") <Bar> syntax off <Bar> <CR> else <Bar> syntax on <Bar> endif <CR>
map ; :if exists("syntax_on") <Bar> syntax off <Bar> <CR> else <Bar> syntax on <Bar> endif <CR>
map <F6> :set invnumber<CR>
map , zA

if has("win32")
	source Z:\4_Greg\configs\vim_abbreviations.vim
else
	source /cygdrive/z/4_Greg/configs/vim_abbreviations.vim
endif

let g:CA = 1
function! CollapseToggle()
    if g:CA
        setl foldlevelstart=1
        let g:CA = 0
    else
        setl foldlevelstart=10
        let g:CA = 1
    endif
endfunction

imap <C-j> me?<<CR>lyt>'ea</<C-R>">

" Use Ctrl-C and Ctrl-V
" source $VIMRUNTIME/mswin.vim


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen

