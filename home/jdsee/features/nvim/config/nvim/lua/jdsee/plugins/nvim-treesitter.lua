-- treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'windwp/nvim-ts-autotag',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'awk',
        'bash',
        'c',
        'cpp',
        'clojure',
        'css',
        'dockerfile',
        'elixir',
        'gleam',
        'go',
        'haskell',
        'html',
        'java',
        'javascript',
        'json',
        'kotlin',
        'ocaml',
        'query',
        'roc',
        'rust',
        'scala',
        'sql',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
      },
      autotag = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = "@parameter.outer",
            ['ia'] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>>a'] = "@parameter.inner",
          },
          swap_previous = {
            ['<leader><a'] = "@parameter.inner",
          },
          ["<leader><f"] = "@function.outer",
          ["<leader>>f"] = "@function.inner",
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
          },
          --
          -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
          ["]o"] = "@loop.*",
        },
      },
    }
  end,
}
