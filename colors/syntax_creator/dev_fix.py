#!/usr/bin/env python3 

# convert one dictionary mapping to another 

import json

DATA = '''
# colors
my_gray1 = "#131313"
my_gray2 = "#24262d"
my_gray3 = "#47525b"
my_white = "#ceced1"
my_cmd_red = "#ff8080"
my_cmd_purple = "#8080ff"
my_cmd_green = "#80ff80"
my_yellow = "#d0d000"
my_light_blue = "#7ac1ff"
my_deep_red = "#681b28"

# mappings
my_dict = {
    "bg" : my_gray1,
    "bg_sec" : my_gray2,
    "comment" : my_gray3,
    "fg" : my_white,
    "kw_type" : my_cmd_purple,
    "kw_flow" : my_cmd_purple,
    "scope" : my_cmd_red,
    "number" : my_cmd_green,
    "string" : my_cmd_green,
    "special" : my_cmd_purple,
    "class" : my_light_blue,
    "function" : my_cmd_red,
    "namespace" : my_light_blue,
    "var_access" : my_light_blue,
    "visual_fg" : my_bg,
    "visual_bg" : my_cmd_green
}
'''

class Scanner:
    def __init__(self):
        self.lookup_dict = {}
        self.output_dict = {} 

    def handle_colors(self, line: str):
        if "=" not in line:
            return

        pair = [t.strip() for t in line.split("=")]
        if (len(pair) != 2):
            return 
        
        k, v = pair[0], pair[1]
        k = k.replace("\"", "")
        v = v.replace("\"", "")
        self.lookup_dict[k] = v 
        print("lookup_dict: added {} => {}".format(k, v))

    def handle_mappings(self, line: str):
        if ":" not in line:
            return 

        pair = [t.strip() for t in line.split(":")]
        if (len(pair) != 2):
            return 

        k, v = pair[0], pair[1]
        k = k.replace("\"", "")
        v = v.replace(",", "")
        self.output_dict[k] = self.lookup_dict.get(v, "MISSING")
    
    def scan(self, data: str):
        lines = data.split("\n")
        mode = "none"
        self.lookup_dict.clear()
        self.output_dict.clear()

        for line in lines:
            if line.startswith("# colors"):
                mode = "colors"
                continue
            if line.startswith("# mappings"):
                mode = "mappings"
                continue
            
            if mode == "colors":
                self.handle_colors(line)
            elif mode == "mappings":
                self.handle_mappings(line)
    
    def show(self):
        print(json.dumps(self.output_dict, indent=4))


def main():
    scanner = Scanner()
    scanner.scan(DATA)
    scanner.show()

if __name__ == "__main__":
    main()

