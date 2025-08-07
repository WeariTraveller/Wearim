local opts = function()
  local lga_actions = require "telescope-live-grep-args.actions"

  local function flash(prompt_bufnr)
    require("flash").jump {
      pattern = "^",
      label = { after = { 0, 0 } },
      search = {
        mode = "search",
        exclude = {
          function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults" end,
        },
      },
      action = function(match)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        picker:set_selection(match.pos[1] - 1)
      end,
    }
  end

  return {
    defaults = {
      mappings = {
        n = {
          s = flash,
          f = require("telescope.actions").to_fuzzy_refine,
        },
        i = {
          ["<c-s>"] = flash,
          ["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
        },
      },
      prompt_prefix = " ",
      selection_caret = " ",
    },
    pickers = {
      find_files = {
        theme = "ivy",
      },
      oldfiles = {
        theme = "ivy",
      },
      jumplist = {
        theme = "dropdown",
      },
    },
    extensions = {
      live_grep_args = {
        theme = "dropdown",
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
          },
        },
      },
    },
  }
end

local config = function(_, opts)
  local telescope = require "telescope"

  telescope.setup(opts)

  local extensions = {
    "dap",
    "fzy_native",
    "notify",
    "live_grep_args",
    "luasnip",
  }

  for _, ext in ipairs(extensions) do
    local ok = pcall(telescope.load_extension, ext)
    if not ok then vim.print("Failed to load telescope extension: " .. ext) end
  end
end

local keys = {
  { "t", "<nop>", group = "telescope" },
  {
    "tf",
    function() require("telescope.builtin").find_files() end,
    desc = "Files",
  },
  {
    "tb",
    function() require("telescope.builtin").buffers() end,
    desc = "Buffers",
  },
  {
    "t?",
    function() require("telescope.builtin").help_tags() end,
    desc = "Telescope help",
  },
  {
    "to",
    function() require("telescope.builtin").oldfiles() end,
    desc = "Opened files",
  },
  {
    "tm",
    function() require("telescope.builtin").marks() end,
    desc = "Marks",
  },
  {
    "ts",
    function() require("telescope.builtin").lsp_document_symbols() end,
    desc = "Lsp doc buffer symbols",
  },
  {
    "tS",
    function() require("telescope.builtin").lsp_workspace_symbols() end,
    desc = "Lsp doc workspace symbols",
  },
  {
    "tj",
    function() require("telescope.builtin").jumplist() end,
    desc = "Jumplist",
  },
  {
    "tg",
    function() require("telescope").extensions.live_grep_args.live_grep_args() end,
    desc = "Live grep",
  },
  {
    "tn",
    function() require("telescope").extensions.notify.notify() end,
    desc = "Notify",
  },
  {
    "tc",
    function() require("telescope").extensions.dap.commands() end,
    desc = "Commands",
  },
  {
    "ti",
    function() require("telescope").extensions.dap.configurations() end,
    desc = "Configurations",
  },
  {
    "tp",
    function() require("telescope").extensions.dap.list_breakpoints() end,
    desc = "Breakpoints",
  },
  {
    "tv",
    function() require("telescope").extensions.dap.variables() end,
    desc = "Variables",
  },
  {
    "tw",
    function() require("telescope").extensions.dap.frames() end,
    desc = "Frames",
  },
}

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "benfowler/telescope-luasnip.nvim",
  },
  opts = opts,
  config = config,
  cmd = {
    "Telescope",
  },
  lazy = true,
  whichKey = keys,
}
