vim.g['conjure#mapping#doc_word'] = false
vim.g['g:sexp_enable_insert_mode_mappings'] = false

-- Keymappings
vim.keymap.set('n', '<LocalLeader>tt', '<cmd>ConjureCljRunCurrentTest<cr>')
vim.keymap.set('n', '<LocalLeader>tn', '<cmd>ConjureCljRunCurrentNsTests<cr>')
vim.keymap.set('n', '<LocalLeader>ta', '<cmd>ConjureCljRunAllTests<cr>')
