--[[
     Auto bootstrapper code, taken from example in packer repo readme
     (https://github.com/wbthomason/packer.nvim#bootstrapping)
--]]
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end


return require('packer').startup(function(use)
  -- Tell Packer to keep packer, I guess?
  use 'wbthomason/packer.nvim'

  -- Visuals
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'arcticicestudio/nord-vim'

  -- Surround/Comment manipulation
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'

  -- Treesitter is wonderful
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Language Server Stuffs
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'

  -- Completion Snippets
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- Telescope for searching
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- Git integration
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- Session Management made dead easy
  use 'tpope/vim-obsession'

  -- EditorConfig support
  use 'editorconfig/editorconfig-vim'

  -- Movement commands
  use 'tpope/vim-unimpaired'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
