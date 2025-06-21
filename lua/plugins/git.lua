local s = require "style"
return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		floating = {
			width = s.winRatioF.width,
			height = s.winRatioF.height,
			border = s.border,
		},
		graph_style = "unicode",
		kind = require "style".prefer_tabpage and "tab" or "split",
		integrations = {
			diffview = true,
			telescope = true,
		},
		sections = {
			stashes = {
				folded = false,
			},
			recent = {
				folded = false,
			},
		},
	},
	keys = { {
		"<leader>gt",
		function() require("neogit").open() end,
		desc = "Open Neogit",
	} },
}
