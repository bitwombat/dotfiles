" gutentags {{{
let g:gutentags_ctags_exclude = [
    \ '*/node_modules',
    \ '*/vendor',
    \ '*.json',
    \ '*/content',
    \ '*/site-packages',
    \ '*/include/site'
    \ ]
let g:gutentags_exclude_project_root=['/home/gbell2', '/home/gbell2/.config', '/data/home/gbell2']
"let g:gutentags_define_advanced_commands=1
"let g:gutentags_trace=1
let g:gutentags_add_default_project_roots=1
"let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

augroup MyGutentagsStatusLineRefresher
            autocmd!
            autocmd User GutentagsUpdating call lightline#update()
            autocmd User GutentagsUpdated call lightline#update()
augroup END
" }}}
