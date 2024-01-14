vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap = true })
