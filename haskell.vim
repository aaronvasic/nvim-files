" Haskell
" F1 show type
" F2 clear
" F3 show info
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

" gq to convert expression to point free form, possibly removing unnecesary
" variables
autocmd BufEnter *.hs set formatprg=pointfree
