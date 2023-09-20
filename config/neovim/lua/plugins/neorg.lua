---@type LazySpec
local config = {
    {
        {
            "nvim-neorg/neorg",
            opts = {
                load = {
                    ["core.defaults"] = {},
                    ["core.integrations.telescope"] = {},
                },
            },
            dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
        }
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        cmd = "Neorg",
        dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
        config = function()
            require("neorg").setup {
                load = {
                    ["core.keybinds"] = {
                        config = {
                            default_keybinds = true,
                            hook = function(keybinds)
                                keybinds.unmap("norg", "n", "<LocalLeader>th")
                            end
                        }
                    },
                    ["core.integrations.telescope"] = {},
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "diamond",
                        },
                    },                  -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes",
                        },
                    },
                },
            }
            local neorg_callbacks = require("neorg.core.callbacks")
            neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
                -- Map all the below keybinds only when the "norg" mode is active
                keybinds.map_event_to_mode("norg", {
                    n = { -- Bind keys in normal mode
                        { "<LocalLeader>sl", "core.integrations.telescope.find_linkable" },
                    },

                    i = { -- Bind in insert mode
                        { "<C-l>", "core.integrations.telescope.insert_link" },
                    },
                }, {
                    silent = true,
                    noremap = true,
                })
            end)
            -- local callbacks = require("neorg.core.callbacks")
            --
            -- callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
            --     keybinds.map_event_to_mode("norg", {
            --         n = {
            --             { "<LocalLeader>ls", "core.integrations.telescope.find_linkable" },
            --             { "<LocalLeader>li", "core.integrations.telescope.insert_link" },
            --         },
            --     }, {
            --         silent = true,
            --         noremap = true,
            --     })
            -- end)
        end,
    },
}
return config
