" init.vim
" Basic vim setup

" Line numbers
set number
set relativenumber

" Smart indentation and tab settings
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Window toggling key remaps
" Use the following to navigate between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Disable arrow keys in Normal and Insert modes
"map <Up> <Nop>
"map <Down> <Nop>
"map <Left> <Nop>
"map <Right> <Nop>
"imap <Up> <Nop>
"imap <Down> <Nop>
"imap <Left> <Nop>
"imap <Right> <Nop>

" Clipboard settings
set clipboard=unnamedplus

" Syntax settings
syntax enable
colorscheme gedit_cobalt

