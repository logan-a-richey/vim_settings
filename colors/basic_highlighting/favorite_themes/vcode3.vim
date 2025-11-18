" ------------------------------------------------------------------------------
" Name:         vcode3.vim
" Description:  Theme inspired by VSCODE
" Author:       Logan Richey
" Date:         Nov 18, 2025
" ------------------------------------------------------------------------------

hi clear
if exists('syntax_on')
     syntax reset
endif
let g:colors_name = 'github_dark'
set termguicolors

" ------------------------------------------------------------------------------
" Color scheme 

let s:gray1 = '#0b1117'
let s:gray2 = '#161b22'
let s:gray3 = '#707070'

let s:cyan = '#4fcab0'
let s:light_blue = '#9ddcff'
let s:dark_blue = '#569dd6'

let s:purple = '#c586c0'
let s:yellow = '#dcdcaa'
let s:orange = '#e3b342'
let s:red = '#f9786f' 

" Mapping -> Main colors
let s:background_primary = s:gray1
let s:background_secondary = s:gray2
let s:comment = s:gray3
let s:foreground = s:light_blue

" Mapping -> Keywords and Scope
let s:keyword_type = s:purple
let s:keyword_control_flow = s:purple 
let s:scope_highlight = s:purple

" Mapping -> Values
let s:number = s:red
let s:string = s:red
let s:special = s:yellow

" Mapping -> Functions and Namespaces
let s:variable_access = s:yellow
let s:function_name = s:yellow
let s:class_name = s:cyan
let s:namespace_access = s:cyan

" ------------------------------------------------------------------------------
" UI Elements

execute 'hi Normal guifg=' . s:foreground . ' guibg=' . s:background_primary
execute 'hi CursorLine guibg=' . s:background_secondary
execute 'hi CursorLineNr guifg=' . s:keyword_type
execute 'hi LineNr guifg=' . "#444444"
execute 'hi Visual guibg=' . "#49483E"
execute 'hi Search guifg=' . s:background_primary . ' guibg=' . s:keyword_type
execute 'hi IncSearch guifg=' . s:background_primary . ' guibg=' . s:keyword_control_flow
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg=' . "#3e3d32" . ' guibg=' . s:background_primary
execute 'hi StatusLine guifg=' . s:foreground . ' guibg=' . s:background_secondary
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:background_secondary

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ------------------------------------------------------------------------------
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment . ' gui=italic'

" covers char, string, numbers
execute 'hi Constant guifg=' . s:string 

execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:class_name 
execute 'hi Function guifg=' . s:class_name 
execute 'hi Statement guifg=' . s:keyword_control_flow 
execute 'hi Keyword guifg=' . s:keyword_control_flow 
execute 'hi PreProc guifg=' . s:keyword_control_flow 
execute 'hi Type guifg=' . s:keyword_type 
execute 'hi Special guifg=' . s:special 
execute 'hi Error guifg=' . '#ffffff' . ' guibg=#b02752'
execute 'hi Todo guifg=' . '#ffffff' . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:keyword_control_flow
execute 'hi Directory guifg=' . s:class_name
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

function! InitCustomSyntax() abort
    syntax match ClassName /\v<(class|struct)\s+\zs\w+/
    execute 'highlight ClassName guifg=' . s:class_name

    syntax match FunctionName /\v\w+\ze\s*\(/
    execute 'highlight FunctionName guifg=' . s:function_name

    syntax match VarAccess /\v(\.|->)\zs\w+/
    execute 'highlight VarAccess guifg=' . s:variable_access
endfunction

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    autocmd Syntax * call InitCustomSyntax()
augroup END

call InitCustomSyntax()
