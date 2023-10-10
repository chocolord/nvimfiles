setlocal tabstop=2
setlocal shiftwidth=2

inoremap <M-g> **
inoremap <M-i> *
inoremap <M-c> `

nnoremap + :s/^/#<CR>
nnoremap - :s/^#//<CR>
