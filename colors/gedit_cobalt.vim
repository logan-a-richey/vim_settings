"*******************************************************************************
" Name: GeditCobalt v2.0
" Description: Inspired from Gedit cobalt syntax theme.
" Author: Logan Richey

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "gedit_cobalt"
set termguicolors

"*******************************************************************************
" Color Palette

let s:bg                = "#0c1021"   " muted deep navy background
let s:bg_sec            = "#1c1f3a"   " subtle highlight for cursor line

let s:fg                = "#ffffff"   " main text (white)
let s:fg_alt            = "#0088fe"   " soft blue for comments/line numbers

let s:keyword           = "#ffa500"   " orange for control-flow keywords
let s:keyword_type      = "#7effbb"   " cyan/turquoise for types
let s:string            = "#3ad900"   " vivid green for strings
let s:scalar            = "#fe0044"   " bright red for numbers, booleans
let s:line_nr           = "#0088fe"   " blue line numbers
let s:cursor_line_nr    = "#ffa500"   " orange cursor line number

"*******************************************************************************
" UI Elements

execute 'hi Normal         guifg=' . s:fg             . ' guibg=' . s:bg
execute 'hi CursorLine     guibg=' . s:bg_sec
execute 'hi CursorLineNr   guifg=' . s:cursor_line_nr
execute 'hi LineNr         guifg=' . s:line_nr
execute 'hi Visual         guibg=' . "#223366"
execute 'hi Search         guifg=' . s:bg             . ' guibg=' . s:keyword_type
execute 'hi IncSearch      guifg=' . s:bg             . ' guibg=' . s:cursor_line_nr
execute 'hi MatchParen     guifg=' . s:keyword_type   . ' guibg=' . "#334477"
execute 'hi VertSplit      guifg=' . "#3e4451"        . ' guibg=' . s:bg
execute 'hi StatusLine     guifg=' . s:fg             . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC   guifg=' . s:fg_alt         . ' guibg=' . s:bg_sec

"*******************************************************************************
" Syntax Highlighting

execute 'hi Comment        guifg=' . s:fg_alt         . ' gui=italic'
execute 'hi Constant       guifg=' . s:scalar
execute 'hi String         guifg=' . s:string
execute 'hi Character      guifg=' . s:string
execute 'hi Number         guifg=' . s:scalar
execute 'hi Boolean        guifg=' . s:scalar

execute 'hi Identifier     guifg=' . s:fg
execute 'hi Function       guifg=' . s:fg

" Core language constructs
execute 'hi Statement      guifg=' . s:keyword
execute 'hi Keyword        guifg=' . s:keyword
execute 'hi PreProc        guifg=' . s:keyword

" Types (int, uint32_t, bool, etc.)
execute 'hi Type           guifg=' . s:keyword_type

execute 'hi Special        guifg=' . "#a9a1e1"
execute 'hi Error          guifg=' . s:scalar         . ' guibg=' . s:bg
execute 'hi Todo           guifg=#ffffff guibg=#804000'
