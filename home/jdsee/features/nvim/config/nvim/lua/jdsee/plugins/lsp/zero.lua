return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
    }
  },
  config = function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_lspconfig()
    lsp_zero.on_attach(require('jdsee.plugins.lsp.config').on_attach)
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
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
        'rnix',
        'rust_analyzer',
        'texlab',
        'tsserver',
        'yamlls',
      },
      handlers = {
        lsp_zero.default_setup,
        rust_analyzer = lsp_zero.noop,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
      },
    }
  end,
}
