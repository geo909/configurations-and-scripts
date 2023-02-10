filetype plugin on
syntax on

" Vim-plug ==================================================================

set rtp+=~/.config/nvim/autoload
call plug#begin('~/.local/share/nvim/plugged')
Plug 'davidhalter/jedi-vim'
" deoplete-jedi requires pynvim (pacman -S python-pynvim)
" Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'sbdchd/neoformat'
Plug 'preservim/nerdtree'
Plug 'neomake/neomake'
Plug 'vim-scripts/YankRing.vim'
Plug 'plasticboy/vim-markdown'
Plug 'majutsushi/tagbar'
Plug 'kassio/neoterm'
Plug 'tmhedberg/SimpylFold'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'ebranlard/vim-simple-comment'
Plug 'freitass/todo.txt-vim'
Plug 'mattn/emmet-vim'
"Plug 'elzr/vim-json'
Plug 'thalesmello/tabfold'
Plug 'nathangrigg/vim-beancount'
" Plug 'lyokha/vim-xkbswitch' <- Check that out!
call plug#end()

" Basic options =============================================================

set timeoutlen=500              " (default 1000)
set number                      " turn on line numbers
set noerrorbells                " No noise
set expandtab                   " use spaces, not tabs
set tabstop=4                   " tabstops of 4
set shiftwidth=4                " indents of 4
set textwidth=0
set linebreak
set showmatch
set breakindent                 " For identation to visually wrapped lines
set autoindent smartindent      " turn on auto/smart indenting
set hidden                      " Be able to change buffer without saving
let mapleader = ","
set clipboard=unnamedplus       " Share clipboard between vim instances <- sudo pacman -S xclip
set foldlevelstart=99           " Do not fold when file launches
set encoding=utf-8
set splitright
set visualbell                  " This is actually for pycharm, otherwise it beeps 
 

" Terminal
"" Run xfce4-terminal on shortcut
nnoremap <a-t> :silent !xfce4-terminal &<cr>

" Neovim terminal
"" Map <Esc> to exit terminal-mode:
" tnoremap <Esc> <C-\><C-n>
" nnoremap <C-t> :Ttoggle<CR>
"" open terminal in bottom split
" let g:neoterm_default_mod='vertical'
" let g:neoterm_size=50
"" "" Scroll to the bottom when running a command
" let g:neoerm_autoscroll=1
" let g:neoterm_use_relative_path=1
"" "" Open terminal in insert mode by default
"" "" https://github.com/neovim/neovim/issues/8816
" let g:previous_window = -1
" function SmartInsert()
"  if &buftype == 'terminal'
"    if g:previous_window != winnr()
"      startinsert
"    endif
"    let g:previous_window = winnr()
"  else
"    let g:previous_window = -1
"  endif
"endfunction

"au BufEnter * call SmartInsert()

"" 
" Mappings ==================================================================

"" Easier buffer switching
nnoremap <leader>b :ls<CR>:b

"" jk instead of ESC for normal mode
" inoremap jk <Esc>/<+[0-9a-zA-Z]*+><CR>vf>c
" inoremap <Esc> <Esc>:echo "Esc is mapped to jk now"<CR>

"" Use space instead of :
nnoremap <Space> :
vnoremap <Space> :
nnoremap : :echo "Colon is mapped to space now"<CR>

" No case sensitive search
nnoremap <A-/> /\c

"" Edit and reload configuration file (this file)
function! Configinit()
    tabnew ~/.config/nvim/init.vim
endfunction
nnoremap <leader>c :call Configinit()<CR>

"" Source configuration file
nnoremap <C-s> :w<CR>:source ~/.config/nvim/init.vim<CR>:source ~/.config/nvim/plugin/colours.vim<CR>

