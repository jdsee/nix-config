-- NVIM AUTOCOMMANDS

-- Open help in vertical split
vim.cmd [[
  au FileType help wincmd L
]]

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 100 }
  augroup end
]]

-- Terminal Defaults
vim.cmd [[
  augroup Terminal
      au!
      au TermEnter * startinsert                     "" start terminal in insert mode
      au TermOpen * :set nonumber norelativenumber   "" disable linenumbers in terminal
      au TermOpen * nnoremap <buffer> <C-c> i<C-c>   "" use Ctrl-c in terminal
  augroup END
]]

-- Set wrap for text files
vim.cmd [[
  augroup OpenReadFiles
    au!
    au BufEnter *.md,*.tex,*.typ,*.adoc setlocal wrap spell
  augroup END
]]

-- TODO: Try to delay saving the file or otherwise typst recompiling to prevent zathura from crashing
vim.api.nvim_create_autocmd(
  { 'InsertLeave', --[['TextChanged', 'TextChangedI']] }, {
  pattern = {'*.typ'},
  command = 'silent write',
})

-- Set insert mappings for German umlauts in text files
vim.api.nvim_create_autocmd(
  { 'BufEnter' }, {
  group = 'OpenReadFiles',
  pattern = { '*.md', '*.tex', '*.typ', '*.adoc' },
  callback = function()
    vim.keymap.set('i', 'Ae', 'Ä')
    vim.keymap.set('i', 'Oe', 'Ö')
    vim.keymap.set('i', 'Ue', 'Ü')
    vim.keymap.set('i', 'ae', 'ä')
    vim.keymap.set('i', 'oe', 'ö')
    vim.keymap.set('i', 'ue', 'ü')
    vim.keymap.set('i', 'sz', 'ß')
  end,
})

-- Set mappings only for quickfix windows
-- TODO: make this work
-- vim.cmd [[
--   augroup QuickFix
--     au FileType qf <buffer> nnoremap o <CMD>.cc<CR>
--     au FileType qf <buffer> nnoremap <CR> <CMD>.cc<CR>
--   augroup END
-- ]]

-- Prevent creation of insecure copies of gopass files
vim.cmd [[
  au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
]]

-- Call PackerSync when plugins changed
vim.api.nvim_create_autocmd(
  'BufWritePost', {
  pattern = 'lua/plugins.lua',
  command = 'PackerSync',
})

-- Make macro indicator visible with cmdheight=0
vim.api.nvim_create_autocmd(
  'RecordingEnter', {
  pattern = '*',
  command = 'set cmdheight=1',
})
vim.api.nvim_create_autocmd(
  'RecordingLeave', {
  pattern = '*',
  command = 'set cmdheight=0',
})

-- Turn off cursorline on inactive buffers (stolen from TJ)
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline('WinLeave', false)
set_cursorline('WinEnter', true)
set_cursorline('FileType', false, 'TelescopePrompt')
