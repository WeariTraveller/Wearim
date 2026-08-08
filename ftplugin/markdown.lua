local t = require "utils"
vim.keymap.set("n", "<leader>p", openFileInBrowser, { buf = t.bufnr(), desc = "Open browser and preview" })
