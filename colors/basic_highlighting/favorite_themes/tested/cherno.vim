" ==============================================================================
" Name:         cherno.vim
" Description:  Theme inspired by Cherno youtube code theme.
" Author:       Logan Richey
" Date:         Nov 25, 2025
" ==============================================================================

" Reset previous theme settings
hi clear

if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'cherno'

set termguicolors
set cursorline

" ==============================================================================

let s:preproc = '#84af83'
let s:bg = '#1e2022'
let s:bg_sec = '#313f35'

let s:kw_type = '#b65951'
let s:kw_flow = '#af554e'
let s:string = '#b2bc55'
let s:fg = '#8e9c96'
let s:function_name = '#d6be64'
let s:comment = '#5c5d54'
let s:value = '#bb8e9b'

let s:scope = s:kw_flow
let s:number = s:value
let s:special = s:value 

let s:defclass = s:function_name " def/class names
let s:namespace = s:function_name

" Visual select and Search and Replace
let s:select_fg = s:bg
let s:select_bg = s:value

" ==============================================================================
" UI Elements

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . s:comment
execute 'hi Visual guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi Search guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_flow
execute 'hi MatchParen guifg=' . s:scope . ' guibg=#49483E'

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ==============================================================================
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
execute 'hi Special guifg=' . s:special 
execute 'hi Error guifg=' . s:fg . ' guibg=#b02752'
execute 'hi Todo guifg=' . s:fg . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:kw_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

" ==============================================================================
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

" Background change function
function! SetDarkBG() abort 
    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg_gray
    execute 'hi CursorLine guibg=' . s:bg_gray_sec
endfunction 

" Background change function
function! SetNormalBG() abort
    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:turq
    execute 'hi CursorLine guibg=' . s:turq_sec
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

