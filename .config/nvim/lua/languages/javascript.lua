local M = {}

M.servers = {
    tsserver = {},
}

M.modules = {
    {
        'nvim-neotest/neotest-jest',
        dependencies = { 'nvim-neotest/neotest' },
        ft = { "js", "ts" },
    }
}

M.test_adapters = {
    require('neotest-jest')({
        jestCommand = "yarn test",
        env = { CI = true }
    })
}

return M
