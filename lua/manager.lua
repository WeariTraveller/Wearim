local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"git@github.com:folke/lazy.nvim",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local style = require "style"

require("lazy").setup("plugins", {
	git = {
		url_format = 'git@github.com:%s.git'
	},
	checker = {
		enabled = true,
		concurrency = nil,
		notify = false,
		frequency = 3600,
	},
  ui = {
    border = style.border,
  },
  diff = {
    cmd = "diffview.nvim",
  },
  performance = {
    rtp = {
      -- Required in NixOS
      reset = false,
      disabled_plugins = {
        "2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin"
      },
    },
  },
})