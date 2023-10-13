local M = {}

M.servers = function()
    local util = require('lspconfig').util
    return {
        tflint = {},
        terraform_ls = {}
    }
end

M.modules = {}

M.test_adapters = function()
    return {}
end

return M
