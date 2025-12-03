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
let s:solarized_base03 	= '#002b36'
let s:solarized_base02 	= '#073642'
let s:solarized_base01 	= '#586e75'
let s:solarized_base00 	= '#657b83'
let s:solarized_base0 	= '#839496'
let s:solarized_base1 	= '#93a1a1'
let s:solarized_base2 	= '#eee8d5'
let s:solarized_base3 	= '#fdf6e3'
let s:solarized_yellow 	= '#b58900'
let s:solarized_orange 	= '#cb4b16'
let s:solarized_red 	= '#dc322f'
let s:solarized_magenta = '#d33682'
let s:solarized_violet 	= '#6c71c4'
let s:solarized_blue 	= '#268bd2'
let s:solarized_cyan 	= '#2aa198'
let s:solarized_green 	= '#859900'

let s:bg 			= s:solarized_base03
let s:bg_sec        = s:solarized_base02
let s:cursor_line 	= s:bg_sec
let s:fg 			= '#d0d0d0'
let s:comment 		= '#707070'

let s:line_nr_above = s:comment
let s:line_nr_below = s:comment
let s:line_nr 		= s:fg
let s:statement 	= s:solarized_yellow
let s:type 			= s:solarized_yellow

let s:function 		= s:solarized_red
let s:namespace 	= s:solarized_green
let s:defclass      = s:solarized_green

let s:preproc 		= s:solarized_magenta
let s:number 		= s:solarized_cyan
let s:string 		= s:solarized_cyan
let s:character 	= s:solarized_cyan
let s:special 		= s:solarized_cyan
let s:paren         = s:solarized_blue
let s:visual_select = s:solarized_green

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
    syntax match myNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[~a-zA-Z_][a-zA-Z0-9_]*\)\+'
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
    autocmd Syntax * call InitScopeSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

call InitNamespaceSyntax()
call InitScopeSyntax()
call DisableGuiBold()

