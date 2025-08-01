vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- won't be folded even in fact the level > 99
vim.wo.foldlevel = 99

local tsOpts = {
  highlight = {
    enable = true,
  },
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "vim",
    "vimdoc",
    "regex",
    "markdown",
    "markdown_inline",
    "latex",
    "javascript",
    "json",
    "typescript",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
}

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

return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = tsOpts,
    build = ":TSUpdate",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    main = "nvim-treesitter.configs",
    config = function()
      require("nvim-next.integrations").treesitter_textobjects()
      require("nvim-treesitter.configs").setup(tsObjOpts)
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "ghostbuster91/nvim-next",
    },
    event = "VeryLazy",
  },
}
