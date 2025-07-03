vim.cmd [[
function OpenMarkdownPreview(url)
	execute "silent ! firefox --new-tab " . a:url
endfunction
]]

return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	keys = {
		{ "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview Toggle" },
	},
}
