return {
  "nvimtools/none-ls.nvim",
  event = "BufEnter",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local null_ls = require "null-ls"
    null_ls.setup {
      sources = require "langs".nullIter:map(function(cb) return cb(null_ls) end):totable(),
    }
  end,
}
