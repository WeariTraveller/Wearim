local lspConfig = function()
	local utils = require "utils"
	local lspconfig = require "lspconfig"
	
	vim.iter(vim.fs.dir(vim.fn.stdpath("config") .. "/lua/langservers"))
		:map(utils.File.new):filter(utils.isLuaFile)
		:each( function(configFile)
			local name = utils.basename(configFile.name)
			local custom = require("langservers." .. name)
			lspconfig[name].setup(custom or {})
		end )
end

return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		config = lspConfig
	},
	{
		'glepnir/lspsaga.nvim',
		event = 'LspAttach',
		config = true
	}
}