local resultEnum = {
  "Success",
  "Error",
  "Failure",
  "Unconfigured",
}

function synctex_forward_search()
  local params = {
    textDocument = { uri = vim.uri_from_bufnr(0) },
    position = { line = vim.fn.line(".") - 1, character = vim.fn.col(".") },
  }
  vim.lsp.buf_request_all(
    0,
    "textDocument/forwardSearch",
    params,
    function(re) vim.notify("SyncTeX: " .. resultEnum[re[1].result.status + 1], vim.log.levels.INFO) end
  )
end
toMap("n", "<leader>tfs", synctex_forward_search, "SyncTeX")

return {}
