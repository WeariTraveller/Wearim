local M = {}
local t = require "utils"
local Path = require "path"

local allLangList = {}
M.list = allLangList
local lspConfigs = {}
local dapConfigs = {}
local installedByMason = {}
local null = {}

local function ensureInstalled(list, langs)
  local function normalize(item)
    if type(item) == "string" then
      return {
        name = item,
        cmd = item,
        source = "mason",
      }
    else
      return {
        name = item[1],
        cmd = item.cmd or item[1],
        tip = item.tip,
        source = item.src or "mason",
      }
    end
  end
  local function check(prog)
    if vim.fn.executable(prog.cmd) == 0 then
      local msg = string.format("Command not found: %s (for %s). Source: %s.", prog.cmd, prog.name, prog.source)
      if prog.tip then msg = msg .. "\nTip: " .. prog.tip end
      vim.api.nvim_echo({ { msg, "ErrorMsg" } }, true, {})
    end
  end

  if type(list) ~= "table" or not list[2] then list = { list } end
  for _, i in ipairs(list) do
    local prog = normalize(i)
    if prog.source == "mason" then
      table.insert(installedByMason, prog.name)
    else
      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        once = true,
        callback = function() check(prog) end,
      })
    end
  end
end

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
    if t.oc(config, "ensure") then ensureInstalled(config.ensure, groupedLangs) end
    table.insert(null, t.oc(config, "null"))
  end)

M.lspIter = vim.iter(lspConfigs)

M.dapIter = vim.iter(dapConfigs):map(function(pair)
  if not pair[1].filetypes then pair[1].filetypes = pair[2] end
  return pair[1]
end)

M.mason = installedByMason

M.nullIter = vim.iter(null)

return M
