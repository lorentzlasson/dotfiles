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
    cmd = { "roc_lang_server" },
    filetypes = { 'roc' },
    root_dir = lspconfig.util.root_pattern(".git"),
    settings = {},
  },
}

-- SERVERS WITH DEFAULT CONFIG
local servers = {
  "bashls",
  "denols",
  "elmls",
  "eslint",
  "gopls",
  "jsonls",
  "nil_ls",
  "rocls",
  "solargraph",
  "tsserver",
  "yamlls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end

-- SERVERS WITH SPECIAL CONFIG

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
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
  end,
})

vim.api.nvim_create_augroup('AutoFormatting', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'AutoFormatting',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- AUTO COMPLETE
local cmp = require('cmp')

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
})

-- TREE SITTER
require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

-- SYMBOL OUTLINE
require("symbols-outline").setup()

vim.api.nvim_set_keymap('n', '<C-s>', ':SymbolsOutline<CR>', { noremap = true })