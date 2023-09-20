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

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end
})
