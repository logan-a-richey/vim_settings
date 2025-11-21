" ******************************************************************************
" Name: nord.vim
" Description: Theme inspired by Nord theme. 
" Author: Logan Richey
" Date: Nov 12, 2025
" ******************************************************************************

hi clear
if exists('syntax_on')
     syntax reset
endif
let g:colors_name = 'nord'
set termguicolors

" ******************************************************************************
" Color scheme 
let s:gray1 = '#2d3441'
let s:gray2 = '#3a4252'
let s:gray3 = '#5e6e89'
let s:white = '#d7deea'
let s:blue = '#79a1c4'
let s:red = '#bb8baf'
let s:cyan = '#76c2d2'
let s:green = '#9ac186'
let s:yellow = '#f1cb81'

" Mapping -> Main colors
let s:bg = s:gray1
let s:bg_sec = s:gray2
let s:comment = s:gray3
let s:fg = s:white

" Mapping -> Keywords and Scope
let s:kw_type = s:blue " keywords (if, not, return)
let s:kw_type = s:blue " types (def, int, struct, etc.)
let s:scope_highlight = s:red " highlighted parentheses

" Mapping -> Values
let s:number = s:red
let s:string = s:green
let s:special = s:yellow 

" Mapping -> Functions and Namespaces
let s:function = s:cyan
let s:defclass = s:cyan " def/class names
let s:namespace = s:cyan

" ******************************************************************************
" UI Elements

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . "#444444"
execute 'hi Visual guibg=' . "#49483E"
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:kw_type
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_type
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg=' . "#3e3d32" . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:bg_sec

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
execute 'hi Statement guifg=' . s:kw_type 
execute 'hi Keyword guifg=' . s:kw_type 
execute 'hi PreProc guifg=' . s:kw_type 
execute 'hi Type guifg=' . s:kw_type 
execute 'hi Special guifg=' . s:special 
execute 'hi Error guifg=' . '#ffffff' . ' guibg=#b02752'
execute 'hi Todo guifg=' . '#ffffff' . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:kw_type
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

