-- https://vhyrro.github.io/posts/neorg-and-luarocks/

---@type LazySpec
local config = {
    {
        "nvim-neorg/neorg",
        -- build = ":Neorg sync-parsers",
        dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
        lazy = false,
        -- cmd = "Neorg",
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
                    ["core.summary"] = {},
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
                                notes = "~/Documents/notes",
                            },
                            default_workspace = "notes",
                        },
                    },
                },
            }
            -- local neorg_callbacks = require("neorg.core.callbacks")
            -- neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
            --     -- Map all the below keybinds only when the "norg" mode is active
            --     keybinds.map_event_to_mode("norg", {
            --         n = { -- Bind keys in normal mode
            --             { "<LocalLeader>nl", "core.integrations.telescope.find_linkable" },
            --         },
            --
            --         i = { -- Bind in insert mode
            --             { "<C-l>", "core.integrations.telescope.insert_link" },
            --         },
            --     }, {
            --         silent = true,
            --         noremap = true,
            --     })
            -- end)
            --
            vim.keymap.set("n", "<LocalLeader>sl", "<Plug>(neorg.telescope.find_linkable)")
            vim.keymap.set("i", "<C-l>", "<C-o><Plug>(neorg.telescope.insert_link)")
        end,
    },
}

return config
