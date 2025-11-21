# TODO
The themes in the `tested/` folder are *battle-tested* and ready to go.<br>
The other themes, after some introspection, are dubious at best. <br>
I am becoming officially cracked at `vimscript`. I can now color my terminal in ever more creative ways. <br>

## Themes
* Monokai           (variation of VsCode theme)
* Kimbie            (variation of VsCode theme)
* GeditCobalt       (variation of Gedit Cobalt theme)
* GeditSolarized    (variation on Solarized Dark theme)
* Naysayer          (Johnathan Blow's favorite theme)
* Glacier           (Stacy Gaudreau theme)
* StackOverflow     (variation of theme as seen in Stack Overflow code snippets)
* GithubDark        (variation of theme as seen in Github)
* VsCodeDark        (Standard VsCode C++ dark theme)
* ChatGpt           (using colors seen in ChatGpt code snippets)
* Renoise           (as seen from Famitracker)
* Dracula           (popular green and pink theme)
* SystematicChaos   (using colors from a Dream Theater album as a code theme!)


## Generator
* Python generator that reads in a .json file and outputs the correct `vimscript` file.

## Regex Planning:

### match function call
**TODO** - negative look-behind to ensure :: does precede expression.
```vimscript
:%s/\(~\?[a-zA-Z_][a-zA-Z0-9_]*\)\((\)/\1\2
```

### match member access
**TODO** - negative look-behind to ensure :: does precede expression.
```vimscript
:%s/\(->\|\.\)\([a-zA-Z_][a-zA-Z0-9_]*\)/\1\2 
```

### match namespace access
**TODO** - positive look-ahead to not match on a namspeace function call.
```vimscript
:%s/\([a-zA-Z_][a-zA-Z0-9_]*\)\(::[a-zA-Z_][a-zA-Z0-9_]*\(\?\!\\)\)\+
```

### match namespace function call
**TODO** - positive look-behind to not match
```vimscript
:%s/\(::\)\([a-zA-Z_][a-zA-Z0-9_]*\)\((\)/\1\2\3 
```

### match paren
```vimscript
:%s/\([()\[\]\{\}]\)/\1/g
```

**NOTE** All of these match groups should not match inside of comment blocks 

