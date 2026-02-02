" init.vim

" ==============================================================================
" Shortcuts

" Put yank and cut into system clipboard
set clipboard+=unnamedplus

" Set Caps Lock to ESC key
" execute 'setxkbmap -option caps:escape'

" Disable auto comment on endl
" :set formatoptions-=c formatoptions-=r formatoptions-=o
:set formatoptions-=cro

augroup NoAutoComment
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup end

" vim window change
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ==============================================================================
" --- Line numbers ---
set relativenumber  
set number          

set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

" --- Indentation ---
" set breakindent
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

