-- require 'jdsee.plugins.nvim-cmp'

local lsp = require('lsp-zero').preset {
  name = 'recommended',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
  cmp_capabilities = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'treesitter' },
    { name = 'conjure' },
    { name = 'buffer',    keyword_length = 5 },
  }
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
  'lua_ls',
  'rnix',
  'pyright',
  'texlab',
  'yamlls',
}

local config = require('jdsee.lsp.config')

lsp.on_attach(config.on_attach)
lsp.skip_server_setup {
  'rust_analyzer'
}

lsp.setup()

local rt = require 'rust-tools'

rt.setup {
  server = {
    on_attach = config.on_attach,
  },
  assist = {
    importEnforceGranularity = true,
    importPrefix = 'crate',
  },
  cargo = {
    allFeatures = true,
  },
  checkOnSave = {
    command = 'clippy',
  },
  inlayHints = { locationLinks = false },
  diagnostics = {
    enable = true,
    experimental = {
      enable = true,
    },
  },
}

require 'jdsee.lsp' -- Configure manually managed lsp servers
