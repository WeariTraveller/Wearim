local style = require "style"
local kinds = vim.iter(style.icons.kind):fold({}, function(t, k, v)
  t[k] = { icon = v }
  return t
end)
local function getFile(state) return state.tree:get_node():get_id() end
local modify = vim.fn.fnamemodify
local function copy(ctx) vim.fn.setreg("+", ctx) end

local opts = {
  popup_border_style = style.border,
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
    },
  },
  source_selector = {
    winbar = true,
    sources = {
      {
        source = "filesystem",
        display_name = "  Files ",
      },
      {
        source = "buffers",
        display_name = "  Buffers ",
      },
      {
        source = "git_status",
        display_name = "  Git ",
      },
      {
        source = "document_symbols",
        display_name = "  Symbols",
      },
    },
    highlight_separator = "NeoTreeTabInactive",
    highlight_separator_active = "NeoTreeTabActive",
  },
  window = {
    width = style.widthNr,
    mappings = {
      ["h"] = "smart_key_h",
      ["l"] = "smart_key_l",

      -- Swap default split behavior
      ["S"] = "open_vsplit",
      ["s"] = "open_split",

      ["y"] = "copy_path_relative_to_cwd",
      ["Y"] = "copy_absolute_path",
      ["c"] = "none",
      ["cy"] = "copy_filename",
      ["cc"] = "copy",
      ["ch"] = "copy_path_relative_to_home",
    },
  },
  commands = {
    smart_key_h = function(state)
      local node = state.tree:get_node()
      if node.type == "directory" and node:is_expanded() then
        if state.name == "filesystem" then
          require("neo-tree.sources.filesystem.commands").toggle_node(state)
        else
          require("neo-tree.sources.common.commands").toggle_node(state)
        end
      else
        require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
      end
    end,

    smart_key_l = function(state)
      local node = state.tree:get_node()
      if node.type == "directory" then
        if not node:is_expanded() then
          if state.name == "filesystem" then
            require("neo-tree.sources.filesystem.commands").toggle_node(state)
          else
            require("neo-tree.sources.common.commands").toggle_node(state)
          end
        elseif node:has_children() then
          require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
        end
      elseif node.type == "file" then
        require("neo-tree.sources.common.commands").open(state)
      end
    end,

    copy_path_relative_to_cwd = function(state) copy(modify(getFile(state), ":.")) end,
    copy_absolute_path = function(state) copy(getFile(state)) end,
    copy_filename = function(state) copy(state.tree:get_node().name) end,
    copy_path_relative_to_home = function(state) copy(modify(getFile(state), ":~")) end,
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
    },
    group_empty_dirs = true,
    follow_current_file = {
      enabled = true,
    },
    window = {
      mappings = {
        ["[g"] = "none",
        ["]g"] = "none",
        ["[h"] = "prev_git_modified",
        ["]h"] = "next_git_modified",
      },
    },
  },
  document_symbols = {
    kinds = kinds,
  },
}

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "main",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("load_neo_tree", {}),
      desc = "Loads neo-tree when openning a directory",
      callback = function(args)
        local stats = vim.uv.fs_stat(args.file)

        if not stats or stats.type ~= "directory" then return end

        require "neo-tree"

        return true
      end,
    })
  end,
  config = function()
    require("neo-tree").setup(opts)
    vim.api.nvim_create_augroup("load_neo_tree", {})
  end,
  keys = {
    { "<A-t>", "<cmd>Neotree toggle<cr>", desc = "File Explorer" },
  },
}
