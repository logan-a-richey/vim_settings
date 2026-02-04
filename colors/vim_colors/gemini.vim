" ------------------------------------------------------------------------------
" Name:         gemini.vim
" Descripton:   Inspired by Google Theme
" Date:         2026-04-01
" ------------------------------------------------------------------------------

hi clear
hi clear myFunctionName
hi clear myNamespaceName
hi clear myScopeName

if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'gemini'
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
\ 'white': '#d3d5d5',
\ 'gray': '#909090',
\ 'purple': '#9a86d7',
\ 'orange': '#f08d3a',
\ 'green': '#7cc895',
\ 'blue': '#88b3f2',
\ 'red': '#d78686',
\ 'bg': '#22252d',
\ 'bg_sec': '#424654'
\}

" ------------------------------------------------------------------------------
" Base UI colors

let s:bg = s:colors.bg
let s:bg_sec = s:colors.bg_sec
let s:cursor_line = s:colors.bg_sec
let s:fg = s:colors.white

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:colors.bg_sec
execute 'hi CursorLineNr guifg=' . s:fg
execute 'hi LineNr guifg=' . s:fg
execute 'hi LineNrAbove guifg=' . s:fg
execute 'hi LineNrBelow guifg=' . s:fg
execute 'hi NonText guifg=' . s:fg

execute 'hi Visual guifg=' . s:bg . ' guibg=' . s:colors.gray
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:colors.gray
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:colors.gray

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:colors.bg

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ============================================================
" Code syntax highlights
" ============================================================

execute 'hi Comment guifg=' . s:colors.gray
execute 'hi Constant guifg=' . s:colors.green
execute 'hi String guifg=' . s:colors.green
execute 'hi Character guifg=' . s:colors.green
execute 'hi Number guifg=' . s:colors.green
execute 'hi Boolean guifg=' . s:colors.green
execute 'hi Identifier guifg=' . s:colors.green
execute 'hi Function guifg=' . s:colors.orange
execute 'hi Statement guifg=' . s:colors.purple
execute 'hi Keyword guifg=' . s:colors.purple
execute 'hi PreProc guifg=' . s:colors.purple
execute 'hi Type guifg=' . s:colors.purple
execute 'hi Special guifg=' . s:colors.orange
execute 'hi MatchParen guifg=' . s:fg . ' guibg=' . s:colors.gray

execute 'hi pythonExceptions guifg=' . s:colors.red
execute 'hi pythonInclude guifg=' . s:colors.purple
execute 'hi pythonStatement guifg=' . s:colors.purple
execute 'hi pythonNumber guifg=' . s:colors.green
execute 'hi pythonString guifg=' . s:colors.green
execute 'hi pythonEscape guifg=' . s:colors.orange
execute 'hi pythonFunction guifg=' . s:colors.orange
execute 'hi pythonBuiltin guifg=' . s:colors.blue
execute 'hi pythonDecorator guifg=' . s:colors.red
execute 'hi pythonDecoratorName guifg=' . s:colors.red

execute 'hi NonText guifg=' . s:colors.gray
execute 'hi Error guifg=#aaaaaa guibg=#aa0000'
execute 'hi Todo guifg=#000000 guibg=#aaaa00'

" For merge/pull requests
execute 'hi Title guifg=' . s:fg
execute 'hi Directory guifg=' . s:fg
execute 'hi DiffAdd guifg='. s:fg . ' guibg=#aa0000'
execute 'hi DiffChange guifg=' . s:fg . ' guibg=#aaaa00'
execute 'hi DiffText guifg=' . s:fg . ' guibg=#aaaa00'
execute 'hi DiffDelete guifg=' . s:fg . ' guibg=#0000aa'

" ------------------------------------------------------------------------------
" Syntax tweaks

function! InitNamespaceSyntax() abort
    syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[~A-Za-z_][A-Za-z0-9_]*\)\+'
    execute 'highlight myNamespaceName guifg=' . s:colors.blue
endfunction

function! InitFunctionSyntax() abort
    syntax match myFunctionName '[~A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight myFunctionName guifg=' . s:colors.orange
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScopeName
    syntax match myScopeName '[(){}\[\]]'
    execute 'highlight myScopeName guifg=' . s:fg
endfunction

function! HighlightSelfKeyword() abort
    if &filetype ==# 'python'
        syntax match mySelf '\<self\>'
        execute 'highlight mySelf guifg=' . s:colors.blue
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

