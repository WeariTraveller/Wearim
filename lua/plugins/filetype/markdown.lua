return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	init = function() vim.g.mkdp_filetypes = { "markdown" } end,
	ft = { "markdown" },
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Preview" },
		{ "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Preview Stop" },
	},
}
