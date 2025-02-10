return {
  name = "gcc",
  builder = function(params)
    local file = vim.fn.expand("%:p")
		local basename = vim.fn.expand("%:p:r")
		local cmd = {
		  c = "gcc",
			cpp = "g++",
		}
    return {
      cmd = {cmd[vim.bo.filetype], file, "-o", basename, "-Wall"},
			args = params.moreArgs,
      components = {
				"on_result_diagnostics",
				"default"
			}
    }
  end,
  condition = {
    filetype = {"c", "cpp"}
  },
	tags = {"compile", "default"},
	params = {
		moreArgs = {
			name = "More args",
			type = "list",
			subtype = {
        type = "string"
      },
      delimiter = " ",
			default = {}
		}
	}
}