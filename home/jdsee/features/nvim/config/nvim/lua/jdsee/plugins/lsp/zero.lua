local function setup_zero()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()
  lsp_zero.on_attach(require('jdsee.plugins.lsp.config').on_attach)
  lsp_zero.format_on_save({
    format_opts = {
      async = false,
      timeout_ms = 10000,
    },
    servers = {
      ['tsserver'] = { 'javascript', 'typescript' },
      ['rust_analyzer'] = { 'rust' },
      ['lua-ls'] = { 'lua' },
    }
  })
  lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  })
end

local function setup_servers()
  local lspconfig = require('lspconfig')
  local lsp_zero = require('lsp-zero')

  lspconfig.bashls.setup({})
  lspconfig.cssls.setup({})
  lspconfig.elmls.setup({})
  lspconfig.gleam.setup({})
  lspconfig.jsonls.setup({})
  lspconfig.nil_ls.setup({})
  lspconfig.tsserver.setup({})
  lspconfig.volar.setup({})
  lspconfig.phpactor.setup({})
  -- TODO, this is broken: lspconfig.kotlin_language_server.setup({})
  lspconfig.lua_ls.setup {
    on_attach = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      lspconfig.lua_ls.setup(lua_opts)
    end
  }
end

local function setup_mason()
  local lsp_zero = require('lsp-zero')

  require('mason').setup()
  require('mason-lspconfig').setup {
    handlers = {
      lsp_zero.default_setup,
      rust_analyzer = lsp_zero.noop,
      lua_ls = function()
        local lua_opts = lsp_zero.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
      end,
    },
  }
end

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
      opts = { lsp = { auto_attach = true } }
    }
  },
  config = function()
    setup_zero()
    setup_servers()
    setup_mason()
  end,
}
