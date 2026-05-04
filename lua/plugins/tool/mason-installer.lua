return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  lazy = false,
  opts = {
    auto_update = true,
    ensure_installed = require "langs".mason,
  },
  dependencies = { "williamboman/mason.nvim", opts = {} },
}
