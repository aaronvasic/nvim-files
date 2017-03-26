
" Debugging {{{1
" PROFILING {{{2
if $PROFILING == 'true' || $PROFILING == 'on' || $PROFILING == 'yes'
        profile start ./vim-profile
        profile func *
        profile file *
endif
"}}}2
" VERBOSE {{{2
if $VERBOSE == 'true' || $VERBOSE == 'on' || $VERBOSE == 'yes'
        set verbose=1
        set verbosefile=vim-debug
endif
if $VERBOSE > 0
        let &verbose=$VERBOSE
        set verbosefile=vim-debug
endif
"}}}2
"}}}1
