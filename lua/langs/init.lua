local M = {}
local utils = require "utils"

local langList = {}
M.list = langList
local langModuleMaps = {}

M.lspIter = utils
  .getModuleNamesInDir(vim.fn.stdpath("config") .. "/lua/langs")
  -- First, this part deals with langList and langModuleMaps
  :filter(function(modul) return modul ~= "init" end)
  -- 1. Can't use each() here, which will drain the iterator.
  -- 2. AI may think map() will evaluate the callback lazily (2025 Oct.6).
  --    That's incorrect. See examples/iter.lua
  :map(
    function(modul)
      local langs = {}
      for part in string.gmatch(modul, "[^&]+") do
        table.insert(langList, part)
        table.insert(langs, part)
      end
      langModuleMaps[modul] = langs
      return modul
    end
  )
  -- Next, this part actually generates lspIter
  :map(function(modul) return require("langs." .. modul).lsp end)
  :filter(function(config) return config ~= nil end)

M.dapIter = vim
  .iter(langModuleMaps)
  :map(function(modul, filetypes)
    local config = require("langs." .. modul).dap
    if config == nil then return nil end
    if config.filetypes == nil then config.filetypes = filetypes end
    return config
  end)
  :filter(function(config) return config ~= nil end)

return M
