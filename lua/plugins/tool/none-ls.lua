return {
  "nvimtools/none-ls.nvim",
  event = "BufEnter",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local null_ls = require "null-ls"
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.markdownlint_cli2,
      },
    }
  end,
}
