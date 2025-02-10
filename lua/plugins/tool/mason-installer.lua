-- vim.opt.path:append doesn't outside the home dir
vim.env.PATH = vim.env.PATH .. require"utils".sys.pathSeparator
	.. vim.fn.stdpath("data") .. "/mason/bin"
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	opts = {
		auto_update = true,
		ensure_installed = {
			"cpptools",
			"lua-language-server",
			"texlab"
		}
	},
	dependencies = {"williamboman/mason.nvim", config = true}
}