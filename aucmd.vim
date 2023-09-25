
augroup relative_num
autocmd! InsertEnter * set norelativenumber
autocmd! InsertLeave * set relativenumber
augroup END

augroup dont_list_qf
autocmd! FileType qf set nobuflisted
augroup END
