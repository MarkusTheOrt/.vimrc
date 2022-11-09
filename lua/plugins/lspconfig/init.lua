local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig').rust_analyzer.setup({
  on_attach = on_attach,
  flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        }
      }
    }
})

local function format(diagnostic)
  local icon = ''
  if diagnostic.severity == vim.diagnostic.severity.WARN then
    icon = ''
  end

  if diagnostic.severity == vim.diagnostic.severity.HINT then
    icon = ''
  end

  local message = string.format(' %s [%s][%s] %s', icon, diagnostic.code, diagnostic.source, diagnostic.message)
  return message
end

vim.diagnostic.config({
  underline = true,
  signs = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = false,
    scope = 'line',
    source = false,
    format = format,
  },
  virtual_text = {
    prefix = '•',
    spacing = 2,
    source = false,
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    format = format,
  }
})
