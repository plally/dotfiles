require("lspconfig").gopls.setup({
    settings = {
        gopls = {
            staticcheck = true,
            codelenses = {
                gc_details = true,
            },
            analyses = {
                ST1005 = true,
                ST1006 = true,
                ST1013 = true,
                ST1018 = true,
                ST1020 = true,
                ST1021 = true,
                ST1022 = true,
                ST1023 = true,
                ST1016 = true,
            }
        }
    }
})

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require("go.format").goimport()
    end,
    group = format_sync_grp,
})
