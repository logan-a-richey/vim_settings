#!/usr/bin/env python3

import json
import os
import sys

def get_input_json():
    try:
        if (len(sys.argv) == 1):
            print("[Usage] ./main.py <input.json>")
            exit(1)
        input_json = sys.argv[1]
        data = {}
        with open(input_json, 'r') as file:
            data = json.load(file)
        return data
    except FileNotFoundError:
        print("[E] file not found")
        exit(1)
    except json.JSONDecodeError as e:
        print("[E] error decoding json: {}".format(e))
        exit(1)

def main():
    color_json = get_input_json()
    print(json.dumps(color_json, indent=4))

if __name__ == "__main__":
    main()
