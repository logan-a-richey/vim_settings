" ------------------------------------------------------------------------------
" Name:     glacier.vim
" Info:     Blue theme with a soothing oceanic color scheme.
" Author:   Logan A Richey
" Date:     Nov 7, 2025
" ------------------------------------------------------------------------------

hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'glacier'
set termguicolors

" Main colors
let s:white = '#e2e5f4'
let s:gray = '#7f8497'
let s:blue1 = '#091022'
let s:blue2 = '#14192c'
let s:blue3 = '#44a8b7'
let s:yellow = '#f2dba7'
let s:green = '#8ae39f'
let s:turq = '#56a497'
let s:purple = '#9c9bd4'
let s:magenta = '#ff00ff'
let s:orange = '#b77c44'
let s:red_pink = '#b74466'

" Color Mapping
let s:bg        = s:blue1
let s:bg_sec    = s:blue2
let s:comment   = s:gray
let s:fg        = s:white
let s:kw_flow   = s:blue3
let s:kw_type   = s:turq

let s:string    = s:green
let s:number    = s:yellow
let s:char      = s:yellow
let s:special   = s:red_pink
let s:paren     = s:red_pink

let s:namspace  = s:purple
let s:defclass  = s:yellow
let s:function  = s:yellow 


" UI Elements
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . '#444444'
execute 'hi Visual guibg=' . '#49483E'
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:kw_type
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_flow
execute 'hi MatchParen guifg=' . s:paren . ' guibg=' . '#49483E'
execute 'hi VertSplit guifg=' . '#3e3d32' . ' guibg=' . s:bg

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
execute 'hi Special guifg=' . s:number 
execute 'hi Error guifg=' . '#ffffff' . ' guibg=#b02752'
execute 'hi Todo guifg=' . '#ffffff' . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:kw_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

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

" call InitNamespaceSyntax()
call InitFunctionSyntax()
call DisableGuiBold()

