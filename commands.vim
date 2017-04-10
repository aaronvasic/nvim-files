" Commands {{{1
command ToggleBare call ToggleBare()
command -bar Hexmode call ToggleHex()

command -count=0 Buffer call Buffer()
command -count=0 SetFoldLevel call SetFoldLevel()

" Sudo Write
" looks like nvim fixed !shell commands
"if has("nvim")
"        command W terminal sudo echo gaining root | w ! sudo tee % > /dev/null
"else
        command W w !sudo tee % > /dev/null
"endif

command GitCommit call GitCommit()
command GitPush call GitPush()
command GitPull call GitPull()
command GitCheckout call GitCheckout()
command GitDiff call GitDiff()
command GitShow call GitShow()
command GitStatus call GitStatus()

command RunFile call RunFile(&ft)
command InteractiveRunFile call InteractiveRunFile(&ft)
command FontInc call IncFontSize()
command FontDec call DecFontSize()
" }}}1
