" ------------------------------------------------------------------------------
" Name:     traffic_light.vim
" Info:     Theme consisting of mostly green, yellow, and red.
" Author:   Logan Richey
" Date:     Oct 28, 2025
" ------------------------------------------------------------------------------

" TODO - make this theme more like cppref

hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'traffic_light'
set termguicolors
set cursorline 

let s:darker_gray = '#101010'
let s:dark_gray = '#202020'
let s:gray = '#707070'
let s:white = '#d0d0d0'
let s:green = '#00aa00'
let s:yellow = '#d0d000'
let s:cyan = '#00d0d0'
let s:orange = '#d05000'
let s:purple = '#600dad'
let s:red = '#dd0000'
let s:pink = '#dd00dd'

" Color Mapping
let s:bg = s:darker_gray
let s:bg_sec = s:dark_gray 
let s:comment = s:gray
let s:fg = s:white

let s:kw_flow = s:green
let s:kw_type = s:green
let s:paren = s:red

let s:number = s:red
let s:string = s:yellow
let s:char = s:number
let s:special = s:number 

let s:function_name = s:cyan 
let s:defclass = s:cyan
let s:namespace = s:cyan

" UI Elements
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . '#444444'
execute 'hi Visual guibg=' . '#49483E'
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:kw_type
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_flow
execute 'hi MatchParen guifg=' . s:paren . ' guibg=' . '#49483E'

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ******************************************************************************
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment
execute 'hi Constant guifg=' . s:string 
execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:kw_flow 
execute 'hi Keyword guifg=' . s:kw_flow 
execute 'hi PreProc guifg=' . s:kw_flow 
execute 'hi Type guifg=' . s:kw_type 
execute 'hi Special guifg=' . s:special 

execute 'hi Error guifg=#ffffff guibg=#b02752'
execute 'hi Todo guifg=#ffffff guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:kw_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"

" ------------------------------------------------------------------------------
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

