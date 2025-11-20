#!/usr/bin/env python3

import sys
import json
import os 
from typing import (List, Dict, Tuple)
from copy import deepcopy

SYNTAX_SPEC = "syntax_spec.txt"

def get_tokens(input_file) -> List[str]:
    ''' returns a list of valid vimscript highlight group strings '''

    tokens = []
    with open(input_file, 'r') as file:
        for line in file:
            line = line.strip()
            tokens_in_line = line.split()
            if tokens_in_line:
                tokens.extend(tokens_in_line)
    tokens.sort()
    return tokens

def get_vim_commands(color_dict: Dict[str, str], tokens: List[str]) -> List[str]:
    # custom color scheme
    text_mode = 'NONE' # set all text to non-bold
        
    # default colors (renoise theme)
    default_color_dict = {
        "bg": "#131313",
        "bg_sec": "#24262d",
        # "comment": "#47525b",
        "comment": "#404040",
        "fg": "#ceced1",
        "kw_type": "#8080ff",
        "kw_flow": "#8080ff",
        "scope": "#ff8080",
        "number": "#80ff80",
        "string": "#80ff80",
        "special": "#8080ff",
        "class": "#7ac1ff",
        "function": "#ff8080",
        "namespace": "#7ac1ff",
        "var_access": "#7ac1ff",
        # "visual_fg": "#ceced1",
        # "visual_bg": "#80ff80"
    }
    default_color_dict["visual_fg"] = deepcopy(default_color_dict["bg"])
    default_color_dict["visual_bg"] = deepcopy(default_color_dict["scope"])

    vimscript_var_lookup = {
        "bg": color_dict.get("bg", default_color_dict["bg"]),
        "bg_sec": color_dict.get("bg_sec", default_color_dict["bg_sec"]),
        "comment": color_dict.get("comment", default_color_dict["comment"]),
        "fg": color_dict.get("fg", default_color_dict["fg"]),
        "kw_type": color_dict.get("kw_type", default_color_dict["kw_type"]),
        "kw_flow": color_dict.get("kw_flow", default_color_dict["kw_flow"]),
        "scope": color_dict.get("scope", default_color_dict["scope"]),
        "number": color_dict.get("number", default_color_dict["number"]),
        "string": color_dict.get("string", default_color_dict["string"]),
        "special": color_dict.get("special", default_color_dict["special"]),
        "class": color_dict.get("class", default_color_dict["class"]),
        "function": color_dict.get("function", default_color_dict["function"]),
        "namespace": color_dict.get("namespace", default_color_dict["namespace"]),
        "var_access": color_dict.get("var_access", default_color_dict["var_access"]),
        "visual_fg": color_dict.get("visual_fg", default_color_dict["visual_fg"]),
        "visual_bg": color_dict.get("visual_bg", default_color_dict["visual_bg"]),
        "error_fg": "#e0e0e0",
        "error_bg": "#b02752",
        "todo_fg": "#e0e0e0",
        "todo_bg": "#a08916",
        "underline_blue": "#0000ff"
    }
    
    
    # reocurring colors so we do not need to instantiate the string every iteration
    color = ""
    primary_fg = color_dict.get("fg", default_color_dict["fg"])
    primary_bg = color_dict.get("bg", default_color_dict["bg"])
    
    # TODO - instead of subbing in the color hex directly, sub in s:VAR_NAME for easier vim editting.
    # loop over token types in spec file
    cmds = []

    for token in tokens:
        if (token == "Pmenu"):
            cmd = "highlight Pmenu ctermbg=darkblue guibg=darkblue"
            cmds.append(cmd)
            continue
        elif (token == "PemnuSel"):
            cmd = "highlight PmenuSel ctermbg=blue guibg=blue"
            cmds.append(cmd)
            continue
        elif (token == "Normal"):
            cmd = "execute \'hi Normal guifg=\' . s:fg . \' guibg=\' . s:bg . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "CursorLine"):
            cmd = "execute \'hi CursorLine guibg=\' . s:bg_sec . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "CursorLineNr"):
            cmd = "execute \'hi CursorLineNr guifg=\' . s:kw_type . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "LineNr"):
            cmd = "execute \'hi LineNr guifg=\' . s:comment . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "Visual"):
            cmd = "execute \'hi Visual guifg=\' . s:visual_fg . \' guibg=\' . s:visual_bg  . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "Search"):
            cmd = "execute \'hi Search guifg=\' . s:visual_fg . \' guibg=\' . s:visual_bg . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "IncSearch"):
            cmd = "execute \'hi IncSearch guifg=\' . s:visual_fg . \' guibg=\' . s:visual_bg . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "MatchParen"):
            cmd = "execute \'hi MatchParen guifg=\' . s:scope . \' guibg=\' . s:bg_sec . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "VertSplit"):
            cmd = "execute \'hi VertSplit guifg=\' . \'#s:bg_sec\' . \' guibg=\' . s:bg . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "StatusLine"):
            cmd = "execute \'hi StatusLine guifg=\' . s:fg . \' guibg=\' . s:bg_sec . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "StatusLineNC"):
            cmd = "execute \'hi StatusLineNC guifg=\' . s:fg . \' guibg=\' . s:bg_sec . \' gui=NONE\'"
            cmds.append(cmd)
        elif (token == "Comment"):
            cmd = "execute \'hi Comment guifg=\' . s:comment . \' gui=NONE\' " 
            cmds.append(cmd)
        elif (token == "Constant"):
            cmd = "execute \'hi Constant guifg=\' . s:string  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "String"):
            cmd = "execute \'hi String guifg=\' . s:string  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Character"):
            cmd = "execute \'hi Character guifg=\' . s:number  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Number"):
            cmd = "execute \'hi Number guifg=\' . s:number  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Boolean"):
            cmd = "execute \'hi Boolean guifg=\' . s:number  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Identifier"):
            cmd = "execute \'hi Identifier guifg=\' . s:fg  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Function"):
            cmd = "execute \'hi Function guifg=\' . s:fg  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Statement"):
            cmd = "execute \'hi Statement guifg=\' . s:kw_flow  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Keyword"):
            cmd = "execute \'hi Keyword guifg=\' . s:kw_flow  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "PreProc"):
            cmd = "execute \'hi PreProc guifg=\' . s:kw_flow  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Type"):
            cmd = "execute \'hi Type guifg=\' . s:kw_type  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Special"):
            cmd = "execute \'hi Special guifg=\' . s:special  . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Error"):
            cmd = "execute \'hi Error guifg=#ffffff guibg=#b02752\' . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Todo"):
            cmd = "execute \'hi Todo guifg=#ffffff guibg=#a08916 gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Title"):
            cmd = "execute \'hi Title guifg=\' . s:kw_flow . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "Directory"):
            cmd = "execute \'hi Directory guifg=\' . s:class . \' gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "DiffAdd"):
            cmd = "execute \'hi DiffAdd guibg=#13354a gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "DiffChange"):
            cmd = "execute \'hi DiffChange guibg=#4a410d gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "DiffDelete"):
            cmd = "execute \'hi DiffDelete guibg=#420e09 gui=NONE\'" 
            cmds.append(cmd)
        elif (token == "DiffText"):
            cmd = "execute \'hi DiffText guibg=#4c4745 gui=NONE\'" 
            cmds.append(cmd)
        else:
            generic_fg = "s:fg"
            generic_bg = "s:bg"
            generic_mode = "NONE"
            if ("Underline" in token):
                #if "underline_blue" not in vimscript_var_lookup:
                #    vimscript_var_lookup["underline_blue"] = "#0000ff"
                generic_fg = "s:underline_blue"
                generic_mode = "underline"
            if ("Error" in token):
                #if "error_fg" not in vimscript_var_lookup:
                #    vimscript_var_lookup["error_fg"] = "#e0e0e0"
                #if "error_bg" not in vimscript_var_lookup:
                #    vimscript_var_lookup["error_bg"] = "#b02752"
                generic_fg = "s:error_fg"
                generic_bg = "s:error_bg"
            cmd = "execute \'hi {} guifg=\' . {} . \' guibg=\' . {} . \' gui={}\'".format(
                token, generic_fg, generic_bg, generic_mode
            )
            pass
        
    cmds.sort()
    return cmds, vimscript_var_lookup

