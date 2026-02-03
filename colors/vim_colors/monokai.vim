" ------------------------------------------------------------------------------
" Name:         MONOKAI DARK
" Descripton:   Inspired by VSCode Monokai
" Date:         2026-02-03
" Author:       Logan Richey
" ------------------------------------------------------------------------------

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'monokai_dark'
set termguicolors
" set cursorline

" NOTE: You can see the syntax group being applied to the current word using the following command:
" :echo synIDattr(synID(line('.'), col('.'), 1), 'name')

function! What() abort 
    execute "echo synIDattr(synID(line('.'), col('.'), 1), 'name')"
endfunction 

" ------------------------------------------------------------------------------
" Basic Tones

let s:colors = {
\ 'bg': '#202020',
\ 'bg_sec': '#303030',
\ 'fg': '#cdf2ff',
\ 'gray': '#95906f',
\ 'yellow': '#fdef6c',
\ 'orange': '#ff8900',
\ 'green': '#9df814',
\ 'blue': '#56e4ff',
\ 'purple': '#a76eff',
\ 'magenta': '#ec0c6c',
\}

" ------------------------------------------------------------------------------
" Color Mappings

let s:bg = s:colors.bg
let s:bg_sec = s:colors.bg_sec
let s:comment = s:colors.gray
let s:fg = s:colors.fg

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi Comment guifg=' . s:colors.gray

execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:colors.gray
execute 'hi LineNr guifg=' . s:colors.blue
execute 'hi LineNrAbove guifg=' . s:comment
execute 'hi LineNrBelow guifg=' . s:comment
execute 'hi NonText guifg=' . s:comment

execute 'hi Visual guifg=' . s:bg . ' guibg=' . s:colors.purple
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:colors.purple
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:colors.purple

execute 'hi VertSplit guifg=' . s:bg_sec . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:bg . ' guibg=' . s:fg
execute 'hi StatusLineNC guifg=' . s:bg_sec . ' guibg=' . s:colors.gray

highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

execute 'hi Constant guifg=' . s:colors.blue
execute 'hi String guifg=' . s:colors.purple
execute 'hi Character guifg=' . s:colors.purple
execute 'hi Number guifg=' . s:colors.purple
execute 'hi Boolean guifg=' . s:colors.purple
execute 'hi Identifier guifg=' . s:colors.purple
execute 'hi Function guifg=' . s:colors.blue
execute 'hi Special guifg=' . s:colors.yellow 

" control flow: while, if, for, while, ...
execute 'hi Statement guifg=' . s:colors.magenta

" types: int, float, class, ...
execute 'hi Type guifg=' . s:colors.blue

execute 'hi Keyword guifg=' . s:colors.magenta
execute 'hi PreProc guifg=' . s:colors.magenta
execute 'hi MatchParen guifg=' . s:fg . ' guibg=' . s:colors.blue

execute 'hi pythonExceptions guifg=' . s:colors.blue
execute 'hi pythonInclude guifg=' . s:colors.magenta
execute 'hi pythonStatement guifg=' . s:colors.magenta
execute 'hi pythonNumber guifg=' . s:colors.purple
execute 'hi pythonString guifg=' . s:colors.purple
execute 'hi pythonEscape guifg=' . s:colors.yellow
execute 'hi pythonFunction guifg=' . s:colors.green
execute 'hi pythonBuiltin guifg=' . s:colors.green

execute 'hi pythonDecorator guifg=' . s:colors.fg
execute 'hi pythonDecoratorName guifg=' . s:colors.orange

execute 'hi Error guifg=#d0d0d0 guibg=#dd0000'
execute 'hi Todo guifg=#000000 guibg=#dddd00'

" For merge/pull requests
execute 'hi Title guifg=' . s:colors.green
execute 'hi Directory guifg=' . s:colors.blue
execute 'hi DiffAdd guifg='. s:fg . ' guibg=' . s:colors.green 
execute 'hi DiffChange guifg=' . s:fg . ' guibg=' . s:colors.yellow
execute 'hi DiffText guifg=' . s:fg . ' guibg=' . s:colors.yellow
execute 'hi DiffDelete guifg=' . s:fg . ' guibg=#dd0000'

" ------------------------------------------------------------------------------
" --- Functions ---

function! InitNamespaceSyntax() abort
  syntax match myNamespaceName '\<[A-Za-z_][A-Za-z0-9_]*\(::[~A-Za-z_][A-Za-z0-9_]*\)\+'
  execute 'highlight myNamespaceName guifg=' . s:colors.green
endfunction

function! InitFunctionSyntax() abort
  syntax match myFunctionName '[~A-Za-z_][A-Za-z0-9_]*\ze('
  execute 'highlight myFunctionName guifg=' . s:colors.orange
endfunction

function! InitScopeSyntax() abort
  silent! syntax clear myScopeName
  syntax match myScopeName '[(){}\[\]]'
  execute 'highlight myScopeName guifg=' . s:colors.yellow
endfunction

function! HighlightSelfKeyword() abort
  if &filetype ==# 'python'
    syntax match mySelf '\<self\>'
    execute 'highlight mySelf guifg=' . s:colors.blue
  endif
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
    autocmd FileType * call InitNamespaceSyntax()
    autocmd FileType * call InitScopeSyntax()
    autocmd FileType * call InitFunctionSyntax()
    autocmd FileType * call HighlightSelfKeyword()
    autocmd FileType * call DisableGuiBold()
augroup END

" --- Run immediately ---
call InitNamespaceSyntax()
call InitScopeSyntax()
call InitFunctionSyntax()
call HighlightSelfKeyword()
call DisableGuiBold()

