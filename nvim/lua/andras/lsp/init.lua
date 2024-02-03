local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "andras.lsp.mason"
require("andras.lsp.handlers").setup()
require "andras.lsp.null-ls"
