" Neovim-qt
" Use the tui tabline instead
GuiTabline 0 
GuiFont Ubuntu Mono:h12:b

set mouse=a

" Paste with middle mouse click
vmap <LeftRelease> "*ygv

" Paste with <Shift> + <Insert>
imap <S-Insert> <C-R>*
inoremap <C-v> <C-R>*
