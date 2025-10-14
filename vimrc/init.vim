"===============================================================================
" Name: init.vim / .vimrc
" Description: Basic vim setup. Contains tab-stop logic and window navigation.

"===============================================================================
" Navigation

" Line numbers
set relativenumber  
set number          

" vim window change
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"===============================================================================
" Editing

" Any yanked and deleted lines are copied to system clipboard:
set clipboard+=unnamedplus

" Smart indentation:
filetype plugin indent on
set smartindent
set smarttab
set expandtab

let s:my_spacing = 4

execute 'set shiftwidth=' . s:my_spacing
execute 'set tabstop=' . s:my_spacing
execute 'set softtabstop=' . s:my_spacing

"===============================================================================
" Default Colorscheme

syntax enable
colorscheme darkvs

