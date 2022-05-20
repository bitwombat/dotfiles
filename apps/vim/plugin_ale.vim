if exists("g:loaded_ale")
    let g:ale_linters = {'haskell': ['hls'],
                     \ 'python': ['flake8', 'pyright']
                     \}
    let g:ale_fixers= {'haskell': ['hlint'],
                     \ 'python': ['black', 'isort'],
                     \ 'javascript': ['prettier', 'eslint']
                     \}

    let g:ale_fix_on_save = 1
    let g:ale_completion_enabled = 1
    "let g:ale_set_balloons = 1
    let g:ale_cursor_detail = 1
    let g:ale_echo_delay = 500
    let g:ale_linters_explicit = 1
    let g:ale_sign_error = '⚠'
    let g:ale_sign_warning = '⚐'
    let g:ale_floating_preview = 1

    let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

    augroup ale_hover_cursor
          autocmd!
            autocmd CursorHold * ALEHover
    augroup END

    " Keymaps
    nnoremap <silent> ,ld :ALEGoToDefinition<cr>
    nnoremap <silent> ,le <Cmd>lopen<CR>
    nnoremap <silent> ,lr <Cmd>ALERename<CR>
    nnoremap <silent> ,la <Cmd>ALECodeAction<CR>
    nnoremap <silent> ,lf <Cmd>ALEFix<CR>
    nnoremap <silent> ,lh <Cmd>ALEHover<CR>
    nnoremap <silent> ,li <Cmd>ALEInfo<CR>
    nnoremap <silent> ,] <Cmd>ALEPrevious<CR>
    nnoremap <silent> ,] <Cmd>ALENext<CR>
endif
