" ******************************************************************************
" Name: openai.vim
" Description: Theme inspired by ChatGPT code snippet theme.
" Author: Logan Richey
" Date: Nov 12, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
     syntax reset
endif
let g:colors_name = "openai"
set termguicolors

" ******************************************************************************
" User Colors

let s:gray1 = '#101010' " for background 
let s:gray2 = '#202020' " for background current line
let s:gray3 = '#707070' " for comments
let s:white = '#e0e0e0' " for normal text
let s:blue = '#2e95d3' " for builtin keywords
let s:orange = '#e9950c' " for builtin functions
let s:green = '#06a27b' " for strings
let s:red = '#f22c3d' " for defname classname
let s:pink = '#df3079' " for numeric values

" Mapping -> Main colors
let s:background_primary = s:gray1
let s:background_secondary = s:gray2
let s:comment = s:gray3
let s:foreground = s:white

" Mapping -> Keywords and Scope
let s:keyword_control_flow = s:blue " keywords (if, not, return)
let s:keyword_type = s:blue " types (def, int, struct, etc.)
let s:scope_highlight = s:pink " highlighted parentheses

" Mapping -> Values
let s:number = s:pink
let s:string = s:green

" Mapping -> Functions and Namespaces
let s:function = s:orange
let s:defclass = s:red " def/class names
let s:namespace = s:red

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

execute 'hi Comment guifg=' . s:comment 
" . ' gui=italic'

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
execute 'hi Error guifg=' . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:keyword_control_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"

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
    execute "highlight cppFunction guifg=" . s:function
endfunction

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitFunctionsSyntax()
augroup END

call InitNamespaceSyntax()
call InitFunctionsSyntax()

