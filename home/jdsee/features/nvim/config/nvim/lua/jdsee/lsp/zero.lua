-- require 'jdsee.plugins.nvim-cmp'

local lsp = require('lsp-zero').preset {
  name = 'recommended',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
  -- cmp_capabilities = {
  --   { name = 'nvim_lua' },
  --   { name = 'nvim_lsp' },
  --   { name = 'path' },
  --   { name = 'luasnip' },
  --   { name = 'treesitter' },
  --   { name = 'conjure' },
  --   { name = 'buffer', keyword_length = 5 },
  -- }
}

lsp.nvim_workspace()

lsp.ensure_installed {
  'bashls',
  'clangd',
  'clojure_lsp',
  'cssls',
  'dockerls',
  'eslint',
  'html',
  'jsonls',
  'lemminx',
  'marksman',
  'pyright',
  'texlab',
  'yamlls',
}

lsp.on_attach(require('jdsee.lsp.config').on_attach)

lsp.setup()

