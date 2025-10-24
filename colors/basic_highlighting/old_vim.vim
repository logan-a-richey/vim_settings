" ------------------------------------------------------------------------------
" Name:     old_vim.vim
" Info:     Inspired from default linux terminal.
" Author:   Logan Richey
" Date:     Oct 23, 2025
" ------------------------------------------------------------------------------

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "old_vim"
set termguicolors

" Main colors
" bg original 300a24

let s:dark_purple = "#202020"
let s:gray = "#505050"
let s:white = "#e0e0e0"
let s:yellow = "#fce94f"
let s:cyan = "#00ffff"
let s:light_purple = "#a97ba0"
let s:salmon = "#ffcccb"
let s:green = "#98ff98"

" Color Mapping
let s:bg = s:dark_purple
let s:bg_sec = s:dark_purple 
let s:comment = s:cyan
let s:fg = s:white
let s:keyword1 = s:yellow
let s:keyword2 = s:yellow
let s:number = s:light_purple
let s:paren = s:cyan
let s:defclass = s:salmon
let s:string = s:green

" UI Elements
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

" Change popup menu background to dark blue
highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight PmenuSel ctermbg=blue guibg=blue

" ******************************************************************************
" Code Syntax highlighting 

execute 'hi Comment guifg=' . s:comment

" covers char, string, numbers
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

" Additional Tweaks
execute 'hi Title guifg=' . s:keyword1
execute 'hi Directory guifg=' . s:defclass
execute 'hi DiffAdd guibg=' . "#13354a"
execute 'hi DiffChange guibg=' . "#4a410d"
execute 'hi DiffDelete guibg=' . "#420e09"
execute 'hi DiffText guibg=' . "#4c4745"

" ------------------------------------------------------------------------------
" Language Specific and Advanced Tweaks

" Namespaces
" Any word containing :: will be highlighed as a defclass
function! InitNamespaces() abort
    syntax match cppNamespace "\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+"
    execute "highlight cppNamespace guifg=" . s:defclass
endfunction

" ------------------------------------------------------------------------------
" Highlight words from C standard headers

function! s:SetupCLib() abort
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
    execute "highlight MyKeyword guifg=" . s:defclass
endfunction

" ------------------------------------------------------------------------------
" Init Advanced tweaks on startup

augroup MySyntaxTweaks
    autocmd!
    autocmd Syntax * call InitNamespaces()
    autocmd FileType c,cpp call s:SetupCLib()
augroup END

" In case Namespaces does not load, simply call the function again.
call InitNamespaces()

