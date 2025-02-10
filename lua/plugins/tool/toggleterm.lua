local opts = {
	size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
	open_mapping = '<m-=>',
	start_in_insert = true,
	direction = "float",
	winbar = {
		enabled = false,
    name_formatter = function(term)
      return term.name
    end
	},
	close_on_exit = false
}

return {
	'akinsho/toggleterm.nvim',
	opts = opts,
	-- It doesn't work if add desc here
	keys = {"<m-=>"}
}