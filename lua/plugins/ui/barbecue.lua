return {
	"utilyre/barbecue.nvim",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		exclude_filetypes = { "neo-tree", "toggleterm" },
	},
	event = "VeryLazy",
	enabled = false,
}
