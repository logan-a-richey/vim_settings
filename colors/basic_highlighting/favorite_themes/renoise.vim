" Name: renoise_theme.vim
" Description: Theme inspired by Famitracker Renoise 
" Author: Logan Richey
" Date: Nov 18, 2025

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
let s:gray1 		= '#131313'
let s:gray2 		= '#24262d'
let s:gray3 		= '#47525b'
let s:white         = '#ceced1'
let s:cmd_red 	    = '#ff8080'
let s:cmd_purple 	= '#8080ff'
let s:cmd_green 	= '#80ff80'
let s:yellow 		= '#d0d000'
let s:light_blue 	= '#7ac1ff'
let s:deep_red 		= '#681b28'

" color mapping
let s:bg 		    = s:gray1
let s:bg_sec 		= s:gray2
let s:comment 		= s:gray3
let s:fg 		    = s:white
let s:kw_type 		= s:cmd_purple
let s:kw_flow 		= s:cmd_purple
let s:scope 		= s:cmd_red
let s:number 		= s:cmd_green
let s:string 		= s:cmd_green
let s:special 		= s:cmd_purple
let s:class 		= s:light_blue
let s:function 		= s:cmd_red
let s:namespace 	= s:light_blue
let s:var_access    = s:light_blue
let s:visual_fg 	= s:bg
let s:visual_bg 	= s:cmd_green

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

function! InitCustomSyntax() abort
    "syntax match ClassName /\v<(class|struct)\s+\zs\w+/
    "execute 'highlight ClassName guifg=' . s:class
    
    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute "highlight cppNamespace guifg=" . s:namespace

    syntax match VarAccess /\v(\.|->)\zs\w+/
    execute 'highlight VarAccess guifg=' . s:var_access
    
    syntax match FunctionName /\v[~\w]\+\ze\s*\(/
    execute 'highlight FunctionName guifg=' . s:function

endfunction

" Run OnStart
augroup MySyntaxTweaks
    autocmd!
    autocmd Syntax * call InitCustomSyntax()
augroup END

call InitCustomSyntax()
