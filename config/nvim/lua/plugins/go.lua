---@type LazySpec
local plugins = {
    {
        "ray-x/go.nvim",
        lsp_cfg = {
            settings = {
                gopls = {
                    staticcheck = true,
                    codelenses = {
                        gc_details = true,
                    },
                    analyses = {
                        ST1005 = true,
                        ST1006 = true,
                        ST1013 = true,
                        ST1018 = true,
                        ST1020 = true,
                        ST1021 = true,
                        ST1022 = true,
                        ST1023 = true,
                        ST1016 = true,
                    }
                }
            },
        },

        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()

            local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimport()
                end,
                group = format_sync_grp,
            })
        end,
        ft = { "go", "gomod" },
    }
}

return plugins
