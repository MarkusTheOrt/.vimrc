local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local indent = 4

g.mapleader = ' '

-- standard commands
cmd('colorscheme nordfox')
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
