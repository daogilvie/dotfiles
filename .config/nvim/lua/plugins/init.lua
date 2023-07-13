-- Contains any modules that are universally applicable, or have hardly any config
return {
    -- Catppucin seems nice
    { "nvim-lua/plenary.nvim" }, -- This provides utility functions for other plugins
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                integrations = {
                    telescope = {
                        enabled = true
                    },
                    treesitter = true,
                    which_key = true
                }
            })
            vim.cmd([[colorscheme catppuccin-mocha]])
        end
    },
    "MunifTanjim/nui.nvim",       -- This provides UI elements for other plugins
    {
        "stevearc/dressing.nvim", -- As does this
        event = "VeryLazy",
        opts = {
            input = { relative = "editor" },
            select = {
                backend = { "telescope", "fzf", "builtin" },
            },
        },
    },
    -- Nice notifcations
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
        config = function(_, opts)
            require("notify").setup(opts)
            vim.notify = require "notify"
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = { default = true },
    },
    -- The obligatory tpope entry
    { "tpope/vim-surround",   event = "BufReadPre" }, -- Nice surround manipulation
    -- The obligatory folke section
    -- Nicer diagnostics
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            {
                "<leader>xx",
                "<cmd>TroubleToggle<cr>",
                desc =
                "Toggle Trouble"
            },
            {
                "<leader>xw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc =
                "Workspace diagnostics"
            },
            {
                "<leader>xd",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc =
                "Document diagnostics"
            },
            {
                "<leader>xl",
                "<cmd>TroubleToggle loclist<cr>",
                desc =
                "Loclist"
            },
            {
                "<leader>xq",
                "<cmd>TroubleToggle quickfix<cr>",
                desc =
                "Quickfix"
            },
            {
                "]x",
                function() require("trouble").next({ skip_groups = true, jump = true }); end,
                desc = "Next Trouble Item"
            },
            {
                "[x",
                function() require("trouble").previous({ skip_groups = true, jump = true }); end,
                desc = "Previous Trouble Item"
            }
        }
    },
    -- Used to use tpope's Obsession.vim but giving the below a try now for session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
        keys = {
            { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            {
                "<leader>qd",
                function() require("persistence").stop() end,
                desc =
                "Don't Save Current Session"
            },
        },
    },
    -- Well regarded task runner.
    {
        "stevearc/overseer.nvim",
        keys = {
            { "<leader>rR", "<cmd>OverseerRunCmd<cr>",       desc = "Run Command" },
            { "<leader>ra", "<cmd>OverseerTaskAction<cr>",   desc = "Task Action" },
            { "<leader>rb", "<cmd>OverseerBuild<cr>",        desc = "Build" },
            { "<leader>rc", "<cmd>OverseerClose<cr>",        desc = "Close" },
            { "<leader>rd", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
            { "<leader>rl", "<cmd>OverseerLoadBundle<cr>",   desc = "Load Bundle" },
            { "<leader>ro", "<cmd>OverseerOpen<cr>",         desc = "Open" },
            { "<leader>rq", "<cmd>OverseerQuickAction<cr>",  desc = "Quick Action" },
            { "<leader>rr", "<cmd>OverseerRun<cr>",          desc = "Run" },
            { "<leader>rs", "<cmd>OverseerSaveBundle<cr>",   desc = "Save Bundle" },
            { "<leader>rt", "<cmd>OverseerToggle<cr>",       desc = "Toggle" },
        },
        config = function(_, opts)
            local overseer = require('overseer')
            overseer.setup(opts)
            overseer.add_template_hook({ module = "^make$" }, function(task_defn)
                -- We use gmake because it's newer and better
                task_defn.cmd = "gmake"
            end)
        end,
    },
}
