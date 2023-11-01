---@type LazySpec
local plugins = {
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup({
                luasnip = true
            })
        end,
        ft = { "go", "gomod" },
        -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
}
return plugins
