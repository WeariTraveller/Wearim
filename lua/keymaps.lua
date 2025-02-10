local function map(mode, lhs, rhs, desc)
	local opt = {noremap = true, silent = true, desc = desc}
	vim.keymap.set(mode, lhs, rhs, opt)
end

-- Split
map("n", "sh", "<cmd>sp<CR>", "↔split")
map("n", "sv", "<cmd>vsp<CR>", "↕split")

-- Move
map({"n", "i", "v", "t"}, "<A-h>", "<C-w>h", "To left window")
map({"n", "i", "v", "t"}, "<A-j>", "<C-w>j", "To window below")
map({"n", "i", "v", "t"}, "<A-k>", "<C-w>k", "To window above")
map({"n", "i", "v", "t"}, "<A-l>", "<C-w>l", "To right window")

---Resize
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", "Win ↔size -2")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", "Win ↔size +2")
map("n", "sn", "<cmd>vertical resize -20<CR>", "Win ↔size -20")
map("n", "sw", "<cmd>vertical resize +20<CR>", "Win ↔size +20")
map("n", "<C-Up>", "<cmd>resize -2<CR>", "Win ↕size -2")
map("n", "<C-Down>", "<cmd>resize +2<CR>", "Win ↕size +2")
map("n", "sl", "<cmd>resize -10<CR>", "Win ↕size -10")
map("n", "sh", "<cmd>resize +10<CR>", "Win ↕size +10")

-- Indent
map("v", "<", "<gv", "Indent")
map("v", ">", ">gv", "Unindent")

map({"n", "i", "v"}, "<C-s>", "<cmd>w<CR>", "Save")
map("n", "<A-q>", "<cmd>qa<cr>", "Quit")
map("n", "<A-Q>", "<cmd>qa!<cr>", "Force quit")
map("n", "sc", "<C-w>c", "Close curr")
map("n", "<A-C>", "<cmd>close!<cr>", "Force close curr")
map("n", "so", "<C-w>o", "Close others")
map("v", "<A-y>", '"+y', "Copy to sys")
map("n", "<A-p>", '"+p', "Paste from sys")

-- Term
map("t", "<A-N>", [[<C-\><C-N>]])
map("t", "<A-C>", [[<C-\><C-O>]])

-- Code
local function toggle_quickfix()
  local wins = vim.fn.getwininfo()
  local qf_win = vim
    .iter(wins)
    :filter(function(win)
      return win.quickfix == 1
    end)
    :totable()
  if #qf_win == 0 then
    vim.cmd.copen()
  else
    vim.cmd.cclose()
  end
end

map("n", "<leader>q", toggle_quickfix, "Quickfix")
map("n", "<leader>hi", function()
  vim.show_pos()
end, "Inspect")
map("n", "<leader>ht", function()
  vim.treesitter.inspect_tree()
end, "Treesitter Tree" )
map("n", "<leader>hq", function()
  vim.treesitter.query.edit()
end, "Treesitter Query" )

-- translator
map({"n", "v"}, "<leader>tl", "<cmd>TranslateW<CR>")

-- autopairs：not to insert in pair
for _,punct in pairs {"(", ")", "[", "]", "{", "}"} do
	map("i", "<A-" .. punct .. ">", punct)
end

-- lspsaga
map("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gr", "<cmd>Lspsaga rename<CR>")
map("n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>")