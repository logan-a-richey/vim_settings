" ------------------------------------------------------------------------------
" Name:         naysayer88.vim
" Description:  Minimalist John Blow–inspired theme
" ------------------------------------------------------------------------------

hi clear
hi clear myNamespaceName
hi clear myScopeName

if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'naysayer'
set termguicolors

" ------------------------------------------------------------------------------
" Debug helper
function! What() abort
    echo synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction

" ------------------------------------------------------------------------------
" Color palette (reduced roles)

let s:bg1 = '#042327'
let s:bg2 = '#063036'
let s:fg1 = '#bdb395'
let s:fg2 = '#8a826b'
let s:comment = '#26922b'
let s:scalar = '#2ca198'
let s:control_flow = '#9de3c0'
let s:type = '#d0d0d0'
let s:yellow = '#dddd00'

" ------------------------------------------------------------------------------
" UI

execute 'hi Normal guifg=' . s:fg1 . ' guibg=' . s:bg1
execute 'hi CursorLine guibg=' . s:bg1
execute 'hi CursorLineNr guifg=' . s:fg1
execute 'hi LineNr guifg=' . s:fg1
execute 'hi LineNrAbove guifg=' . s:fg1
execute 'hi LineNrBelow guifg=' . s:fg1
execute 'hi NonText guifg=' . s:comment

execute 'hi Visual guibg=' . s:comment . ' guifg=' . s:bg1
execute 'hi Search guibg=' . s:comment . ' guifg=' . s:bg1
execute 'hi IncSearch guibg=' . s:comment . ' guifg=' . s:bg1

execute 'hi StatusLine guibg=' . s:fg1 . ' guifg=' . s:bg1
execute 'hi StatusLineNC guibg=' . s:bg1 . ' guifg=' . s:fg1
execute 'hi VertSplit guifg=' . s:bg1 . ' guibg=' . s:bg1

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ------------------------------------------------------------------------------
" Core syntax (intentionally boring)

execute 'hi Comment guifg=' . s:comment
execute 'hi String guifg=' . s:scalar
execute 'hi Character guifg=' . s:scalar
execute 'hi Number guifg=' . s:scalar
execute 'hi Boolean guifg=' . s:scalar
execute 'hi Constant guifg=' . s:scalar

execute 'hi Statement guifg=' . s:control_flow
execute 'hi Keyword guifg=' . s:control_flow
execute 'hi Conditional guifg=' . s:control_flow
execute 'hi Repeat guifg=' . s:control_flow

execute 'hi Type guifg=' . s:type
execute 'hi Identifier guifg=' . s:fg1
execute 'hi Function guifg=' . s:fg1
execute 'hi Special guifg=' . s:fg1

execute 'hi MatchParen guibg=' . s:comment . ' guifg=' . s:fg1

" ------------------------------------------------------------------------------
" Language specifics

" Python
execute 'hi pythonBuiltin guifg=' . s:type
execute 'hi pythonException guifg=' . s:type
execute 'hi pythonDecorator guifg=' . s:fg1

" Perl
execute 'hi perlStatement guifg=' . s:control_flow
execute 'hi perlVarPlain guifg=' . s:scalar
execute 'hi perlVarPlain2 guifg=' . s:scalar
execute 'hi perlFunction guifg=' . s:fg1

" Vimscript
execute 'hi vimCommand guifg=' . s:control_flow
execute 'hi vimFuncName guifg=' . s:fg1
execute 'hi vimVar guifg=' . s:scalar
execute 'hi vimOption guifg=' . s:type

" ------------------------------------------------------------------------------
" Custom syntax

function! InitNamespaceSyntax() abort
    syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[A-Za-z_][A-Za-z0-9_]*\)\+'
    execute 'highlight myNamespaceName guifg=' . s:fg2
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScopeName
    syntax match myScopeName '[(){}\[\]]'
    execute 'highlight myScopeName guifg=' . s:yellow
endfunction

function! HighlightSelfKeyword() abort
    if &filetype ==# 'python'
        syntax match mySelf '\<self\>'
        execute 'highlight mySelf guifg=' . s:type
    endif
endfunction

function! DisableGuiBold() abort
    for group in getcompletion('', 'highlight')
        if group =~# '^\w\+$'
            try
                redir => l:hl
                silent execute 'highlight ' . group
                redir END
                if l:hl =~# 'gui=bold'
                    execute 'highlight ' . group . ' gui=NONE'
                endif
            catch
            endtry
        endif
    endfor
endfunction

" ------------------------------------------------------------------------------
" OnStart

augroup myInitGroup 
    autocmd!
	autocmd FileType * hi clear myFunctionName
	autocmd FileType * hi clear myNamespaceName
	autocmd FileType * hi clear myScopeName

    autocmd FileType * call InitNamespaceSyntax()
	autocmd FileType * call InitScopeSyntax()

	autocmd FileType python call HighlightSelfKeyword()
	autocmd FileType perl call HighlightSelfKeyword()
	autocmd FileType javascript call HighlightSelfKeyword()
	
    autocmd FileType * call DisableGuiBold()
augroup END

call InitNamespaceSyntax()
call InitScopeSyntax()
call HighlightSelfKeyword()
call DisableGuiBold()

