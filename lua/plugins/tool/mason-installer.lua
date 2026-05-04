local masonBin = vim.fn.stdpath("data") .. "/mason/bin"
require "utils".env.PATH:append(masonBin)
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  opts = {
    auto_update = true,
    ensure_installed = require "langs".mason,
  },
  dependencies = { "williamboman/mason.nvim", config = true },
}
