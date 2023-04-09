local lspconfig = require 'lspconfig'

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  on_attach = require('jdsee.lsp.config').on_attach,
}

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults)

local external_servers = {
    'typst_lsp'
}

for _, server in pairs(external_servers) do
  local opts = lsp_defaults
  local extend, ext_opts = pcall(require, 'jdsee.lsp.' .. server)

  if extend then
    opts = vim.tbl_deep_extend('force', opts, ext_opts)
  end

  lspconfig[server].setup(lsp_defaults)
end

-- Autoformat on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.js', '*.jsx', '*.lua' },
  callback = vim.lsp.buf.format,
})
