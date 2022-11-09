require('plugins.packer')

-- Plugin configurations
require('plugins.mason')
require('plugins.treesitter')
require('plugins.lspconfig')
require('plugins.nvim-cmp')

require('gitsigns').setup()

require('null-ls').setup({})
require('rust-tools').setup()
require('rust-tools').inlay_hints.enable()