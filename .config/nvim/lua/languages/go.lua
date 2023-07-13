local util = require "lspconfig/util"

local M = {}

M.servers = {
    golangci_lint_ls = {},
    gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true,
                },
            },
        },
    }
}

M.modules = {
    {
        "dreamsofcode-io/nvim-dap-go",
        ft = "go",
        dependencies = { "mfussenegger/nvim-dap" },
        config = true,
        keys = {
            { "<leader>dgt", function() require('dap-go').debug_test() end, desc = "Debug Test" }
        }
    },
    {
        'nvim-neotest/neotest-go',
        dependencies = { "nvim-neotest/neotest" },
        ft = "go"
    }
}

M.test_adapters = {
    require("neotest-go")({
        experimental = {
            test_table = true,
        },
        args = { "-count=1", "-timeout=60s" }
    })
}

return M
