local lspconfig = require('lspconfig')

-- SERVERS WITH DEFAULT CONFIG
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "bashls",
  "elmls",
  "eslint",
  "gleam",
  "gopls",
  "jsonls",
  -- "postgres_lsp", not really doing much yet
  "pyright",
  "roc_ls",
  "solargraph",
  "terraformls",
  "yamlls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end

-- SERVERS WITH SPECIAL CONFIG

lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.elixirls.setup {
  cmd = { "elixir-ls" };
}

lspconfig.ts_ls.setup {
  root_dir = function(filename)
    local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename);
    if denoRootDir then
      return nil;
    end

    return lspconfig.util.root_pattern("package.json", ".git")(filename);
  end,
  single_file_support = false,
  on_init = function(client)
    client.offset_encoding = "utf-8"
  end,
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

lspconfig.nil_ls.setup {
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      }
    }
  }
}

lspconfig.sqls.setup{
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr) -- require sqls.nvim
  end,
  settings = {
    sqls = {
      connections = {
        {
          driver = 'postgresql',
          dataSourceName = 'postgres://postgres:@localhost/postgres',
        },
      },
    },
  },
}


-- GENERAL KEY MAPPINGS
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    -- General config
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
  end,
})

vim.diagnostic.config({
  virtual_text = false, -- Disable inline text
})


-- AUTO COMPLETE
local cmp = require('cmp')

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  },
})

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
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

-- SYMBOL OUTLINE
require("symbols-outline").setup()

vim.api.nvim_set_keymap('n', '<C-s>', ':SymbolsOutline<CR>', { noremap = true })
