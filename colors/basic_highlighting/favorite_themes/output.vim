" Name: output.vim
hi clear
if exists('syntax_on')
   syntax reset
endif
let g:colors_name = 'output'
set termguicolors

let s:bg = '#131313'
let s:bg_sec = '#232323'
let s:comment = '#404040'
let s:fg = '#d0d0d0'
let s:kw_type = '#8080ff'
let s:kw_flow = '#8080ff'
let s:scope = '#ff8080'
let s:number = '#a04040'
let s:string = '#40a040'
let s:special = '#8080ff'
let s:class = '#7ac1ff'
let s:function = '#ff8080'
let s:namespace = '#7ac1ff'
let s:var_access = '#7ac1ff'
let s:visual_fg = '#131313'
let s:visual_bg = '#ff8080'
let s:error_fg = '#e0e0e0'
let s:error_bg = '#b02752'
let s:todo_fg = '#e0e0e0'
let s:todo_bg = '#a08916'
let s:underline_blue = '#0000ff'

execute 'hi Boolean guifg=' . s:number  . ' gui=NONE'
execute 'hi Boolean guifg=' . s:number  . ' gui=NONE'
execute 'hi Character guifg=' . s:number  . ' gui=NONE'
execute 'hi Character guifg=' . s:number  . ' gui=NONE'
execute 'hi Comment guifg=' . s:comment . ' gui=NONE' 
execute 'hi Comment guifg=' . s:comment . ' gui=NONE' 
execute 'hi Constant guifg=' . s:string  . ' gui=NONE'
execute 'hi Constant guifg=' . s:string  . ' gui=NONE'
execute 'hi CursorLine guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi CursorLine guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi CursorLineNr guifg=' . s:kw_type . ' gui=NONE'
execute 'hi CursorLineNr guifg=' . s:kw_type . ' gui=NONE'
execute 'hi DiffAdd guibg=#13354a gui=NONE'
execute 'hi DiffAdd guibg=#13354a gui=NONE'
execute 'hi DiffChange guibg=#4a410d gui=NONE'
execute 'hi DiffChange guibg=#4a410d gui=NONE'
execute 'hi DiffDelete guibg=#420e09 gui=NONE'
execute 'hi DiffDelete guibg=#420e09 gui=NONE'
execute 'hi DiffText guibg=#4c4745 gui=NONE'
execute 'hi DiffText guibg=#4c4745 gui=NONE'
execute 'hi Directory guifg=' . s:class . ' gui=NONE'
execute 'hi Directory guifg=' . s:class . ' gui=NONE'
execute 'hi Error guifg=#ffffff guibg=#b02752' . ' gui=NONE'
execute 'hi Error guifg=#ffffff guibg=#b02752' . ' gui=NONE'
execute 'hi Function guifg=' . s:fg  . ' gui=NONE'
execute 'hi Function guifg=' . s:fg  . ' gui=NONE'
execute 'hi Identifier guifg=' . s:fg  . ' gui=NONE'
execute 'hi Identifier guifg=' . s:fg  . ' gui=NONE'
execute 'hi IncSearch guifg=' . s:visual_fg . ' guibg=' . s:visual_bg . ' gui=NONE'
execute 'hi IncSearch guifg=' . s:visual_fg . ' guibg=' . s:visual_bg . ' gui=NONE'
execute 'hi Keyword guifg=' . s:kw_flow  . ' gui=NONE'
execute 'hi Keyword guifg=' . s:kw_flow  . ' gui=NONE'
execute 'hi LineNr guifg=' . s:comment . ' gui=NONE'
execute 'hi LineNr guifg=' . s:comment . ' gui=NONE'
execute 'hi MatchParen guifg=' . s:scope . ' guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi MatchParen guifg=' . s:scope . ' guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg . ' gui=NONE'
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg . ' gui=NONE'
execute 'hi Number guifg=' . s:number  . ' gui=NONE'
execute 'hi Number guifg=' . s:number  . ' gui=NONE'
execute 'hi PreProc guifg=' . s:kw_flow  . ' gui=NONE'
execute 'hi PreProc guifg=' . s:kw_flow  . ' gui=NONE'
execute 'hi Search guifg=' . s:visual_fg . ' guibg=' . s:visual_bg . ' gui=NONE'
execute 'hi Search guifg=' . s:visual_fg . ' guibg=' . s:visual_bg . ' gui=NONE'
execute 'hi Special guifg=' . s:special  . ' gui=NONE'
execute 'hi Special guifg=' . s:special  . ' gui=NONE'
execute 'hi Statement guifg=' . s:kw_flow  . ' gui=NONE'
execute 'hi Statement guifg=' . s:kw_flow  . ' gui=NONE'
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi StatusLineNC guifg=' . s:fg . ' guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi StatusLineNC guifg=' . s:fg . ' guibg=' . s:bg_sec . ' gui=NONE'
execute 'hi String guifg=' . s:string  . ' gui=NONE'
execute 'hi String guifg=' . s:string  . ' gui=NONE'
execute 'hi Title guifg=' . s:kw_flow . ' gui=NONE'
execute 'hi Title guifg=' . s:kw_flow . ' gui=NONE'
execute 'hi Todo guifg=#ffffff guibg=#a08916 gui=NONE'
execute 'hi Todo guifg=#ffffff guibg=#a08916 gui=NONE'
execute 'hi Type guifg=' . s:kw_type  . ' gui=NONE'
execute 'hi Type guifg=' . s:kw_type  . ' gui=NONE'
execute 'hi VertSplit guifg=' . '#s:bg_sec' . ' guibg=' . s:bg . ' gui=NONE'
execute 'hi VertSplit guifg=' . '#s:bg_sec' . ' guibg=' . s:bg . ' gui=NONE'
execute 'hi Visual guifg=' . s:visual_fg . ' guibg=' . s:visual_bg  . ' gui=NONE'
execute 'hi Visual guifg=' . s:visual_fg . ' guibg=' . s:visual_bg  . ' gui=NONE'
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight Pmenu ctermbg=darkblue guibg=darkblue

" Custom Tweaks
function! InitCustomSyntax() abort
    \"syntax match ClassName /\v<(class|struct)\s+\zs\w+/
    \"execute 'highlight ClassName guifg=' . s:class

    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'
    execute 'highlight cppNamespace guifg=' . s:namespace

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