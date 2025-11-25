" ------------------------------------------------------------------------------
" Name: constant_motion
" Date: 2025-11-25
" Description: Based off of Systematic Chaos album colors.
" ------------------------------------------------------------------------------
" --- header ---

hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'constant_motion'
set termguicolors
set cursorline

" ------------------------------------------------------------------------------
" --- color pallette ---

let s:bg = '#202020'
" let s:bg_sec = '#341501'
" let s:bg_sec = '#24140a'
let s:bg_sec = '#272727'

let s:comment = '#9b8476'
let s:fg = '#cc9554'
let s:kw_type = '#ffefb9'
let s:kw_flow = '#ffefb9'
let s:preproc = '#ffefb9'
let s:paren = '#ffefb9'
let s:select_fg = '#6c71c4'
let s:number = '#bd3539'
let s:char = '#bd3539'
let s:special = '#bd3539'
let s:string = '#a2c449'
let s:member_access = '#bd954d'
let s:function_name = '#cf591c'

let s:namespace = '#9c6e38'
" let s:namespace = '#875f31'

let s:defclass = '#bd954d'

let s:select_fg = s:bg
let s:select_bg = s:string

" ------------------------------------------------------------------------------
" --- ui lines ---

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . s:comment
execute 'hi Visual guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi Search guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_flow
execute 'hi MatchParen guifg=' . s:paren . s:bg_sec
execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ------------------------------------------------------------------------------
" --- syntax lines ---

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
" Additional tweaks
execute 'hi Title guifg=' . s:kw_flow
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

" ------------------------------------------------------------------------------
" --- syntax function lines ---

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
endfunctio 

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

call InitNamespaceSyntax()
call InitFunctionSyntax()
call DisableGuiBold()
