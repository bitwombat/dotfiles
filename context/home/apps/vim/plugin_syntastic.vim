" Syntastic {{{
" Shut up by default
let g:syntastic_mode_map = {}
let g:syntastic_mode_map['mode']='passive'

" General options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" PHP
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'

" JS
let g:syntastic_javascript_checkers=['eslint']

" Python
" W503 and W504 are mutually exclusive. We want a complaint for a newline after
" a binary operator, not before.
"let g:syntastic_python_flake8_args="--select=E,W --ignore=W503"

" CSS
let g:syntastic_css_csslint_args="--errors=known-properties,duplicate-background-images,duplicate-properties"

" }}}
