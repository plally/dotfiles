-- -@type LazySpec
local plugins = {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    {
        "neovim/nvim-lspconfig",
    },

    { "williamboman/mason.nvim", config = true },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "rust_analyzer",
                "gopls",
                "lua_ls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
                -- gopls = function()
                --     -- noop
                -- end,
                lua_ls = function()
                    local conf = require("lspconfigs.lua")
                    require("lspconfig").lua_ls.setup(conf)

                    if vim.fn.isdirectory("lua/autorun") == 1 then
                        vim.fn.jobstart("git pull origin main --recurse-submodules",
                            { cwd = vim.fn.expand("$HOME/LuaLibs/glua/glua") })
                    end
                end,
                rust_analyzer = function()
                    require("lspconfig").rust_analyzer.setup({
                        settings = {
                            ["rust-analyzer"] = {
                                files = {
                                    -- if you have a directory with a large amount of files rust analyzer can get stuck so it must be excluded
                                    excludeDirs = { "data" },
                                },
                            }
                        }
                    })
                end,
            }
        }
    },

    {
        "nvim-lua/lsp-status.nvim",
        config = function()
        end,
        event = "VeryLazy",
    },

    { "github/copilot.vim",      event = "VeryLazy" },


    -- TODO none ls
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.goimports,
                    require("null-ls").builtins.formatting.nixpkgs_fmt,
                    require("null-ls").builtins.diagnostics.actionlint
                },
            })
        end,
        event = "VeryLazy"
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
}

return plugins
