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

let s:colors = {
\ 'bg':       '#042327',
\ 'fg':       '#bdb395',
\ 'comment':  '#26922b',
\ 'scalar':   '#2ca198',
\ 'flow':     '#9de3c0',
\ 'type':     '#d0d0d0',
\ 'namespace':'#8a826b',
\}

" ------------------------------------------------------------------------------
" UI

execute 'hi Normal guifg=' . s:colors.fg . ' guibg=' . s:colors.bg
execute 'hi CursorLine guibg=' . s:colors.bg
execute 'hi CursorLineNr guifg=' . s:colors.fg
execute 'hi LineNr guifg=' . s:colors.fg
execute 'hi LineNrAbove guifg=' . s:colors.fg
execute 'hi LineNrBelow guifg=' . s:colors.fg
execute 'hi NonText guifg=' . s:colors.comment

execute 'hi Visual guibg=' . s:colors.comment . ' guifg=' . s:colors.bg
execute 'hi Search guibg=' . s:colors.comment . ' guifg=' . s:colors.bg
execute 'hi IncSearch guibg=' . s:colors.comment . ' guifg=' . s:colors.bg

execute 'hi StatusLine guibg=' . s:colors.fg . ' guifg=' . s:colors.bg
execute 'hi StatusLineNC guibg=' . s:colors.bg . ' guifg=' . s:colors.fg
execute 'hi VertSplit guifg=' . s:colors.bg . ' guibg=' . s:colors.bg

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ------------------------------------------------------------------------------
" Core syntax (intentionally boring)

execute 'hi Comment guifg=' . s:colors.comment
execute 'hi String guifg=' . s:colors.scalar
execute 'hi Character guifg=' . s:colors.scalar
execute 'hi Number guifg=' . s:colors.scalar
execute 'hi Boolean guifg=' . s:colors.scalar
execute 'hi Constant guifg=' . s:colors.scalar

execute 'hi Statement guifg=' . s:colors.flow
execute 'hi Keyword guifg=' . s:colors.flow
execute 'hi Conditional guifg=' . s:colors.flow
execute 'hi Repeat guifg=' . s:colors.flow

execute 'hi Type guifg=' . s:colors.type
execute 'hi Identifier guifg=' . s:colors.fg
execute 'hi Function guifg=' . s:colors.fg
execute 'hi Special guifg=' . s:colors.fg

execute 'hi MatchParen guibg=' . s:colors.comment . ' guifg=' . s:colors.fg

" ------------------------------------------------------------------------------
" Language specifics

" Python
execute 'hi pythonBuiltin guifg=' . s:colors.type
execute 'hi pythonException guifg=' . s:colors.type
execute 'hi pythonDecorator guifg=' . s:colors.fg

" Perl
execute 'hi perlStatement guifg=' . s:colors.flow
execute 'hi perlVarPlain guifg=' . s:colors.scalar
execute 'hi perlVarPlain2 guifg=' . s:colors.scalar
execute 'hi perlFunction guifg=' . s:colors.fg

" Vimscript
execute 'hi vimCommand guifg=' . s:colors.flow
execute 'hi vimFuncName guifg=' . s:colors.fg
execute 'hi vimVar guifg=' . s:colors.scalar
execute 'hi vimOption guifg=' . s:colors.type

" ------------------------------------------------------------------------------
" Custom syntax

function! InitNamespaceSyntax() abort
    syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[A-Za-z_][A-Za-z0-9_]*\)\+'
    execute 'highlight myNamespaceName guifg=' . s:colors.namespace
endfunction

function! InitScopeSyntax() abort
    silent! syntax clear myScopeName
    syntax match myScopeName '[(){}\[\]]'
    execute 'highlight myScopeName guifg=' . s:colors.fg
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

