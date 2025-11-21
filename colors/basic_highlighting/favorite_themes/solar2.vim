" ------------------------------------------------------------------------------
" Name:         solar2.vim
" Description:  Theme inspired by Solarized Dark
" Author:       Logan Richey
" Date:         Oct 7, 2025
" ------------------------------------------------------------------------------

hi clear

if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'solar2'

set cursorline
set termguicolors
set nowrap 

" ------------------------------------------------------------------------------
" User Colors

let s:blue0 = '#00171d'
let s:blue1 = '#002b36' 
let s:blue2 = '#073642'  " current row
let s:blue3 = '#586e75'  " comments
let s:green = '#859900'  " strings
let s:orange = '#bb6622' " keywords
let s:cyan = '#2aa198'   " types
let s:red = '#dc322f'    " scalars
let s:pink = '#d33682'   " special
let s:white = '#b0b0b0'  " normal text
let s:yellow = '#b58900' " other
let s:purple = '#6c71c4' " classdef

" Color Mapping
let s:bg          = s:blue1
let s:bg_sec      = s:blue2
let s:comment     = s:blue3
let s:fg          = s:white
let s:kw_flow    = s:cyan    " keywords (if, not, return)
let s:kw_type    = s:cyan      " types (def, int, struct, etc.)
let s:number      = s:red       " numbers
let s:paren       = s:yellow    " highlighted parentheses
let s:defclass    = s:orange    " def/class names
let s:string      = s:green     
let s:function    = s:green 

" ------------------------------------------------------------------------------
" UI Elements

execute 'hi Normal guifg='     . s:fg       . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg='     . "#444444"
execute 'hi Visual guibg='     . "#49483E"
execute 'hi Search guifg='     . s:bg       . ' guibg=' . s:kw_type
execute 'hi IncSearch guifg='  . s:bg       . ' guibg=' . s:kw_flow
execute 'hi MatchParen guifg=' . s:paren    . ' guibg=' . s:bg_sec

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ------------------------------------------------------------------------------
" Code Syntax highlighting 

execute 'hi Comment guifg='    . s:comment 

" covers char, string, numbers
execute 'hi Constant guifg='   . s:string 

execute 'hi String guifg='     . s:string 
execute 'hi Character guifg='  . s:string 
execute 'hi Number guifg='     . s:number 
execute 'hi Boolean guifg='    . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg='   . s:defclass 
execute 'hi Statement guifg='  . s:kw_flow 
execute 'hi Keyword guifg='    . s:kw_flow 
execute 'hi PreProc guifg='    . s:kw_flow 
execute 'hi Type guifg='       . s:kw_type 
execute 'hi Special guifg='    . s:number 
execute 'hi Error guifg='      . '#ffffff' . ' guibg=#b02752'
execute 'hi Todo guifg='       . '#ffffff' . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg='      . s:kw_flow
execute 'hi Directory guifg='  . s:defclass
execute 'hi DiffAdd guibg='    . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg='   . '#4c4745'

" ----------------------------------------------------------------------------
" Language Specific and Advanced Tweaks

" Syntax change function : color entire word containing ::
function! InitNamespaceSyntax() abort
    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight cppNamespace guifg=' . s:namespace
endfunction 

" Syntax change function : color word that precede a (, to signal a function call
function! InitFunctionSyntax() abort
    syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight cppFunction guifg=' . s:function_name
endfunction

" Disable bold for all syntax groups
function! DisableGuiBold() abort
    for group in getcompletion('', 'highlight')
        if group =~# '^\w\+$' " Only process valid highlight group names
            try
                " Get current highlight settings for the group
                redir => l:current_settings
                silent! execute 'highlight ' . group
                redir END

                " If 'gui=bold' is present, set gui to NONE
                if l:current_settings =~# 'gui=bold'
                    execute 'highlight ' . group . ' gui=NONE'
                endif
            catch /E28: No such highlight group/
                " Ignore errors for non-existent groups (shouldn't happen with getcompletion)
            endtry
        endif
    endfor
endfunction

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    " autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

" call InitFunctionSyntax()
call InitFunctionSyntax()
call DisableGuiBold()

