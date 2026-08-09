# Introduction
- Self-used
- Use lazy.nvim to manage plugins
- Easy to expand

# Quick Start

## Pre-requisite
- Latest Neovim
- A browser with the plugin [Markdown Viewer](https://github.com/simov/markdown-viewer)
- Some other programs which nvim will remind you of when you open specific filetypes

You need to set `$browser` to your browser's path.

## Customize
Every (a few) language has a lua file as its configuration under the directory `lua/langs`.
The name of the lua file is the same as the language, and you can use `&` to share configuration,
such as `c&cpp.lua`. Each file returns a table like:
```lua
{
  -- Each top field is optional, so you can let a module return nil
  -- The tree-sitter will install the language automatically
  lsp = {
    name = "clangd",     -- the name passed to vim.lsp.enable and vim.lsp.config
    -- The rest is optional and will be passed to vim.lsp.config, used to partly override the default
  },
  dap = {
    -- Define a debug adapter; see `:h dap-adapter`
    name = "gdb",
    adapter = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      options = {
        initialize_timeout_sec = 10,
      },
    },
    -- This will be applied to each language above; see `:h dap-configuration`
    -- This cannot be a list
    configurations = {
      name = "Launch GDB",
      type = "gdb",
      request = "launch",
      program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = true,
    },
  },
  -- Neovim will check whether the program is installed and remind you if not
  -- or you can just `ensure = "clangd"`
  -- Also, this field can be a list consisting of many such elements.
  ensure = {
    "clangd",       -- the name of the program which should be installed
    -- The cmd to test; the default is the same as its name
    -- cmd = "clangd",
    source = "sys",      -- the default is "mason", to make the program installed automatically
    -- There is an optional field `tip` as part of the reminder
  },
}
```

# Develop

## Init
After cloning this repo, you need to run `npm install` or `pnpm install`, etc.
to init git hooks.
