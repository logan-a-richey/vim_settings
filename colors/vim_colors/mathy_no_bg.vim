" ------------------------------------------------------------------------------
" Name:         MATHY
" Descripton:   Inspired by some colors used in a math youtube video.
" Date:         2026-02-11
" Author:       Logan Richey
" ------------------------------------------------------------------------------

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:name = 'mathy'
set termguicolors
" set cursorline

" NOTE: You can see the syntax group being applied to the current word using the following command:
" :echo synIDattr(synID(line('.'), col('.'), 1), 'name')

function! What() abort 
    execute "echo synIDattr(synID(line('.'), col('.'), 1), 'name')"
endfunction 

" ------------------------------------------------------------------------------
" Basic Tones
let s:bg = '#192636'
let s:bg2 = '#272727'
let s:gray = '#777777'
let s:fg = '#d0d0d0'
let s:fg2 = '#b0b0b0'
let s:light_blue = '#58ccfd'
let s:yellow = '#fcf059'
let s:green = '#84d96a'
let s:pink = '#ff86d7'
let s:orange = '#bf7861'
let s:red = '#bb111c' 
let s:purple = '#bbb7ff'

" ------------------------------------------------------------------------------
" Color Mappings

let s:bg = s:bg
let s:bg_sec = s:bg2
let s:comment = s:light_blue
let s:fg = s:fg

execute 'hi Normal guifg=' . s:fg 
execute 'hi Comment guifg=' . s:comment

" execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:comment
execute 'hi LineNr guifg=' . s:comment
execute 'hi LineNrAbove guifg=' . s:comment
execute 'hi LineNrBelow guifg=' . s:comment
execute 'hi NonText guifg=' . s:comment

execute 'hi Visual guifg=' . s:bg 
execute 'hi Search guifg=' . s:bg 
execute 'hi IncSearch guifg=' . s:bg 

execute 'hi VertSplit guifg=' . s:bg_sec 
execute 'hi StatusLine guifg=' . s:bg 
execute 'hi StatusLineNC guifg=' . s:bg_sec 

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

execute 'hi Constant guifg=' . s:purple
execute 'hi String guifg=' . s:purple
execute 'hi Character guifg=' . s:purple
execute 'hi Number guifg=' . s:purple
execute 'hi Boolean guifg=' . s:purple
execute 'hi Identifier guifg=' . s:purple
execute 'hi Special guifg=' . s:yellow 

execute 'hi Function guifg=' . s:orange

" control flow: while, if, for, while, ...
execute 'hi Statement guifg=' . s:green

" types: int, float, class, ...
execute 'hi Type guifg=' . s:green

execute 'hi Keyword guifg=' . s:green
execute 'hi PreProc guifg=' . s:green
execute 'hi MatchParen guifg=' . s:pink 

execute 'hi pythonExceptions guifg=' . s:yellow
execute 'hi pythonStatement guifg=' . s:pink

execute 'hi pythonNumber guifg=' . s:purple
execute 'hi pythonString guifg=' . s:purple

execute 'hi pythonEscape guifg=' . s:yellow

execute 'hi pythonFunction guifg=' . s:green
execute 'hi pythonBuiltin guifg=' . s:green

execute 'hi pythonInclude guifg=' . s:pink
execute 'hi pythonConditional guifg=' . s:pink

execute 'hi pythonDecorator guifg=' . s:fg
execute 'hi pythonDecoratorName guifg=' . s:orange

execute 'hi Error guifg=#d0d0d0 guibg=#dd0000'
execute 'hi Todo guifg=#000000 guibg=#dddd00'

" For merge/pull requests
execute 'hi Title guifg=' . s:green
execute 'hi Directory guifg=' . s:orange
execute 'hi DiffAdd guifg='. s:fg 
execute 'hi DiffChange guifg=' . s:fg 
execute 'hi DiffText guifg=' . s:fg 
execute 'hi DiffDelete guifg=' . s:fg 

" ------------------------------------------------------------------------------
" --- Functions ---

function! InitScopeSyntax() abort
  silent! syntax clear myScopeName
  syntax match myScopeName '[(){}\[\]]'
  execute 'highlight myScopeName guifg=' . s:yellow
endfunction

function! DisableGuiBold() abort
  for group in getcompletion('', 'highlight')
    if group =~# '^\w\+$'
      try
        redir => l:current_settings
        silent! execute 'highlight ' . group
        redir END
        if l:current_settings =~# 'gui=bold'
          execute 'highlight ' . group . ' gui=NONE'
        endif
      catch
      endtry
    endif
  endfor
endfunction

augroup MyInitGroup
    autocmd!
    autocmd FileType * call DisableGuiBold()
augroup END

" --- Run immediately ---
call DisableGuiBold()

