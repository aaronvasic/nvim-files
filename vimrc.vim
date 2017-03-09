"Netrw #{{{1
" Fix for UTF-8 double-width characters
let g:netrw_xstrlen=0
"#}}}1
" Terminal settings {{{1
if ! has("gui_running")
        "Unpatched ST Compatibility {{{2
        "if $TERM == "st-256color" || $TERM == "st"
        "        " backspace with 
        "        set t_kb=
        "        " delete with 
        "        set t_kD=
        "endif "}}}2
        " clear termcap mode
        set t_ti= t_te=

"        if $TERM == "nebuchadnezzar"
"                set t_kD=
"        end
endif "}}}1
" Global constants {{{1
" if we are root, don't look at $HOME because when we use 'sudo vim' the
" $HOME var possibly stays the same even though we are really root
if $USER == "root"
        let g:__tmp_files_dir="/root/.vim/tmp"
else
        let g:__tmp_files_dir=$HOME."/.vim/tmp"
endif
let g:baremode=0
let g:font_size=8
let g:font="Source Code Pro for Powerline"
" }}}1
" Neovim {{{
if has("nvim")
        "we are running neovim
        "
"        syntax off
        "let $EDITOR="nvim --remote"
endif " }}}
" Functions {{{1
" Local {{{2
function s:mkdirtree(dir) "{{{3
" make directory tree
" and do not complain about errors
        try
                " make dir and parent directories
                call mkdir(a:dir,"p")
        catch
        endtry
endfunction " }}}3
function s:set_to_dir(var,dir) "{{{3
" Create directory tree if necessary,
" then set variable to specified directory
        call s:mkdirtree(a:dir)
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
        exec '!cd' fnameescape(ResolveCurrentFileDir()) '&&' 'git' a:cmd
endfunction        "}}}3
function GitCommit() "{{{3
        exec GitCmd('commit')
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
function RunFile(type) " {{{3
        let s:s=getpos('.')
        let s:l=line('.')
        let s:basic_cases={}
        let s:basic_cases["sh"] =       "bash -s"
        let s:basic_cases["ruby"] =     "env ruby - --"
"
        let s:matched = 0
        let s:fname=tempname()
        for s:ft in keys(s:basic_cases)
                if a:type == s:ft
                        let s:matched = 1
                        exec feedkeys('m"')
                        exec feedkeys(":w ! ")
                        exec feedkeys(s:basic_cases[s:ft])
                        exec feedkeys("")
                        break
                endif
        endfor
        if s:matched == 1
                return
        else
                echo "This file has no execution application associated."
        end
        call setpos('.',s:s)
endfunction "}}}3
"}}}2 }}}1
au CmdwinLeave * exec cursor("'".'"')
" Commands {{{1
command ToggleBare call ToggleBare()
command -bar Hexmode call ToggleHex()

command -count=0 Buffer call Buffer()
command -count=0 SetFoldLevel call SetFoldLevel()

" Sudo Write
if has("nvim")
        command W terminal sudo echo gaining root | w ! sudo tee % > /dev/null
else
        command W w !sudo tee % > /dev/null
endif

command GitCommit call GitCommit()
command GitDiff call GitDiff()
command GitShow call GitShow()
command GitStatus call GitStatus()

command RunFile call RunFile(&ft)
command FontInc call IncFontSize()
command FontDec call DecFontSize()
" }}}1
" Keybindings {{{
" Map Leader {{{2
"mapleader is \ by default
" this must be before mappings i think
let mapleader="z"
" }}}2
map <M-Up> :FontInc
map <M-Down> :FontDec
map <F11> :ToggleBare
" execute buffer in bash
map <F5> :RunFile
" In-line math {{{2
" TODO:
" - convert to function and grab/replace text more intelligently
" - insert mode version
" :ODOT
" answer on current line
vmap <F2> Iscale=10;gv!bc
nmap <F2> Biscale=10;vE!bc
" answer on next line
vmap <F3> yIscale=10;gv!bcgPi = 
nmap <F3> ByEiscale=10;vE!bcPa = 
" }}}2
" z* <Nop> {{{2
map za <Nop>
map za <Nop>
map zA <Nop>
map z<CR> <Nop>
map zd <Nop>
map zD <Nop>
map zE <Nop>
map zg <Nop>
map zG <Nop>
map zh <Nop>
map zH <Nop>
map zi <Nop>
map zl <Nop>
map zL <Nop>
map zm <Nop>
map zn <Nop>
map zN <Nop>
map z- <Nop>
map z. <Nop>
map zr <Nop>
map zug <Nop>
map zuG <Nop>
map zuw <Nop>
map zuW <Nop>
map zv <Nop>
map zw <Nop>
map zW <Nop>
map zx <Nop>
map zX <Nop>
map zF <Nop>
map zf <Nop>
" }}}2

