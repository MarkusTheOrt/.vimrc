local lsp_status = require('lsp-status')
local lspconfig = require('lspconfig')
lsp_status.register_progress()
lsp_status.config({
  kind_labels = kind_labels,
  indicator_errors = "×",
  indicator_warnings = "!",
  indicator_info = "i",
  indicator_hint = "›",
  -- the default is a wide codepoint which breaks absolute and relative
  -- line counts if placed before airline's Z section
  status_symbol = "",
})
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.cmd([[
    if !g:lsp_wait_added
      call airline#add_statusline_func('LspWait')
      call airline#add_inactive_statusline_func('LspWait')
      call airline#update_statusline()
      let g:lsp_wait_added = 1
    endif
  ]])
  lsp_status.on_attach(client, bufnr)
  local handler = vim.lsp.handlers['textDocument/publishDiagnostics']
  vim.lsp.handlers['textDocument/publishDiagnostics'] = function (...)
    vim.cmd([[
      if !g:lsp_wait_done
        call airline#remove_statusline_func('LspWait')
        call airline#update_statusline()
        let g:lsp_wait_done = 1
      endif
    ]])
    if handler ~= nil then
      handler(...)
    end
  end

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
  capabilities = vim.tbl_extend("keep", {}, lsp_status.capabilities),
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
    prefix = '',
    spacing = 2,
    source = false,
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    format = format,
  }
})