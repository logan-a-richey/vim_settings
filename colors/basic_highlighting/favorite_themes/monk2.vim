" ******************************************************************************
" Name:         monk2.vim
" Description:  Theme inspired sublime Monokai. 
"               Fun theme that recognizes namespaces and function signatures.
" Author:       Logan Richey
" Date:         Nov 11, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "monokai2"
set termguicolors

" ******************************************************************************
" Color Scheme
let s:gray1 = "#101010"
let s:gray2 = "#202020"
let s:gray3 = "#707070"
let s:blue = "#65d3ee"
let s:green = "#ade132"
let s:red = "#f2266c"
let s:purple = "#ab82ef"
let s:white = "#fafae0"
let s:yellow = "#e6db74"
let s:magenta = "#ff00ff"
let s:orange = "#ef7215"

" Mapping -> Color Mapping
let s:background_primary    = s:gray1
let s:background_secondary  = s:gray2
let s:comment               = s:gray3
let s:foreground            = s:white

" Mapping -> Keywords and Values
let s:keyword_control_flow  = s:red 
let s:keyword_type          = s:blue 
let s:number                = s:purple 
" let s:string                = s:yellow 
let s:string                = s:purple 

" Mapping -> Additional Highlights
let s:scope_highlight       = s:magenta 
let s:defclass              = s:green 
let s:namespace_color       = s:green 
" let s:function_call_color   = s:orange
let s:function_call_color   = s:yellow

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
    execute "highlight cppNamespace guifg=" . s:namespace_color
endfunction 

" Match any word preceeding a function
function! InitFunctionsSyntax() abort
    syntax match cppFunction "\<[A-Za-z_][A-Za-z0-9_]*\ze\s*("
    execute "highlight cppFunction guifg=" . s:function_call_color
endfunction

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    " Always init namespaces for all filetypes
    autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitFunctionsSyntax()
augroup END

call InitNamespaceSyntax()
call InitFunctionsSyntax()

