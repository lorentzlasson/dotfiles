local lspconfig = require('lspconfig')

-- CUSTOM SERVERS
-- Roc
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.roc",
  command = "set filetype=roc"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "roc",
  callback = function()
    vim.bo.syntax = "elm"
    vim.bo.commentstring = "# %s"
  end
})

require('lspconfig.configs').rocls = {
  default_config = {
    cmd = { "roc_language_server" },
    filetypes = { 'roc' },
    root_dir = lspconfig.util.root_pattern(".git"),
    settings = {},
  },
}

-- SERVERS WITH DEFAULT CONFIG
local servers = {
  "bashls",
  "elmls",
  "eslint",
  "gopls",
  "jsonls",
  "nil_ls",
  "pyright",
  "rocls",
  "solargraph",
  "yamlls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end

-- SERVERS WITH SPECIAL CONFIG

lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
  root_dir = function(filename)
    local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.json")(filename);
    if denoRootDir then
      return nil;
    end

    return lspconfig.util.root_pattern("package.json")(filename);
  end,
  single_file_support = false,
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

-- -- TREE SITTER
-- require 'nvim-treesitter.configs'.setup {
--   highlight = {
--     enable = true,
--   },
-- }

-- SYMBOL OUTLINE
require("symbols-outline").setup()

vim.api.nvim_set_keymap('n', '<C-s>', ':SymbolsOutline<CR>', { noremap = true })
