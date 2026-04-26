vim.loader.enable()
isWin = vim.loop.os_uname().sysname == "Windows_NT"
pathSeparator = isWin and ";" or ":"
require "options"
require "plainkeys"
require "filetype"
require "manager"
