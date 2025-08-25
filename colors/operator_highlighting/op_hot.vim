" ------------------------------------------------------------------------------
" Name:         hot.vim
" Description:  hot colors theme
" Author:       Logan Richey
" ------------------------------------------------------------------------------

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "subdue"
set termguicolors

let s:bg        = "#000000"
let s:bg_sec    = "#1c1f3a"
let s:fg        = "#e0e0e0"
let s:comment   = "#707070"
let s:color1    = "#ce0044" " scalars
let s:color2    = "#0088fe" " operators
let s:color3    = "#cc6600" " keywords
let s:color4    = "#cccc00" " classes, namespaces, special fname
let s:color5    = "#0000dd" " vi gui text
let s:color6    = "#dddd00" " vi highlight text

let s:keyword1       = s:color3
let s:keyword2       = s:color3
let s:string         = s:color1
let s:number         = s:color1
let s:line_nr        = s:color5
let s:cursor_line_nr = s:color6
let s:paren          = s:color6
let s:defclass       = s:color4
let s:ckeyword       = s:color4
let s:operator_color = s:color2

execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=' . s:bg_sec
execute 'hi CursorLineNr guifg=' . s:keyword2
execute 'hi LineNr guifg=' . "#444444"
execute 'hi Visual guibg=' . "#49483E"
execute 'hi Search guifg=' . s:bg . ' guibg=' . s:keyword2
execute 'hi IncSearch guifg=' . s:bg . ' guibg=' . s:keyword1
execute 'hi MatchParen guifg=' . s:paren . ' guibg=' . "#49483E"
execute 'hi VertSplit guifg=' . "#3e3d32" . ' guibg=' . s:bg
execute 'hi StatusLine guifg=' . s:fg . ' guibg=' . s:bg_sec
execute 'hi StatusLineNC guifg=' . "#666666". ' guibg=' . s:bg_sec

execute 'hi Comment guifg=' . s:comment . ' gui=italic'
execute 'hi Constant guifg=' . s:string
execute 'hi String guifg=' . s:string 
execute 'hi Character guifg=' . s:string
execute 'hi Number guifg=' . s:number
execute 'hi Boolean guifg=' . s:number
execute 'hi Identifier guifg=' . s:defclass
execute 'hi Function guifg=' . s:defclass
execute 'hi Statement guifg=' . s:keyword1
execute 'hi Keyword guifg=' . s:keyword1
execute 'hi PreProc guifg=' . s:keyword1
execute 'hi Type guifg=' . s:keyword2
execute 'hi Special guifg=' . s:number
execute 'hi Error guifg=' . "#ffffff" . ' guibg=#b02752'
execute 'hi Todo guifg=' . "#ffffff" . ' guibg=#a08916'

execute 'hi Title guifg=' . s:keyword1
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"

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
    
    " Namespace Highlights
    syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
    execute "highlight cppNamespace guifg=" . s:defclass . " gui=bold"
endfunction

function! s:setup_ops() abort
    " Highlight operators globally, but exclude Comment and String
    syntax match MyOp "[\!\%\^\&\*\~\-\+\=\[\]\{\}\;\:\,\.\/\(\)\[\]\{\\}\<\>]" containedin=ALLBUT,Comment,String
    execute "highlight MyOp guifg=".s:operator_color
endfunction

augroup MySyntaxTweaks
    autocmd!
    autocmd ColorScheme * call s:setup_ops()
    autocmd FileType * call s:setup_ops()
    
    if &filetype == 'c' || &filetype == 'cpp'
        autocmd ColorScheme * call s:setup_c_keywords()
        autocmd FileType * call s:setup_c_keywords()
    endif
augroup END

