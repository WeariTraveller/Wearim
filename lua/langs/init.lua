local M = {}
local utils = require "utils"

local langList = {}
M.list = langList
local langModuleMaps = {}

M.lspIter = utils
  .getModuleNamesInDir(vim.fn.stdpath("config") .. "/lua/langs")
  -- First, this part deals with langList and langModuleMaps
  :filter(function(modul) return modul ~= "init" end)
  :each(function(modul)
    local langs = {}
    for part in string.gmatch(modul, "[^&]+") do
      table.insert(langList, part)
      table.insert(langs, part)
    end
    langModuleMaps[modul] = langs
  end)
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
