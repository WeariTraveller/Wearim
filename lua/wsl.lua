local M = {}

function M.pathToWin(wslPath)
  -- Raw ouput ends with \n
  return string.sub(vim.system({ "wslpath", "-w", wslPath }):wait().stdout, 1, -2)
end
function M.pathFromWin(winPath) return string.sub(vim.system({ "wslpath", "-u", winPath }):wait().stdout, 1, -2) end

function M.whereInWin(target)
  return M.pathFromWin(string.sub(
    -- Raw ouput ends with \r\n
    vim.system({ "/mnt/c/Windows/System32/where.exe", target }):wait().stdout,
    1,
    -3
  ))
end

return M
