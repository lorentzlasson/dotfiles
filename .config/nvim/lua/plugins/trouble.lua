require('trouble').setup({
  focus = true,
})

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')