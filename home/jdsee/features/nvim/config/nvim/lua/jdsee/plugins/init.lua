require('jdsee.util.bootstrap').install_lazy()

require('lazy').setup {
  -- TO ADD:
  -- 'SmiteshP/nvim-navbuddy'

  'tpope/vim-repeat', -- repeat plugin commands with .
  'tpope/vim-surround', -- work on surrounding characters like [({"'...
  'wellle/targets.vim', -- inner style text objects
  'dhruvasagar/vim-table-mode', -- markdown table support
  'ThePrimeagen/vim-be-good', -- game to practice vim movements
  'xiyaowong/transparent.nvim', -- Simple command to make bg transparent

  -- Git Integration ---
  {
    'tpope/vim-fugitive',
    config = function() require('jdsee.plugins.fugitive') end,
  },

  -- Git Worktree support ---
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function() require 'jdsee.plugins.git-worktree' end
  },

  --- Autopair Brackets ---
  {
    'windwp/nvim-autopairs',
    config = function() require 'jdsee.plugins.nvim-autopairs' end,
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

  --- Smooth Scrolling ---
  {
    'karb94/neoscroll.nvim',
    config = function() require('neoscroll').setup() end,
  },

  --- Treesitter ---
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function() require 'jdsee.plugins.nvim-treesitter' end,
    build = ':TSUpdate'
    ,
  },

  --- Refactoring Tool ---
  {
    'ThePrimeagen/refactoring.nvim',
    config = function() require 'jdsee.plugins.refactoring' end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter' }
    }
  },

  {
    'ThePrimeagen/harpoon',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require 'jdsee.plugins.harpoon' end
  },

  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('octo').setup() end,
    cond = true,
  },

  --- Nvim Build Tool ---
  {
    'pianocomposer321/yabs.nvim',
    config = function() require 'jdsee.plugins.yabs' end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    cond = true,
  },

  --- Code Runner ---
  {
    'michaelb/sniprun',
    config = function() require 'jdsee.plugins.sniprun' end,
    build = 'bash ./install.sh',
    cond = true,
  },

  --- GIT Marker ---
  {
    'lewis6991/gitsigns.nvim',
    config = function() require 'jdsee.plugins.gitsigns' end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  --- Tab View for Buffers ---
  {
    'romgrk/barbar.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

  --- Colorschemes ---
  {
    { 'ellisonleao/gruvbox.nvim' },
    { 'sainnhe/gruvbox-material' },
    { 'sainnhe/everforest' },
    { 'Mofiqul/adwaita.nvim' },
    { 'rebelot/kanagawa.nvim' },
    { 'folke/tokyonight.nvim' },
    { 'EdenEast/nightfox.nvim' },
    { 'catppuccin/catppuccin' },
    { 'shaunsingh/oxocarbon.nvim' },
    {
      'mcchrish/zenbones.nvim',
      dependencies = 'rktjmp/lush.nvim'
    }
  },

  {
    "smjonas/live-command.nvim",
    config = function() require 'jdsee.plugins.live-command' end,
  },

  --- File Tree ---
  {
    'nvim-neo-tree/neo-tree.nvim',
    config = function() require 'jdsee.plugins.neotree' end,
    branch = "v2.x",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },

  --- Indentation Visualizer ---
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require 'jdsee.plugins.indent-blankline' end,
  },

  --- Statusbar ---
  {
    'nvim-lualine/lualine.nvim',
    config = function() require 'jdsee.plugins.lualine' end,
  },

  --- Telescope Fuzzy Finder ---
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'jdsee.plugins.telescope'
      require 'jdsee.plugins.neoclip' 
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'jvgrootveld/telescope-zoxide',
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-frecency.nvim',
      'tami5/sqlite.lua',
      'AckslD/nvim-neoclip.lua',
    },
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
    config = function() require 'jdsee.lsp.zero' end,
  },

  --- Java LSP ---
  { 'mfussenegger/nvim-jdtls' },

  --- Scala LSP ---
  {
    'scalameta/nvim-metals',
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  --- Latex Integration ---
  {
    'lervag/vimtex',
    config = function() require 'jdsee.plugins.vimtex' end
  },

  --- Typst language support ---
  {
    'SeniorMars/typst.nvim',
  },

  --- Clojure Integration ---
  {
    {
      'Olical/conjure',
      config = function() require 'jdsee.plugins.conjure' end
    },
    {
      'clojure-vim/vim-jack-in',
      dependencies = {
        'tpope/vim-dispatch',
        'radenling/vim-dispatch-neovim',
      }
    },
    {
      'tpope/vim-sexp-mappings-for-regular-people',
      dependencies = 'guns/vim-sexp'
    }
  },

  --- Testrunner ---
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'vim-test/vim-test',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test',
    },
    config = function() require 'jdsee.plugins.neotest' end
  },

  {
    'mfussenegger/nvim-dap',
    config = function() require 'jdsee.plugins.nvim-dap' end,
    dependencies = {
      { 'nvim-telescope/telescope-dap.nvim' },
      { 'theHamsta/nvim-dap-virtual-text' },
      { 'rcarriga/nvim-dap-ui' },
      { 'jbyuki/one-small-step-for-vimkind' },
      { 'mfussenegger/nvim-dap-python' },
    }
  }
}
