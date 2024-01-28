return {
  -- Want to try:
  -- - 'nvim-pack/nvim-spectre'

  'tpope/vim-repeat', -- repeat plugin commands with .
  'tpope/vim-surround', -- work on surrounding characters like [(
  'tpope/vim-unimpaired', -- Pairs of hande bracket mappings       
  'wellle/targets.vim', -- inner style text objects                
  'dhruvasagar/vim-table-mode', -- markdown table support          
  'ThePrimeagen/vim-be-good', -- game to practice vim movements    
  'xiyaowong/transparent.nvim', -- Simple command to make bg tran  
  'chentoast/marks.nvim', -- View marks in sign column             

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

}
