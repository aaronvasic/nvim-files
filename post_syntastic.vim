
" Syntastic
if exists("g:loaded_syntastic_plugin")
        " auto open and close loc list (error window)
        let g:syntastic_auto_loc_list=1
        " set loc list height 3 so it's not so annoying
        let g:syntastic_loc_list_height=3
        " hide cmd window error since the loc window shows it
        let g:syntastic_echo_current_error = 0
        " don't check when quitting vim
        let g:syntastic_check_on_wq = 0
        " use sign column to show errors
        let g:syntastic_enable_signs = 1
endif
