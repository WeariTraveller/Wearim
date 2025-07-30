local lspConfig = function()
  local utils = require "utils"
  local lspconfig = require "lspconfig"

  utils
    .getModuleNamesInDir(vim.fn.stdpath("config") .. "/lua/langservers")
    :each(function(modul) lspconfig[modul].setup(require("langservers." .. modul) or {}) end)
end

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = lspConfig,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = {
      symbol_in_winbar = { enable = false },
      lightbulb = {
        enable = true,
        sign = false,
        virtual_text = true,
      },
    },
  },
}
