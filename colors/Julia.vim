" Name: JULIA
" Descripton: Inspired by Julia logo colors.
" Date: 2025-11-30
" Author: Logan Richey

" ============================================================
hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'julia'
set termguicolors
set cursorline

" ============================================================
" Colors 

"let s:julia_blue = '#3f64b2'
let s:julia_blue = '#4d79d6'
let s:julia_green = '#00993b'
let s:julia_yellow_green = '#7d9900'
let s:julia_pink = '#a558a6'
let s:julia_purple = '#380099'
let s:julia_tomato = '#ea3931'
let s:julia_cyan = '#009996'

let s:bg 			= '#202020'
let s:bg_sec        = '#272727'
let s:cursor_line 	= s:bg_sec
let s:fg 			= '#e0e0e0'
let s:comment 		= '#7a7a7a'

let s:line_nr_above = s:comment
let s:line_nr_below = s:comment
let s:line_nr 		= s:fg
"let s:statement 	= s:julia_blue
"let s:type 		= s:julia_cyan
let s:statement 	= s:julia_pink
let s:type 			= s:julia_blue

let s:function 		= s:julia_cyan
let s:namespace 	= s:julia_cyan
let s:defclass      = s:julia_blue

let s:preproc 		= s:julia_pink
let s:number 		= s:julia_green
let s:string 		= s:julia_green
let s:character 	= s:julia_green
let s:special 		= s:julia_yellow_green
let s:paren         = s:julia_pink
let s:visual_select = s:julia_green

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
execute 'hi MatchParen guibg=#ff0000'
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
    "autocmd Syntax * call InitNamespaceSyntax()
    "autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call InitScopeSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

"call InitNamespaceSyntax()
"call InitFunctionSyntax()
call InitScopeSyntax()
call DisableGuiBold()

