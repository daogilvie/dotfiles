function dotconf -d "Dotfile git wrapper" -w git
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
