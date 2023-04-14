vim.opt.shell = 'sh'

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
    use 'overcache/NeoSolarized'

    -- Surround/Comment manipulation
    use 'tpope/vim-surround'
    -- use 'tpope/vim-commentary'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Treesitter is wonderful
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Language Server Stuffs
    use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", 'neovim/nvim-lspconfig' }
    use 'nvim-lua/lsp-status.nvim'

    -- Completion Snippets
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-vsnip'
    use "rafamadriz/friendly-snippets"

    -- Telescope for searching
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- Or maybe fzf lua?
    use { 'ibhagwan/fzf-lua',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- Null LS for odds and sods that servers don't quite cover
    use { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'jay-babu/mason-null-ls.nvim' }

    -- Git integration
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb' -- For github+fugitive
    use 'lewis6991/gitsigns.nvim'

    -- Session Management made dead easy
    use 'tpope/vim-obsession'

    -- EditorConfig support
    use 'editorconfig/editorconfig-vim'

    -- Movement commands
    use 'tpope/vim-unimpaired'

    -- Better terminal / test integration
    use 'tpope/vim-dispatch'
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use {
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
        }
    }
    use {
        'nvim-neotest/neotest-vim-test',
        requires = {
            'vim-test/vim-test'
        }
    }
    use 'nvim-neotest/neotest-python'

    -- Language specific definitions
    use 'ziglang/zig.vim'
    use 'NoahTheDuke/vim-just'
    use 'earthly/earthly.vim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
