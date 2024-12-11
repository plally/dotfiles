---@type LazySpec
local plugins = {
    { "neovim/nvim-lspconfig" },
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

                lua_ls = function()
                    local conf = require("lspconfigs.lua")
                    require("lspconfig").lua_ls.setup(conf)
                    vim.fn.jobstart("git pull origin main --recurse-submodules",
                        { cwd = vim.fn.expand("$HOME/LuaLibs/glua/glua") })
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

    { "github/copilot.vim", event = "VeryLazy" },


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
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        dependencies = "rafamadriz/friendly-snippets",
        version = "v0.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "enter" },

            ---@diagnostic disable-next-line: missing-fields
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            ---@diagnostic disable-next-line: missing-fields
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                }
            },

            ---@diagnostic disable-next-line: missing-fields
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

        },
        opts_extend = { "sources.default" }
    },
}

return plugins
