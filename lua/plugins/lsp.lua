local lspConfig = function()
  require "langs".lspIter:each(function(config)
    if vim.tbl_count(config) > 1 then vim.lsp.config(config.name, config) end
    vim.lsp.enable(config.name)
  end)
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
