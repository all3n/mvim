local fn = vim.fn

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
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
  -- pack manager
  use { "wbthomason/packer.nvim" }
  -- welcome greeter plugin
  use { "goolord/alpha-nvim" , config = function()
    require "mvim.plugins.alpha"
  end
  }
  -- tree plugin
  use { "nvim-tree/nvim-tree.lua", requires = {"nvim-tree/nvim-web-devicons"},  config = function()
    require "mvim.plugins.nvim-tree"
  end
  }
  use { "windwp/nvim-autopairs" , config = function()
    require "mvim.plugins.autopairs"
  end}
  use { "numToStr/Comment.nvim", config = function()
    require "mvim.plugins.comment"
  end}
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "akinsho/bufferline.nvim", config = function()
    require "mvim.plugins.bufferline"
  end}
  -- delete buffer without closing your windows or messing up your layout
	use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" , config = function()
    require "mvim.plugins.lualine"
  end}
  use { "akinsho/toggleterm.nvim" , config = function()
    require "mvim.plugins.toggleterm"
  end}
  -- project manage
  use { "ahmedkhalf/project.nvim" , config = function()
    require "mvim.plugins.project"
  end}
  -- profile only < 0.9
  -- for 0.9 vim.loader.enable()
  --  use { "lewis6991/impatient.nvim" , config = function()
  --    require "mvim.plugins.impatient"
  --  end}
  use { "lukas-reineke/indent-blankline.nvim", config = function()
    require "mvim.plugins.indentline"
  end}
  -- popup key-binding
	use {"folke/which-key.nvim", config = function()
    require "mvim.plugins.whichkey"
  end}

	-- Colorschemes
  use { "folke/tokyonight.nvim" }
  use { "lunarvim/darkplus.nvim" }
	-- Cmp 
  use { "mfussenegger/nvim-fzy" }
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }
	use { "saadparwaiz1/cmp_luasnip" }
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lua" }

  -- nvim-jdtls
  use { "mfussenegger/nvim-jdtls"}

	-- Snippets
  use { "L3MON4D3/LuaSnip"}
  use { "rafamadriz/friendly-snippets"}

	-- LSP
	use { "neovim/nvim-lspconfig"}
  use { "williamboman/mason.nvim"}
  use { "williamboman/mason-lspconfig.nvim"}
	use { "jose-elias-alvarez/null-ls.nvim"}
  use { "RRethy/vim-illuminate"}

	-- Telescope 0.1.1 nvim < 0.9
	use { "nvim-telescope/telescope.nvim", requires = { {'nvim-lua/plenary.nvim'} }, tag = "0.1.1", config = function()
    require "mvim.plugins.telescope"
  end}

	-- Treesitter
	use {"nvim-treesitter/nvim-treesitter", config = function()
    require "mvim.plugins.treesitter"
  end}

	-- Git
	use { "lewis6991/gitsigns.nvim", config = function()
    require "mvim.plugins.gitsigns"
  end}

  -- async task execution
  use {'skywind3000/asynctasks.vim'}
  use({
		"skywind3000/asyncrun.vim",
		as = "asyncrun",
		config = function()
			require("asyncrun_toggleterm").setup({
				mapping = "<leader>tt",
				start_in_insert = false,
			})
		end,
	})
  -- use {'mfussenegger/nvim-jdtls'}
  -- use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }
  use {"preservim/tagbar"}


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
