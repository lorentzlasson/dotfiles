local o = vim.o
local cmd = vim.cmd
local api = vim.api

-- General settings
o.termguicolors = true

o.number = true -- display line numbers
o.wrap = true -- continue long lines on next lines
o.linebreak = true -- wrap lines at convenient points
o.relativenumber = true -- show relative line numbers
o.cursorcolumn = true
o.cursorline = true -- highlight column and row
o.ruler = true -- display column number
o.hidden = true -- allow unsaved buffers
o.foldenable = false -- disable folding
o.fixendofline = false -- don't auto insert newline at end of file on save

o.clipboard = 'unnamedplus' -- connect to system clipboard (linux)
o.mouse = 'a' -- enable mouse selection

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

cmd([[ autocmd FileType go setlocal noexpandtab ]]) -- use tabs for golang
cmd([[ autocmd FileType gdscript setlocal noexpandtab ]]) -- use tabs for godot script

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
  command = [[ if index(['markdown'], &ft) < 0 | %s/\s\+$//e ]],
})
