" ==============================================================================
" Name:         SOLARIZED
" Descripton:   Inspired by Solarized theme, Gedit variation.
" Date:         2026-02-01
" ==============================================================================

" NOTE: You can see the syntax group being applied to the current word using the following command:
" :echo synIDattr(synID(line('.'), col('.'), 1), 'name')

function! What() abort 
    execute "echo synIDattr(synID(line('.'), col('.'), 1), 'name')"
endfunction 

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

let s:bg1 = '#002b36'
let s:bg2 = '#073642'
let s:fg1 = '#eee8d5'
let s:fg2 = '#93a1a1'
let s:fg3 = '#fdf6e3'
let s:comment = '#586e75'
let s:yellow = '#b58900'
let s:orange = '#cb4b16'
let s:red = '#dc322f'
let s:cyan = '#2aa198'
let s:blue = '#268bd2'
let s:green = '#859900'
let s:magenta = '#d33682'
let s:violet = '#6c71c4'

execute 'hi Normal guifg=' . s:fg1 . ' guibg=' . s:bg1
execute 'hi CursorLine guibg=' . s:bg2
execute 'hi CursorLineNr guifg=' . s:bg2
execute 'hi LineNr guifg=' . s:comment
execute 'hi LineNrAbove guifg=' . s:comment
execute 'hi LineNrBelow guifg=' . s:comment
execute 'hi NonText guifg=' . s:comment

execute 'hi Visual guifg=' . s:bg1 . ' guibg=' . s:yellow
execute 'hi Search guifg=' . s:bg1 . ' guibg=' . s:yellow
execute 'hi IncSearch guifg=' . s:bg1 . ' guibg=' . s:yellow

"execute 'hi VertSplit guifg=' . s:bg2 . ' guibg=' . s:bg1
"execute 'hi StatusLine guifg=' . s:bg1 . ' guibg=' . s:fg1
"execute 'hi StatusLineNC guifg=' . s:bg2. ' guibg=' . s:

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ============================================================
" Code syntax highlights
" ============================================================

execute 'hi Comment guifg=' . s:comment

execute 'hi Constant guifg=' . s:cyan
execute 'hi String guifg=' . s:cyan
execute 'hi Character guifg=' . s:cyan
execute 'hi Number guifg=' . s:cyan
execute 'hi Boolean guifg=' . s:cyan
execute 'hi Special guifg=' . s:magenta
execute 'hi Escape guifg=' . s:magenta

execute 'hi Identifier guifg=' . s:green
execute 'hi Function guifg=' . s:green
execute 'hi Statement guifg=' . s:green
execute 'hi Type guifg=' . s:yellow
execute 'hi Keyword guifg=' . s:yellow
execute 'hi PreProc guifg=' . s:orange
execute 'hi MatchParen guifg=' . s:fg1 . ' guibg=' . s:magenta

" Python
execute 'hi pythonStatement guifg=' . s:yellow
execute 'hi pythonConditional guifg=' . s:yellow
execute 'hi pythonRepeat guifg=' . s:yellow
execute 'hi pythonOperator guifg=' . s:yellow
execute 'hi pythonBuiltin guifg=' . s:green
execute 'hi pythonNumber guifg=' . s:cyan
execute 'hi pythonString guifg=' . s:cyan
execute 'hi pythonEscape guifg=' . s:magenta

execute 'hi pythonFunction guifg=' . s:blue

execute 'hi pythonInclude guifg=' . s:violet
execute 'hi pythonDecorator guifg=' . s:violet
execute 'hi pythonDecoratorName guifg=' . s:violet
execute 'hi pythonExceptions guifg=' . s:yellow

" Perl
execute 'hi perlStatementInclude guifg=' . s:orange
execute 'hi perlStatementPackage guifg=' . s:orange
execute 'hi perlPackageDecl guifg=' . s:fg1

execute 'hi perlFuncion guifg=' . s:yellow
execute 'hi perlSubName guifg=' . s:fg1
execute 'hi perlStatementStorage guifg=' . s:yellow
execute 'hi perlVarPlain guifg=' . s:green
execute 'hi perlVarSimpleMember guifg=' . s:green
execute 'hi perlMethod guifg=' . s:orange

execute 'hi perlString guifg=' . s:cyan
execute 'hi perlNumber guifg=' . s:cyan
execute 'hi perlSpecialString guifg=' . s:magenta
execute 'hi perlOperator guifg=' . s:orange
execute 'hi perlRepeat guifg=' . s:orange
execute 'hi perlConditional guifg=' . s:orange


" execute 'hi NonText guifg=' . s:colors.gra
execute 'hi Error guifg=#d0d0d0 guibg=#dd0000'
execute 'hi Todo guifg=#000000 guibg=#dddd00'

" For merge/pull requests
execute 'hi Title guifg=' . s:green
execute 'hi Directory guifg=' . s:blue
execute 'hi DiffAdd guifg='. s:fg1 . ' guibg=' . s:green 
execute 'hi DiffChange guifg=' . s:fg1 . ' guibg=' . s:yellow
execute 'hi DiffText guifg=' . s:fg1 . ' guibg=' . s:yellow
execute 'hi DiffDelete guifg=' . s:fg1 . ' guibg=' . s:red 


" ============================================================
" Syntax tweaks
" ============================================================

function! InitNamespaceSyntax() abort
    syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[~A-Za-z_][A-Za-z0-9_]*\)\+'
    execute 'highlight myNamespaceName guifg=' . s:fg2
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScopeName
    syntax match myScopeName '[(){}\[\]]'
    execute 'highlight myScopeName guifg=' . s:fg3
endfunction

function! HighlightSelfKeyword() abort
  if &filetype ==# 'python'
    syntax match mySelf '\<self\>'
    execute 'highlight mySelf guifg=' . s:violet
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

augroup MyInitGroup
    autocmd! 
    " autocmd FileType * call InitNamespaceSyntax()
    " autocmd FileType * call InitScopeSyntax()
    " autocmd FileType * call HighlightSelfKeyword()
    autocmd FileType * call DisableGuiBold()
augroup END 

" call InitNamespaceSyntax()
" call InitScopeSyntax()
" call HighlightSelfKeyword()
call DisableGuiBold()

