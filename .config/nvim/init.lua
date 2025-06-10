-- Lua utils
local api = vim.api
local map = vim.api.nvim_set_keymap
local o = vim.o
local cmd = vim.cmd
local g = vim.g
local fn = vim.fn

-- Plugins
require('lazy-setup')
require('plugins')

-- General settings
o.termguicolors = true

cmd 'colorscheme dunkel-kontrast'

-- make horizontal splits clearer
-- TODO: with dunkel?
cmd [[ highlight StatusLineNC guibg=black guifg=white ]]
cmd [[ highlight StatusLine guibg=black guifg=#7a59ff ]]

o.number = true             -- display line numbers
o.wrap = true               -- continue long lines on next lines
o.linebreak = true          -- wrap lines at convenient points
o.relativenumber = true     -- show relative line numbers
o.cursorcolumn = true
o.cursorline = true         -- highlight column and row
o.ruler = true              -- display column number
o.hidden = true             -- allow unsaved buffers
o.foldenable = false        -- disable folding
o.fixendofline = false      -- don't auto insert newline at end of file on save

o.clipboard = 'unnamedplus' -- connect to system clipboard (linux)
o.mouse = 'a'               -- enable mouse selection

-- Turn off swap files
o.swapfile = false
o.backup = false
o.writebackup = false

-- Indentation
o.list = true
o.listchars = 'tab:>-'
o.tabstop = 2
o.softtabstop = 0
o.expandtab = true
o.shiftwidth = 2
o.smarttab = true

cmd [[ autocmd FileType go setlocal noexpandtab ]]       -- use tabs for golang
cmd [[ autocmd FileType gdscript setlocal noexpandtab ]] -- use tabs for godot script

-- Folds
o.foldmethod = 'indent'
o.foldnestmax = 3
o.foldenable = false

-- Completion
o.wildmode = 'list:longest'
o.wildmenu = true
o.wildignore =
'*.o,*.obj,*~,*vim/backups*,*sass-cache*,*DS_Store*,vendor/rails/**,vendor/cache/**,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif'

-- Scrolling
o.scrolloff = 8
o.sidescrolloff = 15
o.sidescroll = 1

-- Search
o.incsearch = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

-- Auto-delete trailing white spaces except markdown
api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[ if index(['markdown'], &ft) < 0 | %s/\s\+$//e ]]
})

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

cmd [[
  cabbrev rel source $MYVIMRC
  cabbrev pp echo "use yn instead"
]]

function CopyFilenameToClipboard()
  vim.fn.setreg('+', vim.fn.expand('%'))
end

map('n', 'yp', ':lua CopyFilenameToClipboard()<CR>', {
  noremap = true,
  silent = false,
})

-- Define a function and command for creating txt files
api.nvim_create_user_command('Txt', function(opts)
  local name = opts.args
  local timestamp = fn.strftime('%Y%m%d%H%M%S')
  local filename = name == '' and (timestamp .. '.txt') or (name .. '.txt')
  cmd('e ' .. filename)
  cmd('write')
end, { nargs = '?' })

api.nvim_create_user_command('Sqlfmt', function()
  vim.cmd('%!sql-formatter --language postgresql')
end, {})

-- Smart indent with A
function IndentWithA()
  if #fn.getline('.') == 0 then
    api.nvim_feedkeys('cc', 'n', false)
  else
    api.nvim_feedkeys('A', 'n', false)
  end
end

map('n', 'A', [[<cmd>lua IndentWithA()<CR>]], { noremap = true, silent = true })

-- Allow :GBrowse to work
vim.api.nvim_create_user_command(
  'Browse',
  function(opts)
    vim.fn.system { 'xdg-open', opts.fargs[1] }
  end,
  { nargs = 1 }
)

-- Wrap selection in js debug log
vim.api.nvim_create_user_command('JsDebug', function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local indent = lines[1]:match("^%s*") or ""
  local selected_text = table.concat(lines, "\n"):gsub("^%s+", "")

  local wrapped_text = indent ..
      'console.log(`🍎🍎🍎 ' .. selected_text .. ': ${JSON.stringify(' .. selected_text .. ', null, 2)} 🍎🍎🍎`)'

  vim.fn.setline(start_pos[2], wrapped_text)
end, { range = true })

-- Copy selection and wrap in codeblock (e.g. for llm prompts)
vim.keymap.set('v', '<leader>y', function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getregion(start_pos, end_pos, { type = vim.fn.visualmode() })
  local ft = vim.bo.filetype
  local formatted = "```" .. ft .. "\n" .. table.concat(lines, "\n") .. "\n```"
  vim.fn.setreg('+', formatted)
end, {})

vim.api.nvim_create_user_command('CopyDiagnostics', function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    print("No diagnostics found")
    return
  end

  local formatted = table.concat(vim.tbl_map(function(d)
    return string.format("%s:%d: %s", vim.fn.bufname(d.bufnr or 0), d.lnum + 1, d.message)
  end, diagnostics), '\n')

  vim.fn.setreg('+', 'Neovim diagnostics:\n```text\n' .. formatted .. '\n```')
  print(string.format("Copied %d diagnostic(s) to clipboard", #diagnostics))
end, {})

-- Icon picker
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal emoji<cr>", opts)

-- Plugin inits
require("oil").setup()
require("icon-picker").setup({ disable_legacy_commands = true })
require('mini.splitjoin').setup()

-- Imports
require('language-support')
require('mod-nvim-tree')
require('plugins.telescope')
