
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
set clipboard+=unnamedplus
" DISABLED ... use "+yy, "+p "*dd , "*p , etc. instead...
" set clipboard=unnamed "}}}2
" Instant searching {{{2
set is "}}}2
" Mouse options {{{2
" Right mouse click does popup
set mousem=popup

" idk why this was vhr....
set mouse=a "vhr "}}}2
"set ttymouse=xterm
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
set tabstop=4

" spaces for indentation >> <<
" (keep this the same as tabstop)
set shiftwidth=4

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
" Persistent Undo {{{3
if has("persistent_undo")

        " set undo dir
        call Set_to_dir("&undodir",__tmp_files_dir."/undo/")
        " enable undo files
        set undofile
endif
" }}}3
" Info Files {{{3
exec "let &viminfo=\"'1000,n".__tmp_files_dir."/info\""
" }}}3
" ShaDa {{{3
if has("nvim")
    exec "let &shada=\"h,%,'10000,n".__tmp_files_dir."/info\""
endif
" }}}3
" Views {{{3
set viewoptions=cursor,folds,options,slash
call Set_to_dir("&vdir",__tmp_files_dir."/view")
" }}}3
" Swap Files {{{3
set swapfile
call Set_to_dir("&dir",__tmp_files_dir."/swap")
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
