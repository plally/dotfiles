---@class LazyKeysWithoutID: LazyKeys
---@diagnostic disable-next-line: duplicate-doc-field
---@field id string?


---@type LazySpec
local plugins = {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        ---@type LazyKeysWithoutID[]
        keys = {
            { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
            { "<leader>b",  function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
            { "<leader>of", function() require("telescope.builtin").oldfiles() end,   desc = "Old files" },
            { "<C-p>",      function() require("telescope.builtin").git_files() end,  desc = "Git files" },
            { "<leader>ps", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
            { "<leader>vh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').create_default_mappings()
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").load_extension("ui-select")
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
        }
    },
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
