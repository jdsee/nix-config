return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'SirZenith/oil-vcs-status',
  },
  config = function()
    local oil = require('oil')
    local actions = require('oil.actions')

    local function toggle_cwd_float()
      oil.toggle_float(vim.fn.getcwd())
    end

    oil.setup(
      {
        cleanup_delay_ms = false, -- prevent removal of buffers from jumplist
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
        },
        columns = {
          'icon',
          -- 'permissions',
        },
        win_options = {
          signcolumn = 'number',
        },
        preview = {
          max_width = 0.9,
          min_width = 0.6,
        },
        keymaps = {
          ['H'] = actions.parent,
          ['L'] = actions.select,
          ['gp'] = actions.preview,
          ['q'] = oil.close,
          ['-'] = oil.close,
          ['<leader>j'] = oil.close,
        },
      }
    )

    vim.keymap.set('n', '<leader>j', oil.open)
    vim.keymap.set('n', '-', oil.toggle_float)
    vim.keymap.set('n', '<S-->', toggle_cwd_float)

    local oil_vcs = require('oil-vcs-status')
    local status_const = require "oil-vcs-status.constant.status"
    local StatusType = status_const.StatusType

    oil_vcs.setup {
      status_symbol = {
        [StatusType.Added]               = "",
        [StatusType.Copied]              = "󰆏",
        [StatusType.Deleted]             = "",
        [StatusType.Ignored]             = "",
        [StatusType.Modified]            = "",
        [StatusType.Renamed]             = "",
        [StatusType.TypeChanged]         = "󰉺",
        [StatusType.Unmodified]          = " ",
        [StatusType.Unmerged]            = "",
        [StatusType.Untracked]           = "",
        [StatusType.External]            = "",

        [StatusType.UpstreamAdded]       = "󰈞",
        [StatusType.UpstreamCopied]      = "󰈢",
        [StatusType.UpstreamDeleted]     = "",
        [StatusType.UpstreamIgnored]     = " ",
        [StatusType.UpstreamModified]    = "󰏫",
        [StatusType.UpstreamRenamed]     = "",
        [StatusType.UpstreamTypeChanged] = "󱧶",
        [StatusType.UpstreamUnmodified]  = " ",
        [StatusType.UpstreamUnmerged]    = "",
        [StatusType.UpstreamUntracked]   = " ",
        [StatusType.UpstreamExternal]    = "",
      }
    }
  end
}
