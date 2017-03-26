" Ruby
" new regex is slow for ruby
set re=1
" disable expensive regex that
" highlights 'end' keyword based on context
let ruby_no_expensive = 1

" ruby.vim has it's own whitespace highlighting
" disable it since we have global space highlighting
let ruby_space_errors = 0

" enable folding based on ruby syntax
let ruby_fold = 1

" Guardfile is written in Ruby
au BufNewFile,BufRead Guardfile set filetype=ruby
au BufNewFile,BufRead *.cr set filetype=ruby