noremap <Leader>F zf
map <Leader>f :SetFoldLevel

map <Leader>w 

" these two are because I use Ctrl-a for tmux,
" which messes up the default Ctrl-a/Ctrl-x setup
" so I think of it like changing the number left/right on a number line
" deincrement with Ctrl-h
map  
" increment with Ctrl-l
map  

"Buffers #{{{2
" list buffers
map <Leader>bb :Buffer
" select buffer
map <Leader>b<Leader> :Buffer
" next buffer
map <Leader>n :bn
map <Leader>bn :bn
" previous buffer
map <Leader>p :bp
map <Leader>N :bp
map <Leader>bN :bp
"}}}2

" list registers
map <Leader>r :registers

" list marks with 'm or mm
map <Leader>m :marks
map 'm :marks
map mm :marks

map  gf

" Tabs {{{2
map <Leader>tn :tabnew
map <Leader>tc :tabclose
map <Leader>tgg :tabfirst
map <Leader>tG :tablast
map <Leader>th :tabprevious
map <Leader>tl :tabnext
map <Leader>tH :tabmove -1
map <Leader>tL :tabmove +1
nmap <leader>t1 <Plug>AirlineSelectTab1
nmap <leader>t2 <Plug>AirlineSelectTab2
nmap <leader>t3 <Plug>AirlineSelectTab3
nmap <leader>t4 <Plug>AirlineSelectTab4
nmap <leader>t5 <Plug>AirlineSelectTab5
nmap <leader>t6 <Plug>AirlineSelectTab6
nmap <leader>t7 <Plug>AirlineSelectTab7
nmap <leader>t8 <Plug>AirlineSelectTab8
nmap <leader>t9 <Plug>AirlineSelectTab9
"}}}2

" Git {{{2
map <Leader>hp <Plug>GitGutterPrevHunk
map <Leader>hN <Plug>GitGutterPrevHunk
map <Leader>hn <Plug>GitGutterNextHunk
map <Leader>hd <Plug>GitGutterPreviewHunk
map <Leader>hs <Plug>GitGutterStageHunk
map <Leader>hS <Plug>GitGutterRevertHunk
map <Leader>hr <Plug>GitGutterRevertHunk
map <Leader>hp <Plug>GitGutterPreviewHunk
map <Leader>gC :GitCommit
map <Leader>gs :GitStatus
map <Leader>gS :GitShow
map <Leader>gd :GitDiff
" }}}2
" }}}
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
" TMUX {{{
"
" }}}
" Plugins {{{1
" Pre-loading options {{{2
" dont let airline fuck with tmux
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#bufferline#enabled=1
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
" I don't like the default git gutter bindings
let g:gitgutter_map_keys=0
let g:SuperTabMappingForward="<S-Tab>"
let g:SuperTabMappingBackward="<c-s-tab>"
" }}}
" }}}2
" GitGutter Preview on Top not Bottom {{{2
function! gitgutter#preview_hunk()
  if gitgutter#utility#is_active()
    silent write

    " construct a diff
    let diff_for_hunk = gitgutter#diff#generate_diff_for_hunk(0, 0)

    " preview the diff
    silent! wincmd P
    if !&previewwindow
      execute 'to ' . &previewheight . ' new'
      set previewwindow
    endif

    setlocal noro modifiable filetype=diff buftype=nofile bufhidden=delete noswapfile
    execute "%delete_"
    call append(0, split(diff_for_hunk, "\n"))

    wincmd p
  endif
endfunction
" }}}2
" Airline fancy design characters {{{2
"if exists("g:loaded_airline")
        let g:airline_powerline_fonts = 1
