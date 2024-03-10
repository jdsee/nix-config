return {
  'gbprod/substitute.nvim',
  dependencies = { 'gbprod/yanky.nvim' },
  opts = {
    -- on_substitute = require("yanky.integration").substitute(),
    range = {
      prefix = "gs",
    },
    highlight_substituted_text = {
      timer = 200,
    },
  },
  config = function()
    local substitute = require('substitute')
    vim.keymap.set("n", "gs", substitute.operator, { noremap = true })
    vim.keymap.set("n", "gss", substitute.line, { noremap = true })
    vim.keymap.set("x", "gs", substitute.visual, { noremap = true })
    vim.keymap.set("n", "S", substitute.eol, { noremap = true })
  end
}
