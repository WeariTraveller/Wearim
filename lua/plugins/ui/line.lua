local stateOpts = {
  sections = {
    lualine_c = { "encoding", "fileformat", "filename" },
    lualine_x = { "lsp_status" },
    lualine_y = { require "plugins.filetype.xmake".lualine, "overseer" },
    lualine_z = { "diagnostics", "progress", "location" },
  },
  extensions = { require "plugins.tool.toggleterm".lualine },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = stateOpts,
    event = "BufEnter",
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = { options = {
      numbers = "ordinal",
      diagnostics = "nvim_lsp",
    } },
    keys = {
      { "<A-b>", "<cmd>BufferLineCyclePrev<CR>" },
      { "<A-f>", "<cmd>BufferLineCycleNext<CR>" },
      { "<leader>bl", "<cmd>BufferLineCloseRight<CR>" },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>" },
      { "<leader>bj", "<cmd>BufferLineMoveNext<CR>" },
      { "<leader>bb", "<cmd>BufferLineMovePrev<CR>" },
      { "<leader>bc", "<cmd>BufferLinePickClose<CR>" },
    },
    event = "BufEnter",
  },
}