"endif
" was an if statement, but apparently
" the variable has to be set before we
" load the airline plugin
"}}}2
" Syntastic {{{2
if exists("g:loaded_syntastic_plugin")
        " auto open and close loc list (error window)
        let g:syntastic_auto_loc_list=1
        " set loc list height 3 so it's not so annoying
        let g:syntastic_loc_list_height=3
        " hide cmd window error since the loc window shows it
        let g:syntastic_echo_current_error = 0
        " don't check when quitting vim
        let g:syntastic_check_on_wq = 0
        " use sign column to show errors
        let g:syntastic_enable_signs = 1
endif

"}}}2
" Airline {{{2
" Sections {{{3
"        let g:airline_section_a       (mode, paste, iminsert)
"        let g:airline_section_b       (hunks, branch)
"        let g:airline_section_c       (bufferline or filename)
"        let g:airline_section_gutter  (readonly, csv)
"        let g:airline_section_x       (tagbar, filetype, virtualenv)
"        let g:airline_section_y       (fileencoding, fileformat)
"        let g:airline_section_z       (percentage, line number, column number)
"        let g:airline_section_warning (syntastic, whitespace)
" }}}3
" }}}2
" CSV"{{{2
let g:csv_highlight_column='y'
""}}}2
" }}}1
" File Beagle {{{
" by default maps <leader>f,
" I don't like that because I use
" z as leader and it overwrites zf
if (exists('g:did_filebeagle') && g:did_filebeagle)
    let g:filebeagle_suppress_keymaps = 1
    map <silent> -          <Plug>FileBeagleOpenCurrentBufferDir
endif
" }}}
" VIM Options {{{1
" File formats {{{2
set fileformats=unix,dos,mac
" }}}2
" Performance {{{2
" lazy redraw
set lazyredraw
" "}}}2
" Scrolling {{{2
" 7 lines above/below cursor while scrolling
set scrolloff=7
" }}}2
" Misc {{{2
set list
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
let &showbreak = "\u21aa "

"set ruler "this is pointless with airline
"}}}2
" "Secure" - Prevent random unexpected commands {{{2
set secure "}}}2
" laststatus {{{
set laststatus=2 "}}}
" Window/Buffer options {{{2
" Split vertically {{{3
set nosplitbelow
set splitright "}}}3

" Hide buffer when it's 'abandoned' {{{3
" otherwise you must force write/close when it's open
" (this is mostly helpful so that if syntastic shows errors, you can still easily quit)
set hidden "}}}3

