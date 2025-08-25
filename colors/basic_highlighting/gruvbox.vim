"*******************************************************************************
" Name: Gruvbox
" Description: Low eye strain theme, inspired from Gruvbox theme
" Author: Logan Richey

"*******************************************************************************
" Setup
hi clear
if exists("syntax_on")
 syntax reset
endif
let g:colors_name = "gruvbox"
set termguicolors

"*******************************************************************************
" Backgrounds
let s:bg = "#1e1e1e" "bg dark gray
let s:bg_sec = "#2a2a2a" "bg subtle highlight

" Foregrounds
let s:fg = "#e0e0e0" "main text: soft white
let s:fg_alt = "#a0a0a0" "comment text: soft gray

" Accents
let s:yellow = "#d6b264"
let s:orange = "#e28d60"
let s:red = "#d66565"
let s:magenta = "#c88fcb"
let s:violet = "#9994e6"
let s:blue = "#79a8ff"
let s:cyan = "#5fb5b5"
let s:green = "#a3c16d"

"*******************************************************************************
" Editor UI 
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:yellow
execute 'hi LineNr guifg=' . s:fg_alt
execute 'hi Visual guibg=' . "#3a3a3a"
execute 'hi Search guibg=' . s:yellow . ' guifg=' . s:bg
execute 'hi IncSearch guibg=' . s:orange . ' guifg=' . s:bg
execute 'hi MatchParen guibg=' . "#3f3f3f" . ' guifg=' . s:yellow
execute 'hi VertSplit guifg=' . "#444444" . ' guibg=' . s:bg

" Syntax Highlighting
execute 'hi Comment guifg=' . s:fg_alt . ' gui=italic'
execute 'hi Constant guifg=' . s:cyan
execute 'hi String guifg=' . s:green
execute 'hi Character guifg=' . s:green
execute 'hi Number guifg=' . s:red
execute 'hi Boolean guifg=' . s:magenta
execute 'hi Identifier guifg=' . s:blue
execute 'hi Function guifg=' . s:blue
execute 'hi Statement guifg=' . s:green
execute 'hi Keyword guifg=' . s:green
execute 'hi PreProc guifg=' . s:orange
execute 'hi Type guifg=' . s:yellow
execute 'hi Special guifg=' . s:violet
execute 'hi Error guifg=' . s:red . ' guibg=' . s:bg
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=' . "#703000"

"*******************************************************************************
" StatusLine / UI tweaks
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . s:fg_alt . ' guibg=' . s:bg_sec
