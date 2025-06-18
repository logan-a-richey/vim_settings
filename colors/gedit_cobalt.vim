"*******************************************************************************
" Name: GeditCobalt v2.0
" Description: Inspired from Gedit cobalt syntax theme.
" Author: Logan Alexander Richey

"*******************************************************************************
" Setup

hi clear
if exists("syntax_on")
 syntax reset
endif
let g:colors_name = "gedit_cobalt"
set termguicolors

"*******************************************************************************
" Background and Foreground

let m_background     = "#0c1021"   " deeper, muted navy
let m_current_line   = "#1c1f3a"   " slightly lighter for active line

let m_normal         = "#dcdcdc"   " soft white
let m_comment        = "#5c8db4"   " muted cool blue
let m_line_nr        = "#465b78"
let m_cursor_line_nr = "#ffaf5f"

" Syntax
let m_keyword        = "#FFA500"   " orange
let m_keyword2       = "#e0c760"
let m_keyword_type   = "#a8ddb5"   " soft teal
let m_string         = "#91d362"   " calm green
let m_scalar         = "#ff6c7c"   " warm salmon

"*******************************************************************************
" --- Colors ---
let m_background     = "#0c1021"
let m_current_line   = "#1c1f3a"
let m_comment        = "#5c8db4"
let m_keyword        = "#e0c760"
let m_keyword2       = "#e0c760"
let m_keyword_type   = "#a8ddb5"
let m_string         = "#91d362"
let m_scalar         = "#ff6c7c"
let m_normal         = "#dcdcdc"
let m_line_nr        = "#465b78"
let m_cursor_line_nr = "#ffaf5f"

"*******************************************************************************
" --- UI ---
execute 'hi! Normal guibg=' . m_background . ' guifg=' . m_normal
execute 'hi! CursorLine guibg=' . m_current_line
execute 'hi! CursorLineNr guifg=' . m_cursor_line_nr
execute 'hi! LineNr guifg=' . m_line_nr

" --- Syntax ---
execute 'hi! Comment guifg=' . m_comment . ' gui=italic'
execute 'hi! Keyword guifg=' . m_keyword . ' gui=bold'
execute 'hi! Type guifg=' . m_keyword_type
execute 'hi! String guifg=' . m_string
execute 'hi! PreProc guifg=' . m_string
execute 'hi! Number guifg=' . m_scalar

"*******************************************************************************
" UI Tweaks

let s:bg = "#1e1e1e" " bg dark gray 
let s:bg_sec = "#2a2a2a" " bg subtle highlight
let s:fg = "#e0e0e0" " main text: soft white
let s:fg_alt = "#707070" " comment text: soft gray

execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . s:fg_alt . ' guibg=' . s:bg_sec

" Optional:
hi! Visual guibg=#333355
hi! MatchParen guibg=#444466
"hi! StatusLine guibg=#1c1f3a guifg=#bbbbbb
