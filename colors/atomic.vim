"*******************************************************************************
" Name: Atomic
" Description: Inspired from Github syntax theme.
" Author: Logan Richey

"*******************************************************************************
" Setup

hi clear
if exists("syntax_on")
 syntax reset
endif
let g:colors_name = "atomic"
set termguicolors

"*******************************************************************************
" Foreground and Background

let s:bg = "#1e1e1e" " bg dark gray 
let s:bg_sec = "#2a2a2a" " bg subtle highlight

let s:fg = "#e0e0e0" " main text: soft white
let s:fg_alt = "#707070" " comment text: soft gray

"*******************************************************************************
" Syntax Accents

let s:red = "#e06c75" " error, numbers, booleans
let s:orange = "#d19a66" " preprocessor, annotations

"let s:yellow = "#e5c07b" " types, constants
let s:types_and_constants = "#00bbbb" " types, constants

let s:green = "#98c379" " strings, success
let s:blue = "#61afef" " functions, method calls
let s:magenta = "#c678dd" " keywords
let s:cyan = "#56b6c2" " constants, language support
let s:violet = "#a9a1e1" " special, subtle highlight

"*******************************************************************************
" UI Elements 
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:types_and_constants
execute 'hi LineNr guifg=' . s:fg_alt
execute 'hi Visual guibg=' . "#3e4451"
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:types_and_constants
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:orange
execute 'hi MatchParen guifg=' . s:types_and_constants . ' guibg=' . "#3e4451"
execute 'hi VertSplit guifg=' . "#3e4451" . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . s:fg_alt . ' guibg=' . s:bg_sec

" Syntax Highlighting 
execute 'hi Comment guifg=' . s:fg_alt . ' gui=italic'
execute 'hi Constant guifg=' . s:cyan
execute 'hi String guifg=' . s:green
execute 'hi Character guifg=' . s:green
execute 'hi Number guifg=' . s:red
execute 'hi Boolean guifg=' . s:red
execute 'hi Identifier guifg=' . s:blue
execute 'hi Function guifg=' . s:blue
execute 'hi Statement guifg=' . s:magenta
execute 'hi Keyword guifg=' . s:magenta
execute 'hi PreProc guifg=' . s:orange
execute 'hi Type guifg=' . s:types_and_constants
execute 'hi Special guifg=' . s:violet
execute 'hi Error guifg=' . s:red . ' guibg=' . s:bg
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=' . "#804000"

" StatusLine / UI tweaks 
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . s:fg_alt . ' guibg=' . s:bg_sec
