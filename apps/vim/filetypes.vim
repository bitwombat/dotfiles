augroup haskell
    au!
    autocmd BufNewFile,BufReadPost *.hs  set tabstop=2
    autocmd BufNewFile,BufReadPost *.hs  set softtabstop=2
    autocmd BufNewFile,BufReadPost *.hs  set shiftwidth=2
    autocmd BufNewFile,BufReadPost *.hs  set smartindent
    autocmd BufNewFile,BufReadPost *.hs  set autoindent
augroup END

augroup ruby
    au!
    autocmd BufNewFile,BufReadPost *.rb  set tabstop=2
    autocmd BufNewFile,BufReadPost *.rb  set softtabstop=2
    autocmd BufNewFile,BufReadPost *.rb  map Q :w<CR>:!clear;ruby %<CR>
augroup END

augroup yml
    au!
    autocmd BufNewFile,BufReadPost *.yml,*.cabal  set tabstop=4
    autocmd BufNewFile,BufReadPost *.yml,*.cabal  set shiftwidth=4
    autocmd BufNewFile,BufReadPost *.yml,*.cabal  set softtabstop=4
    autocmd BufNewFile,BufReadPost *.yml,*.cabal  set nofoldenable
augroup END

"autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

augroup python
    au!
    autocmd BufNewFile,BufReadPost *.py  set foldmethod=syntax
    "autocmd BufNewFile,BufReadPost *.py  set keywordprg=pydoc
    autocmd BufNewFile,BufReadPost *.py  set keywordprg=pyzeal
    " Disable warnings from pytest, otherwise libraries using deprecated python
    " clutter up the output.
    autocmd BufNewFile,BufReadPost *.py  nnoremap Q :w<CR>:!clear;cd $VIRTUAL_ENV;python -m pytest --disable-warnings -vv tests<CR>
    autocmd BufNewFile,BufReadPost *.py  nnoremap W :w<CR>:!clear;python %<CR>
    " Make the 88st column stand out - matches Black's default.
    autocmd BufNewFile,BufReadPost *.py  highlight ColorColumn ctermbg=yellow
    autocmd BufNewFile,BufReadPost *.py  call matchadd('ColorColumn', '\%88v', 100)
augroup END

" HTML tag closing
autocmd FileType html inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>
autocmd FileType html inoremap <lt>/ </<C-x><C-o><Esc>==gi
" Without the fileytype=html, =G reformatting doesn't work, even though
" filetype seems to get set to html without it.
augroup html
    au!
    autocmd BufNewFile,BufReadPost *.html,*.phtml
        \ set sw=2 |
        \ set foldmethod=syntax |
        \ set filetype=html |
        \ let g:indentLine_enabled=1 |
        \ abbreviate sph <?php |
        \ abbreviate eph ?>
augroup END

augroup svelte
    au!
    au! BufNewFile,BufRead *.svelte set ft=html
augroup END

" /usr/share/vim/vim74/syntax/markdown.vim calls javascript.vim which sets
" foldmethod to syntax.  Set it back to what ftplugin/markdown.vim needs to
" work right.
let g:markdown_folding=1
augroup markdown
    au!
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.md set foldmethod=expr
    autocmd BufNewFile,BufReadPost *.md let g:markdown_folding=1
    "autocmd BufNewFile,BufReadPost *.md iab `h <Left>```haskell<CR>```<Up><End><CR>
    autocmd BufNewFile,BufReadPost *.md inoremap <buffer> `h ```haskell<CR>```<Esc><Up>A<CR>
    autocmd BufNewFile,BufReadPost *.md iab `l λ>
    autocmd BufNewFile,BufReadPost *.md hi clear SpellBad
    autocmd BufNewFile,BufReadPost *.md hi SpellBad ctermbg=Red
augroup END

augroup css
    au!
    autocmd BufNewFile,BufReadPost *.css  set foldmethod=syntax
    autocmd BufNewFile,BufReadPost *.css  set keywordprg=:help
    autocmd BufNewFile,BufReadPost *.css  set iskeyword+=-
augroup END

augroup pptx
    au!
    autocmd BufNewFile,BufReadPost       outline.txt set noexpandtab
    autocmd BufNewFile,BufReadPost       outline.txt set fileformat=dos
    autocmd BufNewFile,BufReadPost       outline.txt iunmap <Tab>
