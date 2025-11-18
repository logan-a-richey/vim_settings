" ==============================================================================
" Name:         gsolar.vim
" Description:  Theme inspired by Solarized. Gedit variation.
" Author:       Logan Richey
" Date:         Nov 16, 2025
" ==============================================================================

" Reset previous theme settings
hi clear
if exists("syntax_on")
     syntax reset
endif
let g:colors_name = "gsolar"
set termguicolors

" ==============================================================================
" User Colors

let s:dark_gray = '#101010'
let s:turq1 = '#002b36'
let s:turq2 = '#073642'
let s:gray = '#586e75' " comments
let s:white1 = '#8fa097' " normal text
let s:white2 = '#9db0a8' " slightly brighter
let s:white3 = '#aebfc7' " brighter
let s:white3 = '#b0c0d0' " brighter

let s:green = '#80b000'
let s:orange = '#b4860a'
let s:red = '#bd3f2d'
let s:cyan = '#29a090'
let s:pink = '#d33682'

" Mapping -> Main colors
let s:background_primary = s:turq1
let s:background_secondary = s:turq2
let s:comment = s:gray
let s:foreground = s:white2

" Mapping -> Keywords and Scope
let s:keyword_control_flow = s:orange " keywords (if, not, return)
let s:keyword_type = s:orange " types (def, int, struct, etc.)
let s:scope_highlight = s:orange " highlighted parentheses

" Mapping -> Values
let s:number = s:cyan
let s:string = s:cyan
let s:special = s:pink 

" Mapping -> Functions and Namespaces
let s:function_name = s:green
let s:defclass = s:green " def/class names
let s:namespace = s:green

" Visual select and Search and Replace
let s:select_fg = s:background_primary
let s:select_bg = s:orange

" ==============================================================================
" UI Elements

execute 'hi Normal guifg=' . s:foreground . ' guibg=' . s:background_primary
execute 'hi CursorLine guibg=' . s:background_secondary
execute 'hi CursorLineNr guifg=' . s:keyword_type

" execute 'hi LineNr guifg=' . '#444444'
execute 'hi LineNr guifg=' . s:comment

" execute 'hi Visual guibg=' . '#49483E'
" execute 'hi Search guifg=' . s:background_primary . ' guibg=' . s:keyword_type
execute 'hi Visual guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi Search guifg=' . s:select_fg . ' guibg=' . s:select_bg 

execute 'hi IncSearch guifg=' . s:background_primary . ' guibg=' . s:keyword_control_flow
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=#49483E'
execute 'hi VertSplit guifg=' . '#3e3d32' . ' guibg=' . s:background_primary
execute 'hi StatusLine guifg=' . s:foreground . ' guibg=' . s:background_secondary
execute 'hi StatusLineNC guifg=' . '#666666' . ' guibg=' . s:background_secondary

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ==============================================================================
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
execute 'hi Special guifg=' . s:special 
execute 'hi Error guifg=' . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:keyword_control_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"

" ==============================================================================
" Language Specific and Advanced Tweaks

" Syntax change function : color entire word containing ::
function! InitNamespaceSyntax() abort
    syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
    execute "highlight cppNamespace guifg=" . s:namespace
endfunction 

" Syntax change function : color word that precede a (, to signal a function call
function! InitFunctionsSyntax() abort
    syntax match cppFunction "\<[A-Za-z_][A-Za-z0-9_]*\ze("
    execute "highlight cppFunction guifg=" . s:function_name
endfunction

" Background change function
function! SetDarkBG() abort 
    execute 'hi Normal guifg=' . s:foreground . ' guibg=' . s:dark_gray
endfunction 

" Background change function
function! SetNormalBG() abort
    execute 'hi Normal guifg=' . s:foreground . ' guibg=' . s:background_primary
endfunction 

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitFunctionsSyntax()
augroup END

call InitNamespaceSyntax()
call InitFunctionsSyntax()

