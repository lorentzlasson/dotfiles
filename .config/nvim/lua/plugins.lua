require('lazy').setup({
  {
    'echasnovski/mini.splitjoin',
    version = '*',
  },
  { 'godlygeek/tabular' },
  { 'gregsexton/MatchTag' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'nanotee/sqls.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'j-hui/fidget.nvim' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-telescope/telescope.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
  },
  { 'stevearc/dressing.nvim' },
  { 'stevearc/oil.nvim' },
  { 'tomtom/tcomment_vim' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-endwise' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-surround' },
  { 'ziontee113/icon-picker.nvim' },
  { 'folke/which-key.nvim' },
  { 'folke/trouble.nvim' },
  -- Markdown preview in browser
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup({ app = 'browser' })
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },

  {
    'nvim-dunkel',
    url = 'https://github.com/lorentzlasson/dunkel.nvim.git',
  },
})
