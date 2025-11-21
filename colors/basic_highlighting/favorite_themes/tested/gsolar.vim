" ==============================================================================
" Name:         gsolar.vim
" Description:  Theme inspired by Solarized. Gedit variation.
" Author:       Logan Richey
" Date:         Nov 16, 2025
" ==============================================================================

" Reset previous theme settings
hi clear

if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'gsolar'

set termguicolors
set cursorline

" ==============================================================================
" User Colors

let s:bg_gray = '#202020'
let s:bg_gray_sec = '#272727'

let s:turq = '#002b36'
let s:turq_sec = '#073642'

let s:gray = '#586e75' " comments
let s:white1 = '#8fa097' " normal text
let s:white2 = '#9db0a8' " slightly brighter
let s:white3 = '#aebfc7' " brighter
let s:white3 = '#b0c0d0' " brighter

let s:green = '#80b000'
let s:orange = '#b4860a'
let s:red_orange = '#c94b1a'
let s:red = '#bd3f2d'
let s:cyan = '#29a090'
let s:pink = '#d33682'

" Mapping -> Main colors
let s:bg = s:turq
let s:bg_sec = s:turq_sec
let s:comment = s:gray
let s:fg = s:white2

" Mapping -> Keywords and Scope
let s:kw_stmt = s:orange " keywords (if, not, return)
let s:kw_type = s:orange " types (def, int, struct, etc.)
let s:scope = s:orange " highlighted parentheses

" Mapping -> Values
let s:number = s:cyan
let s:string = s:cyan
let s:special = s:pink 

" Mapping -> Function and Namespaces
let s:function_name = s:green
let s:defclass = s:green " def/class names
let s:namespace = s:green

" Visual select and Search and Replace
let s:select_fg = s:bg
let s:select_bg = s:orange

" ==============================================================================
" UI Elements

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . s:comment
execute 'hi Visual guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi Search guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_stmt
execute 'hi MatchParen guifg=' . s:scope . ' guibg=#49483E'

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ==============================================================================
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment 
execute 'hi Constant guifg=' . s:string 
execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:kw_stmt 
execute 'hi Keyword guifg=' . s:kw_stmt 
execute 'hi PreProc guifg=' . s:kw_stmt 
execute 'hi Type guifg=' . s:kw_type 
execute 'hi Special guifg=' . s:special 
execute 'hi Error guifg=' . s:fg . ' guibg=#b02752'
execute 'hi Todo guifg=' . s:fg . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:kw_stmt
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

" ==============================================================================
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

" Background change function
function! SetDarkBG() abort 
    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg_gray
    execute 'hi CursorLine guibg=' . s:bg_gray_sec
endfunction 

" Background change function
function! SetNormalBG() abort
    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:turq
    execute 'hi CursorLine guibg=' . s:turq_sec
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

