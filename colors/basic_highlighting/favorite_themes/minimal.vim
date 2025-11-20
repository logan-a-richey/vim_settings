" ------------------------------------------------------------------------------
" Name:         minimal.vim
" Author:       Logan Richey
" Date:         Nov 20, 2025
" Description:  Vim syntax theme with a minimal color pallete. 
"               Does not override background color of terminal.

" ------------------------------------------------------------------------------
" Header

if exists('syntax_on')
    syntax reset
endif
set background=dark
let g:colors_name = 'minimal_theme'

" Full highlight reset
execute 'hi clear'
" execute 'hi Statement gui=NONE'

" ------------------------------------------------------------------------------
" Variable palette

let s:gray1 = '#1e1e1e'
let s:white = '#d4d4d4'
let s:gray2 = '#2a2a2a'
let s:gray3 = '#6a6a6a'
let s:blue = '#569cd6'
let s:purple = '#c586c0'
let s:green = '#98c379'
let s:yellow = '#dcdcaa'
let s:cyan = '#4ec9b0'
let s:baby_blue = '#9cdcfe'

" Assignment
let s:bg          = s:gray1 " background main
let s:bg_sec      = s:gray2 " background current line
let s:comment     = s:gray3 " comments
let s:fg          = s:white " normal text

let s:value       = s:green 
let s:string      = s:green
let s:special     = s:cyan

let s:stmt        = s:purple " for control flow keywords (if, else)
let s:kw_type     = s:blue  " for type keywords (int, bool, class)

let s:func_call   = s:yellow
let s:member      = s:cyan
let s:namespace   = s:baby_blue

" ------------------------------------------------------------------------------
" Link to builtin

hi! link Normal      MyNormal
hi! link Comment     MyComment
hi! link Keyword     MyKeyword
hi! link Type        MyType
hi! link Statement   MyStatement
hi! link PreProc     MyStatement
hi! link Constant    MyValue
hi! link String      MyString
hi! link Character   MyValue
hi! link Number      MyValue
hi! link Boolean     MyValue
hi! link Special     MySpecial 
hi! link Identifier  MyNormal
hi! link Function    MyNormal

" Foreground colors
function! EnableForeground() 
    " Main groups
    execute 'hi MyNormal guifg='    . s:fg      . ' gui=NONE'
    execute 'hi MyComment guifg='   . s:comment . ' gui=italic'
    execute 'hi MyKeyword guifg='   . s:kw_type . ' gui=NONE'
    execute 'hi MyType guifg='      . s:kw_type . ' gui=NONE'
    execute 'hi MyStatement guifg=' . s:stmt    . ' gui=NONE'
    execute 'hi MyValue guifg='     . s:value   . ' gui=NONE'
    execute 'hi MyString guifg='    . s:string  . ' gui=NONE'
    execute 'hi MySpecial guifg='   . s:special . ' gui=NONE'

    " Custom groups
    execute 'hi MyFunctionCall guifg='  . s:func_call ' gui=NONE'
    execute 'hi MyMemberAccess guifg='  . s:member    ' gui=NONE'
    execute 'hi MyNamespace guifg='     . s:namespace ' gui=NONE'

    " UI groups
    execute 'hi LineNr guifg='          . s:comment
    execute 'hi CursorLineNr guifg='    . s:comment

    " Specific
    execute 'hi pythonExceptions guifg='. s:kw_type . ' gui=NONE'
    execute 'hi pythonKeyword guifg='   . s:stmt    . ' gui=NONE'
endfunction

function! EnableBackground()
    execute 'hi MyNormal guibg='    s:bg
    execute 'hi MyComment guibg='   s:bg
    execute 'hi MyKeyword guibg='   s:bg
    execute 'hi MyType guibg='      s:bg
    execute 'hi MyStatement guibg=' s:bg
    execute 'hi MyValue guibg='     s:bg
    execute 'hi MyString guibg='    s:bg
    execute 'hi MySpecial guibg='   s:bg

    " Custom structural syntax groups
    execute 'hi MyFunctionCall guibg=' s:bg
    execute 'hi MyMemberAccess guibg=' s:bg
    execute 'hi MyNamespace guibg='    s:bg
endfunction 

function! DisableBackground()
    execute 'hi MyNormal gui=NONE'
    execute 'hi MyComment gui=NONE'
    execute 'hi MyKeyword gui=NONE'
    execute 'hi MyType gui=NONE'
    execute 'hi MyStatement gui=NONE'
    execute 'hi MyValue gui=NONE'
    execute 'hi MyString gui=NONE'
    execute 'hi MySpecial gui=NONE'

    " Custom structural syntax groups
    execute 'hi MyFunctionCall gui=NONE'
    execute 'hi MyMemberAccess gui=NONE'
    execute 'hi MyNamespace gui=NONE'
endfunction

" Popup Menu
function! EnablePopupMenuColors()
    execute 'highlight Pmenu ctermbg=darkblue guibg=darkblue'
    execute 'PmenuSel ctermbg=blue guibg=blue'
endfunction

" Disable bold for all highlight groups
function! DisableGuiBold() abort
    for group in getcompletion('', 'highlight')
        if group =~# '^\w\+$' " Only process valid highlight group names
            try
                " Get current highlight settings for the group
                redir => l:current_settings
                silent! execute "highlight " . group
                redir END

                " If 'gui=bold' is present, set gui to NONE
                if l:current_settings =~# 'gui=bold'
                    execute "highlight " . group . " gui=NONE"
                endif
            catch /E28: No such highlight group/
                " Ignore errors for non-existent groups (shouldn't happen with getcompletion)
            endtry
        endif
    endfor
endfunction

" Highlight valid variable name that comes before a '('
function! InitFunctionSyntax() abort
    " syntax match myFunctionCall '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    syntax match myFunctionCall '\<~?[A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight myFunctionCall guifg=' . s:func_call
endfunction

" Highlight variable coming after '.' or '->'
"function! InitMemberSyntax() abort
    " syntax match myFunctionCall '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    "syntax match myFunctionCall '\<~?[A-Za-z_][A-Za-z0-9_]*\ze('
    "execute 'highlight myFunctionCall guifg=' . s:func_call
"endfunction

" Highlight any variable containing :: 
function! InitNamespaceSyntax() abort 
    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight cppNamespace guifg=' . s:namespace
endfunction 
    
" On Start
augroup Tweaks
    autocmd! Syntax * call EnableForeground() 
    autocmd! Syntax * call EnableBackground()
    autocmd! Syntax * call EnablePopupMenuColors()

    autocmd! Syntax * call DisableGuiBold()
    autocmd! Syntax * call InitFunctionSyntax()
    " autocmd! Syntax * call InitMemberSyntax()
    " autocmd! Syntax * call InitNamespaceSyntax()
augroup END

" Call the function to apply the changes
call DisableGuiBold()
call InitFunctionSyntax()

