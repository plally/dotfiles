require("lspconfig").rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            files = {
                -- if you have a directory with a large amount of files rust analyzer can get stuck so it must be excluded
                excludeDirs = { "data" },
            },
        }
    }
})
