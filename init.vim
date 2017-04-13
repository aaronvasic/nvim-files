let s:editor_root=expand("~/.config/nvim")
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim'
set nocompatible
call vundle#rc(s:editor_root . '/bundle')

" TODO: fix netrw permission changing bug

set background=light
let g:colorscheme='solarized'

let s:cwd=getcwd()
exec 'cd '.s:editor_root
source pre_plugins.vim
source plugins.vim
source post_plugins.vim
source constants.vim
source functions.vim
source autocomplete.vim
source backups.vim
source commands.vim
source debugging.vim
source keybindings.vim
source netrw.vim
source nvim.vim
source options.vim
source persist_session.vim
source programming.vim
source restorecursor.vim
source systemd.vim
source term.vim
source theme.vim
source title.vim
exec 'cd '.s:cwd


filetype plugin indent on

" vim: foldmethod=marker foldlevel=0
