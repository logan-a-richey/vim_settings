" ******************************************************************************
" Name: openai.vim
" Description: Theme inspired by ChatGPT code snippet theme.
" Author: Logan Richey
" Date: Nov 12, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
   syntax reset
endif
let g:colors_name = "openai"
set termguicolors
set cursorline 

" ******************************************************************************
" User Colors

let s:gray1 = '#202020' " for background 
let s:gray2 = '#272727' " for background current line
let s:gray3 = '#707070' " for comments
let s:white = '#e0e0e0' " for normal text
let s:blue = '#2e95d3' " for builtin keywords
let s:orange = '#e9950c' " for builtin functions
let s:green = '#06a27b' " for strings
let s:red = '#f22c3d' " for defname classnamea
let s:light_red = '#d47070'
let s:pink = '#df3079' " for numeric values

" Mapping -> Main colors
let s:bg = s:gray1
let s:bg_sec = s:gray2
let s:comment = s:gray3
let s:fg = s:white

" Mapping -> Keywords and Scope
let s:stmt = s:blue " keywords (if, not, return)
let s:type = s:blue " types (def, int, struct, etc.)
let s:scope_highlight = s:pink " highlighted parentheses

" Mapping -> Values
let s:number = s:pink
let s:string = s:green

" Mapping -> Functions and Namespaces
let s:function = s:orange
let s:defclass = s:light_red " def/class names
let s:namespace = s:light_red

" ******************************************************************************
" UI Elements

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:type
execute 'hi LineNr guifg=' . "#444444"
execute 'hi Visual guibg=' . "#49483E"
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:type
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:stmt
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg=' . "#3e3d32" . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:bg_sec

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ******************************************************************************
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment 
" . ' gui=italic'

" covers char, string, numbers
execute 'hi Constant guifg=' . s:string 

execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:stmt 
execute 'hi Keyword guifg=' . s:stmt 
execute 'hi PreProc guifg=' . s:stmt 
execute 'hi Type guifg=' . s:type 
execute 'hi Special guifg=' . s:number 
execute 'hi Error guifg=' . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:stmt
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"

" *****************************************************************************
" Language Specific and Advanced Tweaks

" Disable bold for all highlight groups
function! DisableGuiBold() abort
  for group in getcompletion('', 'highlight')
    if group =~# '^\w\+$' " Only process valid highlight group names
      try
        " Get current highlight settings for the group
        redir => l:current_settings
        silent! execute "highlight " . group
        redir END

        " If 'gui=bold' is present, set gui to NONE
        if l:current_settings =~# 'gui=bold'
          execute "highlight " . group . " gui=NONE"
        endif
      catch /E28: No such highlight group/
        " Ignore errors for non-existent groups (shouldn't happen with getcompletion)
      endtry
    endif
  endfor
endfunction

" Match any word containing :: and color the entire word.
function! InitNamespaceSyntax() abort
  syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
  execute "highlight cppNamespace guifg=" . s:namespace
endfunction 

" Match any word preceeding a function
function! InitFunctionsSyntax() abort
  " syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze\s*('
  syntax match cppFunction "\<[A-Za-z_][A-Za-z0-9_]*\ze("
  execute "highlight cppFunction guifg=" . s:function
endfunction

function! OperatorSyntax() abort 

endfunction 

" Run OnStart
augroup MySyntaxTweaks
  autocmd!
  autocmd Syntax * call InitNamespaceSyntax()
  autocmd Syntax * call InitFunctionsSyntax()
  autocmd Syntax * call DisableGuiBold()
augroup END

call InitNamespaceSyntax()
call InitFunctionsSyntax()

