-- harpoon
-- https://github.com/ThePrimeagen/harpoon

return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')
    local telescope = require('telescope')

    telescope.load_extension('harpoon')

    vim.keymap.set('n', '<Leader>hl', ui.toggle_quick_menu)
    vim.keymap.set('n', '<Leader>ha', mark.add_file)
    vim.keymap.set('n', '<Leader>hr', mark.rm_file)
    vim.keymap.set('n', '<Leader>hh', mark.toggle_file)
    vim.keymap.set('n', '<C-h>', ui.nav_next)
    vim.keymap.set('n', '<C-l>', ui.nav_next)
    vim.keymap.set('n', '<C-m>', function() ui.nav_file(1) end)
    vim.keymap.set('n', '<C-,>', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<C-.>', function() ui.nav_file(3) end)
    vim.keymap.set('n', '<C-/>', function() ui.nav_file(4) end)
  end
}
