" ==============================================================================
" Name:         naysayer.vim
" Description:  Theme inspired by Emacs Naysayer
" Author:       Logan Richey
" Date:         Nov 20, 2025
" ==============================================================================

" Reset previous theme settings
hi clear

if exists('syntax_on')
     syntax reset
endif
let g:colors_name = 'naysayer'

set termguicolors
set cursorline
set nowrap 

" ==============================================================================
" User Colors

" Main colors
" ---- Core BG + FG ----
let s:bg       = '#0b2329'
let s:bg_sec   = '#081c20'
let s:bg_ter   = '#112e33'

let s:fg       = '#ceb799'   " KEEP (tan)
let s:fg_alt   = '#81735c'   " KEEP (tan darker)

" ---- Comments & Strings ----
let s:comment  = '#3f5a45'   " muted moss green
let s:string   = '#5c9a52'   " soft desaturated green

" ---- Keyword / Type / Meta ----
let s:kw_stmt  = '#d4c6aa'   " warm light parchment
let s:kw_type  = '#8cc8a8'   " muted aqua-green
let s:kw_meta  = '#a78ec9'   " dusty lavender

" ---- Values ----
let s:number   = '#7fb8c1'   " soft cyan-blue
let s:special  = '#a78ec9'   " lavender

" ---- Function / Namespace ----
let s:function = '#a38d6f'   " muted tan-gray
let s:namespace= '#97886d'
let s:defclass = '#9acaa5'   " muted green

" ---- Visual selection ----
let s:select_bg = s:fg
let s:select_fg = s:bg

" ==============================================================================
" UI Elements

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . s:comment
execute 'hi Visual guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi Search guifg=' . s:select_fg . ' guibg=' . s:select_bg 
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:kw_stmt
execute 'hi MatchParen guifg=' . s:kw_meta . ' guibg=#49483E'
execute 'hi VertSplit guifg=' . '#3e3d32' . ' guibg=' . s:bg

" TODO fix me 
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . '#666666' . ' guibg=' . s:bg_sec

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
    execute 'highlight cppFunction guifg=' . s:function
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

