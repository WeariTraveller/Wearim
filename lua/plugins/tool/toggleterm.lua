local s = require "style"
local opts = {
  size = function(term)
    if term.direction == "horizontal" then
      return s.height()
    elseif term.direction == "vertical" then
      return s.width()
    end
  end,
  open_mapping = "<m-=>",
  float_opts = {
    width = s.widthBd,
    height = s.heightTl,
  },
  direction = "float",
}

-- In case of overriding on_create
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function(ev)
    if vim.bo[ev.buf].filetype ~= "toggleterm" then return end
    local _, term = require "toggleterm.terminal".identify()
    if term.display_name then return end
    local stem = require "utils".Path.stem
    -- Get [pid]:[cmd] first, then pathed program as cmd without args, at last a basename
    -- To do: remove ;#toggleterm#%d in the end
    --[[local realProg = stem { filename = vim.fn.expand("%:t"):match("^%d+:(%S+)") }]]
    local prog = --[[realProg ==]]
      stem { filename = (term.cmd or vim.opt.shell:get()):match("^%S+") }
    -- This will be useful after toggleterm migrates to jobstart, replacing deprecated termopen
    --[[and realProg or string.format("scripts in %s", realProg)]]
    -- It's amazing that term.count could be nil
    term.display_name = string.format("%d[%d]%s", vim.b.toggle_number, term.id, prog)
  end,
})

return {
  "akinsho/toggleterm.nvim",
  opts = opts,
  -- It doesn't work if add desc here
  keys = { "<m-=>" },
  lualine = {
    filetypes = { "toggleterm" },
    sections = {
      -- encoding is invalid for term buf
      lualine_a = { "mode" },
      lualine_b = {
        function()
          local _, term = require "toggleterm.terminal".identify()
          return term.display_name
        end,
      },
    },
  },
}
