#!/usr/bin/env python3

""" Usage: 

./enhance_colors.py ../text_files/monokai.json  > new_monokai_colors.txt
./enhance_colors.py ../text_files/solarized.json  > new_solarized_colors.txt

"""

import colorsys
import json 
import os
import sys 

class HSV_Balancer:
    """ hsv utils """

    def __init__(self):
        def increase_hsv(hex_color, sat_factor=1.1, val_factor=1.1):
            """ Enhance color by increasing the value in HSV """
            
            hex_color = hex_color.lstrip('#')
            r = int(hex_color[0:2], 16) / 255
            g = int(hex_color[2:4], 16) / 255
            b = int(hex_color[4:6], 16) / 255
            h, s, v = colorsys.rgb_to_hsv(r, g, b)
            s = min(1.0, s * sat_factor)
            v = min(1.0, v * val_factor)
            r, g, b = colorsys.hsv_to_rgb(h, s, v)
            return f"#{int(r*255):02x}{int(g*255):02x}{int(b*255):02x}"

class Contrast_Balancer:
    """
    contrast utils
    defn:
    contrast = (L_lighter + 0.05) / (L_darker + 0.05)
    """

    def __init__(self):
        pass
    
    def rel_luminance(self, r, g, b) -> tuple:
        def f(c):
            return c/12.92 if c <= 0.03928 else ((c + 0.055)/1.055) ** 2.4
        r, g, b = map(f, (r, g, b))
        return 0.2126*r + 0.7152*g + 0.0722*b

    def hex_to_rgb01(self, hex_color) -> tuple:
        hex_color = hex_color.lstrip('#')
        return tuple(int(hex_color[i:i+2], 16)/255 for i in (0, 2, 4))

    def contrast_ratio(self, hex1, hex2) -> float:
        l1 = self.rel_luminance(*self.hex_to_rgb01(hex1))
        l2 = self.rel_luminance(*self.hex_to_rgb01(hex2))
        lighter, darker = max(l1, l2), min(l1, l2)
        return (lighter + 0.05) / (darker + 0.05)

    def increase_contrast(self, hex_color: str, bg_hex: str, target=4.5, step=0.01) -> str:
        r, g, b = self.hex_to_rgb01(hex_color)
        h, l, s = colorsys.rgb_to_hls(r, g, b)

        bg_lum = self.rel_luminance(*self.hex_to_rgb01(bg_hex))

        for _ in range(200):
            if self.contrast_ratio(hex_color, bg_hex) >= target:
                break

            # Move lightness away from background luminance
            if self.rel_luminance(r, g, b) <= bg_lum:
                l = min(1.0, l + step)
            else:
                l = max(0.0, l - step)

            r, g, b = colorsys.hls_to_rgb(h, l, s)
            hex_color = f"#{int(r*255):02x}{int(g*255):02x}{int(b*255):02x}"

        return hex_color


def load_color_json(input_file) -> dict:
    """ Get the input json, return as Python dictionary """
    
    data_dict = {}
    try:
        with open(input_file, 'r') as file:
            data_dict = json.load(file)

        # print("loaded json - good")
        # print(data_dict)
    except FileNotFoundError:
        print("[E] Could not find {}".format(input_file))
        print("[E] Aborting.")
        exit(1)
    except Exception as e:
        print("[E] An error has occurred: {}".format(e))
        exit(1)
    
    return data_dict

def print_new_colors(input_file, color_json):
    """ Write to stdout """

    basename = os.path.splitext(os.path.basename(input_file))[0]
    basename = basename.lower()
    
    my_value_editor = HSV_Balancer()
    my_contraster = Contrast_Balancer()

    first_key = list(color_json.keys())[0]
    first_value = color_json[first_key]
    background_color = first_value

    for name, color in color_json.items():
        # new_color =  my_value_editor.increase_hsv(color, 1.15, 1.10)
        new_color = my_contraster.increase_contrast(color, background_color)
        
        print("let s:{}_{} = \'{}\'".format(basename, name, new_color))

def main():
    if len(sys.argv) != 2:
        print("Usage: ./main.py <input.json>")
        exit(1)
    
    input_file = sys.argv[1] 
    color_json = load_color_json(input_file)
    print_new_colors(input_file, color_json)

if __name__ == "__main__":
    main()

