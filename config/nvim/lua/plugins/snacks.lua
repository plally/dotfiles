---@type LazySpecnac
local plugins = {
    "folke/snacks.nvim",
    opts = {
        lazygit = {
            configure = true,
        },
        bigfile = {},
        dashboard = {
            sections = {
                {
                    ttl = 3600,
                    section = "terminal",
                    cmd = "bash ~/.config/nvim/randomfox.sh",
                    height = 25,
                    padding = 1,
                },
                {
                    pane = 2,
                    { section = "keys",   gap = 1, padding = 1 },
                    { section = "startup" },
                },
            },
        },
        animate = {},
        input = {},
        toggle = {},
        quickfile = {},
        -- rename = {},
        statuscolumn = {},
        gitbrowse = {},
        scratch = {
            ---@type table<string, snacks.win.Config>
            win_by_ft = {
                lua = {
                    keys = {
                        ["source"] = {
                            "<cr>",
                            function()
                                local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                                Snacks.debug.run({ buf = self.buf, name = name })
                            end,
                            desc = "Source buffer",
                            mode = { "n", "x" },
                        },
                    },
                },
            },
        },
    },
    lazy = false,
    keys = {
        { "<leader>.",  function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>gB", function() Snacks.gitbrowse() end,      desc = "Git Browse" },
        { "<leader>gg", function() Snacks.lazygit() end,        desc = "Lazygit" },
    },

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                Snacks.toggle.dim():map("<leader>tD")
            end,
        })

        vim.api.nvim_create_user_command("Scratch",
            function(opts)
                Snacks.scratch.open({ ft = opts.args })
            end
            , { nargs = 1 })
        vim.api.nvim_create_user_command("LG",
            function()
                Snacks.lazygit.open()
            end
            , { nargs = 0 })


        -- local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
        -- vim.api.nvim_create_autocmd("User", {
        --     pattern = "NvimTreeSetup",
        --     callback = function()
        --         local events = require("nvim-tree.api").events
        --         events.subscribe(events.Event.NodeRenamed, function(data)
        --             if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        --                 data = data
        --                 print("Renamed", data.old_name, "to", data.new_name)
        --                 Snacks.rename.on_rename_file(data.old_name, data.new_name)
        --             end
        --         end)
        --     end,
        -- })
    end,
}

return plugins
