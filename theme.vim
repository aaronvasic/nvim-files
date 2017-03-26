if &t_Co > 2 || has("gui_running")
        " Solarized
        if $TERM != "linux"
            if g:colorscheme == 'solarized'
                try
                        " set the colorscheme, then, the options,
                        " then, set the colorscheme again.
                        " if it fails the first time,
                        " no options will get set since
                        " it's in a :try block
                        colorscheme solarized
                        if ! has("gui_running")
                                let g:solarized_termtrans=1 " set to 1 if terminal has transparency
                                if $TERM == "xterm-256color"
                                        set t_Co=256
                                        let g:solarized_termcolors=256 " only set this to 256 if the terminal supports 256 colors but isn't using the solarized palette
                                else
                                        set t_Co=16
                                        let g:solarized_termcolors=16 " only set this to 256 if the terminal supports 256 colors but isn't using the solarized palette
                                endif
                                let s:background='dark'
                        else
                                let s:background='dark'
                        endif
                        let &background=s:background
                        " ALSO: this must be done before colorscheme solarized
                        let g:solarized_contrast="normal"   "default value is normal
                        let g:solarized_visibility="normal"        "default value is normal
                        let g:solarized_hitrail=1         "default value is 0
                        let g:solarized_menu=1 "enable menu in gvim
                        let g:solarized_underline=1 "enable underlining
                        " this is stupid but you must set solarized options
                        " before choosing the colorscheme.
                        " I don't want to set the options
                        " if solarized is broken/missing though
                        colorscheme solarized
 "                       if ! has("gui_running")
 "highlight clear SignColumn " makes gitgutter more visible
                                highlight clear Folded " highlighted folds is ugly and unnecesary
                                highlight clear SignColumn
                                highlight clear CursorLineNr
                                highlight link CursorLineNr LineNr
                                highlight SignColumn ctermfg=white
                                highlight GitGutterAdd ctermfg=green
                                highlight GitGutterChange ctermfg=yellow
                                highlight GitGutterDelete ctermfg=red
                                highlight GitGutterChangeDelete ctermfg=yellow
 "                       endif
                catch /^Vim\%((\a\+)\)\=:E185/
                        " catch error E185
                        " (missing colorscheme)
                endtry
            else
                exec 'colorscheme '.g:colorscheme
            endif
        endif
endif
