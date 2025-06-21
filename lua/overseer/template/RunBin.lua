return {
	name = "RunBin",
	builder = function(params)
		return {
			cmd = vim.fn.expand("%:p:r"),
			args = params.moreArgs,
			components = { "default" },
		}
	end,
	condition = {
		filetype = { "c", "cpp" },
	},
	tags = { "run", "default" },
	params = {
		moreArgs = {
			type = "list",
			name = "More args",
			subtype = {
				type = "string",
			},
			delimiter = " ",
			default = {},
		},
	},
}
