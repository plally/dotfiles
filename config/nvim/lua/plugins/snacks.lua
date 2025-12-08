---@type LazySpec
local plugins = {
    "folke/snacks.nvim",
    opts = {
        explorer = {},
        picker = {
            sources = {
                explorer = {}
            }
        },
        lazygit = {
            configure = true,
        },
        bigfile = {},
        image = {},
        notifier = {},
        indent = {},
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
        { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end,        desc = "Select Scratch Buffer" },
        { "<leader>gB", function() Snacks.gitbrowse() end,             desc = "Git Browse" },
        { "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Show notification history" },

        { "<leader>pf", function() Snacks.picker.files({}) end,        desc = "Find files" },
        { "<leader>ps", function() Snacks.picker.grep() end,           desc = "Live grep" },
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
    end,
}

return plugins
