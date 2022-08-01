local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float()
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use({ "nvim-lua/popup.nvim" })
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use "akinsho/bufferline.nvim"
  use "akinsho/toggleterm.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "christianchiarulli/hop.nvim"
  use "nacro90/numb.nvim"
  use {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
  }

  -- UI
  use "goolord/alpha-nvim"
  use "karb94/neoscroll.nvim"
  use "folke/which-key.nvim"
  use "tamago324/lir.nvim"
  use({
    "rcarriga/nvim-notify",
    requires = { "nvim-telescope/telescope.nvim" },
  })

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use("lunarvim/darkplus.nvim")
  use("tomasiser/vim-code-dark")
  use({ "lunarvim/onedarker.nvim", commit = 'b00dd21' })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "onsails/lspkind-nvim" })

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "eirabben/tree-sitter-twig" }
  use "p00f/nvim-ts-rainbow"
  use "windwp/nvim-ts-autotag"

  -- Telescope
  use { "nvim-telescope/telescope.nvim", requires = { { 'nvim-lua/plenary.nvim' } } }

  -- Comment
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
