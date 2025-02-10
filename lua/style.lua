local M = {}

-- Colorscheme
M.theme = "tokyonight"

-- Where a tab is a tabpage rather than a buffer
M.prefer_tabpage = true

-- Border style of floating windows
M.border = "rounded"

-- Width of side windows
M.gwidth = function()
  local columns = vim.go.columns
  return math.floor(columns * 0.45) > 48 and math.floor(columns * 0.45) or 48
end

M.lheight = function()
	local rows = vim.go.lines
	return math.floor(rows*0.33)
end

local append_space = function(icons)
  local result = {}
  for k, v in pairs(icons) do
    result[k] = v .. " "
  end
  return result
end

local kind_icons = {
  Array = "",
  Boolean = "",
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

M.icons = {
  -- LSP diagnostic
  diagnostic = {
    error = "󰅚 ",
    warn = "󰀪 ",
    hint = "󰌶 ",
    info = "󰋽 ",
  },
  -- LSP kinds
  kind = kind_icons,
  kind_with_space = append_space(kind_icons),
	-- DAP breakpoint
	breakpoint = {
		default = {
			text = '',
			texthl = 'DapBreakpoint',
			linehl = 'DapBreakpoint',
			numhl = 'DapBreakpoint',
		},
		condition = {
			text = 'ﳁ',
			texthl = 'DapBreakpoint',
			linehl = 'DapBreakpoint',
			numhl = 'DapBreakpoint',
		},
		rejected = {
			text = "",
			texthl = "DapBreakpint",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		}
	},
	logpoint = {
		text = '',
		texthl = 'DapLogPoint',
		linehl = 'DapLogPoint',
		numhl = 'DapLogPoint',
	},
	stopped = {
		text = "",
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	}
}

M.colours = {
	-- DAP colour
	breakpoint = {
    ctermbg=0,
		fg='#98c379',
    bg='#31353f',
  },
  logpoint = {
    ctermbg=0,
    fg='#61afef',
    bg='#31353f',
  },
  stopped = {
    ctermbg=0,
		fg='#ffc633',
    bg='#31353f'
  },
}

return M
