-- treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ['ia'] = "@parameter.inner",
          },
          swap_previous = {
            ['aa'] = "@parameter.inner",
          },
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
        },
      },
    }
  end,
}