"}}}2
" GUI options {{{2
if has("gui_running")
        " this makes it so commands will open inside GVIM
        " for example, now Git will work inside X11
        let $EDITOR="gvim"
        set guiheadroom=0
        " clear all options
        set guioptions=
        " 'a' Autoselect: {{{3
        " If present, then whenever VISUAL mode is started,
        " or the Visual area extended, Vim tries to become the owner of
        " the windowing system's global selection.  This means that the
        " Visually highlighted text is available for pasting into other
        " applications as well as into Vim itself.  When the Visual mode
        " ends, possibly due to an operation on the text, or when an
        " application wants to paste the selection, the highlighted text
        " is automatically yanked into the "* selection register.
        " Thus the selection is still available for pasting into other
        " applications after the VISUAL mode has ended.
        "     If not present, then Vim won't become the owner of the
        " windowing system's global selection unless explicitly told to
        " by a yank or delete operation for the "* register.
        " The same applies to the modeless selection.
        set guioptions+=a
        " }}}3
        " 'A' {{{3
        " Autoselect for the modeless selection.
        " Like 'a', but only applies to the modeless selection.
        " set guioptions+=A
        " }}}3
        "'P'{{{3
        "Like autoselect but using the "+ register instead of the "* register.
        set guioptions-=P
        "}}}3
        "'c'{{{3
        "Use console dialogs instead of popup dialogs for simple
        "choices.
        set guioptions-=c
        "}}}3
        "'e'{{{3
        "Add tab pages when indicated with 'showtabline'.
        "'guitablabel' can be used to change the text in the labels.
        "When 'e' is missing a non-GUI tab pages line may be used.
        "The GUI tabs are only supported on some systems, currently
        "GTK, Motif, Mac OS/X and MS-Windows.
        set guioptions-=e
        "}}}3
        "'f'{{{3
        "Foreground: Don't use fork() to detach the GUI from the shell
        "where it was started.  Use this for programs that wait for the
        "editor to finish (e.g., an e-mail program).  Alternatively you
        "can use "gvim -f" or ":gui -f" to start the GUI in the
        "foreground.  |gui-fork|
        "Note: Set this option in the vimrc file.  The forking may have
        "happened already when the |gvimrc| file is read.
        set guioptions+=f
        "}}}3
        "'i'{{{3
        "Use a Vim icon.  For GTK with KDE it is used in the left-upper
        "corner of the window.  It's black&white on non-GTK, because of
        "limitations of X11.  For a color icon, see |X11-icon|.
        set guioptions+=i
        "}}}3
        "'m'{{{3
        "Menu bar is present.
        set guioptions+=m
        "}}}3
        "'M'{{{3
        "The system menu "$VIMRUNTIME/menu.vim" is not sourced.  Note
        "that this flag must be added in the .vimrc file, before
        "switching on syntax or filetype recognition (when the |gvimrc|
        "                file is sourced the system menu has already been loaded; the
        "                ":syntax on" and ":filetype on" commands load the menu too).
        set guioptions-=M
        "}}}3
        "'g'{{{3
        "Grey menu items: Make menu items that are not active grey.  If
        "'g' is not included inactive menu items are not shown at all.
        "Exception: Athena will always use grey menu items.
        set guioptions+=g
        "}}}3
        "'t'{{{3
        "Include tearoff menu items.  Currently only works for Win32,
        "        GTK+, and Motif 1.2 GUI.
        set guioptions+=t
        "        }}}3
        "'T'{{{3
        "Include Toolbar.  Currently only in Win32, GTK+, Motif, Photon
        "        and Athena GUIs.
        set guioptions-=T
        "        }}}3
        "'r'{{{3
        "Right-hand scrollbar is always present.
        set guioptions-=r
        "        }}}3
        "'R'{{{3
        "Right-hand scrollbar is present when there is a vertically
        "        split window.
        set guioptions-=R
        "        }}}3
        "'l'{{{3
        "Left-hand scrollbar is always present.
        set guioptions-=l
        "        }}}3
        "'L'{{{3
        "Left-hand scrollbar is present when there is a vertically
        "        split window.
        set guioptions-=L
        "        }}}3
        "'b'{{{3
        "Bottom (horizontal) scrollbar is present.  Its size depends on
        "        the longest visible line, or on the cursor line if the 'h'
        "        flag is included. |gui-horiz-scroll|
        set guioptions-=b
        "        }}}3
        "'h'{{{3
        "Limit horizontal scrollbar size to the length of the cursor
        "        line.  Reduces computations. |gui-horiz-scroll|
        set guioptions-=h
        "
        "        }}}3
        "'v'{{{3
        "Use a vertical button layout for dialogs.  When not included,
        "        a horizontal layout is preferred, but when it doesn't fit a
        "        vertical layout is used anyway.
        set guioptions-=v
        "        }}}3
        "'p'{{{3
        "Use Pointer callbacks for X11 GUI.  This is required for some
        "        window managers.  If the cursor is not blinking or hollow at
        "        the right moment, try adding this flag.  This must be done
        "        before starting the GUI.  Set it in your |gvimrc|.  Adding or
        "        removing it after the GUI has started has no effect.
        set guioptions+=p
        "        }}}3
        "Toolbar settings {{{3
        "clear toolbar settings
        set toolbar=
        "icons
        "Toolbar buttons are shown with icons.
        set toolbar+=icons
        "text
        "Toolbar buttons shown with text.
        set toolbar-=text
        "horiz
        "Icon and text of a toolbar button are
        "horizontally arranged.  {only in GTK+ 2 GUI}
        set toolbar-=horiz
        "tooltips
        "Tooltips are active for toolbar buttons.
        set toolbar+=tooltips
        "}}}3
        exec SetFont()
