" Name: Tango
" Descripton: Linux Theme
" Date: 2026_01_04
" Author: Logan Richey

hi clear
hi clear myNamespace 
hi clear myFunction 
hi clear myScope

if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'Tango'
set termguicolors
set nocursorline

let s:gray1 = '#202020'
let s:gray2 = '#303030'
let s:gray3 = '#606060'

let s:white = '#bdc8c8'
let s:green = '#88e234'
let s:blue = '#729fcf'
let s:red = '#cf7285'
let s:yellow = '#cfc372'
let s:purple = '#6a50b3'
let s:orange = '#c97253'

let s:bg 			= s:gray1
let s:bg_sec        = s:gray2
let s:cursor_line 	= s:gray2
let s:fg 			= s:white
let s:comment 		= s:purple

let s:line_nr_above = s:gray3
let s:line_nr_below = s:gray3
let s:line_nr       = s:white

let s:statement 	= s:blue
let s:type 			= s:blue

let s:paren         = s:red

let s:preproc 		= s:red
let s:number 		= s:green
let s:string 		= s:green
let s:character 	= s:green
let s:special 		= s:yellow
let s:visual_select = s:gray3 

let s:function 		= s:white
let s:namespace 	= s:white
let s:defclass      = s:orange

" ============================================================
" VIM UI Syntax 

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:cursor_line
execute 'hi CursorLineNr guifg=' . s:line_nr
execute 'hi LineNr guifg=' . s:line_nr
execute 'hi LineNrAbove guifg=' . s:line_nr_above
execute 'hi LineNrBelow guifg=' . s:line_nr_below
execute 'hi NonText guifg=' . s:line_nr_below

execute 'hi Visual guifg=' . s:bg . ' guibg=' . s:visual_select 
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:visual_select 
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:visual_select

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:gray3
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
    execute 'highlight myNamespace guifg=' . s:namespace
endfunction 

" Syntax change function : color word that precede a (, to signal a function call
function! InitFunctionSyntax() abort
    syntax match myFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight myFunction guifg=' . s:function
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScope
    "syntax match myScope '[\(\)\{\}\[\]\<\>]'
    syntax match myScope '[\(\)\{\}\[\]]'
    execute 'highlight myScope guifg=' . s:paren . ' ctermfg=magenta' 
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
    " autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call InitScopeSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

call InitNamespaceSyntax()
" call InitFunctionSyntax()
call InitScopeSyntax()
call DisableGuiBold()

