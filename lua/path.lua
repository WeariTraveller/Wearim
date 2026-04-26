local M = {}

local SuperPath = require "pathlib"
local Path = SuperPath
M.Path = Path

M.getModuleFilesInDir = function(dir)
  return vim
    .iter(vim.fs.dir(dir))
    :map(Path.new)
    :filter(function(item) return item:is_file() and item:suffix() == ".lua" end)
end

M.getModuleNamesInDir = function(dir)
  return M.getModuleFilesInDir(dir):map(function(file) return file:stem() end)
end

return M
