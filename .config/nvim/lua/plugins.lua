require("lazy").setup({
  { "AndrewRadev/splitjoin.vim" },
  { "LnL7/vim-nix" },
  { "godlygeek/tabular" },
  { "gregsexton/MatchTag" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "ibhagwan/fzf-lua" },
  {
    "junegunn/fzf",
    dir = "~/.fzf",
    build = "yes | ./install",
  },
  { "nanotee/sqls.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "simrat39/symbols-outline.nvim" },
  { "stevearc/dressing.nvim" },
  { "stevearc/oil.nvim" },
  { "tomtom/tcomment_vim" },
  { "tpope/vim-abolish" },
  { "tpope/vim-endwise" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-surround" },
  { "ziontee113/icon-picker.nvim" },

  -- Colorschemes
  { "Luxed/ayu-vim" },
  { "glepnir/zephyr-nvim" },
  { "marko-cerovac/material.nvim" },
  { "mhartington/oceanic-next" },
  { "navarasu/onedark.nvim" },
  { "ofirgall/ofirkai.nvim" },
  {
    'nvim-dunkel',
    url = 'https://codeberg.org/fabrlyn/nvim-dunkel.git',
  }
})