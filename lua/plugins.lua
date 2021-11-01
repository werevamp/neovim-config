local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require("packer").startup(
  function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    use "mhartington/oceanic-next"
    use "folke/tokyonight.nvim"
    use "sainnhe/everforest"
    use "rafamadriz/friendly-snippets"

    use(
      {
        "vuki656/package-info.nvim",
        requires = "MunifTanjim/nui.nvim"
      }
    )

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }

    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
    }
    use "neovim/nvim-lspconfig"
    -- use "glepnir/lspsaga.nvim"
    use "tami5/lspsaga.nvim"

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-buffer"
      }
    }
    use "onsails/lspkind-nvim"
    use "hrsh7th/cmp-nvim-lsp"
    use "L3MON4D3/Luasnip"
    use "saadparwaiz1/cmp_luasnip"
    use "ray-x/lsp_signature.nvim"

    -- Telescope
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"

    -- Dirvish
    use "justinmk/vim-dirvish"
    use "tpope/vim-eunuch"
    use "kristijanhusak/vim-dirvish-git"

    -- Syntax parsers
    use "jparise/vim-graphql"
    use "hail2u/vim-css3-syntax"
    use "lumiliet/vim-twig"

    -- Other
    use "mhartington/formatter.nvim"
    use "romgrk/barbar.nvim"
    use "kyazdani42/nvim-web-devicons"
    -- use "bling/vim-airline"
    use {
      "shadmansaleh/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
    use "lukas-reineke/indent-blankline.nvim"
    use "justinmk/vim-sneak"
    use "windwp/nvim-autopairs"
    use "tpope/vim-surround"
    use "tpope/vim-fugitive"
    use "tpope/vim-rhubarb"
    use "junegunn/gv.vim"
    use "mattn/emmet-vim"
    use "edkolev/tmuxline.vim"

    use "b3nj5m1n/kommentary"

    use "wellle/tmux-complete.vim"
    use "valloric/matchtagalways"
    use "jeffkreeftmeijer/vim-numbertoggle"
    use "cohama/agit.vim"
    use "yamatsum/nvim-cursorline"
    use "windwp/nvim-ts-autotag"
    use "folke/zen-mode.nvim"
  end
)
