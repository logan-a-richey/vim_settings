#!/usr/bin/env python3

import json
import os
import sys
from datetime import date 

def get_input_json(input_file):
    try:
        data = {}
        with open(input_file, 'r') as file:
            data = json.load(file)
        return data
    except FileNotFoundError:
        print("[E] file not found")
        exit(1)
    except json.JSONDecodeError as e:
        print("[E] error decoding json: {}".format(e))
        exit(1)

def generate_theme(color_data, theme_name, output_file):
    header_lines = [
        "hi clear",
        "if exists(\'syntax_on\')",
        "    syntax reset",
        "endif",
        "let g:colors_name = \'{}\'".format(theme_name),
        "set termguicolors",
        "set cursorline"
    ]
    ui_lines = [
        "execute \'hi Normal guifg=\' . s:fg . \' guibg=\' . s:bg",
        "execute \'hi CursorLine guibg=\' . s:bg_sec",
        "execute \'hi CursorLineNr guifg=\' . s:kw_type",
        "execute \'hi LineNr guifg=\' . s:comment",
        "execute \'hi Visual guifg=\' . s:select_fg . \' guibg=\' . s:select_bg ",
        "execute \'hi Search guifg=\' . s:select_fg . \' guibg=\' . s:select_bg ",
        "execute \'hi IncSearch guifg=\' . s:bg . \' guibg=\' . s:kw_stmt",
        "execute \'hi MatchParen guifg=\' . s:scope . s:bg_sec",
        "execute \'hi VertSplit guifg=\' . s:bg_sec . \' guibg=\' . s:bg",
        "execute \'hi StatusLineNC guifg=\' . s:bg_sec . \' guibg=\' . s:comment",
        "execute \'hi StatusLine guifg=\' . s:bg . \' guibg=\' . s:fg",
        "highlight Pmenu ctermbg=darkblue guibg=darkblue",
        "highlight PmenuSel ctermbg=blue guibg=blue"
    ] 
    syntax_lines = [
        "execute \'hi Comment guifg=\' . s:comment ",
        "execute \'hi Constant guifg=\' . s:string ",
        "execute \'hi String guifg=\' . s:string ",
        "execute \'hi Character guifg=\' . s:string ",
        "execute \'hi Number guifg=\' . s:number ",
        "execute \'hi Boolean guifg=\' . s:number ",
        "execute \'hi Identifier guifg=\' . s:defclass ",
        "execute \'hi Function guifg=\' . s:defclass ",
        "execute \'hi Statement guifg=\' . s:kw_stmt ",
        "execute \'hi Keyword guifg=\' . s:kw_stmt ",
        "execute \'hi PreProc guifg=\' . s:kw_stmt ",
        "execute \'hi Type guifg=\' . s:kw_type ",
        "execute \'hi Special guifg=\' . s:special ",
        "execute \'hi Error guifg=\' . s:fg . \' guibg=#b02752\'",
        "execute \'hi Todo guifg=\' . s:fg . \' guibg=#a08916\'",
        "\" Additional tweaks",
        "execute \'hi Title guifg=\' . s:kw_stmt",
        "execute \'hi Directory guifg=\' . s:defclass",
        "execute \'hi DiffAdd guibg=\' . \'#13354a\'",
        "execute \'hi DiffChange guibg=\' . \'#4a410d\'",
        "execute \'hi DiffDelete guibg=\' . \'#420e09\'",
        "execute \'hi DiffText guibg=\' . \'#4c4745\'"
    ]
    syntax_function_lines = [
        "\" Language Specific and Advanced Tweaks",
        "",
        "\" Syntax change function : color entire word containing ::",
        "function! InitNamespaceSyntax() abort",
        "    syntax match cppNamespace '\<[a-zA-Z_][a-zA-Z0-9_]*\(::[a-zA-Z_][a-zA-Z0-9_]*\)\+'",
        "    execute 'highlight cppNamespace guifg=' . s:namespace",
        "endfunction ",
        "",
        "\" Syntax change function : color word that precede a (, to signal a function call",
        "function! InitFunctionSyntax() abort",
        "    syntax match cppFunction '\<[A-Za-z_][A-Za-z0-9_]*\ze('",
        "    execute 'highlight cppFunction guifg=' . s:function_name",
        "endfunction",
        "",
        "\" Background change function",
        "function! SetDarkBG() abort ",
        "    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg_gray",
        "    execute 'hi CursorLine guibg=' . s:bg_gray_sec",
        "endfunction ",
        "",
        "\" Background change function",
        "function! SetNormalBG() abort",
        "    execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:turq",
        "    execute 'hi CursorLine guibg=' . s:turq_sec",
        "endfunction ",
        "",
        "\" Disable bold for all syntax groups",
        "function! DisableGuiBold() abort",
        "    for group in getcompletion('', 'highlight')",
        "        if group =~# '^\w\+$' \" Only process valid highlight group names",
        "            try",
        "                \" Get current highlight settings for the group",
        "                redir => l:current_settings",
        "                silent! execute 'highlight ' . group",
        "                redir END",
        "",
        "                \" If 'gui=bold' is present, set gui to NONE",
        "                if l:current_settings =~# 'gui=bold'",
        "                    execute 'highlight ' . group . ' gui=NONE'",
        "                endif",
        "            catch /E28: No such highlight group/",
        "                \" Ignore errors for non-existent groups (shouldn't happen with getcompletion)",
        "            endtry",
        "        endif",
        "    endfor",
        "endfunction",
        "",
        "\" Run OnStart",
        "augroup MySyntaxTweaks",
        "    autocmd!",
        "    \" autocmd Syntax * call InitNamespaceSyntax()",
        "    autocmd Syntax * call InitFunctionSyntax()",
        "    autocmd Syntax * call DisableGuiBold()",
        "augroup END",
        "",
        "\" call InitNamespaceSyntax()",
        "call InitFunctionSyntax()",
        "call DisableGuiBold()",
    ]

    fh = open(output_file, 'w')
    if (not fh):
        print("[E] could not open output_file: {}".format(output_file))
        exit(1)

    divider = "\n\" " + "-"*78 + "\n"

    # write to file
    fh.write(divider)
    fh.write("\" Name: {}\n".format(theme_name))
    fh.write("\" Date: {}\n".format(date.today()))

    fh.write(divider)
    fh.write("\" --- color pallette ---\n\n")
    for line in header_lines:
        fh.write("{}\n".format(line))
    
    fh.write(divider)
    fh.write("\" --- color pallette ---\n\n")
    for k, v in color_data.items():
        fh.write("let s:{} = \'{}\'\n".format(k, v))

    for category, cat_name in zip(
        [ui_lines, syntax_lines, syntax_function_lines], 
        ["ui lines", "syntax lines", "syntax function lines"]
    ):
        fh.write(divider)
        fh.write("\" --- {} ---\n\n".format(cat_name))
        for line in category:
            fh.write("{}\n".format(line))

def print_output_file(output_file):
    try:
        with open(output_file, 'r') as file:
            for line in file:
                print(line, end="")
    except:
        print("[E] could not open output file")

def main():
    if (len(sys.argv) == 1):
        print("[Usage] ./main.py <input.json>")
        exit(1)

    input_file = sys.argv[1]
    if not (input_file.endswith(".json")):
        print("[W] file should be json")

    data = get_input_json(input_file)

    # print(json.dumps(input_file, indent=4))
    
    input_basename = os.path.basename(input_file)
    input_basename_no_ext = os.path.splitext(input_basename)[0]

    output_folder_name = "output_themes"
    output_folder_path = os.path.join(os.getcwd(), output_folder_name)
    os.makedirs(output_folder_path, exist_ok=True)

    output_filename = "{}.vim".format(input_basename_no_ext)
    output_filepath = os.path.join(output_folder_path, output_filename)
    generate_theme(data, input_basename_no_ext, output_filepath)
    
    print("[I] Created file: {}".format(output_filepath))
    print_output_file(output_filepath)

if __name__ == "__main__":
    main()

