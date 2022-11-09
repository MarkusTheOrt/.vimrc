local merge = require('util').merge
local function map(mode, lhs, rhs, opts)
  local defaults = {
    silent = true,
    noremap = true,
  }
  vim.keymap.set(mode, lhs, rhs, merge(defaults, opts or {}))
end

map('n', '<leader>ck', ':cexpr[]<cr>')

map('n', '<leader>w', ':w<cr>')
map('n', '<leader>q', ':q<cr>')
-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fg', builtin.live_grep)