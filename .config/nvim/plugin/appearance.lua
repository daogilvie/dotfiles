local opt = vim.opt

-- Nord!
vim.cmd('colorscheme nord')

-- Use termgui colors
opt.termguicolors = true

-- Add a bit more space for cmd displays
-- and use it
opt.cmdheight = 2
opt.showcmd = true

-- And space for the sign column
-- which we fill with git signs!
opt.signcolumn = 'yes'
require('gitsigns').setup()

-- Line numbers, with relative/absolute toggling
opt.number = true
opt.relativenumber = true
local numbertoggle_ag = vim.api.nvim_create_augroup('RelAbsLineToggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' },
  { group = numbertoggle_ag, command = 'set relativenumber' })
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' },
  { group = numbertoggle_ag, command = 'set norelativenumber' })

-- Place a ruler at column 80
opt.colorcolumn = '80'

-- Highlight matching bracket
opt.showmatch = true

-- Highlight on yank
local highlight = require 'vim.highlight'
local h_on_y = function()
  highlight.on_yank({ timeout = 300 })
end
local highlight_yank_ag = vim.api.nvim_create_augroup('HighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', { group = highlight_yank_ag, callback = h_on_y })
