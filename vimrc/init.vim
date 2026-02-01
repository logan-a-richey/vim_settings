" init.vim

" ==============================================================================
" Shortcuts

" Put yank and cut into system clipboard
set clipboard+=unnamedplus

" Set Caps Lock to ESC key
" execute 'setxkbmap -option caps:escape'

" vim window change
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ==============================================================================
" Formatting

" Line numbers 
set relativenumber  
set number          
set wrap
set linebreak
set nolist
set breakindent

" Disable smart indentation
filetype plugin indent on
set smartindent
set smarttab
set expandtab
let s:my_spacing = 4
execute 'set shiftwidth=' . s:my_spacing
execute 'set tabstop=' . s:my_spacing
execute 'set softtabstop=' . s:my_spacing

" ==============================================================================
" Syntax

set nocursorline
syntax enable
colorscheme monokai

