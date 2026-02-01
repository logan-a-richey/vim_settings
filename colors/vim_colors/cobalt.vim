" Name:         GEDIT COBALT
" Descripton:   Inspired by Gedit Cobalt blue theme.
" Date:         2026-02-01
" Author:       Logan A Richey

" ============================================================
hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'cobalt'
set termguicolors

" ============================================================
" Colors 

let s:cobalt_bg = '#001b33'
let s:cobalt_bg_sec = '#003b70'
let s:cobalt_comment = '#0088fe'
let s:cobalt_white = '#fcfbe4'
let s:cobalt_baby_blue = '#aac9c5'
let s:cobalt_orange = '#ff9d00'
let s:cobalt_green = '#38a81e'
let s:cobalt_turqoise = '#61fabb'
let s:cobalt_red = '#da0a39'
let s:cobalt_highlight = '#4f94cd'
let s:cobalt_yellow = '#faed7d'
let s:white = '#d0d0d0'
let s:white_depressed = '#909090'

let s:bg 			= s:cobalt_bg
let s:bg_sec        = s:cobalt_bg_sec
let s:cursor_line 	= s:bg_sec
let s:fg 			= s:white
let s:comment 		= s:cobalt_comment

let s:line_nr_above = s:comment
let s:line_nr_below = s:comment
let s:line_nr       = s:cobalt_orange

let s:statement 	= s:cobalt_orange
let s:type 			= s:cobalt_turqoise

let s:function 		= s:cobalt_yellow
let s:my_namespace 	= s:white_depressed
let s:defclass      = s:cobalt_red

let s:py_function   = s:cobalt_turqoise 
let s:py_builtin    = s:cobalt_turqoise
let s:py_exceptions = s:cobalt_red 

let s:preproc 		= s:cobalt_green
let s:number 		= s:cobalt_green
let s:string 		= s:cobalt_green
let s:character 	= s:cobalt_green
let s:special 		= s:cobalt_red
let s:paren         = s:cobalt_yellow
let s:visual_select = s:cobalt_highlight

" ============================================================
" VIM UI Syntax 

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:cursor_line
execute 'hi CursorLineNr guifg=' . s:line_nr
execute 'hi LineNr guifg=' . s:line_nr
execute 'hi LineNrAbove guifg=' . s:line_nr_above
execute 'hi LineNrBelow guifg=' . s:line_nr_below

execute 'hi Visual guifg=' . s:bg . ' guibg=' . s:visual_select 
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:visual_select 
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:visual_select

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ============================================================
" Code syntax 

execute 'hi Comment guifg=' . s:comment 
execute 'hi Constant guifg=' . s:string 
execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:statement 
execute 'hi Keyword guifg=' . s:statement 
execute 'hi PreProc guifg=' . s:preproc 
execute 'hi Type guifg=' . s:type 
execute 'hi Special guifg=' . s:special 

execute 'hi pythonFunction guifg=' . s:py_function
execute 'hi pythonBuiltin guifg=' . s:py_builtin
execute 'hi pythonExceptions guifg=' . s:py_exceptions

execute 'hi NonText guifg=' . s:comment

execute 'hi Error guifg=#d0d0d0 guibg=#dd0000'
execute 'hi Todo guifg=#000000 guibg=#dddd00'

" ============================================================
" Additional Tweaks

execute 'hi Title guifg=' . s:statement
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

" ============================================================
" Syntax Tweaks 

" Syntax change function : color entire word containing ::
function! InitNamespaceSyntax() abort
    syntax match myNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight myNamespace guifg=' . s:my_namespace
endfunction 

" Syntax change function : color word that precede a (, to signal a function call
function! InitFunctionSyntax() abort
    " syntax match myFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    syntax match myFunction '[~a-zA-Z_][A-Za-z0-9_]*\ze('
    execute 'highlight myFunction guifg=' . s:function
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScope
    "syntax match myScope '[\(\)\{\}\[\]\<\>]'
    syntax match myScope '[\(\)\{\}\[\]]'
    execute 'highlight myScope guifg=' . s:paren . ' ctermfg=magenta' 
endfunction

function! HighlightSelfKeyword()
    if &filetype ==# 'python'
        syntax match mySelf '\<self'
        execute 'highlight mySelf guifg=' . s:cobalt_turqoise
    endif
endfunction

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
    autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitScopeSyntax()
    " autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call HighlightSelfKeyword
    autocmd Syntax * call DisableGuiBold()
augroup END

call InitNamespaceSyntax()
" call InitFunctionSyntax()
call InitScopeSyntax()
call HighlightSelfKeyword()
call DisableGuiBold()

