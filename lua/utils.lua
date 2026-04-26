local M = {}

M.env = {}
setmetatable(M.env, {
  __newindex = function(_, key, val) vim.env[key] = val end,
  __index = function(_, key)
    return {
      append = function(_, val)
        -- Can't use vim.opt.path:append() for env PATH, it's for nvim builtin commands
        -- see :h 'path'
        vim.env[key] = vim.env[key] .. pathSeparator .. val
      end,
    }
  end,
})

M.file = function() return vim.fn.expand("%:p") end
M.fileRoot = function() return vim.fn.expand("%:p:r") end

-- Optional chaining
M.oc = function(firstborn, ...)
  local keys = { ... }
  local generation = firstborn
  for i = 1, #keys do
    if type(generation) ~= "table" then return nil end
    generation = generation[keys[i]]
  end
  return generation
end
-- Each value in optional chaining
M.eoc = function(firstborn, ...)
  local keys = { ... }
  local generation = firstborn
  local results = { generation }
  for i = 1, #keys do
    if type(generation) ~= "table" then
      -- Let Lua replace remaining property accesses with nil at mult-assignment
      break
    end
    generation = generation[keys[i]]
    table.insert(results, generation)
  end
  return unpack(results)
end

return M
