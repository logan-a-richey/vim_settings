" ------------------------------------------------------------------------------
" Name:     vscode_dark.vim
" Info:     Inspired from VSCode minimal C++ theme.
" Author:   Logan Richey
" Date:     Nov 12, 2025
" ------------------------------------------------------------------------------

hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'vscode_dark'
set termguicolors

" ------------------------------------------------------------------------------
" Main colors
let s:dark_gray = '#202020'
let s:mid_gray = '#282828'
let s:white = '#d4d4d4'
let s:orange = '#ce8f5e'
let s:blue = '#539ac5'
let s:green = '#579755'
let s:purple = '#c870d6'
let s:faint_green = '#b5ce9b'
let s:yellow = '#ffee8c'
let s:red = '#dd2211'
let s:cyan = '#4bc9b0'

" Mapping -> Main colors
let s:bg = s:dark_gray
let s:bg_sec = s:mid_gray
let s:comment = s:green
let s:fg = s:white

" Mapping -> keywords and scope 
let s:kw_flow = s:blue
let s:kw_type = s:blue
let s:scope_highlight = s:purple

" Mapping -> values
let s:string = s:orange 
let s:number = s:faint_green

" Mapping -> Functions and Namespaces
let s:function = s:yellow " For function regex '\w+('
let s:defclass = s:yellow " For Python def/classname
let s:namespace = s:cyan " For words containing ::

" ------------------------------------------------------------------------------
" UI Elements

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . "#444444"
execute 'hi Visual guibg=' . "#49483E"
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:kw_type
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_flow
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=' . s:special

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg

" ------------------------------------------------------------------------------
" Code Syntax highlighting 
execute 'hi Comment guifg=' . s:comment

execute 'hi Constant guifg=' . s:string 
execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:kw_flow 
execute 'hi Keyword guifg=' . s:kw_flow 
execute 'hi PreProc guifg=' . s:kw_flow 
execute 'hi Type guifg=' . s:kw_type 
execute 'hi Special guifg=' . s:number 

execute 'hi Error guifg=#ffffff guibg=#b02752'
execute 'hi Todo guifg=#ffffff guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:kw_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ------------------------------------------------------------------------------
" Language Specific and Advanced Tweaks

" Syntax change function : color entire word containing ::
function! InitNamespaceSyntax() abort
    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight cppNamespace guifg=' . s:namespace
endfunction 

" Syntax change function : color word that precede a (, to signal a function call
function! InitFunctionSyntax() abort
    syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight cppFunction guifg=' . s:function_name
endfunction

" Disable bold for all syntax groups
function! DisableGuiBold() abort
    for group in getcompletion('', 'highlight')
        if group =~# '^\w\+$' " Only process valid highlight group names
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
    " autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

" call InitFunctionSyntax()
call InitFunctionSyntax()
call DisableGuiBold()

