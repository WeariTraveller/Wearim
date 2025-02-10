return {
	adapter = {
		id = 'cppdbg',
		type = 'executable',
		command = "OpenDebugAD7",
		options = {
			detached = false,
			initialize_timeout_sec = 10
		}
	},
	configurations = {
		name = "Launch cppdbg",
		type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true
	},
	filetypes = {'c', 'cpp'}
}