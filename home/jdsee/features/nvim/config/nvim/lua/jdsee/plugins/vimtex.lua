-- vimtex
-- https://github.com/lervag/vimtex

return {
  'lervag/vimtex',
  config = function()
    vim.g.vimtex_syntax_enabled = false
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_mode = 1 -- open quickfix only on errors
    vim.g.vimtex_quickfix_open_on_warning = false
  end,
}
