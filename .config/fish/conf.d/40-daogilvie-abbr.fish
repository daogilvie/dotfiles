if command -v exa >/dev/null
    abbr -a l 'exa'
    abbr -a ls 'exa'
    abbr -a ll 'exa -l'
    abbr -a lll 'exa -la'
    abbr -a tree 'exa --tree'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end
if command -v nvim >/dev/null
    abbr -a e 'nvim'
    abbr -a vim 'nvim'
    abbr -a vdiff 'nvim --diff'
    abbr -a nvses 'nvim -S Session.vim'
end
