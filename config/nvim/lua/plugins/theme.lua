local colors = {
    white = "#f3f3f3",
}

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
    for name, section in pairs(sections) do
        local left = name:sub(9, 10) < "x"
        for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
        end
        for id, comp in ipairs(section) do
            if type(comp) ~= "table" then
                comp = { comp }
                section[id] = comp
            end
            comp.separator = left and { right = "" } or { left = "" }
        end
    end
    return sections
end

---@type LazySpec
local plugins = {
    { "catppuccin/nvim",                    name = "catppuccin", priority = 1000 },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/lsp-status.nvim" },
        config = function()
            local lspStatus = require("lsp-status")
            lspStatus.register_progress()
            require("lualine").setup {
                options = {
                    theme = "catppuccin",
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                },
                sections = process_sections {
                    lualine_a = {
                        { "mode", right_padding = 2 },
                    },
                    lualine_b = { "branch" },
                    lualine_c = {
                        "fileformat",
                    },
                    lualine_x = {},
                    lualine_y = { "filetype", "progress" },
                    lualine_z = {
                        { "location", left_padding = 2 },
                    },
                },
                tabline = {
                    lualine_a = {
                    },
                    lualine_b = {
                        { "buffers" }
                    },
                    lualine_c = {},
                    lualine_x = {
                    },
                    lualine_y = {
                        { function() return lspStatus.status() end },
                        { function() return lspStatus.status_progress() end },
                        "diagnostics",
                    },
                    lualine_z = {
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
