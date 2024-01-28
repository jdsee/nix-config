-- indent-blankline
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    require('ibl').setup()
  end,
}
