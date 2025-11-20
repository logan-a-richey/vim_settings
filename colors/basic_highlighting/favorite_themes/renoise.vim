" Name: renoise_theme.vim
" Description: Theme inspired by Famitracker Renoise 
" Author: Logan Richey
" Date: Nov 20, 2025

" set new theme
hi clear
if exists('syntax_on')
    syntax reset
endif
let s:colors_name = 'renoise_theme'
set termguicolors

" disable bold
" execute 'highlight Comment cterm=NONE gui=NONE'

" disable bold
function! s:disable_bold_in_highlights() abort
  let l:colorschemes = getcompletion('', 'highlight')
  for c in l:colorschemes
    if synIDattr(synIDtrans(hlID(c)), 'bold')
      execute 'hi ' . c . ' cterm=NONE gui=NONE'
    endif
  endfor
endfunction
call s:disable_bold_in_highlights()

" user colors
let s:gray1 		= '#202020'
let s:gray2 		= '#272727'
let s:gray3 		= '#707070'
let s:white         = '#ceced1'
let s:red 	    = '#ff8080'
let s:purple 	= '#8080ff'
let s:green 	= '#80dd80'
let s:yellow 		= '#d0d000'
let s:light_blue 	= '#7ac1ff'
let s:deep_red 		= '#681b28'

" color mapping
let s:bg 		    = s:gray1
let s:bg_sec 		= s:gray2
let s:comment 		= s:gray3
let s:fg 		    = s:white
let s:kw_type 		= s:red
let s:kw_flow 		= s:red
let s:scope 		= s:red
let s:number 		= s:yellow
let s:string 		= s:purple
let s:special 		= s:yellow
let s:class 		= s:light_blue
let s:function 		= s:yellow
let s:namespace 	= s:light_blue
let s:var_access    = s:light_blue
let s:visual_fg 	= s:bg
let s:visual_bg 	= s:purple

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:kw_type
execute 'hi LineNr guifg=' . s:comment
execute 'hi Visual guifg=' . s:visual_fg . ' guibg=' . s:visual_bg 
execute 'hi Search guifg=' . s:visual_fg . ' guibg=' . s:visual_bg
execute 'hi IncSearch guifg=' . s:visual_fg . ' guibg=' . s:visual_bg
execute 'hi MatchParen guifg=' . s:scope . ' guibg=' . s:bg_sec
execute 'hi VertSplit guifg=' . '#3e3d32' . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . s:fg . ' guibg=' . s:bg_sec

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

execute 'hi Comment guifg=' . s:comment 
execute 'hi Constant guifg=' . s:string 
execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string 
execute 'hi Number guifg=' . s:number 
execute 'hi Boolean guifg=' . s:number 
execute 'hi Identifier guifg=' . s:fg 
execute 'hi Function guifg=' . s:fg 
execute 'hi Statement guifg=' . s:kw_flow 
execute 'hi Keyword guifg=' . s:kw_flow 
execute 'hi PreProc guifg=' . s:kw_flow 
execute 'hi Type guifg=' . s:kw_type 
execute 'hi Special guifg=' . s:special 
execute 'hi Error guifg=#ffffff guibg=#b02752'
execute 'hi Todo guifg=#ffffff guibg=#a08916'

execute 'hi Title guifg=' . s:kw_flow
execute 'hi Directory guifg=' . s:class
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
  syntax match myNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
  execute "highlight myNamespace guifg=" . s:namespace
endfunction 

" Match any word preceeding a function
function! InitFunctionsSyntax() abort
  " syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze\s*('
  syntax match cppFunction "\<[A-Za-z_][A-Za-z0-9_]*\ze("
  execute "highlight cppFunction guifg=" . s:function
endfunction

augroup OnStart
  autocmd!
  " autocmd Syntax * call InitNamespaceSyntax()
  autocmd Syntax * call InitFunctionsSyntax()
  autocmd Syntax * call DisableGuiBold()
augroup END

" call InitNamespaceSyntax()
call InitFunctionsSyntax()
call DisableGuiBold()
