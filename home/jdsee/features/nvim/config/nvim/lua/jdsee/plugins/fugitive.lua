-- https://github.com/tpope/vim-fugitive

return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<Leader>gs', '<cmd>G<CR>')
    vim.keymap.set('n', 'gd>', '<cmd>diffget //2<CR>')
    vim.keymap.set('n', 'gd<', '<cmd>diffget //3<CR>')
    vim.keymap.set('n', 'gdl', '<cmd>diffget //2<CR>')
    vim.keymap.set('n', 'gdh', '<cmd>diffget //3<CR>')
  end
}
