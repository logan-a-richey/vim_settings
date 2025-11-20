#!/usr/bin/env python3 

lst = [
    "#1e1e1e",
    "#d4d4d4",
    "#2a2a2a",
    "#6a6a6a",
    "#569cd6",
    "#c586c0",
    "#98c379",
    "#dcdcaa",
    "#4ec9b0",
    "#9cdcfe"
]

for i, c in enumerate(lst):
    cmd = "<tr> <td>Color_{}</td> <td style=\"background-color: {};\"></td> </tr>".format(i, c)
    print(cmd)

