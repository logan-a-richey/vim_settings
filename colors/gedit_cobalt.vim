" -----------------------------------------------------------------------------
" Syntax highlighting inspired by Gedit Cobalt
" Author - Logan Richey
" Date - May 27 2025
" -----------------------------------------------------------------------------

autocmd ColorScheme cobalt colorscheme cobalt

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "cobalt"

set termguicolors

" Define color variables
let m_background     = "#001030"
let m_current_line   = "#003b70"
let m_comment        = "#0088fe"
let m_keyword        = "#ffe135"
let m_keyword2       = "#ffe135"
let m_keyword_type   = "#7effbb"
let m_string         = "#3ad900"
let m_scalar         = "#fe0044"
let m_normal         = "#ffffff"
let m_line_nr        = "#0088fe"
let m_cursor_line_nr = "#fd9015"

" Use execute to apply variables
execute "hi! Normal guibg=" . m_background . " guifg=" . m_normal . " ctermbg=17 ctermfg=15"
execute "hi! CursorLine guibg=" . m_current_line . " ctermbg=24"
execute "hi! CursorLineNr guifg=" . m_cursor_line_nr . " ctermfg=214"
execute "hi! LineNr guifg=" . m_line_nr . " ctermfg=32"
execute "hi! Comment guifg=" . m_comment . " ctermfg=32"
execute "hi! Keyword guifg=" . m_keyword2 . " ctermfg=214"
execute "hi! Type guifg=" . m_keyword_type . " ctermfg=85"
execute "hi! String guifg=" . m_string . " ctermfg=28"
execute "hi! PreProc guifg=" . m_string . " ctermfg=28"
execute "hi! Number guifg=" . m_scalar . " ctermfg=196"

