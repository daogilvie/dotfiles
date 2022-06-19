local g = vim.g

-- Don't use or care for ruby/perl providers
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- Python 2? No thanks.
g.loaded_python_provider = 0

-- Python 3? Yes please
local HOME = os.getenv('HOME')
g.python3_host_prog = HOME .. '/.config/nvim/neovim_venv/bin/python'
