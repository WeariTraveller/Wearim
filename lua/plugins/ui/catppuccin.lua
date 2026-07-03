return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    require "catppuccin".setup {
      transparent_background = true,
      integrations = { notify = true },
    }
    vim.cmd.colorscheme "catppuccin"
  end,
}
