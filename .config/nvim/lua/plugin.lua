local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.dapleader = " "
require('lazy').setup({
    -- Packer can manage itself
    {'navarasu/onedark.nvim', config = 
        function() 
            require('onedark').setup {
                style = 'darker'
            };
            require('onedark').load()
        end 
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        keys = { 
            {"<leader>pf", "<cmd>Neotree toggle<CR>"},
        },
     },
    { "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        lazy = true,
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all"
                ensure_installed = {
                    "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                    "jsdoc", "bash", "cpp", "go", "toml", "yaml", "cmake", "make",
                    "markdown_inline", "dockerfile", "c_sharp", "diff"
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
                auto_install = true,

                indent = {
                    enable = true
                },

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = { "markdown" },
                },
            })
        end
    },
    {"nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { { "nvim-lua/plenary.nvim" } }, 
        keys = {
            {"<leader>ff", "<cmd>Telescope find_files<CR>"},
            {"<leader>fg", "<cmd>Telescope live_grep<CR>"},
            {"<leader>fb", "<cmd>Telescope buffers<CR>"},
            {"<leader>fh", "<cmd>Telescope help_tags<CR>"},
        },
    },
    {"tpope/vim-fugitive"},
    {'tpope/vim-commentary'},
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        init = function()
            require("refactoring").setup()
            require("telescope").load_extension("refactoring")
        end,
        keys =  {
            {
                "<leader>rr", function() require('telescope').extensions.refactoring.refactors() end,
            }
        },
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    {
        "folke/trouble.nvim",
         dependencies = { "nvim-tree/nvim-web-devicons" },
         opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
          }
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = "v3.x",
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            { 'p00f/clangd_extensions.nvim' },

        },
        init = function()
              local lsp_zero = require("lsp-zero")
              lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr, preserve_mappings = false})
              end)
            require("mason").setup()
            require("mason-lspconfig").setup( {
                automatic_installation = true
            }
            )
            require("lspconfig").rust_analyzer.setup {}
            require("lspconfig").clangd.setup {}
            require("lspconfig").lua_ls.setup {}
            require("lspconfig").cmake.setup {}
        end

    },
    {'cdelledonne/vim-cmake'},
    {'feline-nvim/feline.nvim' },
})
