local map = vim.api.nvim_set_keymap
local g = vim.g
local fn = vim.fn

-- Set leader to space
g.mapleader = ' '
g.maplocalleader = '\\'

-- Force reload from file
map('n', '<leader>e', ':edit!<CR>', { noremap = true })
map('n', '<M-a>', 'gg<S-V>G', { noremap = true })

-- Enter mappings
-- map('n', '<C-Enter>', 'O<Esc>', { noremap = true })
-- map('n', '<Enter>', 'o<Esc>', { noremap = true })

-- More mappings
map('v', '$', '$h', { noremap = true })
map('x', 'p', 'P', { noremap = true })
map('n', '<S-y>', 'v$hy<ESC>', { noremap = true })
map('v', '//', 'y/<C-R>"<Esc>', { noremap = true })

map('n', '<C-w>', ':echo "Use leader (Space) instead!"<CR>', { noremap = true })
map('n', '<leader>', '<C-w>', { noremap = true })
map('n', '<leader><leader>', '1<C-w>w', { noremap = true })
map('n', '<leader>>', '20<C-w>>', { noremap = true })
map('n', '<leader><', '20<C-w><', { noremap = true })

map('n', 'yp', ':lua CopyFilenameToClipboard()<CR>', {
  noremap = true,
  silent = false,
})

-- Smart indent with A
map('n', 'A', [[<cmd>lua IndentWithA()<CR>]], { noremap = true, silent = true })

-- Copy selection and wrap in codeblock (e.g. for llm prompts)
vim.keymap.set('v', '<leader>y', function()
  local start_pos = fn.getpos("'<")
  local end_pos = fn.getpos("'>")
  local lines = fn.getregion(start_pos, end_pos, { type = fn.visualmode() })
  local ft = vim.bo.filetype
  local formatted = "```" .. ft .. "\n" .. table.concat(lines, "\n") .. "\n```"
  fn.setreg('+', formatted)
end, {})