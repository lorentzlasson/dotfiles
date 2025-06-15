require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "json",
    "lua",
    "nix",
    "python",
    "roc",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
    "zig",
    -- "zsh", -- https://github.com/nvim-treesitter/nvim-treesitter/issues/655#issuecomment-1470101288
  },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      -- TODO: figure out keymaps
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = true
  }
}