"" Folding with tab
""" Need to check if that messes with ultisnip
" nnoremap <silent> <Tab> @=(foldlevel('.')?'za':"\<Tab>")<CR>
" vnoremap <Tab> zf

"" Moving between buffers
nnoremap <C-b>l <Esc>:bn<CR>
nnoremap <C-b>h <Esc>:bp<CR>
nnoremap <C-b>d <Esc>:bd<CR>
"""Delete buffer but keep split window
"""command Bd bp\|bd \#

"" Saving
inoremap <C-s> <Esc>:w!<CR>li

"" Replace selected; requires nvim/plugin/ReplaceVisual.vim
vnoremap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>//gc<left><left><left>

"" Clear highlight after search
nnoremap <silent> <esc> :noh<CR><esc>

"" Align block code
vnoremap < <gv
vnoremap > >gv

"" Tags
""" pacman -S tags
noremap <leader>a :TagbarToggle<CR>
""" Jump back from tag with 'g, by setting a 'g' mark before you jump
nnoremap <leader>g mg<leader>g


"" Windows
nnoremap <C-w>j <C-W><C-J>
nnoremap <C-w>k <C-W><C-K>
nnoremap <C-w>s <C-W><C-S>
nnoremap <C-w>v <C-W><C-V>
nnoremap <C-w>o <C-W><C-O>
nnoremap <C-w>l <C-W><C-L>
nnoremap <C-w>h <C-W><C-H>
nnoremap <C-w>q <C-W><C-q>

"" Tabs
nnoremap t :tabnext<CR>
nnoremap <s-t> :tabprevious<CR>
"""nnoremap <C-t>n :tabnew<CR>
"""noremap <C-t>c :tabclose<CR>

"" Resize windows
map <A-Left> <C-W><
map <A-Right> <C-W>>
map <A-Up> <C-W>+
map <A-Down> <C-W>-

"" NerdTree
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMapActivateNode='l'


"" Yankring and yanking:
let g:yankring_history_dir='$HOME/.config/nvim'
nnoremap <silent> yb :YRShow<CR> " Open YankRing Buffer
"let g:yankring_replace_n_pkey = 'yp'
"let g:yankring_replace_n_nkey = 'yn'

"" Ultisnips
" let g:UltiSnipsExpandTrigger="fj"
" let g:UltiSnipsJumpForwardTrigger="fj"
" let g:UltiSnipsJumpBackwardTrigger="<S-fj>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsEditSplit="vertical"

"" Jedi
""" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0
""" open the go-to function in split, not another buffer
""" No docstring popup
autocmd FileType python setlocal completeopt-=preview
"""let g:jedi#use_splits_not_buffers = "right"
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

"" Deoplete
let g:deoplete#enable_at_startup = 1
""" Cycle through options with tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
""" Splitbelow, otherwise very annoying window on top
"""set splitbelow

"" Neoformat
""" See also python ftplugin (Neoformat on save)
""" Enable alignment
let g:neoformat_basic_format_align = 1
""" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
""" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1


"" Enable python
""" https://jdhao.github.io/2019/04/22/mix_python_and_vim_script/
let g:python3_host_prog=expand('/usr/bin/python3')
let g:python_host_prog=expand('/usr/bin/python')

"" Greek ====================================================================
""" help 'langmap'
set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz

""" I wasn't using it, but keep it for future reference
set keymap=greek_utf-8
""" set keymap = greek_iso-8859-7
set iminsert=0
set imsearch=-1


" Comment plugin
nnoremap <silent> ,cg :call ToggleComment()<CR>
nnoremap <silent> ,cc :call Comment()<CR>
nnoremap <silent> ,cu :call UnComment()<CR>
nnoremap <silent> ,cl :call InsertLineComment() <cr>
nnoremap <silent> ,ci :call InsertMidComment() <cr>
nnoremap <silent> ,cw :call WrapComment() <cr>

" Json format
function JsonFormat()
:%!jq .
endfunction

" Json plugin: do not conceal double quotes
let g:vim_json_syntax_conceal = 0
