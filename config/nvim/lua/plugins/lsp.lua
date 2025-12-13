local format_on_save = {
    lua_ls = true,
    rust = true,
    nix = true,
}

---@type LazySpec
local plugins = {
    { "mason-org/mason.nvim", config = true },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls@3.15.0", "gopls", "rust_analyzer", "copilot" },
            automatic_enable = true
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        }
    },

    {
        "nvim-lua/lsp-status.nvim",
        config = function()
        end,
        event = "VeryLazy",
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local nls = require("null-ls")
            nls.setup({
                sources = {
                    nls.builtins.diagnostics.actionlint
                },
            })
        end,
        event = "VeryLazy"
    },
    {
        "saghen/blink.cmp",
        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "enter",
                ["<C-J>"] = {
                    "snippet_forward",
                    function() -- sidekick next edit suggestion
                        return require("sidekick").nes_jump_or_apply()
                    end,
                    function() -- if you are using Neovim's native inline completions
                        return vim.lsp.inline_completion.get()
                    end,
                    "fallback",
                },
            },

            completion = { documentation = { auto_show = true, auto_show_delay_ms = 600 } },

            sources = {
                default = { "lsp", "path", "buffer" },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                "lazy.nvim",
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}

vim.diagnostic.config({
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        },
    },
})


local buffer_autoformat = function(bufnr)
    local group = "lsp_autoformat"
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        group = group,
        desc = "LSP format on save",
        callback = function()
            vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end,
    })
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)

        local id = vim.tbl_get(event, "data", "client_id")
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil then
            return
        end
        if not format_on_save[client.name] then
            return
        end

        ---@diagnostic disable-next-line: missing-parameter
        if client:supports_method("textDocument/formatting") then
            buffer_autoformat(event.buf)
        end
    end
})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "ComplHint", {
            fg = "#666666", -- ghost text color
            italic = true,
        })
    end,
})
vim.lsp.inline_completion.enable()

return plugins
