local lsp_status = require('lsp-status')
local lspconfig = require('lspconfig')

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)



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
 -- Enable completion triggered by <c-x><c-o>

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSPActions',
    callback = function()
      local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    bufmap('n', 'K', vim.lsp.buf.hover)
    bufmap('n', 'gD', vim.lsp.buf.declaration)
    bufmap('n', 'gd', vim.lsp.buf.definition)
    bufmap('n', 'gi', vim.lsp.buf.implementation)
    bufmap('n', '<C-k>', vim.lsp.buf.signature_help)
    bufmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
    bufmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
    bufmap('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
    bufmap('n', '<leader>D', vim.lsp.buf.type_definition)
    bufmap('n', '<leader>rn', vim.lsp.buf.rename)
    bufmap({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action)
    bufmap('n', 'gr', vim.lsp.buf.references)
    bufmap('n', '<leader>f', function() vim.lsp.buf.format {async = true} end)
  end
})


local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


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

lspconfig.rust_analyzer.setup({
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        }
      }
    }
})
