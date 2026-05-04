local builder = (function()
  local queries = {
    { "@parameter.outer", "parameter" },
    { "@function.outer", "function" },
    { "@return.outer", "return" },
    { "@class.outer", "class" },
    { "@conditional.outer", "judge" },
    { "@loop.outer", "loop" },
  }
  return function(desc, keynames)
    local maps = {}
    for i, v in pairs(queries) do
      maps[keynames[i]] = { query = v[1], desc = string.gsub(desc, "%s", v[2]) }
    end
    return maps
  end
end)()

local tsObjOpts = {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = { query = "@parameter.outer", desc = "a argument" },
        ["ia"] = { query = "@parameter.inner", desc = "inner part of a argument" },
        ["af"] = { query = "@function.outer", desc = "a function region" },
        ["if"] = { query = "@function.inner", desc = "inner part of a function region" },
        ["ar"] = { query = "@return.outer", desc = "a return" },
        ["ir"] = { query = "@return.inner", desc = "inner return" },
        ["ac"] = { query = "@class.outer", desc = "a of a class" },
        ["ic"] = { query = "@class.inner", desc = "inner part of a class region" },
        ["aj"] = { query = "@conditional.outer", desc = "a judge" },
        ["ij"] = { query = "@conditional.inner", desc = "inner part of a judge region" },
        ["al"] = { query = "@loop.outer", desc = "a loop" },
        ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
      },
    },
  },
  nvim_next = {
    enable = true,
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = builder("Next %s start", { "]a", "]f", "]r", "]c", "]j", "]l" }),
        goto_next_end = builder("Next %s end", { "]A", "]F", "]R", "]C", "]J", "]L" }),
        goto_previous_start = builder("Previous %s start", { "[a", "[f", "[r", "[c", "[j", "[l" }),
        goto_previous_end = builder("Previous %s end", { "[A", "[F", "[R", "[C", "[J", "[L" }),
      },
    },
  },
}

local tssetup = function()
  local ts = require "nvim-treesitter"
  if not ts.get_installed() then ts.install(require "langs".list) end
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
    event = "VeryLazy",
  },
}
