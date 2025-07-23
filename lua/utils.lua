local M = {}

local PlenaryPath = require "plenary.path"
local Path = PlenaryPath:new()
Path.__index = Path
M.Path = Path

function Path.new(nameOrTable, typ)
  local self = PlenaryPath:new(nameOrTable)
  setmetatable(self, Path)
  self.type = typ
  return self
end

function Path.is_path(a)
  local metatable = getmetatable(a)
  return metatable == PlenaryPath or metatable == Path
end
PlenaryPath.is_path = Path.is_path

function Path:stem() return vim.fn.fnamemodify(self.filename, ":t:r") end

function Path:suffix() return vim.fn.fnamemodify(self.filename, ":e") end

--[[function Path:isNormalFile()
	return self.type == "file" or self.type == ""
end]]

-- A name inherited from JAVA
Path.pathSeparator = isWin and ";" or ":"

M.getModuleFilesInDir = function(dir)
  return vim
    .iter(vim.fs.dir(dir))
    :map(Path.new)
    :filter(function(file) return file.type == "file" and file:suffix() == "lua" end)
end

M.getModuleNamesInDir = function(dir)
  return M.getModuleFilesInDir(dir):map(function(file) return file:stem() end)
end

M.env = {}
setmetatable(M.env, {
  __newindex = function(_, key, val) vim.env[key] = val end,
  __index = function(_, key)
    return {
      append = function(_, val)
        -- Can't use vim.opt.path:append() for env PATH, it's for nvim builtin commands
        -- see :h 'path'
        vim.env[key] = vim.env[key] .. Path.pathSeparator .. val
      end,
    }
  end,
})

M.file = function() return vim.fn.expand("%:p") end
M.fileRoot = function() return vim.fn.expand("%:p:r") end

return M
