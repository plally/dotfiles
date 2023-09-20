---@type LazySpec
local plugins = {
    { "catppuccin/nvim",                    name = "catppuccin", priority = 1000 },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local lspStatus = require("lsp-status")
            lspStatus.register_progress()
            require("lualine").setup {
                options = {
                    theme = "catppuccin",
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { left = "" }, right_padding = 2 },
                    },
                    lualine_b = { "branch" },
                    lualine_c = {
                        "fileformat",
                        "diagnostics",
                    },
                    lualine_x = {},
                    lualine_y = { "filetype", "progress" },
                    lualine_z = {
                        { "location", separator = { right = " " }, left_padding = 2 },
                    },
                },
                tabline = {
                    lualine_a = {
                        { function() return "🦊" end, separator = { left = "" } },
                    },
                    lualine_b = {
                        { "buffers" }
                    },
                    lualine_c = {},
                    lualine_x = {
                        { function() return lspStatus.status() end },
                        { function() return lspStatus.status_progress() end },
                    },
                    lualine_y = {},
                    lualine_z = {
                        { function() return "🐱" end, separator = { right = "" } },
                    }
                },
                inactive_sections = {
                    lualine_a = { "filename" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "location" },
                },
                extensions = {},
            }
        end,
    },

    {
        "plally/nvim-colorizer.lua",
        branch = "master",
        ft = { "lua" },
        opts = {
            filetypes = {
                lua = {
                    rgb_fn = true,
                }
            }
        },
    },

    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = true,
        opts = {},
    },

    { "lewis6991/gitsigns.nvim",            config = true },

    { "lukas-reineke/indent-blankline.nvim" },
}
return plugins
