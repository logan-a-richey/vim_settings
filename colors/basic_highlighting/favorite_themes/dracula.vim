" ******************************************************************************
" Name: dracula.vim
" Description: Theme inspired by Dracula theme.
" Author: Logan Richey
" Date: Nov 12, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
     syntax reset
endif
let g:colors_name = "dracula"
set termguicolors

" ******************************************************************************
" DRACULA Colors ... very spooky.
" Two variations of each color; a bright and a dark version for each color.

let s:black1 	= '#282a36'
let s:black2 	= '#1d1e27'
let s:gray1 	= '#44475a'
let s:gray2 	= '#2e303d'
let s:white1 	= '#f7f7f1'
let s:white2 	= '#adada9'
let s:green1 	= '#4ff87a'
let s:green2 	= '#3dbe5d'
let s:orange1 	= '#feb86c'
let s:orange2 	= '#b8844e'
let s:pink1 	= '#ff79c6'
let s:pink2 	= '#cc609e'
let s:purple1 	= '#bb92f7'
let s:purple2 	= '#8b6db8'
let s:blue1 	= '#6272a4'
let s:blue2 	= '#4d5a81'
let s:red1 	    = '#ff5555'
let s:red2 	    = '#a33636'
let s:yellow1 	= '#dae282'
let s:yellow2 	= '#b6be6a'
let s:cyan1 	= '#8be8fc'
let s:cyan2 	= '#6fbaca'

" Mapping -> Main colors
let s:background_primary = s:black2
let s:background_secondary = s:gray1
let s:comment = s:blue1
let s:foreground = s:white1

" Mapping -> Keywords and Scope
let s:keyword_control_flow = s:pink1 " keywords (if, not, return)
let s:keyword_type = s:cyan1 " types (def, int, struct, etc.)
let s:scope_highlight = s:pink1 " highlighted parentheses

" Mapping -> Values
let s:number = s:purple1
let s:string = s:yellow1

" Mapping -> Functions and Namespaces
let s:function = s:green1
let s:defclass = s:green1 " def/class names
let s:namespace = s:orange1

" ******************************************************************************
" UI Elements

execute 'hi Normal guifg=' . s:foreground . ' guibg=' . s:background_primary
execute 'hi CursorLine guibg=' . s:background_secondary
execute 'hi CursorLineNr guifg=' . s:keyword_type
execute 'hi LineNr guifg=' . "#444444"
execute 'hi Visual guibg=' . "#49483E"
execute 'hi Search guifg=' . s:background_primary . ' guibg=' . s:keyword_type
execute 'hi IncSearch guifg=' . s:background_primary . ' guibg=' . s:keyword_control_flow
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg=' . "#3e3d32" . ' guibg=' . s:background_primary
execute 'hi StatusLine guifg=' . s:foreground . ' guibg=' . s:background_secondary
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:background_secondary

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ******************************************************************************
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment . ' gui=italic'

" covers char, string, numbers
execute 'hi Constant guifg=' . s:string 

execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:keyword_control_flow 
execute 'hi Keyword guifg=' . s:keyword_control_flow 
execute 'hi PreProc guifg=' . s:keyword_control_flow 
execute 'hi Type guifg=' . s:keyword_type 
execute 'hi Special guifg=' . s:number 
execute 'hi Error guifg=' . '#ffffff' . ' guibg=#b02752'
execute 'hi Todo guifg=' . '#ffffff' . ' guibg=#a08916'

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
    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight cppNamespace guifg=' . s:namespace
endfunction 

" Match any word preceeding a function
function! InitFunctionsSyntax() abort
    " syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze\s*('
    syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight cppFunction guifg=' . s:function
endfunction

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitFunctionsSyntax()
augroup END

call InitNamespaceSyntax()
call InitFunctionsSyntax()

