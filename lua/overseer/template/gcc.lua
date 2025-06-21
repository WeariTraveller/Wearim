return {
	name = "gcc",
	builder = function(argv)
		local cmd, u = {
			c = "gcc",
			cpp = "g++",
		}, require "utils"
		return {
			cmd = { cmd[vim.bo.filetype], u.file(), "-o", u.fileRoot(), "-Wall" },
			args = argv.moreArgs,
			components = {
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "c", "cpp" },
	},
	tags = { "compile", "default" },
	params = {
		moreArgs = {
			name = "More args",
			type = "list",
			subtype = {
				type = "string",
			},
			delimiter = " ",
			default = {},
		},
	},
}
