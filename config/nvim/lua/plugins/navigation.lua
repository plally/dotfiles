---@class LazyKeysWithoutID: LazyKeys
---@diagnostic disable-next-line: duplicate-doc-field
---@field id string?


---@type LazySpec
local plugins = {
    {
        "nvim-tree/nvim-tree.lua",
        cmd = "Tree",
        opts = {
            update_focused_file = {
                enable = true,
                update_root = false,
                ignore_list = {},
            }
        },
        init = function()
            vim.api.nvim_create_user_command("Tree", function(_) require("nvim-tree.api").tree.toggle() end,
                { nargs = 0 })
        end
    },
}

return plugins
