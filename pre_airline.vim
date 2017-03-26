" Airline fancy design characters
let g:airline_powerline_fonts = 1

" dont let airline fuck with tmux
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#bufferline#enabled=0
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#csv#enabled=1
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#tabline#show_tabs=1
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#show_tab_nr=1
let g:airline#extensions#tabline#show_tab_type=1
let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
