local function map(modes, shortcut, command_or_fn)
  vim.keymap.set(modes, shortcut, command_or_fn, { noremap = true, silent = true })
end

-- Convenient saving
map({ 'n' }, '<leader>w', ':w<CR>')

-- Handy maps for common yank/paste needs
-- Taken from Primeagen and asbjornHaland's 'Greatest remaps ever'
map({ 'v' }, '<leader>P', '"_dP')
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n' }, '<leader>Y', 'gg"+yG')
map({ 'n', 'v' }, '<leader>d', '"_d')

-- Various searchy/openy bindings
local tele = require 'telescope.builtin'
local tele_file_browser = require 'telescope'.extensions.file_browser.file_browser

map({ 'n' }, '<C-f>', tele.live_grep)
map({ 'n' }, '<C-p>', tele.git_files)
map({ 'n' }, '<leader>p', tele.buffers)
map({ 'n' }, '<leader>o', tele_file_browser)
map({ 'n' }, '<leader>sw', function()
  tele.grep_string({ search = vim.fn.expand('<cword>') })
end)
map({ 'n' }, '<leader>ss', function()
  tele.grep_string({ search = vim.fn.input('Rg> '), use_regex = true })
end)

-- Various git-related things
-- Quick access to the fugitive screen
map({ 'n' }, '<leader>gg', ':G<CR>')

-- And niceties around the merge view
map({ 'n' }, '<leader>gd', ':Gvdiffsplit!<CR>')
map({ 'n' }, 'gdh', ':diffget //2<CR>')
map({ 'n' }, 'gdl', ':diffget //3<CR>')