def write_output(color_dict: dict, output_path: str) -> None:
    ''' write vim theme to text file '''
    
    # parse the spec
    tokens = get_tokens(SYNTAX_SPEC)
    cmds, vimscript_var_lookup = get_vim_commands(color_dict, tokens) 

    # lines to be printed at the top of the file
    output_basename  = os.path.basename(output_path)
    output_basename_without_extension = os.path.splitext(output_basename)[0] 
    
    vim_header = [
        "\" Name: {}.vim".format(output_basename_without_extension),
        "hi clear",
        "if exists('syntax_on')",
        "   syntax reset",
        "endif",
        "let g:colors_name = \'{}\'".format(output_basename_without_extension),
        "set termguicolors",
    ]

    vim_closer = r'''" Custom Tweaks
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

call InitCustomSyntax()'''
    

    fh = open(output_path, "w")
    if (not fh):
        raise ValueError("Could not open file.")
    
    for line in vim_header:
        fh.write(line)
        fh.write("\n")
    fh.write("\n")
    
    for k, v in vimscript_var_lookup.items():
        fh.write("let s:{} = \'{}\'\n".format(k, v))
    fh.write("\n")
    
    for cmd in cmds:
        fh.write(cmd)
        fh.write("\n")
    fh.write("\n")
    
    fh.write(vim_closer)

    fh.close() 

