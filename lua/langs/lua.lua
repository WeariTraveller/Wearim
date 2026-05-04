return {
  lsp = { name = "lua_ls" },
  ensure = "lua-language-server",
  null = function(s) return s.builtins.formatting.stylua end,
}
