-- git-worktree
-- https://github.com/ThePrimeagen/git-worktree.nvim

return {
  'ThePrimeagen/git-worktree.nvim',
  config = function() 
    local telescope = require('telescope')
    telescope.load_extension('git_worktree')
    vim.keymap.set('n', '<Leader>gw', telescope.extensions.git_worktree.git_worktrees)
  end
}
