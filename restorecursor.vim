" Remember editing position between sessions
"
" This should be at the end of vimrc
au CmdwinLeave * exec cursor("'".'"')
if has("autocmd")
   autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
endif
