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
" ========================================

function! What() abort
    execute "echo synIDattr(synID(line('.'), col('.'), 1), 'name')"
endfunction 

hi clear
hi clear myFunction
hi clear myNamespace
hi clear myScope

if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'solarized'
set termguicolors

" --- Colors ---
let s:colors = {}
let s:colors['base03'] = '#002f3b'
let s:colors['base02'] = '#003948'
let s:colors['base01'] = '#5c7780'
let s:colors['base00'] = '#6a8590'
let s:colors['base0'] = '#8ca2a5'
let s:colors['base1'] = '#9fb1b1'
let s:colors['base2'] = '#fff7e0'
let s:colors['base3'] = '#fff6e0'
let s:colors['yellow'] = '#c79600'
let s:colors['orange'] = '#df4100'
let s:colors['red'] = '#f21a17'
let s:colors['magenta'] = '#e82181'
let s:colors['purple'] = '#686ed7'
let s:colors['blue'] = '#0d8de7'
let s:colors['cyan'] = '#1ab1a5'
let s:colors['green'] = '#92a800'
let s:colors['gray'] = '#676767'

" --- Mapping ---
let s:bg = s:solarized_base03
let s:bg_sec = s:solarized_base02
let s:cursor_line = s:bg_sec
let s:fg = s:solarized_base2
let s:comment = s:solarized_gray

let s:line_nr_above = s:comment
let s:line_nr_below = s:comment
let s:line_nr = s:fg
let s:statement = s:solarized_green
let s:type = s:solarized_yellow

let s:defclass = s:solarized_blue

let s:my_function = s:solarized_orange
let s:my_namespace = s:solarized_blue
let s:my_scope = s:solarized_magenta

let s:py_function = s:solarized_purple
let s:py_builtin = s:solarized_green
let s:py_exceptions = s:solarized_red

let s:preproc = s:solarized_orange
let s:number = s:solarized_cyan
let s:string = s:solarized_cyan
let s:character = s:solarized_cyan
let s:special = s:solarized_magenta
let s:paren = s:solarized_purple
let s:visual_select = s:solarized_yellow

" ============================================================
" VIM UI Syntax 

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:cursor_line
execute 'hi CursorLineNr guifg=' . s:line_nr
execute 'hi LineNr guifg=' . s:line_nr
execute 'hi LineNrAbove guifg=' . s:line_nr_above
execute 'hi LineNrBelow guifg=' . s:line_nr_below
execute 'hi NonText guifg=' . s:solarized_blue
execute 'hi pythonBuiltin guifg=' . s:solarized_yellow

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
execute 'hi MatchParen guibg=' . s:solarized_magenta . 'guifg=' . s:bg

execute 'hi NonText guifg=' . s:comment

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
    syntax match myNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[~a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight myNamespace guifg=' . s:my_namespace
endfunction 

" Syntax change function : color word that precede a (, to signal a function call
function! InitFunctionSyntax() abort
    " syntax match myFunction '\<[~a-zA-Z_][A-Za-z0-9_]*\ze('
    syntax match myFunction '[~a-zA-Z_][A-Za-z0-9_]*\ze('
    execute 'highlight myFunction guifg=' . s:my_function
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScope
    syntax match myScope '[\(\)\{\}\[\]]'
    execute 'highlight myScope guifg=' . s:my_scope . ' ctermfg=magenta' 
endfunction

function! HighlightSelfKeyword()
    if &filetype ==# 'python'
        syntax match mySelf '\<self'
        execute 'highlight mySelf guifg=' . s:solarized_orange
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

" ==============================================================================
" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitScopeSyntax()
    autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call HighlightSelfKeyword()
    autocmd Syntax * call DisableGuiBold()
augroup END

" Run every time
call InitNamespaceSyntax()
call InitScopeSyntax()
call InitFunctionSyntax()
call HighlightSelfKeyword()
call DisableGuiBold()

