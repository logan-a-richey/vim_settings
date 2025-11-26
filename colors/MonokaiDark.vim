" Name: MONOKAI DARK
" Date: 2025-11-25

" ============================================================
hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'monokai_dark'
set termguicolors
set cursorline

" ============================================================
" Colors 

let s:monokai_bg = '#272822'
let s:monokai_bg_sec = '#3e3d32'
let s:pink = '#d72672'
let s:purple = '#ae7ef8'
let s:blue = '#66d9ef'
let s:orange = '#fd971f'
let s:yellow = '#e6db74'
let s:green = '#9ae22e'
let s:off_white_blue = '#c9e8f2'
let s:monokai_comment = '#88846a'

let s:bg 			= s:monokai_bg
let s:bg_sec        = s:monokai_bg_sec
let s:cursor_line 	= s:bg_sec
let s:fg 			= s:off_white_blue
let s:comment 		= s:monokai_comment

let s:line_nr_above = s:monokai_bg_sec
let s:line_nr_below = s:monokai_bg_sec
let s:line_nr 		= s:blue
let s:statement 	= s:pink
let s:type 			= s:blue

let s:function 		= s:orange
let s:namespace 	= s:green
let s:defclass      = s:green

let s:preproc 		= s:pink
let s:number 		= s:purple
let s:string 		= s:purple
let s:character 	= s:purple
let s:special 		= s:yellow
let s:paren         = s:yellow
let s:visual_select = s:green

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
    syntax match myNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
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
    autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call InitScopeSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

call InitNamespaceSyntax()
call InitFunctionSyntax()
call InitScopeSyntax()
call DisableGuiBold()

