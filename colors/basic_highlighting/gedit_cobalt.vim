"*******************************************************************************
" Name:         GeditCobalt v3
" Description:  Inspired from Gedit cobalt syntax theme.
" Author:       Logan Richey

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "gedit_cobalt"
set termguicolors

"*******************************************************************************
" Color Palette

let s:dark_blue      = "#0c1021"
let s:dark_blue2     = "#1c1f3a"
let s:white          = "#e0e0e0"
let s:light_blue     = "#0088fe"
let s:orange         = "#ffa500"
let s:cyan           = "#7effbb"
let s:green          = "#3ad900"
let s:red            = "#ce0044"
let s:yellow         = "#a08916"
let s:purple         = "#8f2dd8"

let s:bg             = s:dark_blue
let s:bg_sec         = s:dark_blue2
let s:fg             = s:white
let s:comment        = s:light_blue
let s:keyword1       = s:orange
let s:keyword2       = s:cyan
let s:string         = s:green
let s:number         = s:red
let s:line_nr        = s:light_blue
let s:cursor_line_nr = s:orange
let s:paren          = s:yellow
let s:defclass       = s:purple 
let s:operator_color = s:red

"*******************************************************************************
" UI Elements
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:keyword2
execute 'hi LineNr guifg=' . "#444444"
execute 'hi Visual guibg=' . "#49483E"
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:keyword2
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:keyword1
execute 'hi MatchParen guifg=' . s:paren . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg=' . "#3e3d32" . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:bg_sec

"*******************************************************************************
" Syntax Highlighting

" execute 'hi Comment guifg=' . s:comment . ' gui=italic'
execute 'hi Comment guifg=' . s:comment . ' gui=bold'

" covers char, string, numbers
execute 'hi Constant guifg=' . s:string . ' gui=bold'

execute 'hi String guifg=' . s:string . ' gui=bold'
execute 'hi Character guifg=' . s:string . ' gui=bold'
execute 'hi Number guifg=' . s:number . ' gui=bold'
execute 'hi Boolean guifg=' . s:number . ' gui=bold'
execute 'hi Identifier guifg=' . s:defclass . ' gui=bold'
execute 'hi Function guifg=' . s:defclass . ' gui=bold'
execute 'hi Statement guifg=' . s:keyword1 . ' gui=bold'
execute 'hi Keyword guifg=' . s:keyword1 . ' gui=bold'
execute 'hi PreProc guifg=' . s:keyword1 . ' gui=bold'
execute 'hi Type guifg=' . s:keyword2 . ' gui=bold'
execute 'hi Special guifg=' . s:number . ' gui=bold'
execute 'hi Error guifg=' . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:keyword1
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"


"*******************************************************************************
" Language Specific and Advanced Tweaks

" Highlight C++ namespace-qualified identifiers (e.g., std::vector)
syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
execute "highlight cppNamespace guifg=" . s:defclass . ' gui=bold'
" highlight Operator guifg=s:operator_color 

