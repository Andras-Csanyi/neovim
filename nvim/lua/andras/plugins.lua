local fn = vim.fn

-- installing Packer automatically
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
	"git",
	"clone",
	"--depth",
	"1",
	"https://github.com/wbthomason/packer.nvim",
	install_path
  }
  print "Installing packer close and reopen NeoVim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommend to reload NeoVim whenever plugins.lua changes and changes are saved
vim.cmd [[
  augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
	open_fn = function()
	  return require("packer.util").float { border = "rounded" }
	end,
  },
}

return packer.startup(function(use)

  -- dependencies
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "nvim-tree/nvim-web-devicons"
 
  -- colorschemes
  use "lunarvim/darkplus.nvim"
  
  use {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
	  style = "night"
	},
  }

  ----------------------------
  -- -- Tools and System -- --
  ----------------------------

  -- NvimTree
  use {
	"nvim-tree/nvim-tree.lua",
	config = function()
	  require("nvim-tree").setup({
		sort = { sorter = "case_sensitive" },
		view = { width = 60 },
	  })
	end
  }

  -- CMP --
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lua"
  use "saadparwaiz1/cmp_luasnip"

  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"


  ---------------------
  -- -- Languages -- --
  ---------------------

  -- LaTeX
  use {
	"lervag/vimtex"
  }


 
  if PACKER_BOOTSTRAP then
	require("packer").sync()
  end
end)
