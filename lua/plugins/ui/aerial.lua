local s = require "style"
return {
	-- Though lspsaga has outline, aerial's is more powerful, such
	-- as supporting more sources and filter, so keep it
	"stevearc/aerial.nvim",
	config = {
		filter_kind = false,
		icons = s.kind_icons,
		layout = {
			width = s.widthNr,
		},
	},
	keys = {
		{ "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
		{
			"{s",
			function() require "aerial".prev(s.clamp(vim.v.count, 1)) end,
			desc = "Prev (𝑛th) symbol",
		},
		{
			"}s",
			function() require "aerial".next(s.clamp(vim.v.count, 1)) end,
			desc = "Next (𝑛th) symbol",
		},
	},
}
