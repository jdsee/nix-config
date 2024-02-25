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
    oil.setup(
      {
        view_options = {
          show_hidden = true,
        },
        win_options = {
          signcolumn = 'number',
        },
        delete_to_trash = true,
        keymaps = {
          ['-'] = actions.parent,
          ['H'] = actions.parent,
          ['L'] = '<C-o>',
          ['q'] = oil.close,
        },
      }
    )

    local function toggle_cwd_float()
      oil.toggle_float(vim.fn.getcwd())
    end

    vim.keymap.set('n', '-', oil.open)
    vim.keymap.set('n', '<Tab>', oil.toggle_float)
    vim.keymap.set('n', '<S-Tab>', toggle_cwd_float)

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
