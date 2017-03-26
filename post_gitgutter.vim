" GitGutter Preview on Top not Bottom
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
