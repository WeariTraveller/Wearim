return {
  "Mythos-404/xmake.nvim",
  event = "BufReadPost xmake.lua",
  config = true,
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  lualine = {
    function()
      local xmake = require("xmake.project_config").info
      if xmake.target.tg == "" then return "" end
      return xmake.target.tg .. "(" .. xmake.mode .. ")"
    end,
    cond = function() return vim.o.columns > 100 end,
    on_click = function() require("xmake.project_config._menu").init() end,
  },
}
