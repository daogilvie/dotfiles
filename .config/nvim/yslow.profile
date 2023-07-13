FUNCTION  <SNR>21_SynSet()
    Defined: /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/syntax/synload.vim:26
Called 5 times
Total time:   0.002115
 Self time:   0.002115

count  total (s)   self (s)
                              " clear syntax for :set syntax=OFF  and any syntax name that doesn't exist
    5              0.000015   syn clear
    5              0.000010   if exists("b:current_syntax")
                                unlet b:current_syntax
    5              0.000002   endif
                            
    5              0.000012   0verbose let s = expand("<amatch>")
    5              0.000005   if s == "ON"
                                " :set syntax=ON
                                if &filetype == ""
                                  echohl ErrorMsg
                                  echo "filetype unknown"
                                  echohl None
                                endif
                                let s = &filetype
    5              0.000004   elseif s == "OFF"
                                let s = ""
    5              0.000001   endif
                            
    5              0.000003   if s != ""
                                " Load the syntax file(s).  When there are several, separated by dots,
                                " load each in sequence.  Skip empty entries.
    6              0.000008     for name in split(s, '\.')
    3              0.000004       if !empty(name)
    3              0.001033         exe "runtime! syntax/" . name . ".vim syntax/" . name . "/*.vim"
    3              0.000959         exe "runtime! syntax/" . name . ".lua syntax/" . name . "/*.lua"
    3              0.000001       endif
    6              0.000003     endfor
    5              0.000001   endif

FUNCTION  <SNR>1_LoadFTPlugin()
    Defined: /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/ftplugin.vim:14
Called 3 times
Total time:   0.014908
 Self time:   0.014908

count  total (s)   self (s)
    3              0.000020     if exists("b:undo_ftplugin")
                                  exe b:undo_ftplugin
                                  unlet! b:undo_ftplugin b:did_ftplugin
    3              0.000002     endif
                            
    3              0.000014     let s = expand("<amatch>")
    3              0.000004     if s != ""
    3              0.000017       if &cpo =~# "S" && exists("b:did_ftplugin")
                            	" In compatible mode options are reset to the global values, need to
                            	" set the local values also when a plugin was already used.
                            	unlet b:did_ftplugin
    3              0.000001       endif
                            
                                  " When there is a dot it is used to separate filetype names.  Thus for
                                  " "aaa.bbb" load "aaa" and then "bbb".
    6              0.000016       for name in split(s, '\.')
                                    " Load Lua ftplugins after Vim ftplugins _per directory_
                                    " TODO(clason): use nvim__get_runtime when supports globs and modeline
    3              0.001036         exe printf('runtime! ftplugin/%s.vim ftplugin/%s.lua', name, name)
    3              0.012501         exe printf('runtime! ftplugin/%s_*.vim ftplugin/%s_*.lua', name, name)
    3              0.001258         exe printf('runtime! ftplugin/%s/*.vim ftplugin/%s/*.lua', name, name)
    6              0.000005       endfor
    3              0.000001     endif

FUNCTION  GetLuaIndent()
    Defined: /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/indent/lua.vim:29
Called 2 times
Total time:   0.000123
 Self time:   0.000123

count  total (s)   self (s)
                              " Find a non-blank line above the current line.
    2              0.000017   let prevlnum = prevnonblank(v:lnum - 1)
                            
                              " Hit the start of the file, use zero indent.
    2              0.000004   if prevlnum == 0
                                return 0
    2              0.000002   endif
                            
                              " Add a 'shiftwidth' after lines that start a block:
                              " 'function', 'if', 'for', 'while', 'repeat', 'else', 'elseif', '{'
    2              0.000003   let ind = indent(prevlnum)
    2              0.000003   let prevline = getline(prevlnum)
    2              0.000023   let midx = match(prevline, '^\s*\%(if\>\|for\>\|while\>\|repeat\>\|else\>\|elseif\>\|do\>\|then\>\)')
    2              0.000002   if midx == -1
    2              0.000006     let midx = match(prevline, '{\s*$')
    2              0.000001     if midx == -1
    2              0.000010       let midx = match(prevline, '\<function\>\s*\%(\k\|[.:]\)\{-}\s*(')
    2              0.000001     endif
    2              0.000000   endif
                            
    2              0.000001   if midx != -1
                                " Add 'shiftwidth' if what we found previously is not in a comment and
                                " an "end" or "until" is not present on the same line.
                                if synIDattr(synID(prevlnum, midx + 1, 1), "name") != "luaComment" && prevline !~ '\<end\>\|\<until\>'
                                  let ind = ind + shiftwidth()
                                endif
    2              0.000000   endif
                            
                              " Subtract a 'shiftwidth' on end, else, elseif, until and '}'
                              " This is the part that requires 'indentkeys'.
    2              0.000013   let midx = match(getline(v:lnum), '^\s*\%(end\>\|else\>\|elseif\>\|until\>\|}\)')
    2              0.000004   if midx != -1 && synIDattr(synID(v:lnum, midx + 1, 1), "name") != "luaComment"
                                let ind = ind - shiftwidth()
    2              0.000000   endif
                            
    2              0.000001   return ind

FUNCTION  <SNR>2_LoadIndent()
    Defined: /opt/homebrew/Cellar/neovim/0.9.1/share/nvim/runtime/indent.vim:13
Called 3 times
Total time:   0.000886
 Self time:   0.000886

count  total (s)   self (s)
    3              0.000005     if exists("b:undo_indent")
                                  exe b:undo_indent
                                  unlet! b:undo_indent b:did_indent
    3              0.000001     endif
    3              0.000006     let s = expand("<amatch>")
    3              0.000003     if s != ""
    3              0.000003       if exists("b:did_indent")
                            	unlet b:did_indent
    3              0.000001       endif
                            
                                  " When there is a dot it is used to separate filetype names.  Thus for
                                  " "aaa.bbb" load "indent/aaa.vim" and then "indent/bbb.vim".
    6              0.000009       for name in split(s, '\.')
    3              0.000446         exe 'runtime! indent/' . name . '.vim'
    3              0.000391         exe 'runtime! indent/' . name . '.lua'
    6              0.000003       endfor
    3              0.000001     endif

FUNCTIONS SORTED ON TOTAL TIME
count  total (s)   self (s)  function
    3   0.014908             <SNR>1_LoadFTPlugin()
    5   0.002115             <SNR>21_SynSet()
    3   0.000886             <SNR>2_LoadIndent()
    2   0.000123             GetLuaIndent()

FUNCTIONS SORTED ON SELF TIME
count  total (s)   self (s)  function
    3              0.014908  <SNR>1_LoadFTPlugin()
    5              0.002115  <SNR>21_SynSet()
    3              0.000886  <SNR>2_LoadIndent()
    2              0.000123  GetLuaIndent()

