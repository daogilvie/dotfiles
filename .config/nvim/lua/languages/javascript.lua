local M = {}

M.servers = function()
  return {
    tsserver = {},
    jsonls = {
      init_options = {
        provideFormatter = false
      }
    }
  }
end

M.modules = {
  {
    'nvim-neotest/neotest-jest',
    dependencies = { 'nvim-neotest/neotest' },
    ft = { "js", "ts" },
  }
}

M.test_adapters = function() return {
    require('neotest-jest')({
        jestCommand = "yarn test",
        env = { CI = true }
    })
  }
end

return M
