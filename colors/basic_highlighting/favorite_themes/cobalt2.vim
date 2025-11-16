" ******************************************************************************
" Name: cobalt.vim
" Description: Theme inspired by blue theme from Gedit
" Author: Logan Richey
" Date: Oct 7, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "cobalt"
set termguicolors

" ******************************************************************************
" User Colors

let s:blue1 = "#001b33" " bg 
let s:blue2 = "#003b70" " current row
let s:blue3 = "#0086e0" " comments
let s:green = "#28d300" " strings
let s:orange = "#ff9c05" " keywords
let s:cyan = "#5df8b8" " types
let s:red = "#dc0043" " scalars
let s:pink = "#dd00dd" " special
let s:white = "#cccccc" " normal text
let s:yellow = "#ffdd00" " other
let s:purple = "#4b0082" " classdef

" Mapping -> Main colors
let s:background_primary = s:blue1
let s:background_secondary = s:blue2
let s:comment = s:blue3
let s:foreground = s:white

" Mapping -> Keywords and Scope
let s:keyword_control_flow = s:orange " keywords (if, not, return)
let s:keyword_type = s:orange " types (def, int, struct, etc.)
let s:scope_highlight = s:yellow " highlighted parentheses

" Mapping -> Values
let s:number = s:red " numbers
let s:string = s:green 
let s:special = s:pink

" Mapping -> Functions and Namespaces
let s:defclass = s:cyan " def/class names
let s:function_name = s:cyan
let s:namespace = s:cyan 

" ******************************************************************************
" UI Elements

execute 'hi Normal guifg=' . s:foreground . ' guibg=' . s:background_primary
execute 'hi CursorLine guibg=' . s:background_secondary
execute 'hi CursorLineNr guifg=' . s:keyword_type
execute 'hi LineNr guifg=' . '#444444'
execute 'hi Visual guibg=' . '#49483E'
execute 'hi Search guifg=' . s:background_primary . ' guibg=' . s:keyword_type
execute 'hi IncSearch guifg=' . s:background_primary . ' guibg=' . s:keyword_control_flow
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=' . '#49483E'
execute 'hi VertSplit guifg=' . '#3e3d32' . ' guibg=' . s:background_primary
execute 'hi StatusLine guifg=' . s:foreground . ' guibg=' . s:background_secondary
execute 'hi StatusLineNC guifg=' . '#666666'. ' guibg=' . s:background_secondary

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ******************************************************************************
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment . ' gui=italic'

" covers char, string, numbers
execute 'hi Constant guifg=' . s:string . ' gui=bold'

execute 'hi String guifg=' . s:string . ' gui=bold'
execute 'hi Character guifg=' . s:string . ' gui=bold'
execute 'hi Number guifg=' . s:number . ' gui=bold'
execute 'hi Boolean guifg=' . s:number . ' gui=bold'
execute 'hi Identifier guifg=' . s:defclass . ' gui=bold'
execute 'hi Function guifg=' . s:defclass . ' gui=bold'
execute 'hi Statement guifg=' . s:keyword_control_flow . ' gui=bold'
execute 'hi Keyword guifg=' . s:keyword_control_flow . ' gui=bold'
execute 'hi PreProc guifg=' . s:keyword_control_flow . ' gui=bold'
execute 'hi Type guifg=' . s:keyword_type . ' gui=bold'
execute 'hi Special guifg=' . s:special . ' gui=bold'
execute 'hi Error guifg=' . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:keyword_control_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

" *****************************************************************************
" Language Specific and Advanced Tweaks

" Match any word containing :: and color the entire word.
function! InitNamespaceSyntax() abort
  syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
  execute "highlight cppNamespace guifg=" . s:namespace
endfunction 

" Match any word preceeding a function
function! InitFunctionsSyntax() abort
  " syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze\s*('
  syntax match cppFunction "\<[A-Za-z_][A-Za-z0-9_]*\ze("
  execute "highlight cppFunction guifg=" . s:function_name
endfunction

" Run OnStart
augroup MySyntaxTweaks
  autocmd!
  autocmd Syntax * call InitNamespaceSyntax()
  autocmd Syntax * call InitFunctionsSyntax()
augroup END

call InitNamespaceSyntax()
call InitFunctionsSyntax()

