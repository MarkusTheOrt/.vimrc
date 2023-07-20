local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local indent = 4
cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

cmd('set guifont=Comic_Code:h16')

g.mapleader = ' '

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.g.neovide_transparency = 0.9
    vim.g.transparency = 0.8
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_background_color = "#0f1117"
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_density = 30.0
end

vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic = false
vim.g.tokyodark_color_gamma = "1.0"

-- standard commands
cmd('colorscheme tokyodark')
cmd('set colorcolumn=80')
cmd('set number')
cmd('set relativenumber')
cmd('map! <S-Insert> <C-R>+')
-- options
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }
opt.wildmenu = true

opt.cursorline = false
opt.scrolloff = 18
opt.wrap = false

opt.splitbelow = true
opt.splitright = true

opt.updatetime = 50

opt.termguicolors = true

opt.backup = false
opt.swapfile = false
opt.writebackup = false

opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess = opt.shortmess + { c = true }
