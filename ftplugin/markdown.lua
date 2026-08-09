local t = require "utils"
vim.keymap.set(
  "n",
  "<leader>p",
  function() t.browseFile(t.file()) end,
  { buf = t.bufnr(), desc = "Preview in browser" }
)
