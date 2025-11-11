" ******************************************************************************
" Name:         stack_overflow.vim
" Description:  StackOverflow theme with function and object signatures.
" Author:       Logan Richey
" Date:         Nov 11, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "stack_overflow"
set termguicolors

" ******************************************************************************
" Color Scheme

" Main colors
let s:white = "#e0e0e0"
let s:white2 = "#c0c0c0"
let s:black = "#171717"
let s:gray2 = "#303030"
let s:gray = "#808080"
let s:magenta = "#ff00ff"

" Main 3 colors
let s:blue = '#00aeef'
let s:yellow = '#fff200'
let s:magenta = '#ec008c'

" Mapping -> Main colors
let s:background_primary = s:black
let s:background_secondary = s:gray2
let s:comment = s:gray
let s:foreground = s:white

" Mapping -> Keywords and Scope
let s:keyword_control_flow = s:blue 
let s:keyword_type = s:blue 
let s:scope_highlight = s:magenta 

" Mapping -> Values
let s:number = s:magenta
let s:string = s:magenta

" Mapping -> Functions and Namespaces
let s:function = s:yellow
let s:defclass = s:yellow 
let s:namespace = s:yellow

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
    syntax match cppFunction "\<[A-Za-z_][A-Za-z0-9_]*\ze\s*("
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

