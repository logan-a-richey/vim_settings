" ------------------------------------------------------------------------------
" Name:         NAYSAYER88
" Descripton:   Inspired by Solarized theme, Gedit variation.
" Date:         2026-02-01
" ------------------------------------------------------------------------------

hi clear
hi clear myFunctionName
hi clear myNamespaceName
hi clear myScopeName

if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'solarized'
set termguicolors

" ------------------------------------------------------------------------------
" Colors dictionary
" See current syntax being applied to word:
function! What() abort 
    execute "echo synIDattr(synID(line('.'), col('.'), 1), 'name')"
endfunction 

" ------------------------------------------------------------------------------
" Colors dictionary

let s:colors = {
\ 'fg': '#bdb395',
\ 'bg': '#042327',
\ 'scalar': '#2ca198',
\ 'comment': '#26922b',
\ 'type': '#cccccc',
\ 'flow': '#9de3c0',
\ 'function': '#a15f2c',
\ 'namespace':  '#8a826b'
\}

" ------------------------------------------------------------------------------
" Base UI colors

let s:bg = s:colors.bg
let s:bg_sec = s:colors.bg
let s:cursor_line = s:colors.bg
let s:fg = s:colors.fg

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
" execute 'hi CursorLine guibg=' . s:colors.bg
execute 'hi CursorLineNr guifg=' . s:colors.fg
execute 'hi LineNr guifg=' . s:fg
execute 'hi LineNrAbove guifg=' . s:colors.fg
execute 'hi LineNrBelow guifg=' . s:colors.fg
execute 'hi NonText guifg=' . s:colors.fg

execute 'hi Visual guifg=' . s:bg . ' guibg=' . s:colors.comment
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:colors.comment
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:colors.comment

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:colors.bg

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ============================================================
" Code syntax highlights
" ============================================================

execute 'hi Comment guifg=' . s:colors.comment
execute 'hi Constant guifg=' . s:colors.scalar
execute 'hi String guifg=' . s:colors.scalar
execute 'hi Character guifg=' . s:colors.scalar
execute 'hi Number guifg=' . s:colors.scalar
execute 'hi Boolean guifg=' . s:colors.scalar
execute 'hi Identifier guifg=' . s:colors.scalar
execute 'hi Function guifg=' . s:colors.flow
execute 'hi Statement guifg=' . s:colors.flow
execute 'hi Keyword guifg=' . s:colors.flow
execute 'hi PreProc guifg=' . s:colors.flow
execute 'hi Type guifg=' . s:colors.type
execute 'hi Special guifg=' . s:colors.comment
execute 'hi MatchParen guifg=' . s:fg . ' guibg=' . s:colors.comment

execute 'hi pythonExceptions guifg=' . s:colors.scalar
execute 'hi pythonInclude guifg=' . s:colors.scalar
execute 'hi pythonStatement guifg=' . s:colors.scalar
execute 'hi pythonNumber guifg=' . s:colors.scalar
execute 'hi pythonString guifg=' . s:colors.scalar
execute 'hi pythonEscape guifg=' . s:colors.flow
execute 'hi pythonFunction guifg=' . s:colors.flow
execute 'hi pythonBuiltin guifg=' . s:colors.type
execute 'hi pythonDecorator guifg=' . s:colors.fg
execute 'hi pythonDecoratorName guifg=' . s:colors.scalar

execute 'hi NonText guifg=' . s:colors.comment
execute 'hi Error guifg=#aaaaaa guibg=#aa0000'
execute 'hi Todo guifg=#000000 guibg=#aaaa00'

" For merge/pull requests
execute 'hi Title guifg=' . s:colors.fg
execute 'hi Directory guifg=' . s:colors.fg
execute 'hi DiffAdd guifg='. s:fg . ' guibg=#aa0000'
execute 'hi DiffChange guifg=' . s:fg . ' guibg=#aaaa00'
execute 'hi DiffText guifg=' . s:fg . ' guibg=#aaaa00'
execute 'hi DiffDelete guifg=' . s:fg . ' guibg=#0000aa'

" ------------------------------------------------------------------------------
" Syntax tweaks

function! InitNamespaceSyntax() abort
    syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[~A-Za-z_][A-Za-z0-9_]*\)\+'
    execute 'highlight myNamespaceName guifg=' . s:colors.namespace
endfunction

function! InitFunctionSyntax() abort
    syntax match myFunctionName '[~A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight myFunctionName guifg=' . s:colors.function
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScopeName
    syntax match myScopeName '[(){}\[\]]'
    execute 'highlight myScopeName guifg=' . s:fg
endfunction

function! HighlightSelfKeyword() abort
    if &filetype ==# 'python'
        syntax match mySelf '\<self\>'
        execute 'highlight mySelf guifg=' . s:colors.type
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

" ------------------------------------------------------------------------------
" Run immediately

augroup MyInitGroup
    autocmd! 
    autocmd FileType * call InitNamespaceSyntax()
    " autocmd FileType * call InitScopeSyntax()
    autocmd FileType * call InitFunctionSyntax()
    autocmd FileType python call HighlightSelfKeyword()
    autocmd FileType * call DisableGuiBold()
augroup END 

call InitNamespaceSyntax()
" call InitScopeSyntax()
call InitFunctionSyntax()
call HighlightSelfKeyword()
call DisableGuiBold()

