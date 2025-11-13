" ******************************************************************************
" Name: kimbie.vim
" Description: Theme inspired by Kimbie theme.
" Author: Logan Richey
" Date: Nov 12, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
     syntax reset
endif
let g:colors_name = "kimbie"
set termguicolors

" ******************************************************************************
" Color scheme 

let s:soot_brown = '#1f1305'
let s:magenta = '#fa3356'
let s:brown = '#b67b43'
let s:purple = '#aa6768'
let s:pink = '#ff3356'
let s:blue = '#75b3b1'
let s:orange = '#ff6517'
let s:green = '#809d2c'
let s:yellow = '#ff9c00'
let s:off_white = '#d8a777'
let s:bleached_silk = '#fff1de'
let s:dark_green = '#003b0e'


" Mapping -> Main colors
let s:background_primary = s:soot_brown
let s:background_secondary = s:dark_green
let s:comment = s:brown
let s:foreground = s:bleached_silk

" Mapping -> Keywords and Scope
let s:keyword_control_flow = s:pink " keywords (if, not, return)
let s:keyword_type = s:orange " types (def, int, struct, etc.)
let s:scope_highlight = s:green " highlighted parentheses

" Mapping -> Values
let s:number = s:yellow
let s:string = s:green

" Mapping -> Functions and Namespaces
let s:function = s:blue
let s:defclass = s:blue " def/class names
let s:namespace = s:purple

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

