local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap

cmd [[
  cabbrev rel source $MYVIMRC
]]

g.mapleader = ' ' -- set leader to space
g.maplocalleader = '\\'

map('n', '<leader>e', ':edit!<CR>', { noremap = true }) -- force reload from file

map('n', '<M-a>', 'gg<S-V>G', { noremap = true })

map('v', '$', '$h', { noremap = true }) -- skip line break when selecting to end of line
map('x', 'p', 'P', { noremap = true })
map('n', '<S-y>', 'v$hy<ESC>', { noremap = true })
map('v', '//', 'y/<C-R>"<Esc>', { noremap = true })

map('n', '<C-w>', ':echo "Use leader (Space) instead!"<CR>', { noremap = true })
map('n', '<leader>', '<C-w>', { noremap = true })
map('n', '<leader><leader>', '1<C-w>w', { noremap = true })
map('n', '<leader>>', '20<C-w>>', { noremap = true })
map('n', '<leader><', '20<C-w><', { noremap = true })

vim.keymap.set('v', '<leader>y', function()
  local start_pos = fn.getpos("'<")
  local end_pos = fn.getpos("'>")
  local lines = fn.getregion(start_pos, end_pos, { type = fn.visualmode() })
  local ft = vim.bo.filetype
  local formatted = "```" .. ft .. "\n" .. table.concat(lines, "\n") .. "\n```"
  fn.setreg('+', formatted)
end, {})

function CopyFilenameToClipboard()
  fn.setreg('+', fn.expand('%'))
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
  cmd('%!sql-formatter --language postgresql')
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
api.nvim_create_user_command(
  'Browse',
  function(opts)
    fn.system { 'xdg-open', opts.fargs[1] }
  end,
  { nargs = 1 }
)

-- Wrap selection in js debug log
api.nvim_create_user_command('JsDebug', function()
  local start_pos = fn.getpos("'<")
  local end_pos = fn.getpos("'>")

  local lines = fn.getline(start_pos[2], end_pos[2])
  local indent = lines[1]:match("^%s*") or ""
  local selected_text = table.concat(lines, "\n"):gsub("^%s+", "")

  local wrapped_text = indent ..
      'console.log(`🍎🍎🍎 ' .. selected_text .. ': ${JSON.stringify(' .. selected_text .. ', null, 2)} 🍎🍎🍎`)'

  fn.setline(start_pos[2], wrapped_text)
end, { range = true })

api.nvim_create_user_command('CopyDiagnostics', function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    print("No diagnostics found")
    return
  end

  local formatted = table.concat(vim.tbl_map(function(d)
    return string.format("%s:%d: %s", fn.bufname(d.bufnr or 0), d.lnum + 1, d.message)
  end, diagnostics), '\n')

  fn.setreg('+', 'Neovim diagnostics:\n```text\n' .. formatted .. '\n```')
  print(string.format("Copied %d diagnostic(s) to clipboard", #diagnostics))
end, {})