" by default, when overwriting, vim writes a backup,
" then deletes it once the overwrite is complete
" this is pointless since we will automatically
" create backups constantly (nowb turns it off)
set nowb

" Automatic Backups
set backup

" set backup dir
call Set_to_dir("&backupdir",g:__tmp_files_dir."/backup/".strftime("%Y%m%d"))

"Create an extention for backup file like foo.rb.120039
let &backupext=strftime(".%H%M%S")
