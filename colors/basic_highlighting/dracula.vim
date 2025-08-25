" dracula.vim 

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "dracula_custom"
set termguicolors

" Dracula Color Palette Mapping
let s:bg             = "#060606" " dark bg
let s:bg_sec         = "#44475a"
let s:fg             = "#f8f8f2"
let s:comment        = "#6272a4"
let s:keyword1       = "#ff79c6"
let s:keyword2       = "#8be9fd"
let s:string         = "#adebb3"
let s:number         = "#ff5555" " mint color strings
let s:line_nr        = "#6272a4"
let s:cursor_line_nr = "#ffb86c"
let s:paren          = "#f1fa8c"
let s:defclass       = "#bd93f9"
let s:operator_color = "#ff5555"

" UI Elements
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:cursor_line_nr
execute 'hi LineNr guifg=' . s:line_nr
execute 'hi Visual guibg=' . "#44475a"
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:keyword2
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:keyword1
execute 'hi MatchParen guifg=' . s:paren . ' guibg=' . "#44475a"
execute 'hi VertSplit guifg=' . "#3e3d32" . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:bg_sec

" Syntax Highlighting
execute 'hi Comment guifg=' . s:comment . ' gui=bold'
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
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=' . s:paren

" Additional Tweaks
execute 'hi Title guifg=' . s:keyword1
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"

" Language Specific and Advanced Tweaks
syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
execute "highlight cppNamespace guifg=" . s:defclass . ' gui=bold'
