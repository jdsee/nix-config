-- harpoon
-- https://github.com/ThePrimeagen/harpoon

return {
  'ThePrimeagen/harpoon',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local Mark = require('harpoon.mark')
    local Ui = require('harpoon.ui')
    vim.keymap.set('n', '<Leader>hl', Ui.toggle_quick_menu)
    vim.keymap.set('n', '<Leader>ha', Mark.add_file)
    vim.keymap.set('n', '<Leader>hr', Mark.rm_file)
    vim.keymap.set('n', '<Leader>hh', Mark.toggle_file)
    vim.keymap.set('n', '<C-h>', Ui.nav_next)
    vim.keymap.set('n', '<C-l>', Ui.nav_next)
    vim.keymap.set('n', '<C-m>', function() Ui.nav_file(1) end)
    vim.keymap.set('n', '<C-,>', function() Ui.nav_file(2) end)
    vim.keymap.set('n', '<C-.>', function() Ui.nav_file(3) end)
    vim.keymap.set('n', '<C-/>', function() Ui.nav_file(4) end)
  end
}
