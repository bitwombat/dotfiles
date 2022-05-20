" Wildmenu stuff

set wildmenu
set wildmode=longest:full,full

" If we've managed to upgrade to v8.2, enable the pop-up menu for
" completion on the vim command line (this has been what C-X C-F has done for a
" long time, but now in the command line).
" Note the version numbering is weird. 802 is indeed 8.2
if v:version >= 802
    set wildoptions=pum
endif

set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/__pycache__/*
set wildignore+=*/site-packages/*
" }}}

" vim:foldmethod=marker
