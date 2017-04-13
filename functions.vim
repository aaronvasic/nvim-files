
" Functions {{{1
" Local {{{2
function Mkdirtree(dir) "{{{3
" make directory tree
" and do not complain about errors
        try
                " make dir and parent directories
                call mkdir(a:dir,"p")
        catch
        endtry
endfunction " }}}3
function Set_to_dir(var,dir) "{{{3
" Create directory tree if necessary,
" then set variable to specified directory
        call Mkdirtree(a:dir)
        exec "let ".a:var."=\"".a:dir."\""
endfunction " }}}3
" }}}2
" Global {{{2
function IncFontSize()
        let g:font_size=g:font_size+1
        exec SetFont()
endfunction
function DecFontSize()
        let g:font_size=g:font_size-1
        exec SetFont()
endfunction
function SetFont()
        let &guifont=g:font." ".g:font_size
        set columns=999
        set lines=999
endfunction
function ToggleBare()
        if g:baremode==0
                let g:baremode=1
                set nonumber
                set norelativenumber
                set laststatus=0
                GitGutterDisable
                set showtabline=0
        else
                let g:baremode=0
                set number
                set relativenumber
                set laststatus=2
                GitGutterDisable
                set showtabline=2
        endif
endfunction
function Buffer() " #{{{3
        if v:count == 0
                :buffers
        else
                exec 'buffer' v:count
        endif
endfunction "}}}3
function SetFoldLevel() " #{{{3
        let s:s=getpos('.')
        let s:l=line('.')
        if foldclosed(s:l) == -1
                foldclose
                let s:fc=1
        else
                let s:fc=0
        end
        if v:count == 0
                let s:lvl=''
        else
                let s:lvl=v:count
        endif
"        exec 's/\({{{\|}}}\)\d\?/\1'.s:lvl.'/'
        exec 's/\v\{{3}(\d)?(\_.{-})\}{3}(\1)/{{{'.s:lvl.'\2'.'}}}'.s:lvl
        if s:fc == 1
                foldopen
        endif
        call setpos('.',s:s)
endfunction "}}}3
function ResolveCurrentFileDir() "{{{3
        return fnamemodify(resolve(expand('%p')),':p:h')
endfunction        "}}}3
function GitCmd(cmd) "{{{3
        if has("nvim")
                enew
                exec 'cd '.fnameescape(ResolveCurrentFileDir())
                call termopen(['git',a:cmd])
                startinsert
                cd -
        else
                exec '!cd' fnameescape(ResolveCurrentFileDir()) '&&' 'git' a:cmd
        endif
endfunction        "}}}3
function GitCommit() "{{{3
        exec GitCmd('commit')
endfunction " }}}3
function GitPush() "{{{3
        exec GitCmd('push')
endfunction " }}}3
function GitPull() "{{{3
        exec GitCmd('pull')
endfunction " }}}3
function GitCheckout() "{{{3
        exec GitCmd('checkout')
endfunction " }}}3
function GitShow() "{{{3
        exec GitCmd('show')
endfunction " }}}3
function GitStatus() "{{{3
        exec GitCmd('status')
endfunction " }}}3
function GitDiff() "{{{3
        exec GitCmd('diff '.fnameescape(expand('%')))
endfunction " }}}3
function ToggleHex() "{{{3
        " hex mode should be considered a read-only operation
        " save values for modified and read-only for restoration later,
        " and clear the read-only flag for now
        let l:modified=&mod
        let l:oldreadonly=&readonly
        let &readonly=0
        let l:oldmodifiable=&modifiable
        let &modifiable=1
        if ! exists("b:editHex") || ! b:editHex
                let l:size=(( ( winwidth(0) - 10 ) / 3.5 ) - &nuw - 1)
                " save old options
                let b:oldft=&ft
                let b:oldbin=&bin
                " set new options
                setlocal binary " make sure it overrides any textwidth, etc.
                silent :e " this will reload the file without trickeries
                "(DOS line endings will be shown entirely )
                let &ft="xxd"
                " set status
                let b:editHex=1
                " switch to hex editor
                exec "%!xxd -c " . float2nr(l:size)
        else
                " restore old options
                let &ft=b:oldft
                if ! b:oldbin
                        setlocal nobinary
                endif
                " set status
                let b:editHex=0
                " return to normal editing
                exec "%!xxd -c " . float2nr(l:size)
        endif
        " restore values for modified and read only state
        let &mod=l:modified
        let &readonly=l:oldreadonly
        let &modifiable=l:oldmodifiable
endfunction " }}}3
function RestoreCursor()
    if line("'\"") > 1 && line("'\"") <= line("$")
        exe 'normal! g`"'
    endif
endfunction
