return {
  -- TODO: Want to try:
  -- - 'nvim-pack/nvim-spectre'
  -- - Nvim ChatGpt

  'tpope/vim-repeat',           -- repeat plugin commands with .
  'tpope/vim-surround',         -- work on surrounding characters like [(
  'tpope/vim-unimpaired',       -- Pairs of hande bracket mappings
  'wellle/targets.vim',         -- inner style text objects
  'dhruvasagar/vim-table-mode', -- markdown table support
  'ThePrimeagen/vim-be-good',   -- game to practice vim movements
  -- 'xiyaowong/transparent.nvim', -- Simple command to make bg transparent
  'chentoast/marks.nvim',       -- View marks in sign column
  'gleam-lang/gleam.vim',       -- Syntax Highlighting and snippets for Gleam
  'ChrisWellsWood/roc.vim',     -- Syntax Highlighting for Roc

  {
    'jdsee/umlauts.nvim',
    config = function() require('umlauts').setup() end,
  },

  --- Comment out Code with gc[motion] ---
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  },

  --- Visualize Colorcodes ---
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  },

  {
    'karb94/neoscroll.nvim',
    config = function() require('neoscroll').setup() end,
  },

  {
    'romgrk/barbar.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup {
        input_buffer_type = 'dressing',
      }
    end,
  }

}
