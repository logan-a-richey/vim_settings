" ------------------------------------------------------------------------------
" Name:     vscode_dark.vim
" Info:     Inspired from VSCode minimal C++ theme.
" Author:   Logan Richey
" Date:     Nov 12, 2025
" ------------------------------------------------------------------------------

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "darkvs"
set termguicolors

" ------------------------------------------------------------------------------
" Main colors
let s:dark_gray = "#101010"
let s:mid_gray = "#282828"
let s:white = "#d4d4d4"
let s:orange = "#ce8f5e"
let s:blue = "#539ac5"
let s:green = "#579755"
let s:purple = "#c870d6"
let s:faint_green = "#b5ce9b"
let s:yellow = "#ffee8c"
let s:red = "#dd2211"
let s:cyan = "#4bc9b0"

" Mapping -> Main colors
let s:background_primary = s:dark_gray
let s:background_secondary = s:mid_gray
let s:comment = s:green
let s:foreground = s:white

" Mapping -> keywords and scope 
let s:keyword_control_flow = s:blue
let s:keyword_type = s:blue
let s:scope_highlight = s:purple

" Mapping -> values
let s:string = s:orange 
let s:number = s:faint_green

" Mapping -> Functions and Namespaces
let s:function = s:yellow " For function regex '\w+('
let s:defclass = s:yellow " For Python def/classname
let s:namespace = s:cyan " For words containing ::

" ------------------------------------------------------------------------------
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

" ------------------------------------------------------------------------------
" Code Syntax highlighting 
execute 'hi Comment guifg=' . s:comment . ' gui=italic'
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

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ------------------------------------------------------------------------------
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

