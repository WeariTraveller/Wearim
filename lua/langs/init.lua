local M = {}
local t = require "utils"
local Path = require "path"

local allLangList = {}
M.list = allLangList
local lspConfigs = {}
local dapConfigs = {}

-- NOTE:
-- See nvim sources runtime/lua/vim/iter.lua L281 ~ L343
-- The timing of evaluation for vim.iter is uncertain (2025 Oct 11)

Path.getModuleNamesInDir(vim.fn.stdpath("config") .. "/lua/langs")
  :filter(function(modul) return modul ~= "init" end)
  :each(function(modul)
    local groupedLangs = {}
    for part in string.gmatch(modul, "[^&]+") do
      table.insert(allLangList, part)
      table.insert(groupedLangs, part)
    end
    local config, dap = t.eoc(require("langs." .. modul), "dap")
    table.insert(lspConfigs, t.oc(config, "lsp"))
    table.insert(dapConfigs, dap and { dap, groupedLangs })
  end)

M.lspIter = vim.iter(lspConfigs)

M.dapIter = vim.iter(dapConfigs):map(function(pair)
  if not pair[1].filetypes then pair[1].filetypes = pair[2] end
  return pair[1]
end)

return M
