" ------------------------------------------------------------------------------
" Name:     yaru.vim
" Info:     Inspired from GeditEdit yaru dark theme.
" Author:   Logan Richey
" Date:     Nov 7, 2025
" ------------------------------------------------------------------------------

" TODO - need to check the color theme again 

hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'tsoding'
set termguicolors

" Main colors
let s:dark_gray = '#202020'
let s:dark_gray_2 = '#272727'
let s:off_white = '#c0bfbc'

let s:yellow = '#f6c066'
let s:purple = '#b776b0'
let s:swamp_green = '#0e8420'
let s:tangerine = '#ed754a'
let s:baby_blue = '#47c4ec'

let s:bold_white = '#fcf9dc'
let s:magenta = '#ff00ff'

" Color Mapping
let s:bg = s:dark_gray
let s:bg_sec = s:dark_gray_2
let s:comment = s:purple
let s:fg = s:off_white
let s:kw_flow = s:swamp_green
let s:kw_type = s:swamp_green
let s:number = s:tangerine
let s:paren = s:magenta
let s:defclass = s:baby_blue
let s:string = s:yellow

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

" covers char, string, numbers
execute 'hi Constant guifg=' . s:string 

execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:kw_flow 
execute 'hi Keyword guifg=' . s:kw_flow 
execute 'hi PreProc guifg=' . s:kw_flow . ' gui=bold'
execute 'hi Type guifg=' . s:kw_type 
execute 'hi Special guifg=' . s:number 

execute 'hi Error guifg=#ffffff guibg=#b02752'
execute 'hi Todo guifg=#ffffff guibg=#a08916'

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
        " Only process valid highlight group names
        if group =~# '^\w\+$' 
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

