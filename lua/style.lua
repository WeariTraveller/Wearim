local M = {}

-- Colorscheme
M.theme = "catppuccin"

-- Where a tab is a tabpage rather than a buffer
M.prefer_tabpage = true

-- Border style of floating windows
M.border = "rounded"

M.clamp = function(val, lowerBound, upperBound)
  if lowerBound and val < lowerBound then
    return lowerBound
  elseif upperBound and val > upperBound then
    return upperBound
  end
  return val
end

M.winRatioF = { width = 0.7, height = 0.6 }
-- Broader or narrower width of side windows
M.widthBd = function()
  local width = math.floor(vim.go.columns * M.winRatioF.width)
  return M.clamp(width, 48)
end
M.widthNr = 35
M.width = function() return vim.go.columns * 0.27 end
-- Taller or dwarfer height
M.heightTl = function() return math.floor(vim.go.lines * M.winRatioF.height) end
M.heightDf = 19
M.height = function() return vim.go.lines * 0.27 end

M.vertOrHoriz = function() return vim.go.columns > vim.go.lines and "vertical" or "horizontal" end

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
  -- Icons that need defining manaully through loops
  manaul = {
    DapBreakpoint = {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    },
    DapBreakpointCondition = {
      text = "ﳁ",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    },
    DapBreakpointRejected = {
      text = "",
      texthl = "DapBreakpint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    },
    DapLogPoint = {
      text = "",
      texthl = "DapLogPoint",
      linehl = "DapLogPoint",
      numhl = "DapLogPoint",
    },
    DapStopped = {
      text = "",
      texthl = "DapStopped",
      linehl = "DapStopped",
      numhl = "DapStopped",
    },
  },
}

M.colours = {
  DapBreakpoint = {
    ctermbg = 0,
    fg = "#98c379",
    bg = "#31353f",
  },
  DapLogPoint = {
    ctermbg = 0,
    fg = "#61afef",
    bg = "#31353f",
  },
  DapStopped = {
    ctermbg = 0,
    fg = "#ffc633",
    bg = "#31353f",
  },
}

return M
