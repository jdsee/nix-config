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

-- TODO: Try to delay saving the file or otherwise typst recompiling to prevent zathura from crashing
vim.api.nvim_create_autocmd(
  { 'InsertLeave', --[['TextChanged', 'TextChangedI']] }, {
  pattern = {'*.typ'},
  command = 'silent write',
})

local open_read_files_group_id = vim.api.nvim_create_augroup('OpenReadFiles', { clear = true })
local text_filetypes = { '*.md', '*.tex', '*.typ', '*.adoc' }
local function set_umlaut_mappings(delete)
  local mappings = {
    Ae = 'Ä',
    Oe = 'Ö',
    Ue = 'Ü',
    ae = 'ä',
    oe = 'ö',
    ue = 'ü',
    sz = 'ß',
  }
  for lhs, rhs in pairs(mappings) do
    if (not delete) then
      vim.keymap.set('i', lhs, rhs)
    else
      pcall(function() vim.keymap.del('i', lhs) end)
    end
  end
end

local function contains_spelllang(term)
    for _, lang in ipairs(vim.opt_local.spelllang:get()) do
      if (string.match(lang, '^'..term)) then return true end
    end
    return false
end

-- Set insert mappings for German umlauts in text files
vim.api.nvim_create_autocmd(
  { 'BufEnter' }, {
  group = open_read_files_group_id,
  pattern = text_filetypes,
  callback = function()
    vim.o.spell = true
    vim.o.wrap = true
    if (contains_spelllang('de')) then
      set_umlaut_mappings()
    end
  end,
})

-- Activate/deactivate umlaut mappings if spelllang switched to german
vim.api.nvim_create_autocmd(
  { 'OptionSet' }, {
  group = open_read_files_group_id,
  pattern = { 'spelllang' },
  callback = function()
    if (contains_spelllang('de')) then
      vim.api.nvim_exec_autocmds(
        { 'BufEnter' },
        { group = open_read_files_group_id })
    else
      set_umlaut_mappings(true)
    end
  end,
})


-- Set rustfmt as format expression in rust files. See ':help gq'
vim.api.nvim_create_autocmd(
  { 'BufEnter' }, {
  pattern  = { '*.rs' },
  command = 'set fp=rustfmt',
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
