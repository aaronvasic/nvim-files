""Persistent Session if Session.vim is in dir
"function PersistSessionLeave()
"    if argc() == 0
"        if filewritable('Session.vim')
"            mksession!
"        endif
"    endif
"endfunction
"
"function PersistSessionEnter()
"    if argc() == 0
"        if filereadable('Session.vim')
"            source Session.vim
"        endif
"    endif
"endfunction
"
"augroup PersistSession
"au VimLeave * exec PersistSessionLeave()
"exec PersistSessionEnter()
"augroup end
