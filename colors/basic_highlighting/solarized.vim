"*******************************************************************************
" Name: Solarized.vim
" Description: Recreation of Solarized theme for VIM.
" Author: Logan Richey
" Date: Jul 10, 2025

"===============================================================================
" Custom Solarized Vim Theme (Invert Support)
"===============================================================================

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "solarized"
set termguicolors

"===============================================================================
" Invert Function

function! s:InvertHexColor(hex) abort
  let hex = a:hex[1:]  " Remove '#'
  let invert_point = 230 " set to 255 for true invert
  let r = printf('%02x', invert_point - str2nr(hex[0:1], 16))
  let g = printf('%02x', invert_point - str2nr(hex[2:3], 16))
  let b = printf('%02x', invert_point - str2nr(hex[4:5], 16))
  return '#' . r . g . b
endfunction

"===============================================================================
" Original Solarized Palette

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

"===============================================================================
" Invert for Light Mode

if !exists("g:solarized_style")
  let g:solarized_style = "dark"
endif

if g:solarized_style ==# "light"
  for color in ['base03','base02','base01','base00','base0','base1','base2','base3',
              \ 'yellow','orange','red','magenta','violet','blue','cyan','green']
    let s:{color} = s:InvertHexColor(s:{color})
  endfor

  " Post-inversion overrides
  let s:type_color = "#81b02a"     " lime for types
  let s:preproc_color = "#dc322f"  " red for preprocessor
  let s:paren = "#a08916"          " golden parens
else
  let s:type_color = s:cyan
  let s:preproc_color = s:orange
  let s:paren = s:yellow
endif

" Core Assignments
let s:bg       = s:base03
let s:bg_sec   = s:base02
let s:fg       = s:base0
let s:fg_alt   = s:base1

let s:comment  = s:base01
let s:string   = s:green
let s:number   = s:red
let s:keyword1 = s:magenta
let s:keyword2 = s:type_color
let s:defclass = s:blue

"===============================================================================
" UI Elements

execute 'hi Normal       guifg=' . s:fg        . ' guibg=' . s:bg
execute 'hi CursorLine   guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:keyword2
execute 'hi LineNr       guifg=' . "#444444"
execute 'hi Visual       guibg=' . s:base01
execute 'hi Search       guifg=' . s:bg        . ' guibg=' . s:keyword2
execute 'hi IncSearch    guifg=' . s:bg        . ' guibg=' . s:keyword1
execute 'hi MatchParen   guifg=' . s:paren     . ' guibg=' . s:base01
execute 'hi VertSplit    guifg=' . s:base00    . ' guibg=' . s:bg
execute 'hi StatusLine   guifg=' . s:fg        . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666"   . ' guibg=' . s:bg_sec

"===============================================================================
" Syntax Highlighting

execute 'hi Comment      guifg=' . s:comment   . ' gui=bold'
execute 'hi Constant     guifg=' . s:string    . ' gui=bold'
execute 'hi String       guifg=' . s:string    . ' gui=bold'
execute 'hi Character    guifg=' . s:string    . ' gui=bold'
execute 'hi Number       guifg=' . s:number    . ' gui=bold'
execute 'hi Boolean      guifg=' . s:number    . ' gui=bold'
execute 'hi Identifier   guifg=' . s:defclass  . ' gui=bold'
execute 'hi Function     guifg=' . s:defclass  . ' gui=bold'
execute 'hi Statement    guifg=' . s:keyword1  . ' gui=bold'
execute 'hi Keyword      guifg=' . s:keyword1  . ' gui=bold'
execute 'hi PreProc      guifg=' . s:preproc_color . ' gui=bold'
execute 'hi Type         guifg=' . s:keyword2  . ' gui=bold'
execute 'hi Special      guifg=' . s:number    . ' gui=bold'
execute 'hi Error        guifg=#ffffff guibg=' . s:red
execute 'hi Todo         guifg=#ffffff guibg=' . s:paren

"===============================================================================
" Diff

execute 'hi DiffAdd      guibg=#13354a'
execute 'hi DiffChange   guibg=#4a410d'
execute 'hi DiffDelete   guibg=#420e09'
execute 'hi DiffText     guibg=#4c4745'

"===============================================================================
" Custom: C++ Namespace Highlight

syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
execute "highlight cppNamespace guifg=" . s:defclass

"===============================================================================
" Toggle between Light and Dark Modes

if !exists('*ToggleMode')
  function! ToggleMode()
    if !exists("g:solarized_style") || g:solarized_style ==# "dark"
      let g:solarized_style = "light"
    else
      let g:solarized_style = "dark"
    endif
    colorscheme solarized
  endfunction
endif

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue
