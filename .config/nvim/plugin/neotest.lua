require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      args = {"--log-level", "DEBUG"},
      runner = "pytest"
    })
  }
})
require('dap-python').setup('~/.local/virtualenvs/debugpy_venv/bin/python', nil)
