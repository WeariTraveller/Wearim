vim.loader.enable()
isWin = vim.loop.os_uname().sysname == "Windows_NT"
pathSeparator = isWin and ";" or ":"
-- $WSL_DISTRO_NAME is unavailable over SSH
isWSL = vim.fn.executable "wslinfo" == 1
-- Exclude WezTerm's SSHMux
overSSH = vim.env.SSH_CONNECTION ~= nil
-- Match /wezterm-mux-server.{0,4}$/
overWeztermMux = vim.env.TERM_PROGRAM == "WezTerm"
  and string.find(vim.env.WEZTERM_EXECUTABLE or "", "wezterm-mux-server", -22, true) ~= nil
require "options"
require "plainkeys"
require "filetype"
require "manager"
