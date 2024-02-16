vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

local lspconfig = require("lspconfig")
lspconfig.dartls.setup({})
