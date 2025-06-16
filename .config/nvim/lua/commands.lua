local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

cmd [[
  cabbrev rel source $MYVIMRC
  cabbrev pp echo "use yn instead"
]]

function CopyFilenameToClipboard()
  fn.setreg('+', fn.expand('%'))
end

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