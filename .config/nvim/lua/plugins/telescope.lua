local telescope = require('telescope')
local actions = require('telescope.actions')

local builtin = require('telescope.builtin')
local keymap = vim.keymap.set

keymap('n', '<C-f>', builtin.find_files, { noremap = true, silent = true })
keymap('n', '<M-f>', builtin.live_grep, { noremap = true, silent = true })

telescope.load_extension('fzf') -- nvim-telescope/telescope-fzf-native.nvim

telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- move up/down with ctrl-k / ctrl-j
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- cycle search history with ctrl-n / ctrl-p
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
      n = {
        -- also allow moving up/down in normal mode
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true
    },
    live_grep = {
      additional_args = function()
        return { "--hidden" }
      end
    },
  }
}
