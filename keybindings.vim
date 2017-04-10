" Keybindings

" Map Leader
"mapleader is \ by default
" this must be before mappings i think
let mapleader="z"

nnoremap gp `[v`]

map <M-Up> :FontInc
map <M-Down> :FontDec
map <F11> :ToggleBare
" execute buffer in bash
map <F5> :RunFile
map <F6> :InteractiveRunFile
" In-line math
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
" z* <Nop>
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


map z<Space> :noh

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

"Buffers
" list buffers
map <Leader>bb :Buffer
" select buffer
map <Leader>b<Leader> :Buffer
" next buffer
map <Leader>n :bn
map <Leader>bn :bn
" close buffer
map <Leader>bc :bdelete
" previous buffer
map <Leader>p :bp
map <Leader>N :bp
map <Leader>bN :bp

" list registers
map <Leader>r :registers

" list marks with 'm or mm
map <Leader>m :marks
map 'm :marks
map mm :marks

map  gf

" Tabs
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

" Git
map <Leader>hp <Plug>GitGutterPrevHunk
map <Leader>hN <Plug>GitGutterPrevHunk
map <Leader>hn <Plug>GitGutterNextHunk
map <Leader>hd <Plug>GitGutterPreviewHunk
map <Leader>hs <Plug>GitGutterStageHunk
map <Leader>hS <Plug>GitGutterRevertHunk
map <Leader>hr <Plug>GitGutterRevertHunk
map <Leader>hp <Plug>GitGutterPreviewHunk
map <Leader>gC :GitCommit
map <Leader>gP :GitPush
map <Leader>gp :GitPull
map <Leader>gc :GitCheckout
map <Leader>gs :GitStatus
map <Leader>gS :GitShow
map <Leader>gd :GitDiff


" plugins
map <Leader>pa yy:e ~/.config/nvim/plugins.vimGp


" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
