return {
	name = "latexmk",
	builder = function(argv)
		local u = require "utils"
		return {
			cmd = {
				"latexmk",
				argv.engine,
				"-interaction=nonstopmode",
				"-synctex=1",
				"-verbose",
				"-file-line-error",
				u.filename(),
			},
			components = {
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "tex" },
	},
	tags = { "compile", "default" },
	params = {
		engine = {
			name = "Latex engine",
			type = "enum",
			choices = { "-lualatex", "-xelatex", "-latex" },
			default = "-lualatex",
		},
	},
}
