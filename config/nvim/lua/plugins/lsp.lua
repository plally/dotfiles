---@type LazySpec
local plugins = {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required
        }
    },
    {
        "nvim-lua/lsp-status.nvim",
        config = function()
        end
    },
    { "github/copilot.vim", event = "VeryLazy" },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.goimports,
                    require("null-ls").builtins.diagnostics.actionlint
                },
            })
        end
    }
}
return plugins
