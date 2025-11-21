require('icon-picker').setup({ disable_legacy_commands = true })

-- Icon picker keybinding
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader><Leader>i', '<cmd>IconPickerNormal emoji<cr>', opts)
