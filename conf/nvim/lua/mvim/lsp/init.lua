local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "mvim.lsp.mason"
require("mvim.lsp.handlers").setup()
require "mvim.lsp.null-ls"
