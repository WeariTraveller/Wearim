local config = function()
  local cmp = require "cmp"
  local lspkind = require "lspkind"
  local luasnip = require "luasnip"
  local mode = { "i", "c", "s" }

  local wk = require("which-key")
  local registerKey = function(keys)
    local maps = {}
    for _, key in ipairs(keys) do
      wk.add { key[1], mode = mode, desc = key[3] }
      maps[key[1]] = key[2]
    end
    return maps
  end
  local trimap = function(func) return cmp.mapping(func, mode) end

  cmp.setup {
    snippet = {
      expand = function(args) require("luasnip").lsp_expand(args.body) end,
    },

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "nvim_lsp_document_symbol" },
      { name = "nvim_lsp_signature_help" },
      { name = "treesitter" },
      { name = "luasnip" },
      { name = "calc" },
      { name = "buffer" },
      { name = "path" },
    }),

    mapping = registerKey {
      -- <C-.> and <C-,> can't be mapped properly in Windows Terminal properly
      { "<A-.>", trimap(cmp.mapping.complete()), "Open cmp" },
      { "<A-,>", trimap(cmp.mapping.close()), "Close cmp" },

      { "<C-k>", trimap(cmp.mapping.select_prev_item()), "Prev completion" },
      { "<C-j>", trimap(cmp.mapping.select_next_item()), "Next completion" },
      {
        "<C-p>",
        trimap(function()
          for i = 1, 5, 1 do
            cmp.select_prev_item()
          end
        end),
        "Prev 5th completion",
      },
      {
        "<C-n>",
        trimap(function()
          for i = 1, 5, 1 do
            cmp.select_next_item()
          end
        end),
        "Next 5th completion",
      },
      -- Command mode doesn't have the need to confirm manually
      { "<CR>", cmp.mapping.confirm { select = true }, "Confirm completion" },
      { "<C-u>", trimap(cmp.mapping.scroll_docs(-4)), "Scroll up doc" },
      { "<C-d>", trimap(cmp.mapping.scroll_docs(4)), "Scroll down doc" },

      -- snippet
      {
        "<C-l>",
        function()
          if luasnip.locally_jumpable(1) then luasnip.jump(1) end
        end,
        "Next snippet arg",
      },
      {
        "<C-h>",
        function()
          if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
        end,
        "Prev snippet arg",
      },
      {
        "<C-c>",
        function()
          if luasnip.choice_active() then luasnip.change_choice(1) end
        end,
        "Change snippet choice",
      },

      {
        "<Tab>",
        function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end,
        "Super Tab",
      },
      {
        "<S-Tab>",
        function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
        "Super Shift Tab",
      },
    },

    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
        -- Show the source in brackets
        before = function(entry, vim_item)
          vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
          return vim_item
        end,
      }),
    },
  }

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline("?", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
  })
end

return {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lua",
  },
  config = config,
}
