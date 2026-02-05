" ------------------------------------------------------------------------------
" Name: tango.vim
" Description: Minimal semantic colorscheme
" ------------------------------------------------------------------------------

hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'tango'
set termguicolors


" ------------------------------------------------------------------------------
" Palette

let s:bg      = '#1e1e1e'
let s:bg_sec  = '#2e2e2e'
let s:fg      = '#dddddd'

let s:gray    = '#808080'
let s:green   = '#8ae133' " scalars
let s:blue    = '#729ec5' " statements, types
let s:red     = '#c5727a' " comments, escapes
let s:yellow  = '#c5c572' " misc
let s:purple  = '#8072c5'
" ------------------------------------------------------------------------------
" UI

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg

execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:fg

execute 'hi LineNr guifg=' . s:fg
execute 'hi LineNrAbove guifg=' . s:gray
execute 'hi LineNrBelow guifg=' . s:gray
execute 'hi NonText guifg=' . s:gray

execute 'hi Visual guifg=' . s:bg . ' guibg=' . s:purple
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:purple
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:purple

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:gray

execute 'hi MatchParen guibg=' . s:blue . ' guifg=' . s:fg

" ------------------------------------------------------------------------------
" Comments and escapes

execute 'hi Comment guifg=' . s:red
execute 'hi SpecialChar guifg=' . s:red
execute 'hi Escape guifg=' . s:red

" ------------------------------------------------------------------------------
" Scalars (data)

execute 'hi String guifg=' . s:green
execute 'hi Character guifg=' . s:green
execute 'hi Number guifg=' . s:green
execute 'hi Boolean guifg=' . s:green
execute 'hi Float guifg=' . s:green
execute 'hi Constant guifg=' . s:green

" ------------------------------------------------------------------------------
" Statements and types

execute 'hi Statement guifg=' . s:blue
execute 'hi Keyword guifg=' . s:blue
execute 'hi Conditional guifg=' . s:blue
execute 'hi Repeat guifg=' . s:blue
execute 'hi Label guifg=' . s:blue
execute 'hi Operator guifg=' . s:blue

execute 'hi Type guifg=' . s:purple
execute 'hi StorageClass guifg=' . s:blue
execute 'hi Structure guifg=' . s:blue
execute 'hi Typedef guifg=' . s:blue

" ------------------------------------------------------------------------------
" Names (keep neutral)

execute 'hi Identifier guifg=' . s:fg
execute 'hi Function guifg=' . s:fg

" ------------------------------------------------------------------------------
" Misc

execute 'hi PreProc guifg=' . s:yellow
execute 'hi Include guifg=' . s:yellow
execute 'hi Define guifg=' . s:yellow
execute 'hi Special guifg=' . s:yellow

execute 'hi Title guifg=' . s:fg
execute 'hi Directory guifg=' . s:blue

execute 'hi Error guifg=' . s:bg . ' guibg=' . s:red
execute 'hi Todo guifg=' . s:bg . ' guibg=' . s:yellow


" Merge requests
execute 'hi DiffAdd guifg='. s:fg . ' guibg=' . s:green 
execute 'hi DiffChange guifg=' . s:fg . ' guibg=' . s:yellow
execute 'hi DiffText guifg=' . s:fg . ' guibg=' . s:yellow
execute 'hi DiffDelete guifg=' . s:fg . ' guibg=' . s:red 

" Language Specific
execute 'hi pythonBuiltin guifg=' . s:purple
execute 'hi pythonDecorator guifg=' . s:yellow
execute 'hi pythonDecoratorName guifg=' . s:yellow

" ------------------------------------------------------------------------------
" Functions

function! What() abort 
    execute "echo synIDattr(synID(line('.'), col('.'), 1), 'name')"
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

augroup MyInitGroup
    autocmd! 
    autocmd FileType * call DisableGuiBold()
augroup END 


call DisableGuiBold()
