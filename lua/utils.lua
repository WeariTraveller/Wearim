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
M.bufnr = vim.api.nvim_get_current_buf

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

M.check = function(prog)
  if vim.fn.executable(prog.cmd) == 0 then
    local msg = string.format("Command not found: %s (for %s). Source: %s.", prog.cmd, prog.name, prog.source)
    if prog.tip then msg = msg .. "\nTip: " .. prog.tip end
    vim.api.nvim_echo({ { msg, "ErrorMsg" } }, true, {})
  end
end

M.wslpath2Win = function(rawPath)
  -- Raw ouput ends with \n
  return string.sub(vim.system({ "wslpath", "-w", rawPath }):wait().stdout, 1, -2)
end
M.winpath2Wsl = function(rawPath) return string.sub(vim.system({ "wslpath", "-u", rawPath }):wait().stdout, 1, -2) end

if isWSL then
  function openFileInBrowser(path)
    path = path or M.file()
    vim.system({ vim.g.browser, "--new-tab", M.wslpath2Win(path) })
  end
else
  function openFileInBrowser(path)
    path = path or M.file()
    vim.system({ vim.g.browser, "--new-tab", path })
  end
end

return M
