return require "utils"
  .getModuleNamesInDir(vim.fn.stdpath("config") .. "/lua/overseer/template")
  :filter(function(name) return name ~= "index" end)
  :totable()
