" Name: minimal.vim
" Author: Logan Richey
" Date: Nov 20, 2025
" Description: 
" Vim syntax theme with a minimal color pallete. 
" Does not override background color of terminal. 

" ------------------------------------------------------------------------------
" Header

if exists("syntax_on")
    syntax reset
endif
set background=dark
let g:colors_name = "minimal_theme"

" Full highlight reset
execute 'hi clear'
execute 'hi Statement gui=NONE'

" ------------------------------------------------------------------------------
" Variable palette

let s:gray1 = "#1e1e1e"
let s:white = "#d4d4d4"
let s:gray2 = "#2a2a2a"
let s:gray3 = "#6a6a6a"
let s:blue = "#569cd6"
let s:purple = "#c586c0"
let s:green = "#98c379"
let s:yellow = "#dcdcaa"
let s:cyan = "#4ec9b0"
let s:baby_blue = "#9cdcfe"

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
" Custom theme groups

" TODO edit these colors 

execute 'hi MinimalNormal guifg='   . s:fg      . ' guibg=' . s:bg . ' gui=NONE'
execute 'hi MinimalComment guifg='  . s:comment . ' guibg=NONE gui=NONE'
execute 'hi MinimalKeyword guifg='  . s:kw_type . ' guibg=NONE gui=NONE'
execute 'hi MinimalType guifg='     . s:kw_type . ' guibg=NONE gui=NONE'
execute 'hi MinimalStatement guifg='. s:stmt    . ' guibg=NONE gui=NONE'
execute 'hi MinimalValue guifg='    . s:value   . ' guibg=NONE gui=NONE'
execute 'hi MinimalString guifg=' . s:string . ' guibg=NONE gui=NONE'
execute 'hi MinimalSpecial guifg=' . s:special . ' guibg=NONE gui=NONE'

" Custom structural syntax groups
execute 'hi MinimalFunctionCall guifg=' . s:func_call ' gui=NONE'
execute 'hi MinimalMemberAccess guifg=' . s:member    ' gui=NONE'
execute 'hi MinimalNamespace guifg='    . s:namespace ' gui=NONE'


" UI groups
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi LineNr guifg=' . "#4e4e4e" . ' guibg=' . s:bg
execute 'hi CursorLineNr guifg=' . "#cccccc" . ' guibg=' . s:bg_sec
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

execute 'hi pythonExceptions guifg=' . s:kw_type . ' guibg=NONE gui=NONE'
execute 'hi pythonKeyword guifg=' . s:stmt . ' guibg=NONE gui=NONE'

" ------------------------------------------------------------------------------
" Link to builtin

" Core
hi! link Normal      MinimalNormal
hi! link Comment     MinimalComment

" Keywords & types
hi! link Keyword     MinimalKeyword
hi! link Type        MinimalType

" Flow control, preprocessor, etc.
hi! link Statement   MinimalStatement
hi! link PreProc     MinimalStatement

" Values
hi! link String      MinimalString
hi! link Character   MinimalValue
hi! link Number      MinimalValue
hi! link Boolean     MinimalValue
hi! link Constant    MinimalValue
hi! link Special     MinimalSpecial 

" Identifiers / default
hi! link Identifier  MinimalNormal
hi! link Function    MinimalNormal

" ------------------------------------------------------------------------------

" Highlight function name before (
"function! InitFunctionCall() abort
"    syntax match MinimalFunctionCall /\v<[A-Za-z_]\w*\ze\s*\(/ \
"        containedin=ALLBUT,Comment
"    hi! link MinimalFunctionCall MinimalFunctionCall
"endfunction

"" Highlight member access after . or ->
"function! InitMemberAccess() abort
"    syntax match MinimalMemberAccess /\v(\.|->)\zs[A-Za-z_]\w*/ \
"        containedin=ALLBUT,Comment
"    hi! link MinimalMemberAccess MinimalMemberAccess
"endfunction

"" Highlight namespace chains with ::
"function! InitNamespace() abort
"    " Namespace part
"    syntax match MinimalNamespacePart /\v<[A-Za-z_]\w*::/ contained

"    " Full namespace chain
"    syntax match MinimalNamespace /\v(<[A-Za-z_]\w*::)+/ \
"        contains=MinimalNamespacePart \
"        nextgroup=MinimalFunctionCall,MinimalMemberAccess \
"        skipwhite \
"        containedin=ALLBUT,Comment

"    hi! link MinimalNamespace MinimalNamespace
"    hi! link MinimalNamespacePart MinimalNamespace
"endfunction

"" On Start
"augroup MySyntaxTweaks
"    autocmd! 
"    autocmd Syntax * call InitFunctionCall()
"    autocmd Syntax * call InitMemberAccess()
"    autocmd Syntax * call InitNamespace()
"augroup END

"call InitFunctionCall()
"call InitMemberAccess()
"call InitNamespace()

function! DisableGuiBold()
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

" Call the function to apply the changes
call DisableGuiBold()
augroup Tweaks
    autocmd! Syntax * call DisableGuiBold()
augroup END

