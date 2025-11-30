" Name: OPEN AI GPT CODE THEME
" Date: 2025-11-25

" ============================================================
hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'openai'
set termguicolors
set cursorline

" ============================================================
" Colors 

let s:open_gray1 = '#202020' " for background 
let s:open_gray2 = '#272727' " for background current line
let s:open_gray3 = '#707070' " for comments
let s:open_white = '#e0e0e0' " for normal text
let s:open_white2 = '#c0c0c0'

let s:open_blue = '#2e95d3' " for builtin keywords
let s:open_orange = '#e9950c' " for builtin functions
let s:open_green = '#06a27b' " for strings
let s:open_red = '#f22c3d' " for defname classnamea
let s:open_pink = '#df3079' " for numeric values
let s:yellow = '#e6db74'
let s:cyan = '#00aaaa'
let s:magenta = '#aa00aa'

let s:bg 			= s:open_gray1
let s:bg_sec        = s:open_gray2
let s:cursor_line 	= s:open_gray2
let s:comment 		= s:open_gray3
let s:fg 			= s:open_white

let s:line_nr_above = s:comment
let s:line_nr_below = s:comment
let s:line_nr 		= s:open_blue
let s:statement 	= s:open_blue
let s:type 			= s:open_blue

let s:function 		= s:open_orange
let s:namespace 	= s:cyan
let s:defclass      = s:open_red

let s:preproc 		= s:open_pink
let s:number 		= s:open_pink
let s:string 		= s:open_green
let s:character 	= s:open_green
let s:special 		= s:open_pink
let s:paren         = s:yellow
let s:visual_select = s:open_green

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
    "autocmd Syntax * call InitNamespaceSyntax()
    "autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call InitScopeSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

"call InitNamespaceSyntax()
"call InitFunctionSyntax()
call InitScopeSyntax()
call DisableGuiBold()

