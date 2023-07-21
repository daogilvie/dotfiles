local languages = require('languages')
local modules = {
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        keys = { { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
        config = function(_, _)
            local opts = {
                ignore = "^$",
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
            require("Comment").setup(opts)
        end,
    },
    -- Debugging and Testing
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
            {
                "<leader>dus",
                function()
                    local widgets = require('dap.ui.widgets');
                    local sidebar = widgets.sidebar(widgets.scopes);
                    sidebar.open();
                end,
                desc = "Open DAP sidebar"
            }
        },
    },
    {
        "vim-test/vim-test",
        config = function()
            vim.g["test#strategy"] = "neovim"
            vim.g["test#neovim#term_position"] = "belowright"
            vim.g["test#neovim#preserve_screen"] = 1
            vim.g["test#python#runner"] = "pytest"
        end,
    },
    {
        "nvim-neotest/neotest",
        keys = {
            -- This freezes so I'm turning it off until I know why
            -- {
            --     '<leader>ts',
            --     function() require('neotest').summary.toggle() end,
            --     desc = "Toggle Neotest Summary"
            -- },
            { '<leader>tf', function() require('neotest').run.run(vim.fn.expand("%")) end, desc = "Test current file" },
            { '<leader>tr', function() require('neotest').run.run() end,                   desc = "Run test" },
            { '<leader>to', function() require('neotest').output.open() end,               desc = "Open Test Output" },
            {
                "<leader>tD",
                function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,
                desc = "Debug File"
            },
            {
                "<leader>td",
                function() require('neotest').run.run({ strategy = 'dap' }) end,
                desc = "Debug test"
            },
        },
        dependencies = {
            "nvim-neotest/neotest-plenary",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-vim-test",
            "vim-test/vim-test",
        },
        opts = function()
            local adapters = {
                require('neotest-plenary'),
                require('neotest-vim-test') {
                    ignore_file_types = { "python", "vim", "lua" },
                },
            }
            for _, language in pairs(languages) do
                if language.test_adapters then
                    vim.list_extend(adapters, language.test_adapters())
                end
            end
            return {
                adapters = adapters,
                status = { virtual_text = true },
                output = { open_on_run = true },
                quickfix = {
                    open = function()
                        if require("utils").has "trouble.nvim" then
                            vim.cmd "Trouble quickfix"
                        else
                            vim.cmd "copen"
                        end
                    end,
                },
                -- overseer.nvim
                consumers = {
                    overseer = require "neotest.consumers.overseer",
                },
                overseer = {
                    enabled = true,
                    force_default = true,
                },
            }
        end,
        config = function(_, opts)
            local neotest_ns = vim.api.nvim_create_namespace "neotest"
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+",
                            "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup(opts)
        end,
    },
}

-- Pull the modules from the programming files
for _, language in pairs(languages) do
    vim.list_extend(modules, language.modules)
end

return modules
