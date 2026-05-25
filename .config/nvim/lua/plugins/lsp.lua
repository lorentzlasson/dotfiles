-- SERVERS WITH DEFAULT CONFIG
-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
local default_servers = {
  'astro',
  'bashls',
  'elmls',
  'eslint',
  'gdscript',
  'gleam',
  'gopls',
  'jsonls',
  -- "postgres_lsp", not really doing much yet
  'pyright',
  'roc_ls',
  'terraformls',
  'yamlls',
}

vim.lsp.enable(default_servers)

-- SERVERS WITH SPECIAL CONFIG

vim.lsp.config('denols', {
  root_markers = { 'deno.json', 'deno.jsonc' },
})
vim.lsp.enable('denols')

vim.lsp.config('elixirls', {
  cmd = { 'elixir-ls' },
})
vim.lsp.enable('elixirls')

vim.lsp.config('solargraph', {
  cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
  root_markers = { 'Gemfile', '.git' },
})
vim.lsp.enable('solargraph')

vim.lsp.config('ts_ls', {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if vim.fs.root(fname, { 'deno.json', 'deno.jsonc' }) then
      return
    end
    local root = vim.fs.root(fname, { 'package.json', '.git' })
    if root then
      on_dir(root)
    end
  end,
  on_init = function(client)
    client.offset_encoding = 'utf-8'
  end,
})
vim.lsp.enable('ts_ls')

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})
vim.lsp.enable('lua_ls')

vim.lsp.config('nil_ls', {
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
})
vim.lsp.enable('nil_ls')

vim.lsp.config('sqls', {
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
})
vim.lsp.enable('sqls')

-- GENERAL KEY MAPPINGS
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    -- General config
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
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
