-- [[ plug.lua ]]
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
-- print("packer bootstrap: " .. tostring(packer_bootstrap))

return require('packer').startup(function(use)
   use 'wbthomason/packer.nvim'
   -- My plugins here
   use {
      'kyazdani42/nvim-tree.lua',
      requires = {
         'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
   }
   use 'lewis6991/impatient.nvim'                     -- Speed up nvim lua loading
   use 'norcalli/nvim-colorizer.lua'                  -- highlight colors
   use 'ethanholz/nvim-lastplace'                     -- restore cursor position on file load

   -- [[ Theme ]]
   use { 'mhinz/vim-startify' }                       -- start screen
   use { 'DanilaMihailov/beacon.nvim' }               -- cursor jump
   use {
      'nvim-lualine/lualine.nvim',                    -- statusline
      requires = {
         'kyazdani42/nvim-web-devicons',
         opt = true
      }
   }
   use { 'Shatur/neovim-ayu' }                        -- colorscheme
   use { 'sainnhe/gruvbox-material' }                 -- colorscheme

   -- [[ Dev ]]
   use {
      'nvim-telescope/telescope.nvim',                 -- fuzzy finder
      requires = { {'nvim-lua/plenary.nvim'} }
   }
   use { 'majutsushi/tagbar' }                        -- code structure
   use { 'Yggdroot/indentLine' }                      -- see indentation
   use { 'tpope/vim-fugitive' }                       -- git integration
   use { 'junegunn/gv.vim' }                          -- commit history
   use { 'windwp/nvim-autopairs' }                    -- auto close brackets, etc.

   use { 'williamboman/mason.nvim' }                  -- manage LSP servers, debuggers and linters
   use { 'williamboman/mason-lspconfig.nvim' }
   use { 'WhoIsSethDaniel/mason-tool-installer.nvim' } -- automatically install mason tools

   use { 'neovim/nvim-lspconfig' }                    -- automatic lsp configs 
   use { 'simrat39/rust-tools.nvim' }                 -- rust tools

   -- Completion framework:
   use 'hrsh7th/nvim-cmp' 

   -- LSP completion source:
   use 'hrsh7th/cmp-nvim-lsp'

   -- Useful completion sources:
   use 'hrsh7th/cmp-nvim-lua'
   use 'hrsh7th/cmp-nvim-lsp-signature-help'
   use 'hrsh7th/cmp-vsnip'                             
   use 'hrsh7th/cmp-path'                              
   use 'hrsh7th/cmp-buffer'                            
   use 'hrsh7th/vim-vsnip'

   use 'nvim-treesitter/nvim-treesitter'

--   use 'puremourning/vimspector'                      -- debugging

   use {"akinsho/toggleterm.nvim", tag = '*', config = function()
   end}

   use {                                              -- autocommenting
      'numToStr/Comment.nvim',
      config = function()
         require('Comment').setup()
      end
   }

   use 'nanozuki/tabby.nvim'

   -- Debugging
 --   use {
 --      "mfussenegger/nvim-dap",
 --      opt = true,
 --      event = "BufReadPre",
 --      module = { "dap" },
 --      wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
 --      requires = {
 --         "Pocco81/DAPInstall.nvim",
 --         "theHamsta/nvim-dap-virtual-text",
 --         "rcarriga/nvim-dap-ui",
 --         "mfussenegger/nvim-dap-python",
 --         "nvim-telescope/telescope-dap.nvim",
 --         { "leoluz/nvim-dap-go", module = "dap-go" },
 --         { "jbyuki/one-small-step-for-vimkind", module = "osv" },
 --         { "folke/which-key.nvim", config = 
 --            function()
 --               require("which-key").setup {
 --                  -- your configuration comes here
 --                  -- or leave it empty to use the default settings
 --                  -- refer to the configuration section below
 --               }
 --            end
 --         },
	-- },
	--
 --      config = function()
 --        require("config.dap").setup()
 --      end,
 --   }

   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
   if packer_bootstrap then
      require('packer').sync()
   end
end)
