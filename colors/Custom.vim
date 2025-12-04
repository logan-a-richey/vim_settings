" Name: GEDIT SOLARIZED
" Descripton: Inspired by Solarized theme, Gedit variation.
" Date: 2025-11-25
" Author: Logan Richey

hi clear
hi clear myFunction
hi clear myNamespace
hi clear myScope

if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'gedit_solarized'
set termguicolors
set cursorline

" Colors 
let s:black = '#100f0f'
let s:gray1 = '#1c1b1b'
let s:gray2 = '#282726'
let s:gray3 = '#343331'
let s:gray4 = '#403e3c'
let s:gray5 = '#55524e'
let s:gray6 = '#878580'
let s:gray7 = '#cecdc3'

let s:red1 = '#af3029'
let s:red2 = '#d14d41'
let s:orange1 = '#bc5215'
let s:orange2 = '#da702c'
let s:yellow1 = '#ad8301'
let s:yellow2 = '#d0a215'
let s:green1 = '#66800b'
let s:green2 = '#879a39'
let s:cyan1 = '#24837b'
let s:cyan2 = '#3aa99f'
let s:blue1 = '#205ea6'
let s:blue2 = '#4385be'
let s:purple1 = '#5e409d'
let s:purple2 = '#8b7ec8'
let s:pink1 = '#a02f6f'
let s:pink2 = '#ce5d97'

let s:bg 			= s:gray1
let s:bg_sec        = s:gray2
let s:cursor_line 	= s:bg_sec
let s:fg 			= '#a0a0a0'
let s:comment 		= s:red1

let s:line_nr_above = s:gray4
let s:line_nr_below = s:gray4
let s:line_nr 		= s:green2
let s:statement 	= s:yellow2
let s:type 			= s:cyan2

let s:function 		= s:orange2
let s:namespace 	= s:gray6
let s:defclass      = s:cyan2

let s:preproc 		= s:purple2
let s:number 		= s:green1
let s:string 		= s:green1
let s:character 	= s:green1
let s:special 		= s:green2
let s:paren         = s:gray7
let s:visual_select = s:purple2

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
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:line_nr_above
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
    syntax match myFunction '\<[A-Za-z_\~][A-Za-z0-9_]*\ze('
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
    autocmd Syntax * call InitScopeSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

call InitNamespaceSyntax()
call InitScopeSyntax()
call DisableGuiBold()

