return {
	settings = {
		texlab = {
			forwardSearch = {
				executable = "sioyek",
				args = {
					"--reuse-window",
					"--forward-search-file",
					"%f",
					"--forward-search-line",
					"%l",
					"%p",
				},
			},
		},
	},
}
