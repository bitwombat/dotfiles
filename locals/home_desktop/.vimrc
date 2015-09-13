
" Use local vimrc if available {
    if filereadable(expand("$HOME/.myconfigs/.vimrc.basics"))
        source $HOME/.myconfigs/.vimrc.basics
    endif
" }

" Load matchit which makes % pay attention to HTML / XML tags
:source $VIMRUNTIME/macros/matchit.vim

colorscheme zenburn

" CtrlP Settings
let g:ctrlp_use_caching = 1
let g:ctrlp_working_path_mode = 0

" Omnifunc
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Better tabbing / completion
function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-N>"
        else
            return "\<C-N>"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

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

autocmd BufReadPost,FileReadPost *.yml  set tabstop=2

autocmd BufReadPost,FileReadPost *.cpp  syn region myFold start="{" end="}" transparent fold
autocmd BufReadPost,FileReadPost *.cpp  syn sync fromstart
autocmd BufReadPost,FileReadPost *.cpp  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.py  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.py  set keywordprg=pydoc
" Make the 81st column stand out
autocmd BufReadPost,FileReadPost *.py  highlight ColorColumn ctermbg=yellow
autocmd BufReadPost,FileReadPost *.py  call matchadd('ColorColumn', '\%81v', 100)


autocmd BufReadPost,FileReadPost *.h  set foldmethod=syntax

autocmd BufReadPost,FileReadPost *.html  set foldmethod=syntax

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

autocmd BufReadPost,FileReadPost *.css  set foldmethod=syntax
autocmd BufReadPost,FileReadPost *.css  set keywordprg=:help
autocmd BufReadPost,FileReadPost *.css  set iskeyword+=-


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
augroup END

augroup Obj-C
    autocmd BufRead,BufNewFile       *.[cmh] colorscheme oceandeep
    autocmd BufRead,BufNewFile       *.[cmh] so ~/.vim/cocoa.vim/plugin/cocoa.vim
    " Make the 81st column stand out
    autocmd BufRead,BufNewFile       *.[cmh] highlight ColorColumn ctermbg=yellow
    autocmd BufRead,BufNewFile       *.[cmh] call matchadd('ColorColumn', '\%81v', 100)
    autocmd BufRead,BufNewFile       *.[cmh] set foldmethod=syntax
augroup END

augroup pptx
    autocmd BufRead,BufNewFile       outline.txt set noexpandtab
    autocmd BufRead,BufNewFile       outline.txt set fileformat=dos
augroup END 

" Make it obvious in gvim when we have focus
" (unfortunately, this makes it re-fold the code on reentry)
":au FocusLost * syntax off
":au FocusGained * syntax on

set guioptions-=m
set guioptions-=T
"set guifont=Andale\ Mono\ 10
set guifont=Source\ Code\ Pro\ 11
set guioptions-=r
:amenu Edit.Paste\ from\ select  "*P


" Fix error highlighting in terminal
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline

" Better list
set listchars=tab:>.,trail:.,extends:#,nbsp:.,eol:$
" Someday when I switch to a better terminal program, try these
"set listchars=tab:↹·,extends:⇉,precedes:⇇,nbsp:␠,trail:␠,nbsp:␣

call pathogen#infect()

" Syntastic options
let g:syntastic_quiet_messages = { "level" : "warnings", "type": "style"}
let g:syntastic_python_checkers=['pyflakes', 'python']

" If we want to hear about unused imported packages in Python, 
" have to re-enable warnings
autocmd FileType python unlet g:syntastic_quiet_messages

let g:syntastic_css_csslint_args="--errors=known-properties,duplicate-background-images,duplicate-properties"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Vdebug options
let g:vdebug_options={}
let g:vdebug_options['port']=10000

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Vmath stuff
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" Turn off "INSERT" text at bottom, especially since airline shows that for us
set noshowmode
let g:airline_theme='molokai'
" Enable the list of buffers
" (colour theming goes away randomly and makes the text hard to visually
" separate)
" let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" These don't work - space between them - which the Airline FAQ
" says is a "complicated issue"
"let g:airline_powerline_fonts=1

    autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

" Temporary because of a bug
let NERDTreeDirArrows=0

