local dapConfig = function()
  local utils = require "utils"
  local dap = require "dap"
  --dap.set_log_level("DEBUG")

  utils.getModuleNamesInDir(vim.fn.stdpath("config") .. "/lua/dbgadapters"):each(function(modul)
    local custom = require("dbgadapters." .. modul)
    dap.adapters[modul] = custom.adapter
    for _, ft in pairs(custom.filetypes) do
      if not dap.configurations[ft] then dap.configurations[ft] = {} end
      table.insert(dap.configurations[ft], custom.configurations)
    end
  end)
end

local style = require "style"
local layouts = {
  {
    elements = { "scopes", "breakpoints", "stacks", "watches" },
    position = "left",
    size = style.widthNr,
  },
  {
    elements = { "repl", "console" },
    position = "bottom",
    size = style.heightDf,
  },
}
local uiConfig = function()
  local dap, dapui = require("dap"), require("dapui")
  local style = require "style"
  dapui.setup({
    floating = { border = style.border },
    layouts = layouts,
  })
  dap.listeners.before.attach.dapui_config = function() dapui.open() end
  dap.listeners.before.launch.dapui_config = function() dapui.open() end
end
local mode = { "i", "n", "v" }

return {
  {
    "mfussenegger/nvim-dap",
    config = dapConfig,
    lazy = true,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = uiConfig,
    keys = {
      -- which-key can't get normal rhs before plugin loads, so set desc manually
      { "<F7>", "<cmd>DapContinue<cr>", mode = mode, desc = "Continue or start DAP" },
      { "<S-F7>", "<cmd>lua require'dapui'.close()<cr>", mode = mode, desc = "Close DapUI" },
      { "<F8>", "<cmd>DapToggleBreakpoint<cr>", mode = mode, desc = "Toggle breakpoint" },
      { "<F9>", "<cmd>DapStepOver<cr>", mode = mode },
      { "<F10>", "<cmd>DapStepInto<cr>", mode = mode },
      { "<F11>", "<cmd>DapStepOut<cr>", mode = mode },
      { "<F12>", "<cmd>DapTerminate<cr>", mode = mode },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    config = true,
  },
}
