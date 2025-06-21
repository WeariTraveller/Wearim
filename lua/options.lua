vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false
isWin = vim.loop.os_uname().sysname == "Windows_NT"

-- Edit
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.undofile = false
vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.fileencodings = {
	"utf-8",
	"latin1",
	"gb2312",
	"big5",
	"utf-16",
	"utf32",
}
vim.opt.viminfofile = "NONE"
vim.g.mapleader = ","
vim.opt.fileformat = "unix"

-- UI
vim.opt.termguicolors = true
vim.opt.guifont = "Sarasa Term SC Nerd:h13"
vim.opt.number = true

-- Term
vim.opt.hidden = true
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function() vim.cmd [[setlocal modifiable]] end,
})
if isWin then
	vim.opt.shell = "pwsh"
	vim.opt.shellcmdflag = "-command"
	vim.shellquote = [["]]
	vim.opt.shellxquote = ""
end

--[[vim.api.nvim_create_autocmd("DirChanged", {
	pattern = "window",
	callback = function(ev)
		if vim.api.nvim_buf_get_option(ev.buf, "filetype") ~= "NvimTree" then
			return
		end
		vim.cmd.cd(ev.file)
	end
})]]

local style = require "style"

-- Set diagnostic options
vim.diagnostic.config {
	virtual_text = {
		spacing = 4,
		prefix = "●",
		severity = vim.diagnostic.severity.ERROR,
	},
	float = {
		severity_sort = true,
		source = "if_many",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = style.icons.diagnostic.error,
			[vim.diagnostic.severity.WARN] = style.icons.diagnostic.warn,
			[vim.diagnostic.severity.HINT] = style.icons.diagnostic.hint,
			[vim.diagnostic.severity.INFO] = style.icons.diagnostic.info,
		},
	},
}

-- Set breakpoint and its style
vim.fn.sign_define("DapBreakpoint", style.icons.breakpoint.default)
vim.fn.sign_define("DapBreakpointCondition", style.icons.breakpoint.condition)
vim.fn.sign_define("DapBreakpointRejected", style.icons.breakpoint.rejected)
vim.fn.sign_define("DapLogPoint", style.icons.logpoint)
vim.fn.sign_define("DapStopped", style.icons.stopped)
vim.api.nvim_set_hl(0, "DapBreakpoint", style.colours.breakpoint)
vim.api.nvim_set_hl(0, "DapLogPoint", style.colours.logpoint)
vim.api.nvim_set_hl(0, "DapStopped", style.colours.stopped)
