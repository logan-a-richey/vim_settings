"*******************************************************************************
" Name: Solarized
" Description: Minimal Solarized Vim theme (Dark & Light)
" Author: Original scheme by Ethan Schoonover

"*******************************************************************************
" Setup
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "solarized"
set termguicolors

"*******************************************************************************
" Solarized Palette
let s:base03  = "#002b36"
let s:base02  = "#073642"
let s:base01  = "#586e75"
let s:base00  = "#657b83"
let s:base0   = "#839496"
let s:base1   = "#93a1a1"
let s:base2   = "#eee8d5"
let s:base3   = "#fdf6e3"
let s:yellow  = "#b58900"
let s:orange  = "#cb4b16"
let s:red     = "#dc322f"
let s:magenta = "#d33682"
let s:violet  = "#6c71c4"
let s:blue    = "#268bd2"
let s:cyan    = "#2aa198"
let s:green   = "#859900"

"*******************************************************************************
" Background select functions

if &background == "light"
  let s:bg       = s:base3
  let s:bg_sec   = s:base2
  let s:fg       = s:base00
  let s:fg_alt   = s:base01
else
  let s:bg       = s:base03
  let s:bg_sec   = s:base02
  let s:fg       = s:base0
  let s:fg_alt   = s:base1
endif

"*******************************************************************************
" Text Color

execute 'hi Normal       guifg=' . "#e0e0e0"      . ' guibg=' . s:bg

" Editor UI
execute 'hi CursorLine   guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:yellow
execute 'hi LineNr       guifg=' . s:fg_alt
execute 'hi Visual       guibg=' . s:base01
execute 'hi Search       guibg=' . s:yellow . ' guifg=' . s:bg
execute 'hi IncSearch    guibg=' . s:orange . ' guifg=' . s:bg
execute 'hi MatchParen   guibg=' . s:base01 . ' guifg=' . s:base3
execute 'hi VertSplit    guifg=' . s:base00 . ' guibg=' . s:bg

" Synatx
execute 'hi Comment      guifg=' . "#707070" . ' gui=italic'
execute 'hi Constant     guifg=' . s:cyan
execute 'hi String       guifg=' . s:green
execute 'hi Character    guifg=' . s:green
execute 'hi Number       guifg=' . s:red
execute 'hi Boolean      guifg=' . s:magenta
execute 'hi Identifier   guifg=' . s:blue
execute 'hi Function     guifg=' . s:blue
execute 'hi Statement    guifg=' . s:green
execute 'hi Keyword      guifg=' . s:green
execute 'hi PreProc      guifg=' . s:orange
execute 'hi Type         guifg=' . s:yellow
execute 'hi Special      guifg=' . s:violet
execute 'hi Error        guifg=' . s:red . ' guibg=' . s:bg
execute 'hi Todo         guifg=' . "#f0f0f0" . ' guibg=' . "#f00000"

"*******************************************************************************
" UI Tweaks

execute 'hi StatusLine   guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . s:fg_alt . ' guibg=' . s:bg_sec