endif "}}}2
" Clipboard {{{2
" Use system default clipboard for vim default clipboard
" (select/mouse3 not ctrl+c&v)
" DISABLED ... use "+yy, "+p "*dd , "*p , etc. instead...
" set clipboard=unnamed "}}}2
" Instant searching {{{2
set is "}}}2
" Mouse options {{{2
" Right mouse click does popup
set mousem=popup

" idk why this was vhr....
set mouse=a "vhr "}}}2
set ttymouse=xterm
" Autoread {{{2
" Reread a file that hasn't been changed locally if the disk version changes
set autoread "}}}2
" Format options {{{2
" reset format options
" default is tcq
set formatoptions=

" lots of things change the format options
" to override that, you have to use autocmd
augroup FormatOptions
        "t {{{3
        "Auto-wrap text using textwidth
        " no automatic formatting for normal text
        autocmd BufNewFile,BufRead * setlocal formatoptions-=t
        "}}}3
        "c {{{3
        "Auto-wrap comments using textwidth, inserting the current comment
        "leader automatically.
        "With 't' and 'c' you can specify when Vim performs auto-wrapping:
        "value action
        """no automatic formatting (you can use "gq" for manual formatting)
        ""t"automatic formatting of text, but not comments
        ""c"automatic formatting for comments, but not text (good for C code)
        ""tc"automatic formatting for text and comments
        "
        "}}}3
        "r {{{3
        "Automatically insert the current comment leader after hitting
        "<Enter> in Insert mode.
        "}}}3
        "o {{{3
        "Automatically insert the current comment leader after hitting 'o' or
        " do not automatically insert comment character
        " when inserting from normal via o & O
        autocmd BufNewFile,BufRead * setlocal formatoptions-=o
        "}}}3
        "q {{{3
        " Allow formatting of comments with "gq".
        "       Note that formatting will not change blank lines or lines containing
        "       only the comment leader.  A new paragraph starts after such a line,
        "       or when the comment leader changes.
        autocmd BufNewFile,BufRead * setlocal formatoptions+=q
        "}}}3
        "w {{{3
        "Trailing white space indicates a paragraph continues in the next line.
        "A line that ends in a non-white character ends a paragraph.
        "}}}3
        "a {{{3
        "Automatic formatting of paragraphs.  Every time text is inserted or
        "deleted the paragraph will be reformatted.  See |auto-format|.
        "When the 'c' flag is present this only happens for recognized
        "comments.
        "}}}3
        "n {{{3
        "When formatting text, recognize numbered lists.  This actually uses
        " recognize numbered lists
        autocmd BufNewFile,BufRead * setlocal formatoptions+=n
        "the 'formatlistpat' option, thus any kind of list can be used.  The
        "indent of the text after the number is used for the next line.  The
        "default is to find a number, optionally followed by '.', ':', ')',
        "']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
        "well together with "2".
        "Example: >
        "1. the first item
        "   wraps
        "2. the second item
        "When formatting text, use the indent of the second line of a paragraph
        "for the rest of the paragraph, instead of the indent of the first
        "line.  This supports paragraphs in which the first line has a
        "different indent than the rest.  Note that 'autoindent' must be set
        "too.  Example: >
        "first line of a paragraph
        "second line of the same paragraph
        "third line.
        "<This also works inside comments, ignoring the comment leader.
        "}}}3
        "v {{{3
        "Vi-compatible auto-wrapping in insert mode: Only break a line at a
        "blank that you have entered during the current insert command.  (Note:
        "this is not 100% Vi compatible.  Vi has some "unexpected features" or
        "bugs in this area.  It uses the screen column instead of the line
        "column.)
        "}}}3
        "b {{{3
        "Like 'v', but only auto-wrap if you enter a blank at or before
        " auto-wrap if there is a blank at or before wrap margin
        " ignores lines that are already too long,
        " or if you dont insert whitespace
        autocmd BufNewFile,BufRead * setlocal formatoptions+=b
        "the wrap margin.  If the line was longer than 'textwidth' when you
        "started the insert, or you do not enter a blank in the insert before
        "reaching 'textwidth', Vim does not perform auto-wrapping.
        "}}}3
        "l {{{3
        "Long lines are not broken in insert mode: When a line was longer than
        " try to break lines before one letter words rather than after
        autocmd BufNewFile,BufRead * setlocal formatoptions+=l
        "'textwidth' when the insert command started, Vim does not
        "automatically format it.
        "}}}3
        "m {{{3
        "Also break at a multi-byte character above 255.  This is useful for
        "Asian text where every character is a word on its own.
        "}}}3
        "M {{{3
        "When joining lines, don't insert a space before or after a multi-byte
        "character.  Overrules the 'B' flag.
        "}}}3
        "B {{{3
        "When joining lines, don't insert a space between two multi-byte
        "characters.  Overruled by the 'M' flag.
        "}}}3
        "1 {{{3
        "Don't break a line after a one-letter word.  It's broken before it
        "instead (if possible).
        "}}}3
        "j {{{3
        "Where it makes sense, remove a comment leader when joining lines.  For
        " delete comment leader when joining lines
        autocmd BufNewFile,BufRead * setlocal formatoptions+=j
        "}}}3
augroup END
" }}}2
" highlight the current line {{{2
set cursorline "}}}2
" Undo levels {{{2
" we have ram... allow many undos
set undolevels=512 "}}}2
" Cursor start of line behavior {{{2
" when moving the cursor, move to the real start
" rather than moving to the first non-whitespace
set nostartofline "}}}2
" Bells {{{2
" visual bell is really slow for some reason
" so disable it
set novb
set t_vb=

" just annoying
set noerrorbells

"}}}2
" "Virtual" Editing {{{2
" allow moving the cursor over non-characters
" when selecting blocks (so we can choose arbitrary blocks)
set virtualedit=block

" I used to have this as ve=onemore,block
" but when you are at the end of a line
" and hit x in normal mode, you can't trim off
" characters because the cursor will sit just
" past the real end of the line }}}2
" Indenting {{{2
" automatically indent new lines
" (based on syntax)
set smartindent

" auto indent new lines based on previous line
set ai

" tab = 8 spaces
set tabstop=8

" spaces for indentation >> <<
" (keep this the same as tabstop)
set shiftwidth=8

" allow backspace over: autoindent
set backspace+=indent

" use spaces instead of <Tab>
" whenever Tab is pressed or > and < commands are used
" CTRL-V<Tab> can insert a real tab
set expandtab

"}}}2
" History {{{2
" keep larger command history
set history=9001 "}}}2
" Backspace behavior {{{2
" allow backspace over:
" line breaks,
" where insert mode started
set backspace+=eol,start "}}}2
" Folding {{{2
" default to line folding based on file type (syntax)
set foldmethod=syntax

" foldlevel
" folds deeper than this are closed by default
set foldlevel=2

" fold level for new buffers
" -1 means disable
set foldlevelstart=2

set foldcolumn=0
"" DISABLED: Fold text (display) {{{3
"" right now i am disabling this
"" because it doesn't show enough info
"" ...i want to customize it when i have time
"fu! s:foldtext()
"        "get first non-blank line
"        let fs = v:foldstart
"        while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
"        endwhile
"        if fs > v:foldend
"                let line = getline(v:foldstart)
"        else
"        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
"        endif
"
"        let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
"        let foldSize = 1 + v:foldend - v:foldstart
"        let foldSizeStr = " " . foldSize . " lines "
"        let foldLevelStr = repeat("+--", v:foldlevel)
"        let lineCount = line("$")
"        let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
"        let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
"        return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
"endf
"set foldtext=s:foldtext()
""}}}3
"}}}2
" Temp Files {{{2
" Backups {{{3

" by default, when overwriting, vim writes a backup,
" then deletes it once the overwrite is complete
" this is pointless since we will automatically
" create backups constantly (nowb turns it off)
set nowb

" Automatic Backups
set backup

" set backup dir
call s:set_to_dir("&backupdir",__tmp_files_dir."/backup/".strftime("%Y%m%d"))

"Create an extention for backup file like foo.rb.120039
let &backupext=strftime(".%H%M%S")

"}}}3
" Persistent Undo {{{3
if has("persistent_undo")

        " set undo dir
        call s:set_to_dir("&undodir",__tmp_files_dir."/undo/")
        " enable undo files
        set undofile
endif
" }}}3
" Info Files {{{3
exec "let &viminfo=\"'1000,n".__tmp_files_dir."/info\""
" }}}3
" Views {{{3
set viewoptions=cursor,folds,options,slash
call s:set_to_dir("&vdir",__tmp_files_dir."/view")
" }}}3
" Swap Files {{{3
set swapfile
call s:set_to_dir("&dir",__tmp_files_dir."/swap")
" }}}3
"}}}2
" Command bar {{{2
" Show list of completions {{{3
set wildmenu
set wildmode=list:longest,full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

"
" " Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

"
" " Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

"
" " Disable temp and backup files
set wildignore+=*.swp,*~,._*

"}}}3
" display partially typed commands in the command bar
set sc

"}}}2
" Line Numbers {{{2
" show line numbers
set number

" Relative line numbers
set rnu

"}}}2
" Modeline {{{2
" load vim settings from file being edited
set modeline "}}}2
"}}}1
" Programming Languages {{{1
" Ruby {{{2
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

"}}}2
" Haskell {{{2
" F1 show type
" F2 clear
" F3 show info
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

" gq to convert expression to point free form, possibly removing unnecesary
" variables
autocmd BufEnter *.hs set formatprg=pointfree

"}}}2
"}}}1
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
" Remember editing position between sessions {{{1
" This should be at the end of vimrc
if has("autocmd")
        filetype plugin indent on
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
"}}}1
if &t_Co > 2 || has("gui_running") "{{{1
        "" Syntax {-{-{-1
        " This should be at the end of vimrc
        syntax on
        "" }-}-}-1
        " Solarized {{{2
        if $TERM != "linux"
                try
                        " set the colorscheme, then, the options,
                        " then, set the colorscheme again.
                        " if it fails the first time,
                        " no options will get set since
                        " it's in a :try block
                        colorscheme solarized
                        if ! has("gui_running")
                                let g:solarized_termtrans=1 " set to 1 if terminal has transparency
                                if $TERM == "xterm-256color"
                                        set t_Co=256
                                        let g:solarized_termcolors=256 " only set this to 256 if the terminal supports 256 colors but isn't using the solarized palette
                                else
                                        set t_Co=16
                                        let g:solarized_termcolors=16 " only set this to 256 if the terminal supports 256 colors but isn't using the solarized palette
                                endif
                                let s:background='dark'
                        else
                                let s:background='light'
                        endif
                        let &background=s:background
                        " ALSO: this must be done before colorscheme solarized
                        let g:solarized_contrast="normal"   "default value is normal
                        let g:solarized_visibility="normal"        "default value is normal
                        let g:solarized_hitrail=1         "default value is 0
                        let g:solarized_menu=1 "enable menu in gvim
                        let g:solarized_underline=1 "enable underlining
                        " this is stupid but you must set solarized options
                        " before choosing the colorscheme.
                        " I don't want to set the options
                        " if solarized is broken/missing though
                        colorscheme solarized
 "                       if ! has("gui_running")
 "highlight clear SignColumn " makes gitgutter more visible
                                highlight clear Folded " highlighted folds is ugly and unnecesary
                                highlight clear SignColumn
                                highlight clear CursorLineNr
                                highlight link CursorLineNr LineNr
                                highlight SignColumn ctermfg=white
                                highlight GitGutterAdd ctermfg=green
                                highlight GitGutterChange ctermfg=yellow
                                highlight GitGutterDelete ctermfg=red
                                highlight GitGutterChangeDelete ctermfg=yellow
 "                       endif
                catch /^Vim\%((\a\+)\)\=:E185/
                        " catch error E185
                        " (missing colorscheme)
                endtry
        endif
endif " }}}2 }}}1
" Systemd {{{
au BufNewFile,BufRead *.automount set filetype=systemd
au BufNewFile,BufRead *.mount     set filetype=systemd
au BufNewFile,BufRead *.path      set filetype=systemd
au BufNewFile,BufRead *.service   set filetype=systemd
au BufNewFile,BufRead *.socket    set filetype=systemd
au BufNewFile,BufRead *.swap      set filetype=systemd
au BufNewFile,BufRead *.target    set filetype=systemd
au BufNewFile,BufRead *.timer     set filetype=systemd
" }}}
" vim: foldmethod=marker foldlevel=0
