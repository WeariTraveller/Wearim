local stateOpts = {
	options =	{
		theme = 'tokyonight',
		icons_enabled = true
	},
	sections = {
		lualine_x = {"overseer"},
    lualine_y = {
      {
				function()
					local xmake = require("xmake.project_config").info
					if xmake.target.tg == "" then
						return ""
					end
					return xmake.target.tg .. "(" .. xmake.mode .. ")"
				end,
				cond = function()
					return vim.o.columns > 100
				end,
				on_click = function()
					require("xmake.project_config._menu").init()
				end
			}
    }
  }
}

return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = stateOpts,
		event = 'BufEnter'
	},
	{
		'akinsho/bufferline.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {options = {
			mode = "tabs",
			numbers = "ordinal",
			diagnostics = "nvim_lsp"
		}},
		keys = {
			{ "<A-b>", "<cmd>BufferLineCyclePrev<CR>" },
			{ "<A-f>", "<cmd>BufferLineCycleNext<CR>" },
			{ "<A-d>", "<cmd>bdelete<CR>" },
			{ "<A-D>", "<cmd>bdelete!<CR>" },
			{ "<leader>bl", "<cmd>BufferLineCloseRight<CR>" },
			{ "<leader>bh", "<cmd>BufferLineCloseLeft<CR>" },
			{ "<leader>bj", "<cmd>BufferLineMoveNext<CR>" },
			{ "<leader>bk", "<cmd>BufferLineMovePrev<CR>" },
			{ "<leader>bc", "<cmd>BufferLinePickClose<CR>" },
		},
		event = 'BufEnter'
	}
}