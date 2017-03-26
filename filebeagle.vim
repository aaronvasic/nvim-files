
" File Beagle {{{
" by default maps <leader>f,
" I don't like that because I use
" z as leader and it overwrites zf
if (exists('g:did_filebeagle') && g:did_filebeagle)
    let g:filebeagle_suppress_keymaps = 1
    map <silent> -          <Plug>FileBeagleOpenCurrentBufferDir
endif
" }}}
