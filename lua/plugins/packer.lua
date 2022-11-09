
return require("packer").startup(function(use)
  use {
    "wbthomason/packer.nvim",
    "EdenEast/nightfox.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "lewis6991/gitsigns.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",
    "nvim-lua/lsp-status.nvim",
    "tpope/vim-fugitive",
    "andweeb/presence.nvim",
    "windwp/nvim-autopairs"
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      "hrsh7th/cmp-vsnip",
    }
  }
  use("hrsh7th/cmp-nvim-lsp")
  use("simrat39/rust-tools.nvim")
  use {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" }
  }
end)

