---@type LazySpec
local config = {
    { "tpope/vim-fugitive",    cmd = "G" },
    { "folke/trouble.nvim",    cmd = "Trouble", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
    { "numToStr/Comment.nvim", config = true },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
}
return config
