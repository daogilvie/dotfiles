-- helper functions for LSP config
local function lsp_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, bufnr)
        end,
    })
end

local function lsp_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local function lsp_setup(servers)
    local navic = require("nvim-navic")
    lsp_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, buffer)
        end
        require("plugins.lsp.format").on_attach(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }
    require("mason-lspconfig").setup_handlers {
        function(server)
            local opts = servers[server] or {}
            opts.capabilities = lsp_capabilities()
            require("lspconfig")[server].setup(opts)
        end,
    }
end



return {
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        event = "BufReadPre",
        dependencies = {
            { "folke/neoconf.nvim",      cmd = "Neoconf", config = true },
            { "folke/neodev.nvim",       config = true },
            { "smjonas/inc-rename.nvim", config = true },
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim",
                },
                opts = { lsp = { auto_attach = true } },
            },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        keys = {
            { "<leader>vO", function() require("nvim-navbuddy").open() end, desc = "Code Outline (navbuddy)", },
        },
        config = function()
            local languages = { require('languages.lua'), require('languages.go'), require('languages.javascript') }
            local lsp_servers = {}
            for _, lang in pairs(languages) do
              if lang.servers then
                lsp_servers = vim.tbl_deep_extend('force', lsp_servers, lang.servers())
              end
            end
            lsp_setup(lsp_servers)
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        config = true
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "mason.nvim" },
        opts = function()
            local null_ls = require("null-ls")
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            local opts = {
                sources = {
                    null_ls.builtins.formatting.gofumpt,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            }
            return opts
        end,
        config = true,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        opts = { ensure_installed = nil, automatic_installation = true, automatic_setup = false }
    },

}
