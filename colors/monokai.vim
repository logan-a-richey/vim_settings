"*******************************************************************************
" Name: Monokai.vim
" Description: Vim colorscheme inspired by VSCODE MONOKAI.
" Author: Logan A. Richey
" Date: Jul 10, 2025

"*******************************************************************************
" Setup

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "monokai"
set termguicolors

"*******************************************************************************
" Color Palette
" -----------------------------------------------------------------------------+
" CMD             | HEX        | COLORNAME      | DESCRIPTION
" ----------------+------------+----------------+------------------------------+
let s:bg          = "#272822"  " DARK_GRAY      | background idle
let s:bg_sec      = "#3e3d32"  " MID_GRAY       | current line background
let s:comment     = "#5a5b50"  " LIGHT GRAY     | comments
let s:fg          = "#c0c3bb"  " OFF WHITE      | normal text (off-white)
let s:keyword1    = "#b02752"  " MAGENTA        | keywords (if, not, return)
let s:keyword2    = "#52a9b9"  " LIGHT BLUE     | types (def, int, struct, etc.)
let s:number      = "#715aab"  " PURPLE         | numbers
let s:paren       = "#a08916"  " GOLD           | highlighted parentheses
let s:defclass    = "#81b02a"  " LIME GREEN     | def/class names
let s:string      = "#bcb25f"  " OFF YELLOW     | strings, chars, docstrings
let s:operator_color = "#b02752" "MAGENTA

"*******************************************************************************
" UI Elements
execute 'hi Normal guifg='     . s:fg       . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:keyword2
execute 'hi LineNr guifg='     . "#444444"
execute 'hi Visual guibg='     . "#49483E"
execute 'hi Search guifg='     . s:bg       . ' guibg=' . s:keyword2
execute 'hi IncSearch guifg='  . s:bg       . ' guibg=' . s:keyword1
execute 'hi MatchParen guifg=' . s:paren    . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg='  . "#3e3d32"  . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg       . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:bg_sec

"*******************************************************************************
" Syntax Highlighting

" execute 'hi Comment guifg='    . s:comment . ' gui=italic'
execute 'hi Comment guifg='    . s:comment . ' gui=bold'

" covers char, string, numbers
execute 'hi Constant guifg='   . s:string . ' gui=bold'

execute 'hi String guifg='     . s:string . ' gui=bold'
execute 'hi Character guifg='  . s:string . ' gui=bold'
execute 'hi Number guifg='     . s:number . ' gui=bold'
execute 'hi Boolean guifg='    . s:number . ' gui=bold'
execute 'hi Identifier guifg=' . s:defclass . ' gui=bold'
execute 'hi Function guifg='   . s:defclass . ' gui=bold'
execute 'hi Statement guifg='  . s:keyword1 . ' gui=bold'
execute 'hi Keyword guifg='    . s:keyword1 . ' gui=bold'
execute 'hi PreProc guifg='    . s:keyword1 . ' gui=bold'
execute 'hi Type guifg='       . s:keyword2 . ' gui=bold'
execute 'hi Special guifg='    . s:number . ' gui=bold'
execute 'hi Error guifg='      . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg='       . "#ffffff" . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg='      . s:keyword1
execute 'hi Directory guifg='  . s:defclass
execute 'hi DiffAdd guibg='    . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg='   . "#4c4745"


"*******************************************************************************
" Language Specific and Advanced Tweaks

" highlight Operator guifg=s:operator_color 

" Highlight C++ namespace-qualified identifiers (e.g., std::vector)
"\w\+\(::\w\+\)\+
syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
" highlight cppNamespace guifg=s:defclass
execute "highlight cppNamespace guifg=" . s:defclass . ' gui=bold'

