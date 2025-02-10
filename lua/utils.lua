local M = { sys = {} }

M.filename = vim.fs.basename

M.dirname = vim.fs.dirname

M.basename = function(path)
	return vim.fn.fnamemodify(M.filename(path), ':r')
end

M.extension = function(path)
	local ext = vim.fn.fnamemodify(path, ':e')
	if ext ~= "" then
		return ext
	end
	-- Deal with the situation like ".vimrc"
	local filename = M.filename(path)
	if filename:sub(1, 1) == '.' then
		return filename:sub(2, -1)
	else
		return ""
	end
end

local File = {}
File.__index = File
M.File = File

function File.new(name, typ)
	local self = setmetatable({}, File)
	self.name = name
	self.type = typ
	return self
end

function File:isNormalFile()
	return self.type == "file" or self.type == "link"
end

function File:hasExtOf(ext)
	local fileExt = M.extension(self.name)
	return fileExt == ext
end

M.isLuaFile = function(file)
	return file:isNormalFile() and file:hasExtOf("lua")
end

M.sys.pathSeparator =
	-- No one uses Dos or so on any more, right?
	vim.loop.os_uname().sysname == "Windows_NT"
	and ';'
	or ':'

return M