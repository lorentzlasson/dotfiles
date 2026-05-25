local parsers = {
  'bash',
  'css',
  'go',
  'html',
  'json',
  'lua',
  'nix',
  'python',
  'roc',
  'rust',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
  'zig',
  -- "zsh", -- https://github.com/nvim-treesitter/nvim-treesitter/issues/655#issuecomment-1470101288
}

require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd('FileType', {
  pattern = parsers,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
