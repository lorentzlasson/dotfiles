require("lazy").setup({
  { 'echasnovski/mini.splitjoin', version = '*' },
  { "LnL7/vim-nix" },
  { "godlygeek/tabular" },
  { "gregsexton/MatchTag" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "nanotee/sqls.nvim" },
  { "neovim/nvim-lspconfig" },
  { "j-hui/fidget.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-telescope/telescope.nvim" },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "stevearc/dressing.nvim" },
  { "stevearc/oil.nvim" },
  { "tomtom/tcomment_vim" },
  { "tpope/vim-abolish" },
  { "tpope/vim-endwise" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-surround" },
  { "ziontee113/icon-picker.nvim" },
  { "folke/which-key.nvim" },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },

  -- Colorschemes
  { "Luxed/ayu-vim" },
  { "glepnir/zephyr-nvim" },
  { "marko-cerovac/material.nvim" },
  { "mhartington/oceanic-next" },
  { "navarasu/onedark.nvim" },
  { "ofirgall/ofirkai.nvim" },
  {
    'nvim-dunkel',
    url = 'https://codeberg.org/fabrlyn/dunkel.nvim.git',
  },
})
