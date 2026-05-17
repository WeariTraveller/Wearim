return {
  "goolord/alpha-nvim",
  config = function()
    local dashboard = require "alpha.themes.dashboard"
    local button = dashboard.button
    dashboard.section.buttons.val = {
      button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
      button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
      button("<C-h>", "󰌌  Search keymaps"),
      button("<C-k>", "󰘳  WhichKey"),
      button("sc / so", "󰖭  Close current / all other windows"),
      button("<A-q>", "󰅚  Quit"),
    }
    require "alpha".setup(dashboard.config)
  end,
}
