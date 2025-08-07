local lsp = {
  name = "clangd",
  cmd = {
    "clangd",
    "--pretty",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--cross-file-rename=true",
    "--function-arg-placeholders=false",
    "--header-insertion-decorators",
  },
}

local dap = {
  name = "gdb",
  adapter = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    --args = { "-iex", "set debug dap-log-file ~/gdb.log", "-i=dap" },
    options = {
      initialize_timeout_sec = 10,
    },
  },
  configurations = {
    name = "Launch GDB",
    type = "gdb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = true,
  },
}

return { lsp = lsp, dap = dap }
