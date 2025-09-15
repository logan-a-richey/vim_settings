" ******************************************************************************
" Name:         openai.vim
" Description:  Theme inspired by OPENAI CODE
" Author:       Logan Richey
" Date:         Sep 15, 2025
" ******************************************************************************

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "openai"
set termguicolors

" ******************************************************************************
" User Colors

let s:gray1  = "#101010" " for background 
let s:gray2  = "#202020" " for background current line
let s:gray3  = "#707070" " for comments
let s:white  = "#e0e0e0" " for normal text
let s:blue   = "#2e95d3" " for builtin keywords
let s:orange = "#e9950c" " for builtin functions
let s:turq   = "#06a27b" " for strings
let s:red    = "#f22c3d" " for defname classname
let s:pink   = "#df3079" " for numeric values

" Color Mapping
let s:bg          = s:gray1
let s:bg_sec      = s:gray2
let s:comment     = s:gray3
let s:fg          = s:white
let s:keyword1    = s:blue      " keywords (if, not, return)
let s:keyword2    = s:orange    " types (def, int, struct, etc.)
let s:number      = s:pink      " numbers
let s:paren       = s:orange    " highlighted parentheses
let s:defclass    = s:red       " def/class names
let s:string      = s:turq      " strings, chars, docstrings
" let s:operator_color = s:pink

" ******************************************************************************
" UI Elements

execute 'hi Normal guifg='     . s:fg       . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:keyword2
execute 'hi LineNr guifg='     . "#444444"
execute 'hi Visual guibg='     . "#49483E"
execute 'hi Search guifg='     . s:bg       . ' guibg=' . s:keyword2
execute 'hi IncSearch guifg='  . s:bg       . ' guibg=' . s:keyword1
execute 'hi MatchParen guifg=' . s:paren    . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg='  . "#3e3d32"  . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg       . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:bg_sec

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ******************************************************************************
" Code Syntax highlighting 

execute 'hi Comment guifg='    . s:comment . ' gui=italic'

" covers char, string, numbers
execute 'hi Constant guifg='   . s:string . ' gui=bold'

execute 'hi String guifg='     . s:string . ' gui=bold'
execute 'hi Character guifg='  . s:string . ' gui=bold'
execute 'hi Number guifg='     . s:number . ' gui=bold'
execute 'hi Boolean guifg='    . s:number . ' gui=bold'
execute 'hi Identifier guifg=' . s:defclass . ' gui=bold'
execute 'hi Function guifg='   . s:defclass . ' gui=bold'
execute 'hi Statement guifg='  . s:keyword1 . ' gui=bold'
execute 'hi Keyword guifg='    . s:keyword1 . ' gui=bold'
execute 'hi PreProc guifg='    . s:keyword1 . ' gui=bold'
execute 'hi Type guifg='       . s:keyword2 . ' gui=bold'
execute 'hi Special guifg='    . s:number . ' gui=bold'
execute 'hi Error guifg='      . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg='       . "#ffffff" . ' guibg=#a08916'

" Additional Tweaks
execute 'hi Title guifg='      . s:keyword1
execute 'hi Directory guifg='  . s:defclass
execute 'hi DiffAdd guibg='    . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg='   . "#4c4745"

" *****************************************************************************
" Language Specific and Advanced Tweaks

" Namespaces
function! InitNamespaces() abort
    syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
    execute "highlight cppNamespace guifg=" . s:defclass . " gui=bold"
endfunction

" Advanced Tweaks
function! s:setup_c_keywords() abort
    " <stdlib.h>
    for item in ["abs", "atof", "atoi", "atol", "atoll", "calloc", "div", "exit", "free", "malloc", "qsort", "rand", "realloc", "srand" ]
        execute "syntax match MyKeyword '\\<" . item . "\\>'"
    endfor

    " <string.h>
    for item in ["memchr", "memcmp", "memcpy", "memmove", "memset", "strcat", "strchr", "strcmp", "strcoll", "strcpy", "strcspn", "strerror", "strlen", "strncat", "strncmp", "strncpy", "strpbrk", "strrchr", "strspn", "strstr", "strtok", "strxfrm" ]
        execute "syntax match MyKeyword '\\<" . item . "\\>'"
    endfor
    
    " <stdio.h>
    for item in ["fclose", "feof", "ferror", "fgetc", "fgets", "fopen", "fprintf", "fputc", "fputs", "fread", "fscanf", "fseek", "ftell", "fwrite", "getc", "getchar", "printf", "putc", "putchar", "puts", "remove", "rename", "rewind", "scanf", "snprintf", "sprintf", "sscanf"]
        execute "syntax match MyKeyword '\\<" . item . "\\>'"
    endfor
    
    " <math.h>
    for item in ["acos", "acosh", "asin", "asinh", "atan", "atan2", "atanh", "cbrt", "ceil", "copysign", "cos", "cosh", "exp", "exp2", "expm1", "erf", "erfc", "fabs", "fdim", "floor", "fma", "fmax", "fmin", "fmod", "frexp", "hypot", "ilogb", "ldexp", "lgamma", "llrint", "llround", "log", "log10", "log1p", "log2", "logb", "lrint", "lround", "modf", "nan", "nearbyint", "nextafter", "nexttoward", "pow", "remainder", "remquo", "rint", "round", "scalbln", "scalbn", "sin", "sinh", "sqrt", "tan", "tanh", "tgamma", "trunc"]
        execute "syntax match MyKeyword '\\<" . item . "\\>'"
    endfor
    
    " <ctype.h>
    for item in ["isalnum","isalpha","isblank","iscntrl","isdigit","isgraph","islower","isprint","ispunct","isspace","isupper","isxdigit","tolower","toupper"]
        execute "syntax match MyKeyword '\\<" . item . "\\>'"
    endfor
    
    " <time.h>
    for item in ["time","localtime","gmtime","ctime","asctime","strftime","difftime","mktime","clock"]
        execute "syntax match MyKeyword '\\<" . item . "\\>'"
    endfor

    " Define highlight keyword groups once
    execute "highlight MyKeyword guifg=" . s:defclass . ' gui=bold'
endfunction

" Init Advanced tweaks on startup
augroup MySyntaxTweaks
    autocmd!
    " Always init namespaces for all filetypes
    autocmd Syntax * call InitNamespaces()

    " Only setup C keywords after filetype detection
    autocmd FileType c,cpp call s:setup_c_keywords()
augroup END

