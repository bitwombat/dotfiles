" Line numbers

set number relativenumber

" When in insert mode, don't have relative numbers - not navigating
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &number | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if &number | set norelativenumber | endif
augroup END

" vim:foldmethod=marker
