return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'VonHeikemen/lsp-zero.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require('cmp')
    local lsp_zero = require('lsp-zero')
    require('luasnip.loaders.from_vscode').lazy_load()
    cmp.setup {
      preselect = 'item',
      completion = {
        completeopt = 'menu,menuone,noinsert'
      },
      formatting = lsp_zero.cmp_format(),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'treesitter' },
        { name = 'conjure' },
        { name = 'buffer',    keyword_length = 5 },
      },
      mapping = cmp.mapping.preset.insert {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Navigate between snippet placeholder
        ['<C-h>'] = lsp_zero.cmp_action().luasnip_jump_forward(),
        ['<C-l>'] = lsp_zero.cmp_action().luasnip_jump_backward(),
        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      },
    }
  end

}
