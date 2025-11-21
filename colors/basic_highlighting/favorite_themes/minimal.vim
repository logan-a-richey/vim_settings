" ------------------------------------------------------------------------------
" Name:         minimal.vim
" Description:  Minimal theme. Experimenting with custom Syntax groups.
" Author:       Logan Richey
" ------------------------------------------------------------------------------

if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'minimal'

set background=dark
set cursorline

" ------------------------------------------------------------------------------
" ** colors **

let s:bg          = '#1e1e1e'
let s:bg_sec      = '#2a2a2a'
let s:fg          = '#d4d4d4'
let s:comment     = '#6a6a6a'
let s:kw_type     = '#569cd6'
let s:stmt        = '#c586c0'
let s:value       = '#98c379'
let s:string      = '#98c379'
let s:special     = '#4ec9b0'

let s:func_call   = '#dcdcaa'
let s:member      = '#4ec9b0'
let s:namespace   = '#9cdcfe'

" ------------------------------------------------------------------------------
" ** highlight groups **

" Core
execute 'hi MyNormal      guifg=' . s:fg      . ' guibg=' . s:bg      . ' gui=NONE'
execute 'hi MyComment     guifg=' . s:comment . ' guibg=' . s:bg      . ' gui=italic'
execute 'hi MyKeyword     guifg=' . s:kw_type . ' guibg=' . s:bg      . ' gui=NONE'
execute 'hi MyType        guifg=' . s:kw_type . ' guibg=' . s:bg      . ' gui=NONE'
execute 'hi MyStatement   guifg=' . s:stmt    . ' guibg=' . s:bg      . ' gui=NONE'
execute 'hi MyValue       guifg=' . s:value   . ' guibg=' . s:bg      . ' gui=NONE'
execute 'hi MyString      guifg=' . s:string  . ' guibg=' . s:bg      . ' gui=NONE'
execute 'hi MySpecial     guifg=' . s:special . ' guibg=' . s:bg      . ' gui=NONE'

" Custom structural syntax groups
execute 'hi MyFunctionCall guifg=' . s:func_call . ' guibg=' . s:bg . ' gui=NONE'
execute 'hi MyMemberAccess guifg=' . s:member    . ' guibg=' . s:bg . ' gui=NONE'
execute 'hi MyNamespace    guifg=' . s:namespace . ' guibg=' . s:bg . ' gui=NONE'

" UI
execute 'hi LineNr        guifg=' . s:comment . ' guibg=' . s:bg
execute 'hi CursorLine    guibg=' . s:bg_sec
execute 'hi CursorLineNr  guifg=' . s:comment . ' guibg=' . s:bg_sec

" ------------------------------------------------------------------------------
" ** link custom groups **

hi! link Normal       MyNormal
hi! link Comment      MyComment
hi! link Keyword      MyKeyword
hi! link Type         MyType
hi! link Statement    MyStatement
hi! link PreProc      MyStatement
hi! link Constant     MyValue
hi! link Number       MyValue
hi! link Boolean      MyValue
hi! link String       MyString
hi! link Character    MyString
hi! link Special      MySpecial
hi! link Identifier   MyNormal
hi! link Function     MyNormal

" ------------------------------------------------------------------------------
" ** regex custom groups **

" Function call: name followed by '(' (supports destructors)
syntax match MyFunctionCall /\v~?[A-Za-z_]\w*\ze\(/

" Member access: .foo  or ->foo
syntax match MyMemberAccess /\v(\.|->)\zs[A-Za-z_]\w*/

" Namespace: aaaa::bbbb::cccc
syntax match MyNamespace /\v[A-Za-z_]\w*(::[A-Za-z_]\w*)+/

" Disable bold
for group in getcompletion('', 'highlight')
    execute 'hi ' . group . ' gui=NONE'
endfor

