#!/usr/bin/env python3

import sys
import json
import os 
from typing import List, Dict, Tuple

SYNTAX_SPEC = "syntax_spec.txt"

def parse_syntax_spec(input_file) -> List[str]:
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

def write_output(color_dict: dict, output_path: str) -> None:
    ''' write vim theme to text file '''
    
    # parse the spec
    tokens = parse_syntax_spec(SYNTAX_SPEC)
    
    # TODO - output path is being interpreted as a directory and not the base file
    fh = open(output_path, "w")
    if (not fh):
        raise ValueError("Could not open file.")
    
    # lines to be printed at the top of the file
    output_basename  = os.path.basename(output_path)
    print("[DEBUG] basename = {}".format(output_basename))
    
    vim_header = [
        "\" Name: {}".format(theme_name),
        "hi clear",
        "if exists('syntax_on')",
        "   syntax reset",
        "endif",
        "let g:colors_name = \'{}\'".format(theme_name),
        "set termguicolors",
    ]
    for line in vim_header:
        fh.write(line)

    # custom color scheme
    text_mode = 'NONE' # set all text to non-bold
    default_colors = {
        "fg": "#d0d0d0",
        "bg": "#131313",
        "bg_sec": "#232323",
        "comment": "#404040",
        "pmenu_fg": "darkblue",
        "pmenu_bg": "#232323",
        "keyword_type": "#40a0a0",
        "keyword_control_flow": "#a0a040",
        "number": "#a04040",
        "character": "#a04040",
        "string": "#40a040",

        # TODO - better defaults
        "member_access": "#ffff00",
        "function_access": "#ffa500",
        "namespace_access": "#00ffff",
        "operator": "#ff00ff"
    }

    # reocurring colors so we do not need to instantiate the string every iteration
    color = ""
    primary_fg = color_dict.get("fg", default_colors["fg"])
    primary_bg = color_dict.get("bg", default_colors["bg"])
    
    # TODO - instead of subbing in the color hex directly, sub in s:VAR_NAME for easier vim editting.
    # loop over token types in spec file
    for token in tokens:
        # TODO - terminal gui needs a special variable to set the xterm color
        #if "Pmenu" in t:
        #    field = "comment"
        #    color = color_dict.get(field, default_colors[field])
        #    print("execute \'hi {} ctermbg=darkblue guibg={}\'".format(t, color))
        if token == "Comment":
            color = color_dict.get("comment", primary_fg)
            cmd = "execute \'hi {} guifg={} guibg={} gui={}\'".format(token, color, primary_bg, text_mode)
            fh.write(cmd)
            continue
        
        # TODO - handle different types of keywords
        elif token in ["Keyword", "Type"]:
            color = color_dict.get("keyword_type", primary_fg)
            cmd = "execute \'hi {} guifg={} guibg={} gui={}\'".format(token, color, primary_bg, text_mode)
            fh.write(cmd)
            continue
        
        # TODO - handle string and char differently. char is technically a value.
        elif token in ["String", "Character"]:
            color = color_dict.get("string", primary_fg)
            cmd = "execute \'hi {} guifg={} guibg={} gui={}\'".format(token, color, primary_bg, text_mode)
            fh.write(cmd)
            continue

        # Handle all other types
        else:
            cmd = "execute \'hi {} guifg={} guibg={} gui={}\'".format(token, primary_fg, primary_bg, text_mode)
            fh.write(cmd)
            continue

def handle_color_json() -> Dict[str, str]:
    ''' 
    Parse user color json file. 
    Return a dictionary of category->hex mappings 
    '''
    
    # catch missing arg error
    if (len(sys.argv) < 2):
        raise ValueError("Usage: ./main.py <your_colors.json> (<output_file>)")

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

def handle_output_file_path() -> str:
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
    output_full_path = handle_output_file_path() 

    # write vimscript to output
    write_output(color_dict, output_full_path)

    # print newly created file for sanity checking
    print_output_file(output_full_path)
    
    return 0

if __name__ == "__main__":
    main()

