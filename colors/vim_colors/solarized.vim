" Name:         SOLARIZED
" Descripton:   Inspired by Solarized theme, Gedit variation.
" Date:         2026-02-01

" ========================================
" NOTE: You can see the syntax group being applied to the current word using the following command:
" :echo synIDattr(synID(line('.'), col('.'), 1), 'name')
" ========================================

" ========================================
" Python attributes:
" ========================================
" pythonInclude
" pythonStatement
" pythonNumber
" pythonString
" pythonEscape
" pythonFunction
" pythonBuiltin
" pythonDecorator
" pythonDecoratorName

hi clear
hi clear myFunctionName
hi clear myNamespaceName
hi clear myScopeName

if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'solarized'
set termguicolors

" ============================================================
" Colors dictionary
" ============================================================

let s:colors = {
\ 'base03': '#002f3b',
\ 'base02': '#003948',
\ 'base01': '#5c7780',
\ 'base00': '#6a8590',
\ 'base0':  '#8ca2a5',
\ 'base1':  '#9fb1b1',
\ 'base2':  '#fff7e0',
\ 'base3':  '#fff6e0',
\ 'yellow': '#c79600',
\ 'orange': '#df4100',
\ 'red':    '#f21a17',
\ 'magenta':'#e82181',
\ 'purple': '#686ed7',
\ 'blue':   '#0d8de7',
\ 'cyan':   '#1ab1a5',
\ 'green':  '#92a800',
\ 'gray':   '#676767',
\}

" ============================================================
" Base UI colors
" ============================================================

let s:bg = s:colors.base03
let s:bg_sec = s:colors.base02
let s:cursor_line = bg_sec
let s:fg = s:colors.base2
let s:comment = s:colors.gray

let s:line_nr = fg
let s:line_nr_above = comment
let s:line_nr_below = comment

let s:statement = s:colors.green
let s:type_color = s:colors.yellow
let s:defclass = s:colors.blue
let s:my_function = s:colors.orange
let s:my_namespace = s:colors.blue
let s:my_scope = s:colors.magenta
let s:preproc = s:colors.orange
let s:number = s:colors.cyan
let s:string = s:colors.cyan
let s:character = s:colors.cyan
let s:special = s:colors.magenta
let s:visual_select = s:colors.yellow

let s:py_function = s:colors.purple
let s:py_builtin = s:colors.green
let s:py_exceptions = s:colors.red
let s:py_self = s:colors.orange

" ============================================================
" Vim UI highlights
" ============================================================

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:cursor_line
execute 'hi CursorLineNr guifg=' . s:line_nr
execute 'hi LineNr guifg=' . s:line_nr
execute 'hi LineNrAbove guifg=' . s:line_nr_above
execute 'hi LineNrBelow guifg=' . s:line_nr_below
execute 'hi NonText guifg=' . s:colors.blue

execute 'hi Visual guifg=' . s:bg . ' guibg=' . s:visual_select
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:visual_select
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:visual_select

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ============================================================
" Code syntax highlights
" ============================================================

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
execute 'hi Type guifg=' . s:type_color
execute 'hi Special guifg=' . s:special
execute 'hi MatchParen guifg=' . s:bg . ' guibg=' . s:colors.magenta

execute 'hi pythonExceptions guifg=' . s:colors.yellow
execute 'hi pythonInclude guifg=' . s:colors.magenta
execute 'hi pythonStatement guifg=' . s:colors.green
execute 'hi pythonNumber guifg=' . s:colors.cyan
execute 'hi pythonString guifg=' . s:colors.cyan
execute 'hi pythonEscape guifg=' . s:colors.magenta
execute 'hi pythonFunction guifg=' . s:colors.blue
execute 'hi pythonBuiltin guifg=' . s:colors.yellow
execute 'hi pythonDecorator guifg=' . s:colors.green
execute 'hi pythonDecoratorName guifg=' . s:colors.magenta

execute 'hi NonText guifg=' . s:comment
execute 'hi Error guifg=#d0d0d0 guibg=#dd0000'
execute 'hi Todo guifg=#000000 guibg=#dddd00'

execute 'hi Title guifg=' . s:statement
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=#13354a'
execute 'hi DiffChange guibg=#4a410d'
execute 'hi DiffDelete guibg=#420e09'
execute 'hi DiffText guibg=#4c4745'

" ============================================================
" Syntax tweaks
" ============================================================

function! InitNamespaceSyntax() abort
    syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[A-Za-z_][A-Za-z0-9_]*\)\+'
    execute 'highlight myNamespaceName guifg=' . s:colors.blue
endfunction

function! InitFunctionSyntax() abort
    syntax match myFunctionName '[A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight myFunctionName guifg=' . s:colors.orange
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScopeName
    syntax match myScopeName '[(){}\[\]]'
    execute 'highlight myScopeName guifg=' . s:colors.purple
endfunction

function! HighlightSelfKeyword() abort
    if &filetype ==# 'python'
        syntax match mySelf '\<self\>'
        execute 'highlight mySelf guifg=' . s:colors.yellow
    endif
endfunction

function! DisableGuiBold() abort
    for group in getcompletion('', 'highlight')
        if group =~# '^\w\+$'
            try
                redir => l:current_settings
                silent! execute 'highlight ' . group
                redir END
                if l:current_settings =~# 'gui=bold'
                    execute 'highlight ' . group . ' gui=NONE'
                endif
            catch
            endtry
        endif
    endfor
endfunction

" ============================================================
" Run immediately
" ============================================================

call InitNamespaceSyntax()
call InitScopeSyntax()
call InitFunctionSyntax()
call HighlightSelfKeyword()
call DisableGuiBold()

