" Name:         zenburn
" Descripton:   Inspired by Notepad++ Zenburn theme.
" Date:         02/23/2026


hi clear
hi clear myFunctionName
hi clear myNamespaceName
hi clear myScopeName

if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'solarized'
set termguicolors

" Main colors
let s:fg1 	 = '#dfdfdf' " white
let s:fg2 	 = '#a0a0a0' " namespaces // light gray
let s:fg3	 = '#707070' " non text // darker gray
let s:green  = '#7f9f75' " comments
let s:gray 	 = '#89868e' " non-text and side column
let s:bg1 	 = '#202020' " bg2 (darker)
let s:bg2 	 = '#303030' " bg (lighter)
let s:yellow = '#e3ceab' " types and keywords
let s:red 	 = '#c89191' " values, strings
let s:red2 	 = '#9e6565' " darker red for escape characters
let s:blue   = '#759f99' " misc values 

execute 'hi Normal guifg=' . s:fg1 . ' guibg=' . s:bg1
execute 'hi CursorLine guibg=' . s:bg2
execute 'hi CursorLineNr guifg=' . s:fg3
execute 'hi LineNr guifg=' . s:blue
execute 'hi LineNrAbove guifg=' . s:fg3
execute 'hi LineNrBelow guifg=' . s:fg3
execute 'hi NonText guifg=' . s:fg3

execute 'hi Visual guifg=' . s:bg1 . ' guibg=' . s:blue
execute 'hi Search guifg=' . s:bg1 . ' guibg=' . s:blue
execute 'hi IncSearch guifg=' . s:bg1 . ' guibg=' . s:blue

execute 'hi VertSplit guifg=' . s:green . ' guibg=' . s:bg2
execute 'hi StatusLine guifg=' . s:bg2 . ' guibg=' . s:green
execute 'hi StatusLineNC guifg=' . s:bg2 . ' guibg=' . s:green

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ============================================================
" Code syntax highlights
" ============================================================

execute 'hi Comment guifg=' . s:green
execute 'hi Constant guifg=' . s:red
execute 'hi String guifg=' . s:red
execute 'hi Character guifg=' . s:red
execute 'hi Number guifg=' . s:red
execute 'hi Boolean guifg=' . s:red
execute 'hi Special guifg=' . s:red2
execute 'hi Escape guifg=' . s:red2
execute 'hi Identifier guifg=' . s:yellow
execute 'hi Function guifg=' . s:yellow
execute 'hi Statement guifg=' . s:yellow
execute 'hi Type guifg=' . s:yellow
execute 'hi Keyword guifg=' . s:yellow
execute 'hi PreProc guifg=' . s:yellow
execute 'hi MatchParen guifg=' . s:fg1 . ' guibg=' . s:red2

" Python
execute 'hi pythonComment guifg=' . s:green
execute 'hi pythonStatement guifg=' . s:yellow
execute 'hi pythonConditional guifg=' . s:yellow
execute 'hi pythonRepeat guifg=' . s:yellow
execute 'hi pythonOperator guifg=' . s:yellow
execute 'hi pythonBuiltin guifg=' . s:yellow
execute 'hi pythonNumber guifg=' . s:red
execute 'hi pythonString guifg=' . s:red
execute 'hi pythonEscape guifg=' . s:red2
execute 'hi pythonFunction guifg=' . s:blue
execute 'hi pythonInclude guifg=' . s:yellow
execute 'hi pythonDecorator guifg=' . s:yellow
execute 'hi pythonDecoratorName guifg=' . s:yellow
execute 'hi pythonExceptions guifg=' . s:red

" Perl
execute 'hi perlStatementInclude guifg=' . s:yellow
execute 'hi perlStatementPackage guifg=' . s:yellow
execute 'hi perlPackageDecl guifg=' . s:yellow
execute 'hi perlFuncion guifg=' . s:yellow
execute 'hi perlSubName guifg=' . s:yellow
execute 'hi perlStatementStorage guifg=' . s:yellow
execute 'hi perlOperator guifg=' . s:yellow
execute 'hi perlRepeat guifg=' . s:yellow
execute 'hi perlConditional guifg=' . s:yellow
execute 'hi perlVarPlain guifg=' . s:red
execute 'hi perlVarSimpleMember guifg=' . s:red
execute 'hi perlMethod guifg=' . s:red
execute 'hi perlString guifg=' . s:red
execute 'hi perlNumber guifg=' . s:red
execute 'hi perlSpecialString guifg=' . s:blue

" Vimscript
execute 'hi vimVar guifg=' . s:blue

" Javascript
" TODO

" execute 'hi NonText guifg=' . s:colors.gra
execute 'hi Error guifg=#d0d0d0 guibg=' . s:yellow
execute 'hi Todo guifg=#ffffff guibg=' . s:red2

" For merge/pull requests
execute 'hi Title guifg=' . s:green
execute 'hi Directory guifg=' . s:blue
execute 'hi DiffAdd guifg='. s:fg1 . ' guibg=' . s:green 
execute 'hi DiffChange guifg=' . s:fg1 . ' guibg=' . s:yellow
execute 'hi DiffText guifg=' . s:fg1 . ' guibg=' . s:yellow
execute 'hi DiffDelete guifg=' . s:fg1 . ' guibg=' . s:red 


" Console log the vim highlight group name.
function! What() abort 
    execute "echo synIDattr(synID(line('.'), col('.'), 1), 'name')"
endfunction 

" Any words containing :: will match 
function! InitNamespaceSyntax() abort
    syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[~A-Za-z_][A-Za-z0-9_]*\)\+'
    execute 'highlight myNamespaceName guifg=' . s:fg2
endfunction

"function! InitScopeSyntax() abort
"    silent! syntax clear myScopeName
"    syntax match myScopeName '[(){}\[\]]'
"    execute 'highlight myScopeName guifg=' . s:fg3
"endfunction

"function! HighlightSelfKeyword() abort
"  if &filetype ==# 'python'
"    syntax match mySelf '\<self\>'
"    execute 'highlight mySelf guifg=' . s:violet
"  endif
"endfunction

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

" OnStart
augroup MyInitGroup
    autocmd! 
    autocmd FileType * call DisableGuiBold()
augroup END 

call DisableGuiBold()

