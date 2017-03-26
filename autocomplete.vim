" Autocompletion {{{1
if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
                                \ if &omnifunc == "" |
                                \       setlocal omnifunc=syntaxcomplete#Complete |
                                \ endif
endif
if ! exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
endif
if exists('g:loaded_neocomplete')
        let g:neocomplete#enable_at_startup = 1
endif

"}}}1
