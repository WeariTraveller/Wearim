local M = {}
local t = require "utils"

local langList = {}
M.list = langList
local langModuleMaps = {}

-- NOTE:
-- 1. Iter:each() will drain the iterator.
-- 2. AI may think map() will evaluate the callback lazily (2025 Oct.6).
--    That's incorrect. See examples/iter.lua
-- 3. What be Iter:map()ed to nil will be filtered.

M.lspIter = t
  .getModuleNamesInDir(vim.fn.stdpath("config") .. "/lua/langs")
  -- First, this part deals with langList and langModuleMaps
  :filter(function(modul) return modul ~= "init" end)
  :map(function(modul)
    local langs = {}
    for part in string.gmatch(modul, "[^&]+") do
      table.insert(langList, part)
      table.insert(langs, part)
    end
    langModuleMaps[modul] = langs
    -- Next, this part actually generates lspIter
    return t.oc(require("langs." .. modul), "lsp")
  end)

M.dapIter = vim.iter(langModuleMaps):map(function(modul, filetypes)
  local config = t.oc(require("langs." .. modul), "dap")
  if config == nil then return nil end
  if config.filetypes == nil then config.filetypes = filetypes end
  return config
end)

return M
