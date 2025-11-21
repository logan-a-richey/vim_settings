" ==============================================================================
" Name:         cppref.vim
" Description:  Theme inspired by C++ reference. Light theme - prepare your eye lids.
" Author:       Logan Richey
" Date:         Nov 21, 2025
" ==============================================================================

" Reset previous theme settings
hi clear

if exists('syntax_on')
     syntax reset
endif
let g:colors_name = 'cppref'

set termguicolors
set cursorline

" ==============================================================================
" User Colors

let s:white1 = '#c0c0c0'
let s:white2 = '#b0b0b0'
let s:gray   = '#707070'
let s:blue   = '#0000ff'
let s:green  = '#008800'
let s:red   = '#880000'
let s:black  = '#101010'
let s:pink   = '#dd00dd'

" Mapping -> Main colors
let s:bg = s:white1
let s:bg_sec = s:white2
let s:comment = s:gray
let s:fg = s:black

" Mapping -> Keywords and Scope
let s:kw_stmt = s:blue " keywords (if, not, return)
let s:kw_type = s:blue " types (def, int, struct, etc.)
let s:scope_highlight = s:pink " highlighted parentheses

" Mapping -> Values
let s:number = s:green
let s:string = s:green
let s:special = s:pink 

" Mapping -> Function and Namespaces
let s:function_name = s:red
let s:defclass = s:red " def/class names
let s:namespace = s:black

" Visual select and Search and Replace
let s:select_fg = s:bg
let s:select_bg = s:blue

" ==============================================================================
" UI Elements

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type

" execute 'hi LineNr guifg=' . '#444444'
execute 'hi LineNr guifg=' . s:comment

" execute 'hi Visual guibg=' . '#49483E'
" execute 'hi Search guifg=' . s:bg . ' guibg=' . s:kw_type
execute 'hi Visual guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi Search guifg=' . s:select_fg . ' guibg=' . s:select_bg 

execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_stmt
execute 'hi MatchParen guifg=' . s:scope_highlight . ' guibg=#49483E'
execute 'hi VertSplit guifg=' . '#3e3d32' . ' guibg=' . s:bg

execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:comment
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ==============================================================================
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment 
execute 'hi Constant guifg=' . s:string 
execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:defclass 
execute 'hi Function guifg=' . s:defclass 
execute 'hi Statement guifg=' . s:kw_stmt 
execute 'hi Keyword guifg=' . s:kw_stmt 
execute 'hi PreProc guifg=' . s:kw_stmt 
execute 'hi Type guifg=' . s:kw_type 
execute 'hi Special guifg=' . s:special 
execute 'hi Error guifg=' . s:fg . ' guibg=#b02752'
execute 'hi Todo guifg=' . s:fg . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg=' . s:kw_stmt
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . '#13354a'
execute 'hi DiffChange guibg=' . '#4a410d'
execute 'hi DiffDelete guibg=' . '#420e09'
execute 'hi DiffText guibg=' . '#4c4745'

" ==============================================================================
" Language Specific and Advanced Tweaks

" Syntax change function : color entire word containing ::
function! InitNamespaceSyntax() abort
    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight cppNamespace guifg=' . s:namespace
endfunction 

" Syntax change function : color word that precede a (, to signal a function call
function! InitFunctionSyntax() abort
    syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze('
    execute 'highlight cppFunction guifg=' . s:function_name
endfunction

" Background change function
function! SetDarkBG() abort 
    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg_gray
    execute 'hi CursorLine guibg=' . s:bg_gray_sec
endfunction 

" Background change function
function! SetNormalBG() abort
    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:turq
    execute 'hi CursorLine guibg=' . s:turq_sec
endfunction 

function! DisableGuiBold() abort
  for group in getcompletion('', 'highlight')
    if group =~# '^\w\+$' " Only process valid highlight group names
      try
        " Get current highlight settings for the group
        redir => l:current_settings
        silent! execute 'highlight ' . group
        redir END

        " If 'gui=bold' is present, set gui to NONE
        if l:current_settings =~# 'gui=bold'
          execute 'highlight ' . group . ' gui=NONE'
        endif
      catch /E28: No such highlight group/
        " Ignore errors for non-existent groups (shouldn't happen with getcompletion)
      endtry
    endif
  endfor
endfunction

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    " autocmd Syntax * call InitNamespaceSyntax()
    autocmd Syntax * call InitFunctionSyntax()
    autocmd Syntax * call DisableGuiBold()
augroup END

call InitFunctionSyntax()
call DisableGuiBold()

