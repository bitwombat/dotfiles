" vim-illuminate {{{
" make the highlighted word underlined - much easier to see
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
    augroup END
" }}}


" vim:foldmethod=marker
