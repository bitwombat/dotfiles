" Keys {{{

set pastetoggle=<F2>

noremap <F7> :if exists("syntax_on") <Bar> syntax off <Bar> <CR> else <Bar> syntax on <Bar> endif <CR>
noremap <F8> :if &ignorecase <Bar> set noic <Bar> <CR> else <Bar> set ic <Bar> endif <CR>
noremap <F9> :set list!<Bar>set list?<CR>

" Navigate location list
nnoremap ]j :lnext<CR>
nnoremap ]k :lprevious<CR>

" Navigate quickfix list
nnoremap [j :cn<CR>
nnoremap [k :cN<CR>

" Access plugins
nnoremap ,nt :NERDTree<CR>
nnoremap ,f :Files<CR>
noremap ,b :call MyBuffersList()<CR>
function MyBuffersList()
if exists("g:loaded_fzf")
    Buffers
else
    call feedkeys(":ls\<CR>:b\<SPACE>")
endif
endfunction

" Alternate implementations (thanks to zeraphel in #vim and http://ix.io/3yDz)
" function VimEnterPost() abort
"   if exists("g:loaded_fzf")
"     nnoremap ,b :Buffers<cr>
"   endif
" endfunction
"
"
" nnoremap ,b :ls<cr>:buffer<space>
" au VimEnter * call VimEnterPost()
"
"
"
" function Something() abort
"   if ! exists("g:loaded_fzf")
"     Buffers
"   else
"     ls
"     exe 'buffer' . input(':b ','','buffer')
"   endif
" endfunction

nnoremap ,cd :cd %:h<CR>:pwd<CR>

" Buffers
nnoremap ,k :bnext<CR>
nnoremap ,j :bprevious<CR>
nnoremap ,, :e #<CR>

" tabbable list of buffers
set wildcharm=<C-z>
nnoremap ,B :buffer <C-z><S-Tab>
nnoremap ,B :sbuffer <C-z><S-Tab>

" Tabs
nnoremap ,tk :tabnext<CR>
nnoremap ,tj :tabprevious<CR>
nnoremap ,tc :tabclose<CR>
nnoremap ,tn :tabnew<CR>

" Clipboard
noremap ,c "+y
noremap ,p "+p
noremap ,P "+P
" Copy the entire buffer to the system clipboard (like Ctrl-A)
noremap ,a <Esc>gg"+yG

" Replace the current word and all its occurrences. (Global Change)
nnoremap ,C :%s/<C-r>0//g<Left><Left>
vnoremap ,C y:%s/<C-r>0//g<Left><Left>

" Move to match with tab
nnoremap <tab> %
vnoremap <tab> %

" Escape from insert mode with jj
inoremap jj <ESC>

" Move screen line instead of buffer line
nnoremap <C-J> gj
nnoremap <C-K> gk

" Ctrl-C in insert mode opens up a line - for inside things like {}
inoremap <C-c> <CR><Esc>O<Tab>

" Replace the next space with a newline
nnoremap ,J f xi<CR><Esc>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Fixing
nnoremap F gq}
nnoremap T :%s/  *$//g<CR>

" Macroing
nnoremap L @l

" Stay centred
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
" inoremap , ,<c-g>u
" inoremap . .<c-g>u
" inoremap [ [<c-g>u
" inoremap ! !<c-g>u
" inoremap ? ?<c-g>u

" Moving visually
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Saving
noremap <F1> :update<CR>
inoremap <F1> <ESC>:update<CR>a
noremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>a

" Quitting
" closes current window and exit if last window (unlike Ctrl-W C).
nnoremap <C-d> :q<CR>

" Folding
noremap U zA
"noremap , za

" Ctrl-A and Ctrl-E work as they do on the command line
noremap <C-a> ^
noremap <C-e> $
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]

" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv

" Remove the highlighting from the search
nnoremap <silent> <BS>  :nohlsearch<CR>

" Splitting
noremap <C-w>- :split<cr>
noremap <C-w>\| :vsplit<cr>

" Change cw and dw to know about camelCase and underscores
" Problem with this is the hlsearch options highlights a bunch of stuff in the
" file since we're using /.  Didn't find a "non-saved" / in vim.
" Installed https://github.com/chaoren/vim-wordmotion  which seems to work
" but not with PhpStorm's Vim plugin.
"map cw c/\u\\|[^0-9A-Za-z_]<CR>
"map dw d/\u\\|[^0-9A-Za-z_]<CR>
" }}}

" vim:foldmethod=marker
