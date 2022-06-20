local opt = vim.opt

-- Disable swap/backup
opt.backup = false
opt.wb = false
opt.swapfile = false
opt.autoread = true

-- Don't need modelines
opt.modeline = false
opt.modelines = 0

-- But I do want to persist undo buffers to disk
opt.undofile = true

-- Sane, friendly search behaviour
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Splits are placed under/to-the-right
opt.splitbelow = true
opt.splitright = true

-- I tend to find spaces everywhere is a good default
-- and outsource any language-specific settings to
-- editorconfig
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.copyindent = true

-- Fold things via indent in the default case
opt.foldmethod = 'indent'
opt.foldlevel = 4

-- I'm a brit
opt.spelllang = 'en_gb'

-- No wrapping, with nicer scroll behaviour
opt.wrap = false
opt.sidescroll = 5
opt.scrolloff = 5

-- Tweak nvim built-in text formatter
-- Based on TJDevries config:
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/options.lua
opt.formatoptions = opt.formatoptions
  -- No need for weird paragraph indentation.
  - "2"
  -- Disable builtin autoformatting
  - "a"
  - "t"
  -- Comment handling niceties
  + "j"
  + "q"
  -- Comment leader auto-insertion in all cases
  + "o"
  + "r"
  -- Indented lists
  + "n"
