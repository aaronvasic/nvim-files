let s:editor_root=expand("~/.config/nvim")
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim/'
set nocompatible
call vundle#rc(s:editor_root . '/bundle')

Plugin 'scrooloose/syntastic'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'airblade/vim-gitgutter'
Plugin 'dynamotn/csv.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-commentary'
Plugin 'vim-scripts/vim-gnupg'
Plugin 'vim-scripts/Hoogle'
Plugin 'jpalardy/vim-slime'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'bitc/vim-hdevtools'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vinegar'

set expandtab
set tabstop=4
set shiftwidth=4

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set undodir=~/.config/nvim/undo/
set undofile

set ruler

set scrolloff=10

autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

