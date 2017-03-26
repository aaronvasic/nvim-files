
"" DISABLED: Editing Wrapped Lines {{{1
" this makes it confusing when you use relative line numbers, or really any
" line numbers because the specified motion wont be the same as the result if
" there are any wrapped lines
"" move up/down based on visual display, not actual file
"" this means j will move to the next part of the line if it wrapped around
"map j gj
"map k gk
"
" }}}1
