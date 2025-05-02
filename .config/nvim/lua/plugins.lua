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
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",  -- your desired model (or use gpt-4o, etc.)
        timeout = 30000,   -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",        -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
})
