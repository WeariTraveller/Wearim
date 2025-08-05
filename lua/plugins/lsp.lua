local lspConfig = function()
  local lspconfig = require "lspconfig"

  require "langs".lspIter:each(function(config) lspconfig[config.name].setup(config) end)
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
