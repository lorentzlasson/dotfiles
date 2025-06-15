require('which-key').setup()

-- Manual keybinding discovery
vim.keymap.set('n', '<leader>?', '<cmd>WhichKey<CR>', { desc = 'Show keybindings' })