def handle_color_json() -> Dict[str, str]:
    ''' 
    Parse user color json file. 
    Return a dictionary of category->hex mappings 
    '''
    
    # catch missing arg error
    if (len(sys.argv) < 2):
        raise ValueError("Usage: ./main.py <your_colors.json> (<output_path>)")

    input_color_json = sys.argv[1]
    input_color_json_path = os.path.abspath(input_color_json)
    # input_color_json_with_ext = os.path.basename(color_json_path)
    # input_color_json_without_ext, ext = os.path.splitext(color_json_basename_with_ext)
    
    # convert user color json file to dictionary
    color_dict = {}
    try:
        with open(input_color_json_path, "r") as file:
            color_dict = json.load(file)
    except Exception as e:  
        print("An error occured while reading color json file: {}".format(e))
        exit(1)

    return color_dict 

# TODO
def handle_output_path() -> str:
    output_full_path = ""
    
    if (len(sys.argv) < 3):
        print("[WARN] Output path not specified. Writing to current working directory.")
        output_filename = "DEFAULT_THEME.vim"
        output_dir = os.getcwd()
        output_full_path = os.path.join(output_filename, output_dir)
    else:
        output_filename = sys.argv[2]
        output_full_path = os.path.abspath(output_filename)
    
    return output_full_path 

def print_output_file(output_path) -> None:
    with open(output_path, 'r') as file:
        for line in file:
            line = line.strip()
            print(line)

def main() -> int:
    # ideal usage: ./main <user_colors.json> <output.vim>

    # --- Handle Arg1: load color json into dict ---
    color_dict = handle_color_json()
   
    # --- Handle Arg2: optional output file path ---
    # output_full_path = handle_output_file_path() 
    output_filename = "output.vim"
    output_path = os.path.join(os.getcwd(), output_filename) 

    # write vimscript to output
    write_output(color_dict, output_path)

    # print newly created file for sanity checking
    print_output_file(output_path)
    
    return 0

if __name__ == "__main__":
    main()

