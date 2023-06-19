local lspconfig = require 'nvim-lspconfig'

return {
  cmd = 'typst-lsp',
  filetypes = { 'typst' },
  root_dir = lspconfig.util.find_node_modules_ancestor,
  settings = {
    exportPdf = "onSave",
  }
}
