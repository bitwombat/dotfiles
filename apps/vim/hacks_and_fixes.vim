" Hacks and fixes {{{
" Fix error highlighting in terminal
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline

" Set the title of the screen window
if &term =~ "screen"
  set t_ts=k
  set t_fs=\
endif
if &term =~ "screen" || &term == "xterm" || &term == "xterm-256color"
  set title
endif
set titlestring=%{expand(\"%:t\")}

" Make background clearing work in GNU screen
set t_ut=
" }}}

" Tmux {{{
if exists('$TMUX')
    autocmd BufEnter,BufWrite * call system("tmux rename-window '" . expand("%:t") . "'")
    autocmd VimLeave * call system("tmux set-option -w automatic-rename on")
endif

" Fix theme's colour for the matching parens
"hi MatchParen ctermbg=52

" Fix theme's colour for search
"hi Search ctermbg=1

" Make the visual select much calmer
hi Visual term=none cterm=none ctermfg=LightYellow ctermbg=darkgrey
" }}}

" Prevent the delay on macos where the terminal sends the Esc, but vim waits to
" see if there's something else coming. This makes a delay when leaving Insert
" mode.
set ttimeoutlen=5

" vim:foldmethod=marker
