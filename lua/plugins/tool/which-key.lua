return {
  "folke/which-key.nvim",
  keys = {
    {
      "<C-k>",
      function() require("which-key").show({ gobal = false }) end,
      desc = "Which-key",
      mode = { "n", "i", "c", "s" },
    },
  },
  -- Which-key itself can't lazy load by key!
  event = "VeryLazy",
  opts = {
    spec = {
      { "<m-=>", desc = "Toggle term" },
      require "plugins.tool.telescope".whichKey,
    },
  },
}
