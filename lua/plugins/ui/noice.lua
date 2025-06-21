local noiceOpts = {
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
}

return {
	{
		"rcarriga/nvim-notify",
		lazy = true,
		opts = {
			max_width = require "style".widthBd,
			render = "wrapped-compact",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = noiceOpts,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
