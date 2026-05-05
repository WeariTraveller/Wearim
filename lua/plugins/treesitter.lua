local objects = {
  { "@parameter.outer", "@parameter.inner", "argument", "a", "a" },
  { "@function.outer", "@function.inner", "function", "f", "f" },
  { "@return.outer", "@return.inner", "return", "r", "r" },
  { "@class.outer", "@class.inner", "class", "c", "c" },
  { "@conditional.outer", "@conditional.inner", "judge", "j", "j" },
  { "@loop.outer", "@loop.inner", "loop", "l", "l" },
}

local function build_select()
  local maps = {}
  for _, o in ipairs(objects) do
    local outer, inner, name, ok, ik = o[1], o[2], o[3], o[4], o[5]
    maps["a" .. ok] = { query = outer, desc = "a " .. name }
    maps["i" .. ik] = { query = inner, desc = "inner part of a " .. name }
  end
  return maps
end

local function build_move()
  -- { goto_fn_key, key_prefix, desc_prefix, use_outer }
  local directions = {
    { "goto_next_start", "]", "Next %s start", true },
    { "goto_next_end", "]", "Next %s end", true },
    { "goto_previous_start", "[", "Previous %s start", true },
    { "goto_previous_end", "[", "Previous %s end", true },
  }
  -- Lower case for start, and upper for end
  local use_upper = { [2] = true, [4] = true }

  local result = {}
  for i, d in ipairs(directions) do
    local maps = {}
    for _, o in ipairs(objects) do
      local query, name, key = o[1], o[3], o[4]
      local k = use_upper[i] and string.upper(key) or key
      maps[d[2] .. k] = {
        query = query,
        desc = string.gsub(d[3], "%%s", name),
      }
    end
    result[d[1]] = maps
  end
  return result
end

local tssetup = function()
  local ts = require "nvim-treesitter"
  ts.install(require "langs".list)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = require "langs".list,
    callback = function()
      vim.treesitter.start()
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldlevel = 99
    end,
  })
end

local tsObjSetup = function()
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
    },
  })

  local sel = require("nvim-treesitter-textobjects.select")
  local mov = require("nvim-treesitter-textobjects.move")
  local rep = require("nvim-treesitter-textobjects.repeatable_move")

  -- select
  for _, o in ipairs(objects) do
    local outer, inner, name, ok, ik = o[1], o[2], o[3], o[4], o[5]
    local function bind(key, query, desc)
      toMap({ "x", "o" }, key, function() sel.select_textobject(query, "textobjects") end, desc)
    end
    bind("a" .. ok, outer, "a " .. name)
    bind("i" .. ik, inner, "inner part of a " .. name)
  end

  local move_defs = {
    { fn = "goto_next_start", prefix = "]", upper = false, desc = "Next %s start" },
    { fn = "goto_next_end", prefix = "]", upper = true, desc = "Next %s end" },
    { fn = "goto_previous_start", prefix = "[", upper = false, desc = "Previous %s start" },
    { fn = "goto_previous_end", prefix = "[", upper = true, desc = "Previous %s end" },
  }
  for _, d in ipairs(move_defs) do
    for _, o in ipairs(objects) do
      local query, name, key = o[1], o[3], o[4]
      local k = d.upper and key:upper() or key
      toMap({ "n", "x", "o" }, d.prefix .. k, function() mov[d.fn](query, "textobjects") end, d.desc:gsub("%%s", name))
    end
  end

  toMap({ "n", "x", "o" }, ";", rep.repeat_last_move_next, "ts-obj repeats last move next")
  toMap({ "n", "x", "o" }, " ", rep.repeat_last_move_previous, "ts-obj repeats last move previous")
end

return {
  {
    "neovim-treesitter/nvim-treesitter",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    lazy = false,
    build = ":TSUpdate",
    config = tssetup,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      vim.g.no_plugin_maps = true
    end,
    config = tsObjSetup,
    event = "VeryLazy",
  },
}
