" Ack {{{
" Run with :Ack
" Tell it to use ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack
" }}}
