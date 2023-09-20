---@type LazySpec
local config = {
    { "tpope/vim-fugitive",    cmd = "G" },
    { "folke/trouble.nvim",    cmd = "Trouble", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "numToStr/Comment.nvim", config = true },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        config = function()
        end
    },
    { "dstein64/vim-startuptime", cmd = "StartupTime" },
}
return config
