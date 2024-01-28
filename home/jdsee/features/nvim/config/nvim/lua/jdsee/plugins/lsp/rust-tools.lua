return {
  'simrat39/rust-tools.nvim',
  dependencies = {
    'VonHeikemen/lsp-zero.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('rust-tools').setup {
      server = {
        on_attach = require('jdsee.plugins.lsp.config').on_attach,
      },
      assist = {
        importEnforceGranularity = true,
        importPrefix = 'crate',
      },
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        allFeatures = true,
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
  end,
}
