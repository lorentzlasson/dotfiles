require("lazy").setup({
  { 'echasnovski/mini.splitjoin', version = '*' },
  { "LnL7/vim-nix" },
  { "godlygeek/tabular" },
  { "gregsexton/MatchTag" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "nanotee/sqls.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-telescope/telescope.nvim" },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "MeanderingProgrammer/render-markdown.nvim" },
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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",  -- your desired model (or use gpt-4o, etc.)
        timeout = 30000,   -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  }
})
