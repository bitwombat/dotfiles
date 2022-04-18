" lightline  {{{
let g:lightline = {
    \ 'colorscheme': 'bitwombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch' ],
    \             ['filename', 'readonly', 'modified' ],
    \           ],
    \   'right': [
    \             [ 'percent' ],
    \             [ 'lineinfo' ],
    \             [ 'fileformat', 'fileencoding', 'trailing' ],
    \            ],
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'filename': 'LightlineFilename',
    \   'gitbranch': 'fugitive#head',
    \   'fileformat': 'LightlineFileformat',
    \   'fileencoding': 'LightlineFileencoding',
    \ },
    \ }

function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:.')
  let ftype =  &filetype !=# '' ? &filetype : 'no ft'
  return fname . ' (' . ftype . ')'
endfunction

function! LightlineFileencoding()
  let encoding = &fenc !=# '' ? &fenc : &enc
  return encoding !=# 'utf-8' ? encoding : ''
endfunction

function! LightlineFileformat()
  return &fileformat !=# 'unix' ? &fileformat : ''
endfunction
let g:lightline.component_expand = {'trailing': 'lightline#trailing_whitespace#component'}
let g:lightline.component_type = {'trailing': 'error'}

" }}}
