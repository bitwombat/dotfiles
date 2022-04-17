let g:ale_linters = {'haskell': ['hls'],
                 \ 'python': ['flake8']
                 \}
let g:ale_fixers= {'haskell': ['hlint'],
                 \ 'python': ['black', 'isort']
                 \}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_set_balloons=1
