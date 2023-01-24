set colorcolumn=79
nnoremap <buffer> <leader>p :tabnew ~/.config/nvim/ftplugin/python.vim<CR>
nnoremap <buffer> <A-r> :w<cr>:!python %<cr>

augroup fmt
    autocmd!
    " autocmd BufWritePre *.py undojoin | Neoformat
    hi CustomPink ctermbg=205 guibg=hotpink guifg=black ctermfg=black
    call matchadd('CustomPink','TODO') 
    call matchadd('CustomPink','TODO:') 
augroup END

"" Neoterminal mappings

nnoremap <buffer> <leader>tl :<c-u>exec v:count.'Tclear'<cr>

""" Send current line and move down
nnoremap <buffer> <cr> :TREPLSendLine<cr>j

""" Send current selection
vnoremap <buffer> <cr> :TREPLSendSelection<cr> 

""" Clear terminal
nnoremap <buffer> <C-l> :<c-u>exec v:count.'Tclear'<cr> 

""" Execute the whole file
nnoremap <buffer> <C-k> :TREPLSendFile<cr><C-w><C-l>Gzt<C-w><C-h>

"" Neomake (code checking)
let g:neomake_python_enabled_makers = ['pylint']
""call neomake#configure#automake('nrwi', 500)

"nnoremap <buffer> <leader>1 :<silent>!tmux send-keys -t terminal1 clear
"