augroup END

augroup cpp
    au!
    autocmd BufNewFile,BufReadPost *.h  set foldmethod=syntax
    autocmd BufNewFile,BufReadPost *.cpp  syn region myFold start="{" end="}" transparent fold
    autocmd BufNewFile,BufReadPost *.cpp  syn sync fromstart
    autocmd BufNewFile,BufReadPost *.cpp  set foldmethod=syntax
augroup END

let g:php_folding=1
augroup php
    au!
    autocmd BufNewFile,BufReadPost *.php  abbreviate sph <?php
    autocmd BufNewFile,BufReadPost *.php  abbreviate eph ?>
    autocmd BufNewFile,BufReadPost *.php  nnoremap <silent><buffer> K <Esc>:silent! call system("phpdoc " . expand('<cword>'))<CR>
augroup END

let g:javaScript_fold=1
augroup js
    au!
    autocmd BufNewFile,BufReadPost *.js set foldmethod=syntax
    autocmd BufNewFile,BufReadPost *.js set tabstop=2
    autocmd BufNewFile,BufReadPost *.js set autoindent
    autocmd BufNewFile,BufReadPost *.js set smartindent
    autocmd BufNewFile,BufReadPost *.js syn sync fromstart
    autocmd BufNewFile,BufReadPost *.js  map Q :w<CR>:!clear;jest<CR>
    autocmd BufNewFile,BufReadPost *.js  setlocal equalprg=prettier\ --stdin-filepath\ %
augroup END

augroup james
    au!
    autocmd BufNewFile,BufReadPost */deit/*.php set noexpandtab
    autocmd BufNewFile,BufReadPost */uf_checkout/*/src/*.php set noexpandtab
augroup END

augroup bookmarks
    au!
    autocmd VimLeavePre Bookmarks.txt call ClearRegs()
augroup END

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

" Leave a mark when you leave the buffer.
" So, you navigate away from the css, and can
" get back to it with 'C
augroup LastFileMark
  autocmd!
  autocmd BufLeave *.css  normal! mC
  autocmd BufLeave *.hs   normal! mH
  autocmd BufLeave *.js   normal! mJ
  autocmd BufLeave *.php  normal! mP
  autocmd BufLeave *.py   normal! mN
augroup END

au FileType mail call FT_mail()

" With this enabled, for some reason /usr/share/vim/vim81/syntax/javascript.vim
" gets called, which sets foldmethod=syntax, which hoses markdown folding
" (which must be foldmethod=expr)
"
" Perhaps this could be at the top of the file and prevent problems, or perhaps
" I just spent an hour and a half trying to figure out why the exact same file
" folded when it was located in some dirs, but not others.
"
"augroup EnglishFiles
"    autocmd!
"    autocmd BufNewFile,BufReadPost *notes/* call FT_english()

augroup HugoFiles
    autocmd!
    autocmd BufNewFile,BufReadPost *content/posts/* call FT_english()
    autocmd BufNewFile,BufReadPost *content/posts/* call FT_hugo()
    autocmd BufNewFile,BufReadPost *content/posts/* map Q :w<CR>:!hugo --cleanDestinationDir -s ../..<CR>
    autocmd BufNewFile,BufReadPost *content/posts/* set dict+=/www/0_personal_sites/notes/all_tags
    autocmd BufNewFile,BufReadPost *content/posts/* set iskeyword+=-
    autocmd BufNewFile,BufReadPost *content/posts/* set nospell
    autocmd BufNewFile,BufReadPost *content/posts/* command! HugoNewPost exec '!hugo new posts/' . expand("<cWORD>") . '.md'

function! FT_english()
    set textwidth=68
    setlocal spell spelllang=en_au
	normal Go
    syntax on
    iabbr il []({<< relref >>})<Esc>3ba
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
endfunction

function! FT_hugo()
    iabbr il []({<< relref >>})<Esc>3ba
endfunction

" From https://www.systutorials.com/vim-as-thunderbirds-external-editor-in-linux/
function! FT_mail()
    set nocindent
    set noautoindent
    set textwidth=68
    setlocal spell spelllang=en_au
    set fileencodings=iso8859-1,utf-8
	normal 6G
    syntax on
	startinsert
    iabbr  rg Regards,<CR>Greg Bell
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
endfunction

autocmd BufWritePre * call StripTrailingWhitespace()


