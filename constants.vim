" Global constants
" if we are root, don't look at $HOME because when we use 'sudo vim' the
" $HOME var possibly stays the same even though we are really root
if has("nvim")
    let g:__vimtmpdir=".local/share/nvim/tmp"
else
    let g:__vimtmpdir=".vim/tmp"
endif
if $USER == "root"
        let g:__tmp_files_dir="/root/".g:__vimtmpdir
else
        let g:__tmp_files_dir=$HOME."/".g:__vimtmpdir
endif
let g:baremode=0
let g:font_size=8
let g:font="Source Code Pro for Powerline"
